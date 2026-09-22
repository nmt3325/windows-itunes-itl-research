"""Fail-closed native probes for Lyrics media/ITL authority in one retained state.

The harness resets the same absolute-path disposable library before every probe,
changes only the MP3 input, takes ten complete COM snapshots, requires a stable
three-read suffix with stable media bytes, saves normally, validates the saved
ITL independently, and restores the retained root byte for byte at the end.
Results are exact-state observations, not a generic precedence specification.
"""
from __future__ import annotations

import argparse
import copy
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
import time
import traceback
from typing import Any

REPO_ROOT = Path(__file__).resolve().parents[2]
WINDOWS_SCRIPTS = Path(__file__).resolve().parent
for entry in (str(REPO_ROOT), str(WINDOWS_SCRIPTS)):
    if entry not in sys.path:
        sys.path.insert(0, entry)

from scripts.research.analyze_mp3_rewrite import parse_id3v22
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

READ_COUNT = 10
READ_INTERVAL_SECONDS = 1.0
STABLE_SUFFIX_READS = 3
STARTUP_TIMEOUT_SECONDS = 90
ORIGINAL_LYRICS = "Plain ASCII lyrics line one"
CONFLICT_LYRICS = "Other ASCII lyrics line two"
ALLOWED_TRACK_DIFFERENCES = frozenset({"Lyrics", "Size", "ModificationDate"})


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def canonical(value: Any) -> Any:
    if isinstance(value, dict):
        if set(value) == {"unavailable"}:
            return {"unavailable": True}
        return {key: canonical(item) for key, item in value.items()}
    if isinstance(value, list):
        return [canonical(item) for item in value]
    return value


def state_sha256(state: dict) -> str:
    encoded = json.dumps(canonical(state), ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return hashlib.sha256(encoded).hexdigest()


def one_track(state: dict) -> dict:
    tracks = state.get("tracks", [])
    if state.get("track_count") != 1 or len(tracks) != 1:
        raise RuntimeError(f"expected exactly one track, got count={state.get('track_count')} rows={len(tracks)}")
    return tracks[0]


def identity_projection(state: dict) -> dict:
    track = one_track(state)
    master_pid = state.get("library_persistent_id")
    masters = [row for row in state.get("playlists", []) if row.get("persistent_id") == master_pid]
    return {
        "version": state.get("version"),
        "library_persistent_id": master_pid,
        "track_persistent_id": track.get("persistent_id"),
        "location": track.get("Location"),
        "master_instances": len(masters),
        "master_members": [member.get("persistent_id") for member in masters[0].get("members", [])] if len(masters) == 1 else None,
    }


def identity_errors(expected: dict, actual: dict) -> list[dict]:
    wanted = identity_projection(expected)
    observed = identity_projection(actual)
    errors: list[dict] = []
    for key, expected_value in wanted.items():
        actual_value = observed.get(key)
        if key == "location" and isinstance(expected_value, str) and isinstance(actual_value, str):
            equal = str(Path(expected_value)).casefold() == str(Path(actual_value)).casefold()
        else:
            equal = expected_value == actual_value
        if not equal:
            errors.append({"property": key, "expected": expected_value, "actual": actual_value})
    return errors


def authority_projection(state: dict) -> dict:
    projected = copy.deepcopy(canonical(state))
    for track in projected.get("tracks", []):
        for field in ALLOWED_TRACK_DIFFERENCES:
            track.pop(field, None)
    return projected


def authority_projection_errors(expected: dict, actual: dict) -> list[dict]:
    wanted = authority_projection(expected)
    observed = authority_projection(actual)
    if wanted == observed:
        return []
    return [{
        "property": "complete_snapshot_except_authority_fields",
        "allowed_track_differences": sorted(ALLOWED_TRACK_DIFFERENCES),
        "expected_sha256": state_sha256(wanted),
        "actual_sha256": state_sha256(observed),
        "expected": wanted,
        "actual": observed,
    }]


def stable_suffix(samples: list[dict], count: int = STABLE_SUFFIX_READS) -> bool:
    if len(samples) < count or count < 2:
        return False
    suffix = samples[-count:]
    state_hashes = {sample["state_sha256"] for sample in suffix}
    media_hashes = {sample["media"]["sha256"] for sample in suffix}
    return len(state_hashes) == 1 and len(media_hashes) == 1


def replace_exact_ult_text(tagged: bytes, old: str, new: str) -> bytes:
    old_bytes = old.encode("latin-1")
    new_bytes = new.encode("latin-1")
    if len(old_bytes) != len(new_bytes):
        raise ValueError("conflicting Lyrics text must preserve the exact byte length")
    parsed = parse_id3v22(tagged)
    lyrics_frames = [frame for frame in parsed["frames"] if frame["id"] == "ULT"]
    if len(lyrics_frames) != 1:
        raise ValueError(f"expected one ULT frame, got {len(lyrics_frames)}")
    frame = lyrics_frames[0]
    details = frame["unsynchronized_lyrics"]
    if details["encoding"] != 0 or details["description"] != "" or details["text"] != old:
        raise ValueError("retained ULT frame did not have the expected exact shape")
    start = int(frame["payload_offset"])
    end = start + int(frame["payload_bytes"])
    payload = tagged[start:end]
    if payload.count(old_bytes) != 1:
        raise ValueError("expected Lyrics bytes were not unique inside ULT payload")
    replacement = payload.replace(old_bytes, new_bytes)
    rewritten = tagged[:start] + replacement + tagged[end:]
    reparsed = parse_id3v22(rewritten)
    observed = [item for item in reparsed["frames"] if item["id"] == "ULT"][0]["unsynchronized_lyrics"]["text"]
    if observed != new or len(rewritten) != len(tagged):
        raise RuntimeError("conflicting ULT construction failed its exact gate")
    return rewritten


def tree_facts(root: Path) -> list[dict]:
    return inventory(root)


def restore_root(root: Path, backup: Path, expected: list[dict], profile: Path) -> list[dict]:
    require_stopped()
    if profile.exists() or profile.is_symlink():
        raise RuntimeError("per-user profile exists before retained-root reset")
    if root.exists():
        shutil.rmtree(root)
    shutil.copytree(backup, root, copy_function=shutil.copy2)
    observed = tree_facts(root)
    if observed != expected:
        raise RuntimeError("retained disposable root did not restore byte for byte")
    return observed


def worker(spec_path: Path, output_path: Path) -> int:
    import pythoncom
    import win32com.client
    from native_worker import snapshot

    spec = json.loads(spec_path.read_text(encoding="utf-8"))
    expected = canonical(json.loads(Path(spec["expected_state"]).read_text(encoding="utf-8")))
    media = Path(spec["media"]).resolve()
    root = Path(spec["root"]).resolve()
    if not media.is_relative_to(root) or not media.is_file():
        raise RuntimeError("authority-probe media is absent or escaped the disposable root")
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
        for read_number in range(1, READ_COUNT + 1):
            if read_number > 1:
                deadline = time.monotonic() + READ_INTERVAL_SECONDS
                while time.monotonic() < deadline:
                    pythoncom.PumpWaitingMessages()
                    time.sleep(min(0.1, max(0.001, deadline - time.monotonic())))
            state = canonical(snapshot(app))
            sample = {
                "read": read_number,
                "state": state,
                "state_sha256": state_sha256(state),
                "media": file_facts(media),
            }
            result["samples"].append(sample)
            write_json(output_path, result)

        result["stable_suffix"] = {
            "read_count": READ_COUNT,
            "required_equal_suffix_reads": STABLE_SUFFIX_READS,
            "interval_seconds": READ_INTERVAL_SECONDS,
            "passed": stable_suffix(result["samples"]),
            "reads": list(range(READ_COUNT - STABLE_SUFFIX_READS + 1, READ_COUNT + 1)),
        }
        if not result["stable_suffix"]["passed"]:
            raise RuntimeError("COM state and media bytes lacked the required stable suffix")
        stable = result["samples"][-1]["state"]
        result["identity_errors"] = identity_errors(expected, stable)
        if result["identity_errors"]:
            raise RuntimeError("library/track/master identity changed during authority probe")
        result["projection_errors"] = authority_projection_errors(expected, stable)
        if result["projection_errors"]:
            raise RuntimeError("non-authority COM state changed during authority probe")
        track = one_track(stable)
        result["observation"] = {
            "Lyrics": track.get("Lyrics"),
            "Size": track.get("Size"),
            "ModificationDate": track.get("ModificationDate"),
            "media_sha256": result["samples"][-1]["media"]["sha256"],
            "state_sha256": result["samples"][-1]["state_sha256"],
        }
        result["expected_reload_state"] = stable
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
    file_pid = summary.get("file_persistent_id")
    if not isinstance(file_pid, str) or len(file_pid) != 16 or any(ch not in "0123456789ABCDEF" for ch in file_pid) or int(file_pid, 16) == 0:
        errors.append({"property": "file_persistent_id", "expected": "nonzero 16-hex identity", "actual": file_pid})
    check("track_persistent_ids", [projection["track_persistent_id"]], sorted(row.get("persistent_id") for row in summary.get("tracks", [])))
    masters = [row for row in summary.get("playlists", []) if row.get("persistent_id") == projection["library_persistent_id"]]
    check("serialized_master_instances", 1, len(masters))
    members = [row.get("track_persistent_id") for row in masters[0].get("members", [])] if len(masters) == 1 else None
    check("serialized_master_members", [projection["track_persistent_id"]], members)
    if not validation.get("valid"):
        errors.append({"property": "validator.valid", "expected": True, "actual": validation})
    return {"summary": summary, "validation": validation, "errors": errors, "passed": not errors}


def run_probe(
    name: str,
    root: Path,
    evidence: Path,
    expected_state: Path,
    profile: Path,
) -> dict:
    from desktop_probe import snapshot as desktop_snapshot
    from native_driver import wait_ready

    session = evidence / "probes" / name
    session.mkdir(parents=True, exist_ok=False)
    live = root / "live" / "iTunes Library.itl"
    media = root / "media" / "field-followup.mp3"
    shutil.copy2(live, session / "input-library.itl")
    shutil.copy2(media, session / "input-media.mp3")
    result: dict[str, Any] = {
        "name": name,
        "started_utc": utc_now(),
        "input_library": file_facts(live),
        "input_media": file_facts(media),
        "inventory_before": inventory(root / "live"),
        "ui": [],
    }
    process: subprocess.Popen | None = None
    junction_created = False
    try:
        require_stopped()
        if profile.exists() or profile.is_symlink():
            raise RuntimeError("per-user iTunes profile existed before authority probe")
        result["forbidden_before"] = forbidden_artifacts(result["inventory_before"])
        if result["forbidden_before"]:
            raise RuntimeError("forbidden fallback artifacts existed before authority probe")
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
        spec = {
            "schema_version": 1,
            "probe": name,
            "root": str(root),
            "media": str(media),
            "expected_state": str(expected_state),
        }
        spec_path = session / "worker-spec.json"
        output_path = session / "com.json"
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
        completed = subprocess.run(
            command,
            cwd=str(REPO_ROOT),
            text=True,
            encoding="utf-8",
            errors="strict",
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            timeout=240,
        )
        (session / "worker.log").write_text(completed.stdout, encoding="utf-8", newline="\n")
        result["worker_exit_code"] = completed.returncode
        result["worker"] = json.loads(output_path.read_text(encoding="utf-8"))
        if completed.returncode or not result["worker"].get("accepted"):
            raise RuntimeError("authority-probe worker gate failed")
        process.wait(timeout=45)
        result["itunes_exit_code"] = process.returncode
        if process.returncode != 0:
            raise RuntimeError("iTunes exited nonzero after normal authority-probe Quit")
        require_stopped()
        time.sleep(0.5)
        result["inventory_after"] = inventory(root / "live")
        result["forbidden_after"] = forbidden_artifacts(result["inventory_after"])
        if result["forbidden_after"]:
            raise RuntimeError("native fallback artifacts appeared during authority probe")
        if not live.is_file() or live.read_bytes()[:4] != b"hdfm":
            raise RuntimeError("native-saved authority-probe ITL is missing or malformed")
        saved = session / "native-saved.itl"
        final_media = session / "media-after.mp3"
        shutil.copy2(live, saved)
        shutil.copy2(media, final_media)
        result["saved"] = file_facts(saved)
        result["media_after"] = file_facts(final_media)
        result["media_changed"] = result["input_media"]["sha256"] != result["media_after"]["sha256"]
        stable = result["worker"]["expected_reload_state"]
        result["independent_validation"] = independently_validate(saved, stable)
        if not result["independent_validation"]["passed"]:
            raise RuntimeError("independent parser/validator gate failed after authority probe")
        result["observation"] = result["worker"]["observation"]
        result["status"] = "captured"
    except Exception as exc:
        result.update(
            status="failed_with_preserved_evidence",
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
            shutil.copy2(live, session / "live-at-failure.itl")
        if media.is_file():
            shutil.copy2(media, session / "media-at-failure.mp3")
        result["inventory_at_failure"] = inventory(root / "live") if (root / "live").is_dir() else []
    finally:
        try:
            require_stopped()
        except Exception as exc:
            result["stopped_gate_error"] = type(exc).__name__ + ": " + str(exc)
            result["status"] = "failed_with_preserved_evidence"
        if junction_created:
            try:
                result["profile_junction_remove"] = remove_profile_junction(profile, root / "live")
            except Exception as exc:
                result["profile_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
                result["status"] = "failed_with_preserved_evidence"
        if profile.exists() or profile.is_symlink():
            result["profile_absence_error"] = "per-user profile remained after authority probe"
            result["status"] = "failed_with_preserved_evidence"
        result["finished_utc"] = utc_now()
        write_json(session / "result.json", result)
    return result


def classify(probes: list[dict]) -> dict:
    observations = {
        probe["name"]: probe.get("observation", {}).get("Lyrics")
        for probe in probes
        if probe.get("status") == "captured"
    }
    all_captured = len(observations) == 3
    control_exact = observations.get("tagged-control") == ORIGINAL_LYRICS
    stripped_empty = observations.get("tag-stripped") == ""
    conflict_exact = observations.get("tag-conflict") == CONFLICT_LYRICS
    if all_captured and control_exact and stripped_empty and conflict_exact:
        label = "exact_state_media_tag_precedence_observed"
        conclusion = (
            "For this one retained library/track/build, removing the only ID3 ULT frame yielded empty COM Lyrics "
            "and replacing its same-length text yielded that conflicting text; the reset ITL did not override either input."
        )
    elif all_captured and control_exact:
        label = "mixed_exact_state_authority_result"
        conclusion = "The control was exact, but the stripped/conflicting outcomes do not establish the simple media-precedence pattern."
    else:
        label = "uninterpretable_without_exact_control"
        conclusion = "The exact tagged control did not pass, so no authority interpretation is accepted."
    return {
        "label": label,
        "observed_lyrics": observations,
        "all_probes_captured": all_captured,
        "tagged_control_exact": control_exact,
        "tag_stripped_empty": stripped_empty,
        "tag_conflict_exact": conflict_exact,
        "bounded_conclusion": conclusion,
        "limitations": [
            "one retained track and absolute path",
            "one MP3 encoder output and ID3v2.2 ULT frame shape",
            "one iTunes build",
            "does not exclude hidden caches or establish general storage authority",
            "does not establish Unicode, length, UI, other media-kind, or cross-version behavior",
        ],
    }


def run(args: argparse.Namespace) -> int:
    if os.name != "nt":
        raise RuntimeError("native Lyrics authority probes require Windows")
    if not args.confirm_disposable:
        raise RuntimeError("native Lyrics authority probes require --confirm-disposable")
    if not ITUNES_EXE.is_file() or sha256_file(ITUNES_EXE) != EXPECTED_ITUNES_SHA256:
        raise RuntimeError("installed iTunes executable is not the pinned build")

    root = args.root.resolve()
    evidence = args.evidence.resolve()
    source = args.source_evidence.resolve()
    runner_temp = Path(os.environ["RUNNER_TEMP"]).resolve()
    if not root.is_relative_to(runner_temp):
        raise RuntimeError("retained root must be below RUNNER_TEMP")
    if not root.is_dir() or evidence.exists() or not source.is_dir():
        raise RuntimeError("retained root/source must exist and evidence output must be new")
    profile = Path.home() / "Music" / "iTunes"
    require_stopped()
    if profile.exists() or profile.is_symlink():
        raise RuntimeError("per-user iTunes profile exists; refusing authority probe")

    expected_state = source / "mutated-state.json"
    source_tagged = source / "source-final.mp3"
    source_stripped = source / "source-original.mp3"
    source_itl = source / "verify" / "native-saved.itl"
    retained_itl = root / "live" / "iTunes Library.itl"
    retained_media = root / "media" / "field-followup.mp3"
    for path in (expected_state, source_tagged, source_stripped, source_itl, retained_itl, retained_media):
        if not path.is_file():
            raise RuntimeError(f"required authority input is missing: {path}")
    if sha256_file(retained_itl) != sha256_file(source_itl):
        raise RuntimeError("retained live ITL differs from the committed verified input")
    if sha256_file(retained_media) != sha256_file(source_tagged):
        raise RuntimeError("retained media differs from the committed tagged input")

    evidence.mkdir(parents=True)
    shutil.copy2(Path(__file__).resolve(), evidence / "capture-harness.py")
    shutil.copy2(WINDOWS_SCRIPTS / "native_driver.py", evidence / "capture-native-driver.py")
    shutil.copy2(REPO_ROOT / "scripts" / "research" / "analyze_mp3_rewrite.py", evidence / "capture-id3-analyzer.py")
    backup = runner_temp / (evidence.name + "-retained-root-backup")
    if backup.exists():
        raise RuntimeError("authority backup path already exists")
    initial_inventory = tree_facts(root)
    shutil.copytree(root, backup, copy_function=shutil.copy2)
    if tree_facts(backup) != initial_inventory:
        raise RuntimeError("retained-root backup did not preserve exact bytes")

    tagged = source_tagged.read_bytes()
    stripped = source_stripped.read_bytes()
    conflict = replace_exact_ult_text(tagged, ORIGINAL_LYRICS, CONFLICT_LYRICS)
    variants = [
        ("tagged-control", tagged),
        ("tag-stripped", stripped),
        ("tag-conflict", conflict),
    ]
    summary: dict[str, Any] = {
        "schema_version": 1,
        "started_utc": utc_now(),
        "status": "running",
        "environment": {
            "platform": platform.platform(),
            "python": sys.version,
            "itunes_version": EXPECTED_ITUNES_VERSION,
            "itunes_executable": file_facts(ITUNES_EXE),
            "capture_harness": file_facts(evidence / "capture-harness.py"),
            "capture_native_driver": file_facts(evidence / "capture-native-driver.py"),
            "capture_id3_analyzer": file_facts(evidence / "capture-id3-analyzer.py"),
        },
        "inputs": {
            "retained_root": str(root),
            "initial_inventory": initial_inventory,
            "committed_verified_itl": file_facts(source_itl),
            "committed_tagged_media": file_facts(source_tagged),
            "committed_stripped_media": file_facts(source_stripped),
            "expected_state": file_facts(expected_state),
        },
        "policy": {
            "same_absolute_disposable_root": True,
            "root_reset_before_every_probe": True,
            "complete_com_snapshots_per_probe": READ_COUNT,
            "stable_suffix_reads_required": STABLE_SUFFIX_READS,
            "stable_media_hash_required": True,
            "normal_quit_required": True,
            "independent_parse_and_validation_required": True,
            "allowed_track_differences": sorted(ALLOWED_TRACK_DIFFERENCES),
            "retained_root_exact_restoration_required": True,
        },
        "variants": [
            {"name": name, "bytes": len(value), "sha256": hashlib.sha256(value).hexdigest()}
            for name, value in variants
        ],
        "probes": [],
    }
    write_json(evidence / "summary.json", summary)
    restoration: dict[str, Any] = {"attempted": False, "passed": False}
    try:
        for name, variant in variants:
            restore_root(root, backup, initial_inventory, profile)
            retained_media.write_bytes(variant)
            if retained_media.read_bytes() != variant:
                raise RuntimeError("authority variant write did not verify byte for byte")
            outcome = run_probe(name, root, evidence, expected_state, profile)
            summary["probes"].append(outcome)
            write_json(evidence / "summary.json", summary)
        summary["classification"] = classify(summary["probes"])
        summary["all_probes_captured"] = all(probe.get("status") == "captured" for probe in summary["probes"])
    except Exception as exc:
        summary.update(
            status="failed_with_preserved_evidence",
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
        )
    finally:
        restoration["attempted"] = True
        try:
            observed = restore_root(root, backup, initial_inventory, profile)
            restoration.update(passed=True, restored_inventory=observed)
        except Exception as exc:
            restoration.update(passed=False, error=type(exc).__name__ + ": " + str(exc), traceback=traceback.format_exc())
        if restoration["passed"] and backup.exists():
            shutil.rmtree(backup)
            restoration["backup_removed"] = not backup.exists()
        summary["restoration"] = restoration
        capture_passed = bool(summary.get("all_probes_captured")) and restoration["passed"]
        summary["status"] = "captured" if capture_passed else "failed_with_preserved_evidence"
        summary["finished_utc"] = utc_now()
        write_json(evidence / "summary.json", summary)
    print(json.dumps({
        "status": summary["status"],
        "classification": summary.get("classification", {}).get("label"),
        "observed_lyrics": summary.get("classification", {}).get("observed_lyrics"),
        "restoration_passed": restoration["passed"],
    }, ensure_ascii=False), flush=True)
    return 0 if summary["status"] == "captured" else 1


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="mode", required=True)
    native = subparsers.add_parser("run")
    native.add_argument("--root", type=Path, required=True)
    native.add_argument("--source-evidence", type=Path, required=True)
    native.add_argument("--evidence", type=Path, required=True)
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
