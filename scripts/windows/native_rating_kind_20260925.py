"""Bounded native RatingKind/Loved/Disliked research for iTunes 12.13.10.3.

Every case uses the pinned, previously native-qualified one-track ITL in a
fresh profile junction. Static type-library declarations and runtime COM
attempts are reported separately. Each rating case performs a first save, a
restart plus the same setter/save, and a second restart with verification-only
save. Unsupported members are evidence, not failures. Identity drift,
unexpected UI, fallback artifacts, parser disagreement, and abnormal Quit fail
closed. This does not turn structural parsing into universal acceptance.
"""
from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import importlib.metadata
import json
import locale
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

from native_rating_oracle import build_oracle, render_readme  # noqa: E402
from native_field_matrix import (  # noqa: E402
    CANDIDATE,
    CANDIDATE_SHA256,
    TARGET_TRACK,
    canonical,
    identity_errors,
    normalize_com_value,
    target_track,
)
from reference_generated_native import (  # noqa: E402
    EXPECTED_ITUNES_SHA256,
    EXPECTED_ITUNES_VERSION,
    ITUNES_EXE,
    authenticode,
    create_profile_junction,
    file_facts,
    forbidden_artifacts,
    inventory,
    remove_profile_junction,
    require_stopped,
    run_text,
    settle_no_unexpected_modal,
    sha256_file,
    write_json,
)

DEFAULT_CASES = WINDOWS_SCRIPTS / "native_rating_kind_20260925_cases.json"
DEFAULT_INSTALLER = REPO_ROOT.parents[1] / "iTunes64Setup-12.13.10.3.exe"
DEFAULT_INSTALLER_SHA256 = "cea2a74cae3f061eadc11358eeaae9b40cfdea9ec1ee037b47da54a64219e182"
OFFICIAL_ENTRY_URL = "https://www.apple.com/itunes/download/win64"
OFFICIAL_RESOLVED_URL = (
    "https://secure-appldnld.apple.com/itunes12/"
    "140-75773-20260908-6e5e0165-99cb-4b30-b541-1b615fccfc1a/iTunes64Setup.exe"
)
COM_MEMBERS = ("Rating", "RatingKind", "AlbumRating", "AlbumRatingKind", "Loved", "Disliked")
INVOKE_KIND = {1: "method", 2: "property_get", 4: "property_put", 8: "property_putref"}
OWNED_MARKER = ".native-rating-kind-20260925-owned"


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def exception_record(exc: BaseException) -> dict:
    row: dict[str, Any] = {
        "type": type(exc).__name__,
        "message": str(exc),
        "args_repr": repr(exc.args),
    }
    for name in ("hresult", "scode", "excepinfo"):
        if hasattr(exc, name):
            row[name] = normalize_com_value(getattr(exc, name))
    return row


def diff_ranges(before: bytes, after: bytes, *, limit: int = 128) -> dict:
    """Return deterministic bounded raw-byte ranges, including size changes."""
    changed = [
        index
        for index in range(max(len(before), len(after)))
        if (before[index] if index < len(before) else None)
        != (after[index] if index < len(after) else None)
    ]
    ranges: list[tuple[int, int]] = []
    for index in changed:
        if not ranges or index != ranges[-1][1]:
            ranges.append((index, index + 1))
        else:
            ranges[-1] = (ranges[-1][0], index + 1)
    rows = [
        {
            "start": start,
            "end_exclusive": end,
            "length": end - start,
            "before_hex": before[start : min(end, len(before))].hex(),
            "after_hex": after[start : min(end, len(after))].hex(),
        }
        for start, end in ranges[:limit]
    ]
    return {
        "before_bytes": len(before),
        "after_bytes": len(after),
        "changed_byte_positions": len(changed),
        "range_count": len(ranges),
        "ranges": rows,
        "ranges_truncated": len(ranges) > limit,
    }


def inspect_typelib(path: Path = ITUNES_EXE) -> dict:
    import pythoncom

    library = pythoncom.LoadTypeLib(str(path))
    wanted = {name.lower(): name for name in COM_MEMBERS}
    interfaces: dict[str, list[dict]] = {}
    for index in range(library.GetTypeInfoCount()):
        info = library.GetTypeInfo(index)
        interface_name = library.GetDocumentation(index)[0]
        if interface_name not in {"IITTrack", "IITFileOrCDTrack"}:
            continue
        attr = info.GetTypeAttr()
        entries: list[dict] = []
        for function_index in range(attr.cFuncs):
            descriptor = info.GetFuncDesc(function_index)
            names = info.GetNames(descriptor.memid)
            if not names or names[0].lower() not in wanted:
                continue
            entries.append(
                {
                    "canonical_name": wanted[names[0].lower()],
                    "declared_name": names[0],
                    "memid": descriptor.memid,
                    "invkind": int(descriptor.invkind),
                    "invkind_name": INVOKE_KIND.get(int(descriptor.invkind), "unknown"),
                    "funcflags": int(descriptor.wFuncFlags),
                }
            )
        interfaces[interface_name] = entries
    file_members = interfaces.get("IITFileOrCDTrack", [])
    return {
        "source": str(path),
        "interfaces": interfaces,
        "file_track_members": {
            name: [row for row in file_members if row["canonical_name"] == name]
            for name in COM_MEMBERS
        },
    }


def _attempt_get(track: Any, member: str) -> dict:
    row = {"member": member, "operation": "get", "attempted": True}
    try:
        row.update(outcome="observed", value=normalize_com_value(getattr(track, member)))
    except Exception as exc:
        row.update(outcome="blocked", error=exception_record(exc))
    return row


def _attempt_set(track: Any, member: str, value: Any) -> dict:
    row = {"member": member, "operation": "put", "attempted": True, "requested": value}
    try:
        setattr(track, member, value)
        row.update(outcome="observed")
        try:
            row["readback"] = normalize_com_value(getattr(track, member))
        except Exception as readback_exc:
            row["readback_blocked"] = exception_record(readback_exc)
    except Exception as exc:
        row.update(outcome="blocked", error=exception_record(exc))
    return row


def probe_members(track: Any, *, attempt_setters: bool) -> dict:
    getters = {name: _attempt_get(track, name) for name in COM_MEMBERS}
    result: dict[str, Any] = {"getters": getters, "setters": {}, "interaction": None}
    if not attempt_setters:
        result["interaction"] = {
            "outcome": "not_attempted",
            "reason": "setter attempts are isolated to the interface-probe case",
        }
        return result

    # Assign current values where readable, so a surprising writable
    # implementation does not intentionally change state during classification.
    for name in ("Rating", "RatingKind", "AlbumRating", "AlbumRatingKind"):
        result["setters"][name] = _attempt_set(track, name, getters[name].get("value", 0))
    for name in ("Loved", "Disliked"):
        result["setters"][name] = _attempt_set(track, name, getters[name].get("value", False))

    pair_available = all(
        getters[name]["outcome"] == "observed"
        and result["setters"][name]["outcome"] == "observed"
        for name in ("Loved", "Disliked")
    )
    if not pair_available:
        result["interaction"] = {
            "outcome": "blocked",
            "reason": "Loved and Disliked did not both expose readable/writable runtime members",
        }
        return result

    initial = {name: getters[name]["value"] for name in ("Loved", "Disliked")}
    steps = []
    try:
        for member, value in (
            ("Loved", True),
            ("Disliked", True),
            ("Loved", False),
            ("Disliked", False),
        ):
            put = _attempt_set(track, member, value)
            state = {name: _attempt_get(track, name) for name in ("Loved", "Disliked")}
            steps.append({"put": put, "state": state})
            if put["outcome"] != "observed":
                raise RuntimeError(f"{member} interaction setter became unavailable")
        result["interaction"] = {"outcome": "observed", "steps": steps}
    except Exception as exc:
        result["interaction"] = {"outcome": "blocked", "steps": steps, "error": exception_record(exc)}
    finally:
        result["interaction_restore"] = {
            name: _attempt_set(track, name, value) for name, value in initial.items()
        }
    return result


def _find_runtime_track(app: Any) -> Any:
    from native_worker import file_interface, items, pid

    matches = [
        file_interface(app, item)
        for item in items(app.LibraryPlaylist.Tracks)
        if pid(app, item) == TARGET_TRACK
    ]
    if len(matches) != 1:
        raise RuntimeError(f"expected one target runtime track, got {len(matches)}")
    return matches[0]


def worker(spec_path: Path, output_path: Path) -> int:
    import pythoncom
    import win32com.client
    from native_worker import snapshot

    spec = json.loads(spec_path.read_text(encoding="utf-8"))
    result: dict[str, Any] = {
        "schema_version": 1,
        "started_utc": utc_now(),
        "spec": spec,
        "samples": [],
        "operation_log": [],
        "accepted": False,
        "quit_requested": False,
    }
    app = None
    pythoncom.CoInitialize()
    try:
        app = win32com.client.dynamic.Dispatch("iTunes.Application")

        def log(action: str, **details: Any) -> None:
            result["operation_log"].append({"utc": utc_now(), "action": action, **details})
            write_json(output_path, result)

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
        result["before_stable"] = before_1 == before_2
        if not result["before_stable"]:
            raise RuntimeError("pre-operation COM snapshot was unstable")
        if any(sample["identity_errors"] for sample in result["samples"]):
            raise RuntimeError("identity gate failed before operation")

        track = _find_runtime_track(app)
        mode = spec["mode"]
        result["member_probes"] = probe_members(track, attempt_setters=mode == "probe")
        log("member_probes_complete", mode=mode)

        if mode in {"rating_mutation", "rating_repeat"}:
            requested = spec["rating"]
            before_rating = normalize_com_value(getattr(track, "Rating"))
            setattr(track, "Rating", requested)
            immediate = normalize_com_value(getattr(track, "Rating"))
            result["rating_write"] = {
                "requested": requested,
                "before": before_rating,
                "immediate": immediate,
                "exact": immediate == requested,
                "same_value_request": before_rating == requested,
            }
            log(
                "rating_put",
                requested=requested,
                before=before_rating,
                immediate=immediate,
                same_value_request=before_rating == requested,
            )
            if immediate != requested:
                raise RuntimeError("Rating readback did not equal the requested value")
        elif mode in {"rating_verify", "probe", "probe_reload"}:
            log("no_rating_put", mode=mode)
        else:
            raise RuntimeError(f"unknown worker mode: {mode}")

        after_1 = take("after-1")
        after_2 = take("after-2", 2.0)
        result["after_stable"] = after_1 == after_2
        if not result["after_stable"]:
            raise RuntimeError("post-operation COM snapshot was unstable")
        if any(sample["identity_errors"] for sample in result["samples"]):
            raise RuntimeError("identity gate failed after operation")
        if "rating" in spec:
            observed = target_track(after_2).get("Rating")
            result["rating_gate"] = {
                "expected": spec["rating"],
                "actual": observed,
                "passed": observed == spec["rating"],
            }
            if observed != spec["rating"]:
                raise RuntimeError("Rating did not match at end of COM session")

        result["within_session_snapshot_changed"] = before_2 != after_2
        result["accepted"] = True
        app.Quit()
        result["quit_requested"] = True
        log("normal_quit_requested")
        result["finished_utc"] = utc_now()
        write_json(output_path, result)
        return 0
    except Exception as exc:
        result.update(
            accepted=False,
            error=exception_record(exc),
            traceback=traceback.format_exc(),
            finished_utc=utc_now(),
        )
        write_json(output_path, result)
        return 2
    finally:
        app = None
        pythoncom.CoUninitialize()


def _one(items: list[Any], description: str) -> Any:
    if len(items) != 1:
        raise RuntimeError(f"expected exactly one {description}, got {len(items)}")
    return items[0]


def _primary_target(raw: bytes):
    """Use primary container/model parsing even when global semantic gates refuse."""
    from itlkit.binary import uint
    from itlkit.container import Container
    from itlkit.library import Library
    from itlkit.model import parse_sections

    container = Container.from_bytes(raw)
    sections = parse_sections(container.payload)
    track_section = _one([section for section in sections if section.section_type == 1], "primary track section")
    track_root = _one(track_section.children or [], "primary track root")
    track_node = _one(
        [
            node
            for node in track_root.children or []
            if node.tag == b"mith" and f"{uint(node.header, 0x80, 8):016X}" == TARGET_TRACK
        ],
        "primary target track node",
    )
    try:
        library = Library.from_bytes(raw)
        high_level = {"outcome": "observed", "track_count": len(library.tracks)}
    except Exception as exc:
        # The pinned native-qualified source predates a newer global identity
        # gate (secondary track ID). Preserve that refusal without discarding
        # the primary parser's bounded container/section/record evidence.
        high_level = {"outcome": "blocked", "error": exception_record(exc)}
    return container, track_node, high_level


def analyze_snapshot(path: Path) -> dict:
    """Parse with primary and independent implementations plus VALIDATOR."""
    from itlkit.binary import uint
    from REFERENCE_PARSER.core import ReferenceLibrary
    from VALIDATOR.validator import validate_bytes

    raw = path.read_bytes()
    container, primary_node, high_level = _primary_target(raw)
    independent = ReferenceLibrary.from_bytes(raw)
    independent_rows = list(independent.track_semantics())
    independent_row = _one(
        [row for row in independent_rows if row.get("persistent_id") == TARGET_TRACK],
        "independent target track",
    )
    independent_record = independent.track_records[independent_rows.index(independent_row)]
    primary_header = bytes(primary_node.header)
    independent_header = bytes(independent_record.header)
    validation = validate_bytes(raw)
    primary_rating = uint(primary_header, 0x6C, 1)
    primary_refresh = uint(primary_header, 0x6D, 1)
    primary_loved_byte = uint(primary_header, 0x2BF, 1)
    primary_loved = bool(primary_loved_byte & 0x02)
    errors: list[dict] = []

    def check(name: str, expected: Any, actual: Any) -> None:
        if expected != actual:
            errors.append({"property": name, "expected": expected, "actual": actual})

    check("primary_vs_independent.rating", primary_rating, independent_row["rating"])
    check("primary_vs_independent.legacy_loved_bit", primary_loved, independent_row["legacy_loved_bit"])
    check("primary_vs_independent.header", primary_header, independent_header)
    check("validator.valid", True, validation.get("valid"))
    check("version", EXPECTED_ITUNES_VERSION, container.version)
    check("track_header_length", 756, len(primary_header))
    return {
        "file": file_facts(path),
        "primary": {
            "parser_path": "itlkit.Container + itlkit.model.parse_sections",
            "high_level_library": high_level,
            "version": container.version,
            "persistent_id": TARGET_TRACK,
            "rating": primary_rating,
            "name_refresh_flag_raw": primary_refresh,
            "legacy_loved_bit": primary_loved,
            "legacy_loved_byte_raw": primary_loved_byte,
            "track_header_length": len(primary_header),
            "track_header_sha256": hashlib.sha256(primary_header).hexdigest(),
            "rating_window_0x60_0x72": primary_header[0x60:0x72].hex(),
            "legacy_loved_window_0x2b8_0x2c4": primary_header[0x2B8:0x2C4].hex(),
        },
        "independent": {
            "track": independent_row,
            "track_header_sha256": hashlib.sha256(independent_header).hexdigest(),
        },
        "validator": validation,
        "errors": errors,
        "passed": not errors,
    }


def transition_report(before_path: Path, after_path: Path) -> dict:
    before_raw = before_path.read_bytes()
    after_raw = after_path.read_bytes()
    before_analysis = analyze_snapshot(before_path)
    after_analysis = analyze_snapshot(after_path)
    _, before_node, _ = _primary_target(before_raw)
    _, after_node, _ = _primary_target(after_raw)
    fields = ("rating", "name_refresh_flag_raw", "legacy_loved_byte_raw", "legacy_loved_bit")
    before_fields = {field: before_analysis["primary"][field] for field in fields}
    after_fields = {field: after_analysis["primary"][field] for field in fields}
    return {
        "before": before_analysis["file"],
        "after": after_analysis["file"],
        "raw_itl_diff": diff_ranges(before_raw, after_raw),
        "track_header_diff": diff_ranges(bytes(before_node.header), bytes(after_node.header)),
        "target_fields": {
            field: {"before": before_fields[field], "after": after_fields[field]}
            for field in fields
        },
        "primary_and_independent_parsers_passed": before_analysis["passed"] and after_analysis["passed"],
    }

def run_session(case: dict, root: Path, case_evidence: Path, phase: str, mode: str) -> dict:
    from desktop_probe import snapshot as desktop_snapshot
    from native_driver import wait_ready

    live = root / "live" / "iTunes Library.itl"
    session_dir = case_evidence / phase
    session_dir.mkdir(parents=True, exist_ok=False)
    spec: dict[str, Any] = {
        "schema_version": 1,
        "case": case["name"],
        "phase": phase,
        "mode": mode,
    }
    if case["mode"] == "rating":
        spec["rating"] = case["rating"]
    result: dict[str, Any] = {
        "phase": phase,
        "mode": mode,
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
        completed = subprocess.run(
            command,
            cwd=str(REPO_ROOT),
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            timeout=180,
        )
        (session_dir / "worker.log").write_text(completed.stdout, encoding="utf-8")
        result["worker_exit_code"] = completed.returncode
        result["worker"] = json.loads(output_path.read_text(encoding="utf-8"))
        if completed.returncode or not result["worker"].get("accepted"):
            raise RuntimeError("native COM worker gate failed")
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
        result["targeted_validation"] = analyze_snapshot(saved)
        if not result["targeted_validation"]["passed"]:
            raise RuntimeError("primary/independent parser or validator gate failed")
        result["status"] = "passed"
    except Exception as exc:
        result.update(
            status="failed",
            error=exception_record(exc),
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
    baseline = case_evidence / "baseline.itl"
    shutil.copy2(CANDIDATE, live)
    shutil.copy2(CANDIDATE, baseline)
    result: dict[str, Any] = {
        "name": case["name"],
        "case": case,
        "candidate": file_facts(CANDIDATE),
        "baseline_analysis": analyze_snapshot(baseline),
        "started_utc": utc_now(),
        "sessions": [],
    }
    try:
        result["profile_junction_create"] = create_profile_junction(profile, live_dir)
        if case["mode"] == "probe":
            plan = (("probe", "probe"), ("reload", "probe_reload"))
        elif case["mode"] == "rating":
            plan = (
                ("mutation", "rating_mutation"),
                ("same-value-repeat", "rating_repeat"),
                ("restart-verification", "rating_verify"),
            )
        else:
            raise RuntimeError(f"unknown case mode: {case['mode']}")
        for phase, mode in plan:
            session = run_session(case, root, case_evidence, phase, mode)
            result["sessions"].append(session)
            if session["status"] != "passed":
                raise RuntimeError(f"session failed: {phase}")

        paths = [("baseline", baseline)] + [
            (session["phase"], case_evidence / session["phase"] / "native-saved.itl")
            for session in result["sessions"]
        ]
        result["snapshot_analyses"] = {name: analyze_snapshot(path) for name, path in paths}
        result["transitions"] = {
            f"{left_name}_to_{right_name}": transition_report(left_path, right_path)
            for (left_name, left_path), (right_name, right_path) in zip(paths, paths[1:])
        }
        if case["mode"] == "rating":
            expected = case["rating"]
            observed = {
                name: analysis["primary"]["rating"]
                for name, analysis in result["snapshot_analyses"].items()
                if name != "baseline"
            }
            result["rating_persistence"] = {
                "expected": expected,
                "observed": observed,
                "passed": all(value == expected for value in observed.values()),
            }
            if not result["rating_persistence"]["passed"]:
                raise RuntimeError("rating did not persist through all native saves/restarts")
        result.update(passed=True, status="passed")
    except Exception as exc:
        result.update(
            passed=False,
            status="failed_with_preserved_evidence",
            error=exception_record(exc),
            traceback=traceback.format_exc(),
        )
    finally:
        try:
            require_stopped()
            result["profile_junction_remove"] = remove_profile_junction(profile, live_dir)
        except Exception as exc:
            result["profile_junction_remove_error"] = exception_record(exc)
            result["passed"] = False
            result["status"] = "failed_with_preserved_evidence"
    result["finished_utc"] = utc_now()
    write_json(case_evidence / "case-result.json", result)
    return result


def classify_capabilities(typelib: dict, runtime_probes: dict) -> dict:
    """Keep static declarations, attempts, observations, and blocks distinct."""
    result: dict[str, Any] = {}
    getters = runtime_probes.get("getters", {})
    setters = runtime_probes.get("setters", {})
    declarations = typelib.get("file_track_members", {})
    for member in COM_MEMBERS:
        declared = declarations.get(member, [])
        runtime_get = getters.get(member, {"attempted": False, "outcome": "not_attempted"})
        runtime_put = setters.get(member, {"attempted": False, "outcome": "not_attempted"})
        if runtime_get.get("outcome") == "observed" and runtime_put.get("outcome") == "observed":
            classification = "writable"
        elif runtime_get.get("outcome") == "observed" and runtime_put.get("outcome") == "blocked":
            classification = "read_only"
        elif runtime_get.get("outcome") == "blocked" and runtime_put.get("outcome") == "blocked":
            classification = "unsupported"
        else:
            classification = "inconclusive"
        result[member] = {
            "typelib": {
                "declared_get": any(row.get("invkind_name") == "property_get" for row in declared),
                "declared_put": any(
                    row.get("invkind_name") in {"property_put", "property_putref"} for row in declared
                ),
                "entries": declared,
            },
            "runtime_get": runtime_get,
            "runtime_put": runtime_put,
            "classification": classification,
        }
    return result


def _powershell_version_facts(path: Path) -> dict:
    quoted = str(path).replace("'", "''")
    script = (
        f"$i=Get-Item -LiteralPath '{quoted}';"
        "[pscustomobject]@{FileVersion=$i.VersionInfo.FileVersion;"
        "ProductVersion=$i.VersionInfo.ProductVersion;Length=$i.Length}|ConvertTo-Json -Compress"
    )
    command = run_text(["pwsh", "-NoProfile", "-Command", script])
    if command["returncode"]:
        return {"status": "blocked", "command": command}
    return {"status": "observed", "value": json.loads(command["output"]), "command": command}


def _official_redirect() -> dict:
    command = run_text(
        [
            "curl.exe",
            "-sS",
            "-L",
            "-I",
            "--max-time",
            "30",
            "-w",
            "FINAL_URL=%{url_effective}\\nHTTP=%{http_code}\\n",
            "-o",
            "NUL",
            OFFICIAL_ENTRY_URL,
        ],
        timeout=45,
    )
    lines = dict(line.split("=", 1) for line in command["output"].splitlines() if "=" in line)
    return {
        "entry_url": OFFICIAL_ENTRY_URL,
        "expected_resolved_url": OFFICIAL_RESOLVED_URL,
        "observed_resolved_url": lines.get("FINAL_URL"),
        "http_status": lines.get("HTTP"),
        "command": command,
    }


def _manifest_errors(manifest: dict) -> list[str]:
    errors: list[str] = []
    if manifest.get("schema_version") != 1:
        errors.append("unsupported schema_version")
    if manifest.get("candidate_sha256") != CANDIDATE_SHA256:
        errors.append("candidate SHA does not match the pinned harness SHA")
    cases = manifest.get("cases")
    if not isinstance(cases, list) or not cases:
        errors.append("cases must be a nonempty list")
        return errors
    names = [case.get("name") for case in cases]
    if len(names) != len(set(names)) or any(not name for name in names):
        errors.append("case names must be unique nonempty strings")
    probes = [case for case in cases if case.get("mode") == "probe"]
    ratings = sorted(case.get("rating") for case in cases if case.get("mode") == "rating")
    if len(probes) != 1:
        errors.append("exactly one interface probe is required")
    if ratings != [0, 20, 40, 60, 80, 100]:
        errors.append("rating ladder must be exactly 0,20,40,60,80,100")
    if any(case.get("mode") not in {"probe", "rating"} for case in cases):
        errors.append("unknown case mode")
    return errors


def run(args: argparse.Namespace) -> int:
    if os.name != "nt":
        raise RuntimeError("native harness requires Windows")
    manifest = json.loads(args.cases.read_text(encoding="utf-8"))
    errors = _manifest_errors(manifest)
    if errors:
        raise RuntimeError("invalid cases manifest: " + "; ".join(errors))
    if args.evidence.exists() or args.roots.exists():
        raise RuntimeError("evidence and roots paths must both be new")
    if args.profile.exists() or args.profile.is_symlink():
        raise RuntimeError(f"refusing to replace an existing user iTunes profile: {args.profile}")
    require_stopped()
    if sha256_file(CANDIDATE) != CANDIDATE_SHA256:
        raise RuntimeError("pinned candidate SHA-256 mismatch")
    if sha256_file(ITUNES_EXE) != EXPECTED_ITUNES_SHA256:
        raise RuntimeError("installed iTunes executable SHA-256 mismatch")
    if not args.installer.is_file() or sha256_file(args.installer) != DEFAULT_INSTALLER_SHA256:
        raise RuntimeError("installer missing or SHA-256 mismatch")

    args.evidence.mkdir(parents=True)
    args.roots.mkdir(parents=True)
    (args.roots / OWNED_MARKER).write_text(utc_now() + "\n", encoding="utf-8")
    shutil.copy2(args.cases, args.evidence / "cases-input.json")
    shutil.copy2(CANDIDATE, args.evidence / "pinned-baseline.itl")
    type_library = inspect_typelib()
    try:
        pywin32_version = importlib.metadata.version("pywin32")
    except importlib.metadata.PackageNotFoundError:
        pywin32_version = None
    report: dict[str, Any] = {
        "schema_version": 1,
        "scope": manifest["scope"],
        "started_utc": utc_now(),
        "safety_boundary": {
            "isolated_profile": str(args.profile),
            "disposable_roots": str(args.roots),
            "candidate": file_facts(CANDIDATE),
            "user_data_touched": False,
            "ui_policy": "known audio warning only; all other modal states fail closed",
        },
        "environment": {
            "os": platform.platform(),
            "windows_version": platform.version(),
            "python": sys.version,
            "python_executable": sys.executable,
            "pywin32": pywin32_version,
            "locale": locale.getlocale(),
            "preferred_encoding": locale.getpreferredencoding(False),
            "timezone": str(dt.datetime.now().astimezone().tzinfo),
        },
        "provenance": {
            "official_installer_url": _official_redirect(),
            "installer": {
                **file_facts(args.installer),
                "expected_sha256": DEFAULT_INSTALLER_SHA256,
                "version": _powershell_version_facts(args.installer),
                "authenticode": authenticode(args.installer),
            },
            "itunes": {
                **file_facts(ITUNES_EXE),
                "expected_sha256": EXPECTED_ITUNES_SHA256,
                "expected_version": EXPECTED_ITUNES_VERSION,
                "version": _powershell_version_facts(ITUNES_EXE),
                "authenticode": authenticode(ITUNES_EXE),
            },
            "typelib": type_library,
        },
        "cases": [],
    }
    write_json(args.evidence / "report.partial.json", report)
    for case in manifest["cases"]:
        case_result = run_case(case, args.roots, args.evidence, args.profile)
        report["cases"].append(case_result)
        write_json(args.evidence / "report.partial.json", report)

    probe_case = next((case for case in report["cases"] if case["case"]["mode"] == "probe"), None)
    if probe_case and probe_case.get("sessions"):
        probes = probe_case["sessions"][0].get("worker", {}).get("member_probes", {})
        report["capabilities"] = classify_capabilities(type_library, probes)
        report["loved_disliked_interaction"] = probes.get("interaction")
    else:
        report["capabilities"] = {}
        report["loved_disliked_interaction"] = {
            "outcome": "blocked",
            "reason": "interface-probe case did not produce runtime evidence",
        }

    report["counts"] = {
        "cases_total": len(report["cases"]),
        "cases_passed": sum(bool(case.get("passed")) for case in report["cases"]),
        "native_sessions": sum(len(case.get("sessions", [])) for case in report["cases"]),
        "native_sessions_passed": sum(
            session.get("status") == "passed"
            for case in report["cases"]
            for session in case.get("sessions", [])
        ),
        "rating_values": [
            case["case"]["rating"]
            for case in report["cases"]
            if case["case"]["mode"] == "rating"
        ],
    }
    report["observed"] = [
        "COM type-library declarations were inspected from the installed signed iTunes executable.",
        "Each rating value used a fresh isolated copy of the pinned one-track ITL.",
        "Every saved snapshot was parsed by the primary and independent parsers and passed VALIDATOR.",
    ]
    report["attempted"] = [
        "RatingKind and AlbumRatingKind getter and same-value setter attempts.",
        "Loved and Disliked getter and setter attempts.",
        "Loved/Disliked interaction sequence only if both runtime members were readable and writable.",
        "Rating 0/20/40/60/80/100 mutation, same-value repeat save, and restart verification.",
    ]
    report["blocked"] = [
        {
            "member": name,
            "classification": details["classification"],
            "runtime_get": details["runtime_get"],
            "runtime_put": details["runtime_put"],
        }
        for name, details in report["capabilities"].items()
        if details["classification"] in {"read_only", "unsupported", "inconclusive"}
    ]
    report["passed"] = all(case.get("passed") for case in report["cases"])
    report["finished_utc"] = utc_now()
    report_path = args.evidence / "report.json"
    write_json(report_path, report)
    oracle = build_oracle(report, sha256_file(report_path))
    write_json(args.evidence / "oracle.json", oracle)
    (args.evidence / "README.md").write_text(render_readme(oracle), encoding="utf-8")
    partial = args.evidence / "report.partial.json"
    if partial.exists():
        partial.unlink()
    return 0 if report["passed"] else 2


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command")
    worker_parser = subparsers.add_parser("_worker")
    worker_parser.add_argument("--spec", type=Path, required=True)
    worker_parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--cases", type=Path, default=DEFAULT_CASES)
    parser.add_argument("--roots", type=Path)
    parser.add_argument("--evidence", type=Path)
    parser.add_argument("--profile", type=Path, default=Path.home() / "Music" / "iTunes")
    parser.add_argument("--installer", type=Path, default=DEFAULT_INSTALLER)
    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    if args.command == "_worker":
        return worker(args.spec, args.output)
    if args.roots is None or args.evidence is None:
        parser.error("--roots and --evidence are required for a native run")
    return run(args)


if __name__ == "__main__":
    raise SystemExit(main())
