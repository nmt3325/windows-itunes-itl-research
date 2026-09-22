"""Fail-closed media-backed follow-up for unresolved native COM track fields.

Each case creates deterministic WAV or MP3 media and a genuinely fresh native iTunes
profile.  Four serial native sessions initialize the media-backed track,
stabilize the baseline after restart, perform exactly one field mutation, and
verify the complete COM snapshot after another restart.  Every launch starts
with no iTunes process and no per-user profile junction.  Native saves, media
hashes, identities, fallback artifacts, and independent parser/validator
results are retained even when a case fails.
"""
from __future__ import annotations

import argparse
import array
import datetime as dt
import hashlib
import importlib.metadata
import json
import math
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import sys
import time
import traceback
import wave
from typing import Any

REPO_ROOT = Path(__file__).resolve().parents[2]
WINDOWS_SCRIPTS = Path(__file__).resolve().parent
for entry in (str(REPO_ROOT), str(WINDOWS_SCRIPTS)):
    if entry not in sys.path:
        sys.path.insert(0, entry)

from reference_generated_native import (
    EXPECTED_ITUNES_SHA256,
    EXPECTED_ITUNES_VERSION,
    ITUNES_EXE,
    create_profile_junction,
    file_facts,
    forbidden_artifacts,
    inventory,
    remove_profile_junction,
    require_stopped,
    settle_no_unexpected_modal,
    sha256_file,
    write_json,
)

DEFAULT_CASES = WINDOWS_SCRIPTS / "native_media_field_followup_cases.json"
PID_PATTERN = re.compile(r"[0-9A-F]{16}")
LAMEENC_VERSION = "1.8.1"
LAMEENC_WHEEL_SHA256 = "715e0e72ed5429f00042379e48a7903e54ee5dc01069db34338536f3595059c3"
LAMEENC_MODULE_SHA256 = "ff9f47ecfc0b167e2e3e4edacaeb23aa0b10422ef4cc180d52ae3b86ff7636dc"
POST_MUTATION_MAX_READS = 10
POST_MUTATION_INTERVAL_SECONDS = 1.0
STARTUP_TIMEOUT_SECONDS = 90
LONG_STRING_COMPACTION_THRESHOLD = 4096
GENERATED_ASCII_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
GENERATED_ASCII_MAX_CHARACTERS = 20_000_000


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def text_fingerprint(value: str) -> dict:
    encoded = value.encode("utf-8")
    edge = 32
    return {
        "kind": "utf8-string-sha256-v1",
        "characters": len(value),
        "utf8_bytes": len(encoded),
        "sha256": hashlib.sha256(encoded).hexdigest(),
        "prefix": value[:edge],
        "suffix": value[-edge:] if value else "",
        "contains_nul": "\x00" in value,
    }


def generated_ascii_value(length: int) -> str:
    if type(length) is not int or not 16 <= length <= GENERATED_ASCII_MAX_CHARACTERS:
        raise RuntimeError("generated ASCII length is outside the bounded range")
    prefix = f"L{length:09d}:"
    remaining = length - len(prefix)
    repeats = (remaining + len(GENERATED_ASCII_ALPHABET) - 1) // len(GENERATED_ASCII_ALPHABET)
    value = prefix + (GENERATED_ASCII_ALPHABET * repeats)[:remaining]
    if len(value) != length or not value.isascii() or "\x00" in value:
        raise RuntimeError("deterministic ASCII generator violated its exact contract")
    return value


def case_value_spec(case: dict) -> dict:
    has_literal = "value" in case
    has_generated = "generated_ascii_length" in case
    if has_literal == has_generated:
        raise RuntimeError("each case must define exactly one literal or generated value")
    if has_literal:
        return {"kind": "literal-v1", "value": case["value"]}
    value = generated_ascii_value(case["generated_ascii_length"])
    return {
        "kind": "generated-ascii-v1",
        "characters": len(value),
        "fingerprint": text_fingerprint(value),
    }


def materialize_value_spec(spec: dict) -> Any:
    kind = spec.get("kind")
    if kind == "literal-v1":
        return spec.get("value")
    if kind == "generated-ascii-v1":
        value = generated_ascii_value(spec.get("characters"))
        if text_fingerprint(value) != spec.get("fingerprint"):
            raise RuntimeError("generated value fingerprint mismatch")
        return value
    raise RuntimeError(f"unsupported value specification: {kind!r}")


def canonical(value: Any) -> Any:
    """Normalize unavailable values and compact only very long strings by exact digest."""
    if isinstance(value, str) and len(value) > LONG_STRING_COMPACTION_THRESHOLD:
        return text_fingerprint(value)
    if isinstance(value, dict):
        if set(value) == {"unavailable"}:
            return {"unavailable": True}
        return {key: canonical(item) for key, item in value.items()}
    if isinstance(value, list):
        return [canonical(item) for item in value]
    return value


def normalize_com_value(value: Any) -> Any:
    if isinstance(value, (str, int, float, bool)) or value is None:
        return value
    if hasattr(value, "isoformat"):
        return value.isoformat()
    return str(value)


def state_sha256(state: dict) -> str:
    encoded = json.dumps(canonical(state), ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return hashlib.sha256(encoded).hexdigest()


def complete_state_errors(expected: dict, actual: dict) -> list[dict]:
    wanted = canonical(expected)
    observed = canonical(actual)
    if wanted == observed:
        return []
    return [{
        "property": "complete_snapshot",
        "expected_sha256": state_sha256(wanted),
        "actual_sha256": state_sha256(observed),
        "expected": wanted,
        "actual": observed,
    }]


def one_track(state: dict) -> dict:
    tracks = state.get("tracks", [])
    if state.get("track_count") != 1 or len(tracks) != 1:
        raise RuntimeError(f"expected exactly one track, got count={state.get('track_count')} rows={len(tracks)}")
    return tracks[0]


def identity_projection(state: dict) -> dict:
    track = one_track(state)
    master = [row for row in state.get("playlists", []) if row.get("persistent_id") == state.get("library_persistent_id")]
    return {
        "version": state.get("version"),
        "library_persistent_id": state.get("library_persistent_id"),
        "track_persistent_id": track.get("persistent_id"),
        "location": track.get("Location"),
        "master_instances": len(master),
        "master_members": [member.get("persistent_id") for member in master[0].get("members", [])] if len(master) == 1 else None,
    }


def identity_errors(expected: dict, actual: dict) -> list[dict]:
    wanted = identity_projection(expected)
    observed = identity_projection(actual)
    errors: list[dict] = []
    for key, value in wanted.items():
        actual_value = observed.get(key)
        if key == "location" and isinstance(value, str) and isinstance(actual_value, str):
            equal = str(Path(value)).casefold() == str(Path(actual_value)).casefold()
        else:
            equal = value == actual_value
        if not equal:
            errors.append({"property": key, "expected": value, "actual": actual_value})
    return errors


def pcm_samples(frequency: int) -> tuple[int, int, array.array]:
    sample_rate = 44100
    frames = sample_rate // 2
    samples = array.array("h", (int(5000 * math.sin(2 * math.pi * frequency * index / sample_rate)) for index in range(frames)))
    if sys.byteorder != "little":
        samples.byteswap()
    return sample_rate, frames, samples


def create_wav(path: Path, frequency: int) -> dict:
    path.parent.mkdir(parents=True, exist_ok=False)
    sample_rate, frames, samples = pcm_samples(frequency)
    with wave.open(str(path), "wb") as handle:
        handle.setparams((1, 2, sample_rate, frames, "NONE", "not compressed"))
        handle.writeframes(samples.tobytes())
    facts = file_facts(path)
    facts["wave"] = {"channels": 1, "sample_width": 2, "sample_rate": sample_rate, "frames": frames}
    return facts


def lameenc_provenance() -> dict:
    import lameenc

    module_path = Path(lameenc.__file__).resolve()
    version = importlib.metadata.version("lameenc")
    facts = file_facts(module_path)
    if version != LAMEENC_VERSION:
        raise RuntimeError(f"unexpected lameenc version: {version}")
    if facts["sha256"] != LAMEENC_MODULE_SHA256:
        raise RuntimeError("loaded lameenc module hash differs from the pinned Windows build")
    return {"distribution": "lameenc", "version": version, "wheel_sha256": LAMEENC_WHEEL_SHA256, "loaded_module": facts}


def create_mp3(path: Path, frequency: int) -> dict:
    import lameenc

    provenance = lameenc_provenance()
    path.parent.mkdir(parents=True, exist_ok=False)
    sample_rate, frames, samples = pcm_samples(frequency)
    encoder = lameenc.Encoder()
    encoder.set_bit_rate(128)
    encoder.set_in_sample_rate(sample_rate)
    encoder.set_channels(1)
    encoder.set_quality(2)
    encoded = encoder.encode(samples.tobytes()) + encoder.flush()
    path.write_bytes(encoded)
    facts = file_facts(path)
    facts["mp3"] = {"channels": 1, "sample_rate": sample_rate, "pcm_frames": frames, "bit_rate_kbps": 128, "quality": 2, "encoder": provenance}
    return facts


def media_kind(case: dict) -> str:
    return case.get("media_kind", "wav")


def media_path(root: Path, case: dict) -> Path:
    kind = media_kind(case)
    return root / "media" / f"field-followup.{kind}"


def create_media(path: Path, case: dict) -> dict:
    frequency = int(case["frequency"])
    if media_kind(case) == "wav":
        return create_wav(path, frequency)
    if media_kind(case) == "mp3":
        return create_mp3(path, frequency)
    raise RuntimeError(f"unsupported media kind: {media_kind(case)}")


def consecutive_snapshot_convergence(states: list[Any]) -> int | None:
    """Return the one-based read number ending the first equal adjacent pair."""
    canonical_states = [canonical(state) for state in states]
    for index in range(1, len(canonical_states)):
        if canonical_states[index - 1] == canonical_states[index]:
            return index + 1
    return None


def media_gate(state: dict, root: Path, expected_sha256: str | None, *, allow_empty: bool = False) -> list[dict]:
    rows: list[dict] = []
    tracks = state.get("tracks", [])
    if allow_empty and not tracks:
        return rows
    if len(tracks) != 1:
        raise RuntimeError(f"media gate expected one track, got {len(tracks)}")
    location = tracks[0].get("Location")
    if not isinstance(location, str) or not location:
        raise RuntimeError("media-backed track has no COM Location")
    path = Path(location).resolve()
    if not path.is_relative_to(root.resolve()):
        raise RuntimeError("COM Location escaped the disposable case root")
    if not path.is_file():
        raise RuntimeError("COM Location does not exist")
    facts = file_facts(path)
    if expected_sha256 is not None and facts["sha256"] != expected_sha256:
        raise RuntimeError("COM Location bytes differ from the session-entry media hash")
    rows.append({"persistent_id": tracks[0].get("persistent_id"), **facts})
    return rows


def worker(spec_path: Path, output_path: Path) -> int:
    import pythoncom
    import pywintypes
    import win32com.client
    from native_worker import SETTABLE, file_interface, items, pid, snapshot

    spec = json.loads(spec_path.read_text(encoding="utf-8"))
    root = Path(spec["root"]).resolve()
    source = Path(spec["source"]).resolve()
    result: dict[str, Any] = {
        "schema_version": 1,
        "started_utc": utc_now(),
        "spec": spec,
        "samples": [],
        "accepted": False,
        "quit_requested": False,
        "operation_stage": "startup",
    }
    app = None
    pythoncom.CoInitialize()
    try:
        app = win32com.client.dynamic.Dispatch("iTunes.Application")

        def take(label: str, delay: float = 0.0, *, allow_empty: bool = False, allow_media_rewrite: bool = False) -> dict:
            deadline = time.monotonic() + delay
            while time.monotonic() < deadline:
                pythoncom.PumpWaitingMessages()
                time.sleep(min(0.1, max(0.001, deadline - time.monotonic())))
            state = canonical(snapshot(app))
            sample = {
                "label": label,
                "state": state,
                "state_sha256": state_sha256(state),
                "media": media_gate(state, root, None if allow_media_rewrite else spec["source_sha256"], allow_empty=allow_empty),
            }
            result["samples"].append(sample)
            write_json(output_path, result)
            return state

        mode = spec["mode"]
        result["operation_stage"] = f"{mode}:before"
        if mode == "initialize":
            before_1 = take("before-1", allow_empty=True)
            before_2 = take("before-2", 1.0, allow_empty=True)
            result["before_stability_errors"] = complete_state_errors(before_1, before_2)
            if result["before_stability_errors"]:
                raise RuntimeError("fresh native profile was not stable before AddFile")
            if before_2.get("track_count") != 0:
                raise RuntimeError("fresh native profile was not empty")
            result["operation_stage"] = "initialize:add-file"
            status = app.LibraryPlaylist.AddFile(str(source))
            deadline = time.monotonic() + 60
            while status.InProgress:
                if time.monotonic() > deadline:
                    raise TimeoutError("AddFile remained in progress for 60 seconds")
                pythoncom.PumpWaitingMessages()
                time.sleep(0.1)
            if status.Tracks.Count != 1:
                raise RuntimeError(f"AddFile returned {status.Tracks.Count} tracks")
            added = status.Tracks.Item(1)
            result["add_file"] = {"returned_track_persistent_id": pid(app, added)}
            after_1 = take("after-1")
            after_2 = take("after-2", 1.0)
            result["after_stability_errors"] = complete_state_errors(after_1, after_2)
            if result["after_stability_errors"]:
                raise RuntimeError("post-AddFile COM snapshot was unstable")
            if one_track(after_2)["persistent_id"] != result["add_file"]["returned_track_persistent_id"]:
                raise RuntimeError("AddFile return identity disagreed with complete snapshot")
            result["expected_reload_state"] = after_2
        else:
            expected = canonical(json.loads(Path(spec["expected_state"]).read_text(encoding="utf-8")))
            before_1 = take("before-1")
            before_2 = take("before-2", 1.0)
            result["before_stability_errors"] = complete_state_errors(before_1, before_2)
            if result["before_stability_errors"]:
                raise RuntimeError("pre-operation COM snapshot was unstable")
            if mode == "baseline":
                result["operation_stage"] = "baseline:identity"
                result["identity_errors"] = identity_errors(expected, before_2)
                if result["identity_errors"]:
                    raise RuntimeError("native initialization identity changed on baseline restart")
                result["expected_reload_state"] = before_2
            elif mode == "mutate":
                result["operation_stage"] = "mutate:preflight"
                result["reload_errors"] = complete_state_errors(expected, before_2)
                if result["reload_errors"]:
                    raise RuntimeError("complete baseline COM snapshot changed before mutation")
                field = spec["field"]
                if field not in SETTABLE:
                    raise RuntimeError(f"field is not in the bounded writable allowlist: {field}")
                target_pid = one_track(before_2)["persistent_id"]
                matches = [file_interface(app, item) for item in items(app.LibraryPlaylist.Tracks) if pid(app, item) == target_pid]
                if len(matches) != 1:
                    raise RuntimeError(f"expected one mutable target track, got {len(matches)}")
                assigned: Any = materialize_value_spec(spec["value_spec"])
                if field.endswith("Date"):
                    assigned = pywintypes.Time(dt.datetime.fromisoformat(assigned))
                result["operation_stage"] = "mutate:setter"
                setattr(matches[0], field, assigned)
                result["operation_stage"] = "mutate:immediate-readback"
                actual_immediate = normalize_com_value(getattr(matches[0], field))
                expected_immediate = normalize_com_value(assigned)
                actual_projected = canonical(actual_immediate)
                expected_projected = canonical(expected_immediate)
                result["write"] = {
                    "field": field,
                    "requested": spec["value_spec"],
                    "expected_immediate": expected_projected,
                    "actual_immediate": actual_projected,
                    "exact": actual_immediate == expected_immediate,
                }
                if actual_immediate != expected_immediate:
                    raise RuntimeError(
                        f"setter projection mismatch for {field}: "
                        f"{actual_projected!r} != {expected_projected!r}"
                    )
                result["operation_stage"] = "mutate:convergence"
                post_states: list[dict] = []
                convergence_read: int | None = None
                for read_number in range(1, POST_MUTATION_MAX_READS + 1):
                    post_states.append(take(f"after-{read_number}", 0.0 if read_number == 1 else POST_MUTATION_INTERVAL_SECONDS, allow_media_rewrite=bool(spec.get("allow_media_rewrite"))))
                    convergence_read = consecutive_snapshot_convergence(post_states)
                    if convergence_read is not None:
                        break
                result["post_mutation_convergence"] = {
                    "max_reads": POST_MUTATION_MAX_READS,
                    "interval_seconds": POST_MUTATION_INTERVAL_SECONDS,
                    "reads_observed": len(post_states),
                    "converged_read": convergence_read,
                    "consecutive_equal_pair": [convergence_read - 1, convergence_read] if convergence_read is not None else None,
                }
                if convergence_read is None:
                    raise RuntimeError("post-mutation COM snapshot did not converge within the bounded read window")
                after_stable = post_states[convergence_read - 1]
                stable_samples = result["samples"][-2:]
                stable_media_hashes = [sample["media"][0]["sha256"] for sample in stable_samples]
                result["post_mutation_convergence"]["stable_media_sha256"] = stable_media_hashes
                if len(set(stable_media_hashes)) != 1:
                    raise RuntimeError("post-mutation media bytes did not stabilize with the COM snapshot")
                result["after_stability_errors"] = []
                actual = one_track(after_stable).get(field)
                expected_projected = canonical(expected_immediate)
                result["requested_value_gate"] = {
                    "field": field,
                    "expected": expected_projected,
                    "actual": actual,
                    "passed": actual == expected_projected,
                }
                if actual != expected_projected:
                    result["operation_stage"] = "mutate:stable-readback"
                    raise RuntimeError(f"post-set complete snapshot mismatch for {field}")
                result["identity_errors"] = identity_errors(before_2, after_stable)
                if result["identity_errors"]:
                    raise RuntimeError("field mutation changed locked file/track/master identity")
                result["expected_reload_state"] = after_stable
            elif mode == "verify":
                result["operation_stage"] = "verify:reload"
                result["reload_errors"] = complete_state_errors(expected, before_2)
                if result["reload_errors"]:
                    raise RuntimeError("complete mutated COM snapshot changed across native restart")
                field = spec["field"]
                expected_value = spec["expected_value"]
                actual = one_track(before_2).get(field)
                result["requested_value_gate"] = {
                    "field": field,
                    "expected": expected_value,
                    "actual": actual,
                    "passed": actual == expected_value,
                }
                if actual != expected_value:
                    raise RuntimeError(f"requested field did not persist: {field}")
                result["expected_reload_state"] = before_2
            else:
                raise RuntimeError(f"unknown worker mode: {mode}")

        result["operation_stage"] = f"{mode}:completed"
        result["accepted"] = True
        app.Quit()
        result["quit_requested"] = True
        result["finished_utc"] = utc_now()
        write_json(output_path, result)
        return 0
    except Exception as exc:
        result.update(
            accepted=False,
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
            finished_utc=utc_now(),
        )
        if app is not None:
            try:
                app.Quit()
                result["quit_requested"] = True
            except Exception as quit_exc:
                result["quit_error"] = type(quit_exc).__name__ + ": " + str(quit_exc)
        write_json(output_path, result)
        return 2
    finally:
        app = None
        pythoncom.CoUninitialize()


def independent_identity_errors(summary: dict, validation: dict, expected_state: dict) -> list[dict]:
    """Validate serialized identities without conflating file and master domains."""
    projection = identity_projection(expected_state)
    errors: list[dict] = []

    def check(name: str, expected: Any, actual: Any) -> None:
        if expected != actual:
            errors.append({"property": name, "expected": expected, "actual": actual})

    check("version", EXPECTED_ITUNES_VERSION, summary.get("version"))
    file_persistent_id = summary.get("file_persistent_id")
    if not isinstance(file_persistent_id, str) or not PID_PATTERN.fullmatch(file_persistent_id) or int(file_persistent_id, 16) == 0:
        errors.append({"property": "file_persistent_id", "expected": "nonzero 16-hex identity", "actual": file_persistent_id})

    track_ids = [row.get("persistent_id") for row in summary.get("tracks", [])]
    if all(isinstance(value, str) for value in track_ids):
        track_ids.sort()
    check("track_persistent_ids", [projection["track_persistent_id"]], track_ids)

    # A native file's outer hdfm PID and its COM LibraryPlaylist/master PID are
    # separate identity domains.  Select the serialized master by the COM PID;
    # never require the outer PID to equal it.
    master_rows = [
        row for row in summary.get("playlists", [])
        if row.get("persistent_id") == projection["library_persistent_id"]
    ]
    check("serialized_master_instances", 1, len(master_rows))
    master_members = None
    if len(master_rows) == 1:
        master_members = [row.get("track_persistent_id") for row in master_rows[0].get("members", [])]
    check("serialized_master_members", [projection["track_persistent_id"]], master_members)
    if not validation.get("valid"):
        errors.append({"property": "validator.valid", "expected": True, "actual": validation})
    return errors


def independently_validate(path: Path, expected_state: dict) -> dict:
    from REFERENCE_PARSER.core import ReferenceLibrary
    from VALIDATOR.validator import validate_bytes

    raw = path.read_bytes()
    summary = ReferenceLibrary.from_bytes(raw).semantic_summary()
    validation = validate_bytes(raw)
    errors = independent_identity_errors(summary, validation, expected_state)
    return {"summary": summary, "validation": validation, "errors": errors, "passed": not errors}


def run_session(case: dict, root: Path, evidence: Path, profile: Path, mode: str, expected_state: Path | None) -> dict:
    from desktop_probe import snapshot as desktop_snapshot
    from native_driver import wait_ready

    live = root / "live" / "iTunes Library.itl"
    source = media_path(root, case)
    session_dir = evidence / mode
    session_dir.mkdir(parents=True, exist_ok=False)
    result: dict[str, Any] = {
        "phase": mode,
        "started_utc": utc_now(),
        "prelaunch": file_facts(live) if live.is_file() else None,
        "inventory_before": inventory(root / "live"),
        "source_before": file_facts(source),
        "ui": [],
    }
    process: subprocess.Popen | None = None
    junction_created = False
    try:
        require_stopped()
        if profile.exists() or profile.is_symlink():
            raise RuntimeError("per-user iTunes profile existed before native launch")
        result["forbidden_before"] = forbidden_artifacts(result["inventory_before"])
        if result["forbidden_before"]:
            raise RuntimeError("forbidden fallback artifacts existed before launch")
        result["profile_junction_create"] = create_profile_junction(profile, root / "live")
        junction_created = True
        process = subprocess.Popen(
            [str(ITUNES_EXE)],
            cwd=str(root),
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        result["itunes_pid"] = process.pid
        result["startup_timeout_seconds"] = STARTUP_TIMEOUT_SECONDS
        wait_ready(process, result["ui"], timeout_seconds=STARTUP_TIMEOUT_SECONDS)
        settle_no_unexpected_modal(process, result["ui"])
        result["post_readiness_settle_seconds"] = 2.0
        spec: dict[str, Any] = {
            "schema_version": 1,
            "case": case["name"],
            "mode": mode,
            "field": case["field"],
            "root": str(root),
            "source": str(source),
            "source_sha256": result["source_before"]["sha256"],
            "allow_media_rewrite": mode == "mutate",
        }
        if expected_state is not None:
            spec["expected_state"] = str(expected_state)
        if mode == "mutate":
            spec["value_spec"] = case_value_spec(case)
        if mode == "verify":
            expected = json.loads(expected_state.read_text(encoding="utf-8"))
            spec["expected_value"] = one_track(expected)[case["field"]]
        spec_path = session_dir / "worker-spec.json"
        output_path = session_dir / "com.json"
        write_json(spec_path, spec)
        command = [
            sys.executable,
            "-X",
            "utf8",
            "-B",
            "-u",
            str(Path(__file__).resolve()),
            "_worker",
            "--spec",
            str(spec_path),
            "--output",
            str(output_path),
        ]
        result["worker_command"] = command
        worker_result = subprocess.run(
            command,
            cwd=str(REPO_ROOT),
            text=True,
            encoding="utf-8",
            errors="strict",
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            timeout=180,
        )
        (session_dir / "worker.log").write_text(worker_result.stdout, encoding="utf-8")
        result["worker_exit_code"] = worker_result.returncode
        result["worker"] = json.loads(output_path.read_text(encoding="utf-8"))
        if worker_result.returncode or not result["worker"].get("accepted"):
            raise RuntimeError("native media-backed field gate failed")
        process.wait(timeout=45)
        result["itunes_exit_code"] = process.returncode
        if process.returncode != 0:
            raise RuntimeError("iTunes exited nonzero after normal Quit")
        require_stopped()
        time.sleep(0.5)
        result["inventory_after"] = inventory(root / "live")
        result["forbidden_after"] = forbidden_artifacts(result["inventory_after"])
        if result["forbidden_after"]:
            raise RuntimeError("native fallback artifacts appeared")
        if not live.is_file() or live.read_bytes()[:4] != b"hdfm":
            raise RuntimeError("native-saved library is missing or malformed")
        saved = session_dir / "native-saved.itl"
        shutil.copy2(live, saved)
        result["saved"] = file_facts(saved)
        expected = result["worker"]["expected_reload_state"]
        result["independent_validation"] = independently_validate(saved, expected)
        if not result["independent_validation"]["passed"]:
            raise RuntimeError("independent parser/validator identity gate failed")
        result["source_after"] = file_facts(source)
        result["source_changed"] = result["source_after"]["sha256"] != result["source_before"]["sha256"]
        rewrite_allowed = mode == "mutate"
        result["media_rewrite_allowed"] = rewrite_allowed
        if result["source_changed"] and not rewrite_allowed:
            raise RuntimeError("media bytes changed outside the bounded mutation session")
        if case.get("retain_session_media", True):
            post_media = session_dir / f"media-after{source.suffix.lower()}"
            shutil.copy2(source, post_media)
            result["post_session_media"] = {"retained": True, **file_facts(post_media)}
        else:
            result["post_session_media"] = {"retained": False, **file_facts(source)}
        result["media_after"] = media_gate(expected, root, result["source_after"]["sha256"])
        result["status"] = "passed"
    except Exception as exc:
        result.update(
            status="failed",
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
        )
        if process is not None:
            if result.get("worker", {}).get("quit_requested") and process.poll() is None:
                try:
                    process.wait(timeout=45)
                except subprocess.TimeoutExpired:
                    pass
            result["itunes_poll_at_failure"] = process.poll()
            result["windows_at_failure"] = [row for row in desktop_snapshot() if row["pid"] == process.pid]
            result["itunes_killed_after_failure"] = False
            if process.poll() is None:
                process.kill()
                process.wait(timeout=10)
                result["itunes_killed_after_failure"] = True
            result["itunes_exit_after_failure"] = process.returncode
        if live.is_file():
            failure = session_dir / "live-at-failure.itl"
            shutil.copy2(live, failure)
            result["live_at_failure"] = file_facts(failure)
        if source.is_file():
            if case.get("retain_failure_media", True):
                failure_media = session_dir / f"media-at-failure{source.suffix.lower()}"
                shutil.copy2(source, failure_media)
                result["media_at_failure"] = {"retained": True, **file_facts(failure_media)}
            else:
                result["media_at_failure"] = {"retained": False, **file_facts(source)}
        result["inventory_at_failure"] = inventory(root / "live")
        result["forbidden_at_failure"] = forbidden_artifacts(result["inventory_at_failure"])
    finally:
        try:
            require_stopped()
        except Exception as exc:
            result["stopped_gate_error"] = type(exc).__name__ + ": " + str(exc)
            result["status"] = "failed"
        if junction_created:
            try:
                result["profile_junction_remove"] = remove_profile_junction(profile, root / "live")
            except Exception as exc:
                result["profile_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
                result["status"] = "failed"
        if profile.exists() or profile.is_symlink():
            result["profile_absence_error"] = "per-user profile remained after cleanup"
            result["status"] = "failed"
        result["finished_utc"] = utc_now()
        write_json(session_dir / "result.json", result)
    return result


def classify_case_outcome(result: dict) -> dict:
    """Separate exact native persistence, native non-exactness, and harness failure."""
    sessions = result.get("sessions", [])
    by_phase = {session.get("phase"): session for session in sessions}
    phase_statuses = {phase: by_phase.get(phase, {}).get("status") for phase in ("initialize", "baseline", "mutate", "verify")}
    infrastructure_errors: list[str] = []

    def session_cleanup_errors(session: dict) -> list[str]:
        errors: list[str] = []
        for key in ("stopped_gate_error", "profile_cleanup_error", "profile_absence_error"):
            if session.get(key):
                errors.append(f"{session.get('phase')}:{key}")
        return errors

    for session in sessions:
        infrastructure_errors.extend(session_cleanup_errors(session))

    exact_phases = ["initialize", "baseline", "mutate", "verify"]
    if result.get("passed") and [session.get("phase") for session in sessions] == exact_phases:
        for phase in exact_phases:
            session = by_phase[phase]
            if session.get("status") != "passed" or session.get("worker_exit_code") != 0:
                infrastructure_errors.append(f"{phase}:not-passed")
            if not session.get("worker", {}).get("accepted") or not session.get("worker", {}).get("quit_requested"):
                infrastructure_errors.append(f"{phase}:worker-gate")
            if session.get("itunes_exit_code") != 0:
                infrastructure_errors.append(f"{phase}:itunes-exit")
            if session.get("forbidden_before") or session.get("forbidden_after"):
                infrastructure_errors.append(f"{phase}:fallback-artifact")
        mutation = by_phase["mutate"].get("worker", {})
        verification = by_phase["verify"].get("worker", {})
        if not mutation.get("write", {}).get("exact") or not mutation.get("requested_value_gate", {}).get("passed"):
            infrastructure_errors.append("mutate:exact-value-gate")
        if not verification.get("requested_value_gate", {}).get("passed"):
            infrastructure_errors.append("verify:exact-value-gate")
        if not result.get("identity_chain_stable") or not result.get("file_persistent_id_stable"):
            infrastructure_errors.append("identity-chain")
        return {
            "label": "exact_restart_persisted" if not infrastructure_errors else "harness_failure",
            "evidence_complete": not infrastructure_errors,
            "phase_statuses": phase_statuses,
            "infrastructure_errors": infrastructure_errors,
            "requested": mutation.get("write", {}).get("expected_immediate"),
            "actual": mutation.get("write", {}).get("actual_immediate"),
            "source_rewrite_observed": result.get("source_rewrite_observed"),
        }

    initialize = by_phase.get("initialize", {})
    baseline = by_phase.get("baseline", {})
    mutation = by_phase.get("mutate", {})
    worker_result = mutation.get("worker", {})
    preconditions = (
        initialize.get("status") == "passed"
        and baseline.get("status") == "passed"
        and mutation.get("status") == "failed"
        and "verify" not in by_phase
    )
    if preconditions:
        if mutation.get("worker_exit_code") != 2:
            infrastructure_errors.append("mutate:unexpected-worker-exit")
        if not worker_result.get("quit_requested") or worker_result.get("quit_error"):
            infrastructure_errors.append("mutate:normal-quit-not-requested")
        if mutation.get("itunes_exit_after_failure") != 0 or mutation.get("itunes_killed_after_failure"):
            infrastructure_errors.append("mutate:itunes-exit")
        if mutation.get("forbidden_before") or mutation.get("forbidden_at_failure"):
            infrastructure_errors.append("mutate:fallback-artifact")
        write = worker_result.get("write", {})
        native_nonexact = (
            worker_result.get("operation_stage") == "mutate:immediate-readback"
            and write.get("exact") is False
            and "expected_immediate" in write
            and "actual_immediate" in write
            and result.get("source_rewrite_observed") is True
        )
        if native_nonexact and not infrastructure_errors:
            return {
                "label": "native_nonexact_immediate_readback",
                "evidence_complete": True,
                "phase_statuses": phase_statuses,
                "infrastructure_errors": [],
                "requested": write.get("expected_immediate"),
                "actual": write.get("actual_immediate"),
                "worker_error": worker_result.get("error"),
                "source_rewrite_observed": True,
                "normal_exit_after_observation": True,
            }

    if not infrastructure_errors:
        infrastructure_errors.append("outcome-did-not-match-a-qualified-native-class")
    return {
        "label": "harness_failure",
        "evidence_complete": False,
        "phase_statuses": phase_statuses,
        "infrastructure_errors": infrastructure_errors,
        "worker_stage": worker_result.get("operation_stage"),
        "worker_error": worker_result.get("error"),
    }


def run_case(case: dict, roots: Path, evidence_root: Path, profile: Path) -> dict:
    root = roots / case["name"]
    live_dir = root / "live"
    case_evidence = evidence_root / "cases" / case["name"]
    live_dir.mkdir(parents=True, exist_ok=False)
    case_evidence.mkdir(parents=True, exist_ok=False)
    source = media_path(root, case)
    media = create_media(source, case)
    source_original = case_evidence / f"source-original{source.suffix.lower()}"
    shutil.copy2(source, source_original)
    result: dict[str, Any] = {
        "name": case["name"],
        "case": case,
        "source": media,
        "source_original": file_facts(source_original),
        "started_utc": utc_now(),
        "sessions": [],
    }
    try:
        initialize = run_session(case, root, case_evidence, profile, "initialize", None)
        result["sessions"].append(initialize)
        if initialize["status"] != "passed":
            raise RuntimeError("initialization session failed")
        initialized_state = case_evidence / "initialized-state.json"
        write_json(initialized_state, initialize["worker"]["expected_reload_state"])

        baseline = run_session(case, root, case_evidence, profile, "baseline", initialized_state)
        result["sessions"].append(baseline)
        if baseline["status"] != "passed":
            raise RuntimeError("baseline stabilization session failed")
        baseline_state = case_evidence / "baseline-state.json"
        write_json(baseline_state, baseline["worker"]["expected_reload_state"])

        mutation = run_session(case, root, case_evidence, profile, "mutate", baseline_state)
        result["sessions"].append(mutation)
        if mutation["status"] != "passed":
            raise RuntimeError("mutation session failed; verification was not attempted")
        mutated_state = case_evidence / "mutated-state.json"
        write_json(mutated_state, mutation["worker"]["expected_reload_state"])

        verification = run_session(case, root, case_evidence, profile, "verify", mutated_state)
        result["sessions"].append(verification)
        if verification["status"] != "passed":
            raise RuntimeError("verification session failed")

        projections = [identity_projection(session["worker"]["expected_reload_state"]) for session in result["sessions"]]
        result["identity_chain"] = projections
        result["identity_chain_stable"] = all(projection == projections[0] for projection in projections[1:])
        if not result["identity_chain_stable"]:
            raise RuntimeError("master/track/location identity changed across the four-session chain")
        result["file_persistent_id_chain"] = [
            session["independent_validation"]["summary"]["file_persistent_id"] for session in result["sessions"]
        ]
        result["file_persistent_id_stable"] = len(set(result["file_persistent_id_chain"])) == 1
        if not result["file_persistent_id_stable"]:
            raise RuntimeError("serialized file identity changed across the four-session chain")
        result["save_chain"] = [session["saved"]["sha256"] for session in result["sessions"]]
        result["passed"] = True
        result["status"] = "passed"
    except Exception as exc:
        result.update(
            passed=False,
            status="failed_with_preserved_evidence",
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
        )
    finally:
        try:
            require_stopped()
        except Exception as exc:
            result["stopped_gate_error"] = type(exc).__name__ + ": " + str(exc)
            result["passed"] = False
            result["status"] = "failed_with_preserved_evidence"
        if profile.exists() or profile.is_symlink():
            result["profile_absence_error"] = "per-user profile remained after case cleanup"
            result["passed"] = False
            result["status"] = "failed_with_preserved_evidence"
        result["source_final"] = file_facts(source)
        result["source_unchanged"] = result["source_final"]["sha256"] == media["sha256"]
        result["source_rewrite_observed"] = not result["source_unchanged"]
        if case.get("retain_final_media", True):
            final_media = case_evidence / f"source-final{source.suffix.lower()}"
            shutil.copy2(source, final_media)
            result["source_final_capture"] = {"retained": True, **file_facts(final_media)}
        else:
            result["source_final_capture"] = {"retained": False, **file_facts(source)}
        mutation_passed = any(session.get("phase") == "mutate" and session.get("status") == "passed" for session in result.get("sessions", []))
        if result["source_rewrite_observed"] and not mutation_passed:
            result["media_policy_error"] = "media changed without a completed bounded mutation session"
            result["passed"] = False
            result["status"] = "failed_with_preserved_evidence"
        result["final_inventory"] = inventory(live_dir)
        result["outcome"] = classify_case_outcome(result)
        result["finished_utc"] = utc_now()
        write_json(case_evidence / "result.json", result)
    return result


def validate_cases(cases: list[dict]) -> None:
    names: set[str] = set()
    signatures: set[tuple[str, str, int, str]] = set()
    for case in cases:
        if not re.fullmatch(r"[a-z0-9-]+", case.get("name", "")):
            raise RuntimeError("unsafe case name")
        if case["name"] in names:
            raise RuntimeError("duplicate case name")
        if type(case.get("frequency")) is not int or not 100 <= case["frequency"] <= 2000:
            raise RuntimeError("frequency is outside the bounded deterministic range")
        if media_kind(case) not in {"wav", "mp3"}:
            raise RuntimeError("media_kind must be wav or mp3")
        if ("value" in case) == ("generated_ascii_length" in case):
            raise RuntimeError("each case must define exactly one literal or generated value")
        if "generated_ascii_length" in case:
            if case["field"] != "Lyrics" or media_kind(case) != "mp3":
                raise RuntimeError("generated ASCII cases are bounded to MP3-backed Lyrics")
            generated_ascii_value(case["generated_ascii_length"])
        for flag in ("retain_session_media", "retain_failure_media", "retain_final_media"):
            if flag in case and type(case[flag]) is not bool:
                raise RuntimeError(f"{flag} must be boolean")
        signature = (case["field"], json.dumps(case_value_spec(case), ensure_ascii=False, sort_keys=True), case["frequency"], media_kind(case))
        if signature in signatures:
            raise RuntimeError("duplicate exact field/value/media case")
        names.add(case["name"])
        signatures.add(signature)


def run(args: argparse.Namespace) -> int:
    if os.name != "nt":
        raise RuntimeError("native media-backed field follow-up requires Windows")
    if not args.confirm_disposable:
        raise RuntimeError("native follow-up requires --confirm-disposable")
    if not ITUNES_EXE.is_file() or sha256_file(ITUNES_EXE) != EXPECTED_ITUNES_SHA256:
        raise RuntimeError("installed iTunes executable is not the pinned build")
    roots = args.root.resolve()
    evidence = args.evidence.resolve()
    cases_path = args.cases.resolve()
    runner_temp = Path(os.environ["RUNNER_TEMP"]).resolve()
    if not roots.is_relative_to(runner_temp):
        raise RuntimeError("disposable case roots must be below RUNNER_TEMP")
    if roots.exists() or evidence.exists():
        raise RuntimeError("root and evidence outputs must both be new")
    if not cases_path.is_file():
        raise RuntimeError("case matrix is missing")
    profile = Path.home() / "Music" / "iTunes"
    require_stopped()
    if profile.exists() or profile.is_symlink():
        raise RuntimeError("per-user iTunes profile exists; refusing reuse")
    cases = json.loads(cases_path.read_text(encoding="utf-8"))
    validate_cases(cases)
    roots.mkdir(parents=True)
    evidence.mkdir(parents=True)
    shutil.copy2(cases_path, evidence / "case-matrix.json")
    harness_capture = evidence / "capture-harness.py"
    driver_capture = evidence / "capture-native-driver.py"
    shutil.copy2(Path(__file__).resolve(), harness_capture)
    shutil.copy2(WINDOWS_SCRIPTS / "native_driver.py", driver_capture)
    summary: dict[str, Any] = {
        "schema_version": 1,
        "started_utc": utc_now(),
        "status": "running",
        "case_matrix": file_facts(cases_path),
        "environment": {
            "platform": platform.platform(),
            "python": sys.version,
            "itunes_version": EXPECTED_ITUNES_VERSION,
            "itunes_executable": file_facts(ITUNES_EXE),
            "capture_harness": file_facts(harness_capture),
            "capture_native_driver": file_facts(driver_capture),
            "lameenc": lameenc_provenance() if any(media_kind(case) == "mp3" for case in cases) else None,
        },
        "policy": {
            "fresh_native_profile_per_case": True,
            "profile_absent_before_each_launch": True,
            "deterministic_media_backing": True,
            "four_serial_native_sessions_per_case": True,
            "one_property_write_per_case": True,
            "complete_snapshot_fixed_before_mutation": True,
            "complete_snapshot_verified_after_restart": True,
            "two_stable_reads_per_session": True,
            "post_mutation_max_reads": POST_MUTATION_MAX_READS,
            "post_mutation_interval_seconds": POST_MUTATION_INTERVAL_SECONDS,
            "first_consecutive_equal_pair_required": True,
            "startup_timeout_seconds": STARTUP_TIMEOUT_SECONDS,
            "normal_quit_required": True,
            "unexpected_modal_allowed": False,
            "fallback_artifacts_allowed": False,
            "media_mutation_allowed": "only when explicitly enabled for the mutation session; every byte state is captured",
            "independent_parse_and_validation_required": True,
        },
        "cases": [],
    }
    write_json(evidence / "summary.json", summary)
    for case in cases:
        outcome = run_case(case, roots, evidence, profile)
        summary["cases"].append(outcome)
        write_json(evidence / "summary.json", summary)
        print(json.dumps({"case": case["name"], "field": case["field"], "status": outcome["status"]}), flush=True)
    summary["passed_cases"] = sum(bool(case.get("passed")) for case in summary["cases"])
    summary["failed_cases"] = len(summary["cases"]) - summary["passed_cases"]
    summary["all_passed"] = summary["failed_cases"] == 0
    summary["outcome_counts"] = {
        label: sum(case.get("outcome", {}).get("label") == label for case in summary["cases"])
        for label in ("exact_restart_persisted", "native_nonexact_immediate_readback", "harness_failure")
    }
    summary["capture_complete"] = summary["outcome_counts"]["harness_failure"] == 0
    summary["status"] = "passed" if summary["all_passed"] else "failed_with_preserved_evidence"
    summary["finished_utc"] = utc_now()
    write_json(evidence / "summary.json", summary)
    print(json.dumps({"status": summary["status"], "passed": summary["passed_cases"], "failed": summary["failed_cases"]}), flush=True)
    return 0 if summary["all_passed"] else 1


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="mode", required=True)
    native = subparsers.add_parser("run")
    native.add_argument("--root", type=Path, required=True)
    native.add_argument("--evidence", type=Path, required=True)
    native.add_argument("--cases", type=Path, default=DEFAULT_CASES)
    native.add_argument("--confirm-disposable", action="store_true")
    internal = subparsers.add_parser("_worker", help=argparse.SUPPRESS)
    internal.add_argument("--spec", type=Path, required=True)
    internal.add_argument("--output", type=Path, required=True)
    args = parser.parse_args(argv)
    if args.mode == "_worker":
        return worker(args.spec, args.output)
    return run(args)


if __name__ == "__main__":
    raise SystemExit(main())
