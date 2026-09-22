"""Fail-closed media-backed follow-up for unresolved native COM track fields.

Each case creates a deterministic WAV and a genuinely fresh native iTunes
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


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def canonical(value: Any) -> Any:
    """Make unavailable COM values comparable without platform error prose."""
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


def create_wav(path: Path, frequency: int) -> dict:
    path.parent.mkdir(parents=True, exist_ok=False)
    sample_rate = 44100
    frames = sample_rate // 2
    samples = array.array("h", (int(5000 * math.sin(2 * math.pi * frequency * index / sample_rate)) for index in range(frames)))
    if sys.byteorder != "little":
        samples.byteswap()
    with wave.open(str(path), "wb") as handle:
        handle.setparams((1, 2, sample_rate, frames, "NONE", "not compressed"))
        handle.writeframes(samples.tobytes())
    facts = file_facts(path)
    facts["wave"] = {"channels": 1, "sample_width": 2, "sample_rate": sample_rate, "frames": frames}
    return facts


def media_gate(state: dict, root: Path, source_sha256: str, *, allow_empty: bool = False) -> list[dict]:
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
    if facts["sha256"] != source_sha256:
        raise RuntimeError("COM Location bytes differ from the pinned source WAV")
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
    }
    app = None
    pythoncom.CoInitialize()
    try:
        app = win32com.client.dynamic.Dispatch("iTunes.Application")

        def take(label: str, delay: float = 0.0, *, allow_empty: bool = False) -> dict:
            deadline = time.monotonic() + delay
            while time.monotonic() < deadline:
                pythoncom.PumpWaitingMessages()
                time.sleep(min(0.1, max(0.001, deadline - time.monotonic())))
            state = canonical(snapshot(app))
            sample = {
                "label": label,
                "state": state,
                "state_sha256": state_sha256(state),
                "media": media_gate(state, root, spec["source_sha256"], allow_empty=allow_empty),
            }
            result["samples"].append(sample)
            write_json(output_path, result)
            return state

        mode = spec["mode"]
        if mode == "initialize":
            before_1 = take("before-1", allow_empty=True)
            before_2 = take("before-2", 1.0, allow_empty=True)
            result["before_stability_errors"] = complete_state_errors(before_1, before_2)
            if result["before_stability_errors"]:
                raise RuntimeError("fresh native profile was not stable before AddFile")
            if before_2.get("track_count") != 0:
                raise RuntimeError("fresh native profile was not empty")
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
                result["identity_errors"] = identity_errors(expected, before_2)
                if result["identity_errors"]:
                    raise RuntimeError("native initialization identity changed on baseline restart")
                result["expected_reload_state"] = before_2
            elif mode == "mutate":
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
                assigned: Any = spec["value"]
                if field.endswith("Date"):
                    assigned = pywintypes.Time(dt.datetime.fromisoformat(assigned))
                setattr(matches[0], field, assigned)
                actual_immediate = normalize_com_value(getattr(matches[0], field))
                expected_immediate = normalize_com_value(assigned)
                result["write"] = {
                    "field": field,
                    "requested": spec["value"],
                    "expected_immediate": expected_immediate,
                    "actual_immediate": actual_immediate,
                    "exact": actual_immediate == expected_immediate,
                }
                if actual_immediate != expected_immediate:
                    raise RuntimeError(f"setter projection mismatch for {field}: {actual_immediate!r} != {expected_immediate!r}")
                after_1 = take("after-1")
                after_2 = take("after-2", 1.0)
                result["after_stability_errors"] = complete_state_errors(after_1, after_2)
                if result["after_stability_errors"]:
                    raise RuntimeError("post-mutation COM snapshot was unstable")
                actual = one_track(after_2).get(field)
                result["requested_value_gate"] = {
                    "field": field,
                    "expected": expected_immediate,
                    "actual": actual,
                    "passed": actual == expected_immediate,
                }
                if actual != expected_immediate:
                    raise RuntimeError(f"post-set complete snapshot mismatch for {field}")
                result["identity_errors"] = identity_errors(before_2, after_2)
                if result["identity_errors"]:
                    raise RuntimeError("field mutation changed locked file/track/master identity")
                result["expected_reload_state"] = after_2
            elif mode == "verify":
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

        result["accepted"] = True
        app.Quit()
        result["quit_requested"] = True
        result["finished_utc"] = utc_now()
        write_json(output_path, result)
        return 0
    except Exception as exc:
        result.update(
            accepted=False,
            quit_requested=False,
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
            finished_utc=utc_now(),
        )
        write_json(output_path, result)
        return 2
    finally:
        app = None
        pythoncom.CoUninitialize()


def independently_validate(path: Path, expected_state: dict) -> dict:
    from REFERENCE_PARSER.core import ReferenceLibrary
    from VALIDATOR.validator import validate_bytes

    raw = path.read_bytes()
    summary = ReferenceLibrary.from_bytes(raw).semantic_summary()
    validation = validate_bytes(raw)
    projection = identity_projection(expected_state)
    errors: list[dict] = []

    def check(name: str, expected: Any, actual: Any) -> None:
        if expected != actual:
            errors.append({"property": name, "expected": expected, "actual": actual})

    check("version", EXPECTED_ITUNES_VERSION, summary.get("version"))
    file_persistent_id = summary.get("file_persistent_id")
    if not isinstance(file_persistent_id, str) or not PID_PATTERN.fullmatch(file_persistent_id) or int(file_persistent_id, 16) == 0:
        errors.append({"property": "file_persistent_id", "expected": "nonzero 16-hex identity", "actual": file_persistent_id})
    track_ids = sorted(row.get("persistent_id") for row in summary.get("tracks", []))
    check("track_persistent_ids", [projection["track_persistent_id"]], track_ids)
    playlists = {row.get("persistent_id"): row for row in summary.get("playlists", [])}
    master = playlists.get(projection["library_persistent_id"], {})
    master_members = [row.get("track_persistent_id") for row in master.get("members", [])]
    check("serialized_master_members", [projection["track_persistent_id"]], master_members)
    if not validation.get("valid"):
        errors.append({"property": "validator.valid", "expected": True, "actual": validation})
    return {"summary": summary, "validation": validation, "errors": errors, "passed": not errors}


def run_session(case: dict, root: Path, evidence: Path, profile: Path, mode: str, expected_state: Path | None) -> dict:
    from desktop_probe import snapshot as desktop_snapshot
    from native_driver import wait_ready

    live = root / "live" / "iTunes Library.itl"
    source = root / "media" / "field-followup.wav"
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
        wait_ready(process, result["ui"])
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
        }
        if expected_state is not None:
            spec["expected_state"] = str(expected_state)
        if mode == "mutate":
            spec["value"] = case["value"]
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
        if result["source_after"]["sha256"] != result["source_before"]["sha256"]:
            raise RuntimeError("source WAV changed during native session")
        result["media_after"] = media_gate(expected, root, result["source_before"]["sha256"])
        result["status"] = "passed"
    except Exception as exc:
        result.update(
            status="failed",
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
        )
        if process is not None:
            result["itunes_poll_at_failure"] = process.poll()
            result["windows_at_failure"] = [row for row in desktop_snapshot() if row["pid"] == process.pid]
            if process.poll() is None:
                process.kill()
                process.wait(timeout=10)
            result["itunes_exit_after_kill"] = process.returncode
        if live.is_file():
            failure = session_dir / "live-at-failure.itl"
            shutil.copy2(live, failure)
            result["live_at_failure"] = file_facts(failure)
        result["inventory_at_failure"] = inventory(root / "live")
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


def run_case(case: dict, roots: Path, evidence_root: Path, profile: Path) -> dict:
    root = roots / case["name"]
    live_dir = root / "live"
    case_evidence = evidence_root / "cases" / case["name"]
    live_dir.mkdir(parents=True, exist_ok=False)
    case_evidence.mkdir(parents=True, exist_ok=False)
    source = root / "media" / "field-followup.wav"
    media = create_wav(source, int(case["frequency"]))
    result: dict[str, Any] = {
        "name": case["name"],
        "case": case,
        "source": media,
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
        if not result["source_unchanged"]:
            result["passed"] = False
            result["status"] = "failed_with_preserved_evidence"
        result["final_inventory"] = inventory(live_dir)
        result["finished_utc"] = utc_now()
        write_json(case_evidence / "result.json", result)
    return result


def validate_cases(cases: list[dict]) -> None:
    names: set[str] = set()
    fields: set[str] = set()
    for case in cases:
        if not re.fullmatch(r"[a-z0-9-]+", case.get("name", "")):
            raise RuntimeError("unsafe case name")
        if case["name"] in names or case["field"] in fields:
            raise RuntimeError("duplicate case name or field")
        if type(case.get("frequency")) is not int or not 100 <= case["frequency"] <= 2000:
            raise RuntimeError("frequency is outside the bounded deterministic range")
        names.add(case["name"])
        fields.add(case["field"])


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
            "normal_quit_required": True,
            "unexpected_modal_allowed": False,
            "fallback_artifacts_allowed": False,
            "media_mutation_allowed": False,
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
