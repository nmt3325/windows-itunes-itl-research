"""Strict two-cycle native qualification for every writable COM track field.

Each case starts from the same exact template-free reference ITL in a new
isolated Music\\iTunes profile.  The first native session performs exactly one
property write and fixes the complete resulting COM snapshot.  A second native
session must reproduce that snapshot twice before a normal Quit.  Unexpected
UI, fallback artifacts, identity changes, parser/validator failures, unstable
reads, and unsupported setters fail closed and remain in immutable evidence.
"""
from __future__ import annotations

import argparse
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

CANDIDATE = REPO_ROOT / "TEST_CORPUS" / "generated" / "reference-one-track-raw.itl"
CANDIDATE_SHA256 = "c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74"
DEFAULT_CASES = WINDOWS_SCRIPTS / "native_field_matrix_cases.json"
TARGET_TRACK = "A17E000000000001"
MASTER_PLAYLIST = "5245464552454E43"
CUSTOM_PLAYLIST = "A17E000000000002"
EXPECTED_COM_PLAYLISTS_BY_NAME = {
    "Library": {"persistent_id": MASTER_PLAYLIST, "special_kind": None, "members": [TARGET_TRACK]},
    "Music": {"special_kind": 6, "members": [TARGET_TRACK]},
    "Movies": {"special_kind": 7, "members": []},
    "TV Shows": {"special_kind": 8, "members": []},
    "Podcasts": {"special_kind": 3, "members": []},
    "Audiobooks": {"special_kind": 9, "members": []},
    "Genius": {"special_kind": 11, "members": []},
    "Reference Playlist": {"persistent_id": CUSTOM_PLAYLIST, "special_kind": 0, "members": [TARGET_TRACK]},
}
EXPECTED_SERIALIZED_PLAYLISTS = {
    MASTER_PLAYLIST: [TARGET_TRACK],
    CUSTOM_PLAYLIST: [TARGET_TRACK],
}


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def canonical(value: Any) -> Any:
    """Remove platform text from unavailable COM errors, preserving availability."""
    if isinstance(value, dict):
        if set(value) == {"unavailable"}:
            return {"unavailable": True}
        return {key: canonical(item) for key, item in value.items()}
    if isinstance(value, list):
        return [canonical(item) for item in value]
    return value


def identity_errors(state: dict) -> list[dict]:
    errors: list[dict] = []

    def check(name: str, expected: Any, actual: Any) -> None:
        if expected != actual:
            errors.append({"property": name, "expected": expected, "actual": actual})

    check("version", EXPECTED_ITUNES_VERSION, state.get("version"))
    check("library_persistent_id", MASTER_PLAYLIST, state.get("library_persistent_id"))
    tracks = {row.get("persistent_id"): row for row in state.get("tracks", [])}
    check("track_count", 1, state.get("track_count"))
    check("track_ids", [TARGET_TRACK], sorted(key for key in tracks if key))
    rows = state.get("playlists", [])
    playlists_by_name: dict[str, list[dict]] = {}
    for row in rows:
        playlists_by_name.setdefault(row.get("name"), []).append(row)
    check("playlist_count", len(EXPECTED_COM_PLAYLISTS_BY_NAME), len(rows))
    check("playlist_names", sorted(EXPECTED_COM_PLAYLISTS_BY_NAME), sorted(playlists_by_name))
    for name, expected in EXPECTED_COM_PLAYLISTS_BY_NAME.items():
        matches = playlists_by_name.get(name, [])
        check(f"playlist[{name}].instances", 1, len(matches))
        if len(matches) != 1:
            continue
        playlist = matches[0]
        if "persistent_id" in expected:
            check(f"playlist[{name}].persistent_id", expected["persistent_id"], playlist.get("persistent_id"))
        check(f"playlist[{name}].special_kind", expected["special_kind"], playlist.get("special_kind"))
        members = [row.get("persistent_id") for row in playlist.get("members", [])]
        check(f"playlist[{name}].members", expected["members"], members)
    return errors


def target_track(state: dict) -> dict:
    matches = [row for row in state.get("tracks", []) if row.get("persistent_id") == TARGET_TRACK]
    if len(matches) != 1:
        raise RuntimeError(f"expected exactly one target track, got {len(matches)}")
    return matches[0]


def normalize_com_value(value: Any) -> Any:
    if isinstance(value, (str, int, float, bool)) or value is None:
        return value
    if hasattr(value, "isoformat"):
        return value.isoformat()
    return str(value)


def worker(spec_path: Path, output_path: Path) -> int:
    import pythoncom
    import pywintypes
    import win32com.client
    from native_worker import SETTABLE, file_interface, items, pid, snapshot

    spec = json.loads(spec_path.read_text(encoding="utf-8"))
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

        def take(label: str, delay: float = 0.0) -> dict:
            deadline = time.monotonic() + delay
            while time.monotonic() < deadline:
                pythoncom.PumpWaitingMessages()
                time.sleep(min(0.1, max(0.001, deadline - time.monotonic())))
            state = canonical(snapshot(app))
            sample = {"label": label, "state": state, "identity_errors": identity_errors(state)}
            result["samples"].append(sample)
            write_json(output_path, result)
            return state

        before_1 = take("before-1")
        before_2 = take("before-2", 2.0)
        result["before_stability_errors"] = [] if before_1 == before_2 else [
            {"property": "complete_snapshot", "expected": before_1, "actual": before_2}
        ]
        if any(sample["identity_errors"] for sample in result["samples"]):
            raise RuntimeError("identity gate failed before mutation")
        if result["before_stability_errors"]:
            raise RuntimeError("pre-operation COM snapshot was unstable")

        if spec["mode"] == "mutate":
            field = spec["field"]
            if field not in SETTABLE:
                raise RuntimeError(f"field is not in the bounded writable allowlist: {field}")
            matches = []
            for item in items(app.LibraryPlaylist.Tracks):
                if pid(app, item) == TARGET_TRACK:
                    matches.append(file_interface(app, item))
            if len(matches) != 1:
                raise RuntimeError(f"expected one mutable target track, got {len(matches)}")
            track = matches[0]
            requested = spec["value"]
            assigned = requested
            if field.endswith("Date"):
                assigned = pywintypes.Time(dt.datetime.fromisoformat(requested))
            setattr(track, field, assigned)
            immediate = normalize_com_value(getattr(track, field))
            expected_immediate = normalize_com_value(assigned)
            result["write"] = {
                "field": field,
                "requested": requested,
                "expected_immediate": expected_immediate,
                "actual_immediate": immediate,
                "exact": immediate == expected_immediate,
            }
            if immediate != expected_immediate:
                raise RuntimeError(
                    f"setter projection mismatch for {field}: {immediate!r} != {expected_immediate!r}"
                )
            after_1 = take("after-1")
            after_2 = take("after-2", 2.0)
            actual = target_track(after_2).get(field)
            result["requested_value_gate"] = {
                "field": field,
                "expected": expected_immediate,
                "actual": actual,
                "passed": actual == expected_immediate,
            }
            if actual != expected_immediate:
                raise RuntimeError(f"post-set snapshot mismatch for {field}")
            if after_1 != after_2:
                result["after_stability_errors"] = [
                    {"property": "complete_snapshot", "expected": after_1, "actual": after_2}
                ]
                raise RuntimeError("post-operation COM snapshot was unstable")
            result["expected_reload_state"] = after_2
        elif spec["mode"] == "verify":
            expected = canonical(json.loads(Path(spec["expected_state"]).read_text(encoding="utf-8")))
            verification_errors = []
            for sample in (before_1, before_2):
                if sample != expected:
                    verification_errors.append(
                        {"property": "complete_snapshot", "expected": expected, "actual": sample}
                    )
            result["reload_errors"] = verification_errors
            if verification_errors:
                raise RuntimeError("complete COM snapshot changed across native restart")
            field = spec["field"]
            requested = spec["expected_value"]
            actual = target_track(before_2).get(field)
            result["requested_value_gate"] = {
                "field": field,
                "expected": requested,
                "actual": actual,
                "passed": actual == requested,
            }
            if actual != requested:
                raise RuntimeError(f"requested field did not persist: {field}")
        else:
            raise RuntimeError(f"unknown worker mode: {spec['mode']}")

        if any(sample["identity_errors"] for sample in result["samples"]):
            raise RuntimeError("identity gate failed after operation")
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


def independently_validate(path: Path) -> dict:
    from REFERENCE_PARSER.core import ReferenceLibrary
    from VALIDATOR.validator import validate_bytes

    raw = path.read_bytes()
    library = ReferenceLibrary.from_bytes(raw)
    summary = library.semantic_summary()
    validation = validate_bytes(raw)
    errors: list[dict] = []

    def check(name: str, expected: Any, actual: Any) -> None:
        if expected != actual:
            errors.append({"property": name, "expected": expected, "actual": actual})

    check("version", EXPECTED_ITUNES_VERSION, summary.get("version"))
    check("file_persistent_id", MASTER_PLAYLIST, summary.get("file_persistent_id"))
    check("track_ids", [TARGET_TRACK], sorted(row.get("persistent_id") for row in summary.get("tracks", [])))
    playlists = {row.get("persistent_id"): row for row in summary.get("playlists", [])}
    missing_playlist_ids = sorted(set(EXPECTED_SERIALIZED_PLAYLISTS) - set(playlists))
    check("required_playlist_ids_missing", [], missing_playlist_ids)
    for persistent_id, expected_members in EXPECTED_SERIALIZED_PLAYLISTS.items():
        actual_members = [row.get("track_persistent_id") for row in playlists.get(persistent_id, {}).get("members", [])]
        check(f"playlist[{persistent_id}].members", expected_members, actual_members)
    if not validation.get("valid"):
        errors.append({"property": "validator.valid", "expected": True, "actual": validation})
    return {"summary": summary, "validation": validation, "errors": errors, "passed": not errors}


def run_session(case: dict, root: Path, evidence: Path, phase: str, expected_state: Path | None = None) -> dict:
    from desktop_probe import snapshot as desktop_snapshot
    from native_driver import wait_ready

    live = root / "live" / "iTunes Library.itl"
    session_dir = evidence / phase
    session_dir.mkdir(parents=True, exist_ok=False)
    result: dict[str, Any] = {
        "phase": phase,
        "started_utc": utc_now(),
        "prelaunch": file_facts(live),
        "inventory_before": inventory(root / "live"),
        "ui": [],
    }
    process: subprocess.Popen | None = None
    try:
        require_stopped()
        result["forbidden_before"] = forbidden_artifacts(result["inventory_before"])
        if result["forbidden_before"]:
            raise RuntimeError("forbidden fallback artifacts existed before launch")
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
        result["post_readiness_settle_seconds"] = 3.0
        spec: dict[str, Any] = {
            "schema_version": 1,
            "case": case["name"],
            "field": case["field"],
        }
        if phase == "mutation":
            spec.update(mode="mutate", value=case["value"])
        else:
            if expected_state is None:
                raise RuntimeError("verify phase requires a fixed state path")
            expected = json.loads(expected_state.read_text(encoding="utf-8"))
            spec.update(
                mode="verify",
                expected_state=str(expected_state),
                expected_value=target_track(expected)[case["field"]],
            )
        spec_path = session_dir / "worker-spec.json"
        output_path = session_dir / "com.json"
        write_json(spec_path, spec)
        command = [
            sys.executable,
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
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            timeout=150,
        )
        (session_dir / "worker.log").write_text(worker_result.stdout, encoding="utf-8")
        result["worker_exit_code"] = worker_result.returncode
        result["worker"] = json.loads(output_path.read_text(encoding="utf-8"))
        if worker_result.returncode or not result["worker"].get("accepted"):
            raise RuntimeError("native COM field gate failed")
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
        result["independent_validation"] = independently_validate(saved)
        if not result["independent_validation"]["passed"]:
            raise RuntimeError("independent parser/validator identity gate failed")
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
    result["finished_utc"] = utc_now()
    write_json(session_dir / "result.json", result)
    return result


def run_case(case: dict, roots: Path, evidence_root: Path, profile: Path) -> dict:
    root = roots / case["name"]
    live_dir = root / "live"
    case_evidence = evidence_root / "cases" / case["name"]
    live_dir.mkdir(parents=True, exist_ok=False)
    case_evidence.mkdir(parents=True, exist_ok=False)
    live = live_dir / "iTunes Library.itl"
    shutil.copy2(CANDIDATE, live)
    result: dict[str, Any] = {
        "name": case["name"],
        "case": case,
        "candidate": file_facts(CANDIDATE),
        "started_utc": utc_now(),
        "sessions": [],
    }
    try:
        result["profile_junction_create"] = create_profile_junction(profile, live_dir)
        mutation = run_session(case, root, case_evidence, "mutation")
        result["sessions"].append(mutation)
        if mutation["status"] != "passed":
            raise RuntimeError("mutation session failed; verification was not attempted")
        state_path = case_evidence / "expected-reload-state.json"
        write_json(state_path, mutation["worker"]["expected_reload_state"])
        verification = run_session(case, root, case_evidence, "verification", state_path)
        result["sessions"].append(verification)
        if verification["status"] != "passed":
            raise RuntimeError("verification session failed")
        def serialized_identity(session: dict) -> dict:
            summary = session["independent_validation"]["summary"]
            return {
                "track_ids": sorted(row.get("persistent_id") for row in summary.get("tracks", [])),
                "playlists": sorted(
                    (
                        row.get("persistent_id"),
                        row.get("name"),
                        tuple(member.get("track_persistent_id") for member in row.get("members", [])),
                        row.get("smart_rule_objects"),
                        row.get("special_object"),
                    )
                    for row in summary.get("playlists", [])
                ),
            }
        mutation_identity = serialized_identity(mutation)
        verification_identity = serialized_identity(verification)
        result["serialized_identity_stability"] = {
            "mutation": mutation_identity,
            "verification": verification_identity,
            "passed": mutation_identity == verification_identity,
        }
        if mutation_identity != verification_identity:
            raise RuntimeError("serialized track/playlist identities changed on verification save")
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
        try:
            result["profile_junction_remove"] = remove_profile_junction(profile, live_dir)
        except Exception as exc:
            result["profile_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
            result["passed"] = False
            result["status"] = "failed_with_preserved_evidence"
        result["final_inventory"] = inventory(live_dir)
        result["finished_utc"] = utc_now()
        write_json(case_evidence / "result.json", result)
    return result


def run(args: argparse.Namespace) -> int:
    if os.name != "nt":
        raise RuntimeError("native matrix requires Windows")
    if not args.confirm_disposable:
        raise RuntimeError("native matrix requires --confirm-disposable")
    if not CANDIDATE.is_file() or sha256_file(CANDIDATE) != CANDIDATE_SHA256:
        raise RuntimeError("pinned template-free candidate is missing or changed")
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
    fields = [case["field"] for case in cases]
    if len(fields) != len(set(fields)):
        raise RuntimeError("field matrix contains duplicate property cases")
    roots.mkdir(parents=True)
    evidence.mkdir(parents=True)
    shutil.copy2(cases_path, evidence / "case-matrix.json")
    summary: dict[str, Any] = {
        "schema_version": 1,
        "started_utc": utc_now(),
        "status": "running",
        "candidate": file_facts(CANDIDATE),
        "case_matrix": file_facts(cases_path),
        "environment": {
            "platform": platform.platform(),
            "python": sys.version,
            "itunes_version": EXPECTED_ITUNES_VERSION,
            "itunes_executable": file_facts(ITUNES_EXE),
        },
        "policy": {
            "isolated_profile_per_case": True,
            "one_property_write_per_case": True,
            "complete_snapshot_fixed_before_restart": True,
            "two_stable_reads_per_session": True,
            "normal_quit_required": True,
            "unexpected_modal_allowed": False,
            "fallback_artifacts_allowed": False,
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
