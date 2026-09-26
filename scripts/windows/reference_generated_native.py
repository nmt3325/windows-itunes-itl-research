"""Native qualification for exact template-free reference-writer ITLs.

The runner is deliberately fail-closed.  Each candidate gets a new isolated
profile containing only its ITL, and must survive the requested number of
open/snapshot/save/restart cycles without XML, Previous iTunes Libraries,
damaged-library UI, fallback identities, or parser failures.
"""
from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import json
import locale
import os
from pathlib import Path
import platform
import re
import shutil
import stat
import subprocess
import sys
import time
import traceback

REPO_ROOT = Path(__file__).resolve().parents[2]
WINDOWS_SCRIPTS = Path(__file__).resolve().parent
for entry in (str(REPO_ROOT), str(WINDOWS_SCRIPTS)):
    if entry not in sys.path:
        sys.path.insert(0, entry)

ITUNES_EXE = Path(r"C:\Program Files\iTunes\iTunes.exe")
EXPECTED_ITUNES_VERSION = "12.13.10.3"
EXPECTED_ITUNES_SHA256 = "30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d"
OWNED_MARKER = ".reference-generated-native-owned"
DEFAULT_MANIFEST = WINDOWS_SCRIPTS / "reference_generated_native_cases.json"


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def write_json(path: Path, value: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temp = path.with_name(path.name + ".tmp")
    temp.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    temp.replace(path)


def run_text(command: list[str], *, timeout: int = 60, cwd: Path | None = None) -> dict:
    process = subprocess.run(
        command,
        cwd=str(cwd) if cwd else None,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        timeout=timeout,
    )
    return {"argv": command, "returncode": process.returncode, "output": process.stdout}


def version_facts(path: Path) -> dict:
    quoted = str(path).replace("'", "''")
    script = (
        f"$v=(Get-Item -LiteralPath '{quoted}').VersionInfo; "
        "[pscustomobject]@{FileVersion=[string]$v.FileVersion;"
        "ProductVersion=[string]$v.ProductVersion}|ConvertTo-Json -Compress"
    )
    command = run_text(["pwsh", "-NoLogo", "-NoProfile", "-Command", script])
    if command["returncode"]:
        raise RuntimeError("failed to read iTunes executable version: " + command["output"])
    try:
        observed = json.loads(command["output"])
    except json.JSONDecodeError as exc:
        raise RuntimeError("invalid iTunes executable version response") from exc
    return {
        "file_version": observed.get("FileVersion"),
        "product_version": observed.get("ProductVersion"),
        "command": command,
    }


def executable_identity_errors(
    *,
    expected_version: str,
    expected_sha256: str,
    observed_sha256: str,
    observed_file_version: str | None,
    observed_product_version: str | None,
) -> list[dict]:
    errors: list[dict] = []

    def mismatch(property_name: str, wanted, observed) -> None:
        if wanted != observed:
            errors.append({"property": property_name, "expected": wanted, "actual": observed})

    mismatch("sha256", expected_sha256.lower(), observed_sha256.lower())
    mismatch("file_version", expected_version, observed_file_version)
    mismatch("product_version", expected_version, observed_product_version)
    return errors


def validate_executable_identity(path: Path, expected_version: str, expected_sha256: str) -> dict:
    if not path.is_file():
        raise RuntimeError(f"installed iTunes executable is missing: {path}")
    observed_sha256 = sha256_file(path)
    versions = version_facts(path)
    errors = executable_identity_errors(
        expected_version=expected_version,
        expected_sha256=expected_sha256,
        observed_sha256=observed_sha256,
        observed_file_version=versions["file_version"],
        observed_product_version=versions["product_version"],
    )
    identity = {
        "path": str(path),
        "sha256": observed_sha256,
        "file_version": versions["file_version"],
        "product_version": versions["product_version"],
        "expected_sha256": expected_sha256.lower(),
        "expected_version": expected_version,
        "version_probe": versions["command"],
        "errors": errors,
    }
    if errors:
        raise RuntimeError("installed iTunes executable identity mismatch: " + json.dumps(errors, ensure_ascii=True))
    return identity


def expected_with_version(expected: dict, version: str) -> dict:
    projected = dict(expected)
    projected["version"] = version
    return projected


def require_stopped() -> None:
    import win32api
    import win32process

    found: list[int] = []
    for process_id in win32process.EnumProcesses():
        handle = None
        try:
            handle = win32api.OpenProcess(0x0400 | 0x0010, False, process_id)
            if Path(win32process.GetModuleFileNameEx(handle, 0)).name.lower() == "itunes.exe":
                found.append(process_id)
        except Exception:
            pass
        finally:
            if handle:
                handle.Close()
    if found:
        raise RuntimeError(f"iTunes is still running; refusing library replacement: {found}")


def file_facts(path: Path) -> dict:
    info = path.stat()
    return {
        "path": str(path),
        "bytes": info.st_size,
        "mtime_ns": info.st_mtime_ns,
        "sha256": sha256_file(path),
    }


def inventory(root: Path) -> list[dict]:
    rows: list[dict] = []
    for path in sorted(root.rglob("*"), key=lambda value: str(value).lower()):
        relative = path.relative_to(root).as_posix()
        row = {"path": relative, "kind": "directory" if path.is_dir() else "file"}
        if path.is_file():
            row.update({"bytes": path.stat().st_size, "sha256": sha256_file(path)})
        rows.append(row)
    return rows


def forbidden_artifacts(rows: list[dict]) -> list[dict]:
    failures: list[dict] = []
    for row in rows:
        path = row["path"]
        lower = path.lower()
        parts = [part.lower() for part in Path(path).parts]
        reasons: list[str] = []
        if "previous itunes libraries" in parts:
            reasons.append("previous_itunes_libraries")
        if row["kind"] == "file" and lower.endswith(".xml"):
            reasons.append("xml")
        if "damaged" in Path(path).name.lower():
            reasons.append("damaged_library_artifact")
        if reasons:
            failures.append({"path": path, "reasons": reasons})
    return failures


def create_profile_junction(profile: Path, target: Path) -> dict:
    if profile.exists() or profile.is_symlink():
        raise RuntimeError(f"per-user iTunes profile already exists: {profile}")
    profile.parent.mkdir(parents=True, exist_ok=True)
    command = run_text(["cmd.exe", "/d", "/c", "mklink", "/J", str(profile), str(target)])
    if command["returncode"] or not profile.exists() or not os.path.samefile(profile, target):
        raise RuntimeError("failed to create isolated iTunes profile junction: " + command["output"])
    return command


def remove_profile_junction(profile: Path, target: Path) -> dict:
    if not profile.exists() and not profile.is_symlink():
        return {"removed": False, "reason": "absent"}
    attributes = os.lstat(profile).st_file_attributes
    if not attributes & stat.FILE_ATTRIBUTE_REPARSE_POINT:
        raise RuntimeError("refusing to remove a non-reparse iTunes profile")
    if not os.path.samefile(profile, target):
        raise RuntimeError("profile junction target changed; refusing removal")
    command = run_text(["cmd.exe", "/d", "/c", "rmdir", str(profile)])
    if command["returncode"] or profile.exists():
        raise RuntimeError("failed to remove isolated profile junction")
    return {"removed": True, "command": command}


def expected_state_errors(expected: dict, actual: dict) -> list[dict]:
    errors: list[dict] = []

    def mismatch(property_name: str, wanted, observed) -> None:
        if wanted != observed:
            errors.append({"property": property_name, "expected": wanted, "actual": observed})

    mismatch("version", expected["version"], actual.get("version"))
    mismatch("library_persistent_id", expected["library_persistent_id"], actual.get("library_persistent_id"))
    mismatch("track_count", expected["track_count"], actual.get("track_count"))
    actual_tracks = {row.get("persistent_id"): row for row in actual.get("tracks", [])}
    expected_track_ids = [row["persistent_id"] for row in expected["tracks"]]
    mismatch("track_persistent_ids", sorted(expected_track_ids), sorted(key for key in actual_tracks if key))
    for row in expected["tracks"]:
        observed = actual_tracks.get(row["persistent_id"])
        if observed is None:
            continue
        mismatch(f"track[{row['persistent_id']}].Name", row["name"], observed.get("Name"))
    actual_playlists = {row.get("persistent_id"): row for row in actual.get("playlists", [])}
    for row in expected["playlists"]:
        observed = actual_playlists.get(row["persistent_id"])
        if observed is None:
            errors.append({"property": f"playlist[{row['persistent_id']}]", "expected": "present", "actual": "missing"})
            continue
        mismatch(f"playlist[{row['persistent_id']}].name", row["name"], observed.get("name"))
        members = [member.get("persistent_id") for member in observed.get("members", [])]
        mismatch(f"playlist[{row['persistent_id']}].members", row["members"], members)
    return errors


def reference_summary(path: Path) -> dict:
    command = [sys.executable, "-X", "utf8", "-B", "-m", "REFERENCE_PARSER", "summary", str(path)]
    process = subprocess.run(
        command,
        cwd=str(REPO_ROOT),
        text=True,
        encoding="utf-8",
        errors="strict",
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        timeout=60,
    )
    if process.returncode:
        raise RuntimeError("independent reference parser failed: " + process.stdout[:8000])
    return json.loads(process.stdout)


def reference_summary_errors(expected: dict, actual: dict) -> list[dict]:
    errors: list[dict] = []

    def mismatch(property_name: str, wanted, observed) -> None:
        if wanted != observed:
            errors.append({"property": property_name, "expected": wanted, "actual": observed})

    mismatch("version", expected["version"], actual.get("version"))
    mismatch("file_persistent_id", expected["library_persistent_id"], actual.get("file_persistent_id"))
    tracks = {row.get("persistent_id"): row for row in actual.get("tracks", [])}
    mismatch("track_persistent_ids", sorted(row["persistent_id"] for row in expected["tracks"]), sorted(key for key in tracks if key))
    for row in expected["tracks"]:
        observed = tracks.get(row["persistent_id"])
        if observed is not None:
            mismatch(f"track[{row['persistent_id']}].name", row["name"], observed.get("name"))
    playlists = {row.get("persistent_id"): row for row in actual.get("playlists", [])}
    for row in expected["playlists"]:
        observed = playlists.get(row["persistent_id"])
        if observed is None:
            errors.append({"property": f"playlist[{row['persistent_id']}]", "expected": "present", "actual": "missing"})
            continue
        mismatch(f"playlist[{row['persistent_id']}].name", row["name"], observed.get("name"))
        members = [item.get("track_persistent_id") for item in observed.get("members", [])]
        mismatch(f"playlist[{row['persistent_id']}].members", row["members"], members)
    return errors


def settle_no_unexpected_modal(process: subprocess.Popen, log: list[dict], seconds: float = 3.0) -> None:
    """Require a stable modal-free main window before COM qualification."""
    import win32con
    import win32gui
    from desktop_probe import snapshot as desktop_snapshot

    deadline = time.monotonic() + seconds
    while time.monotonic() < deadline:
        if process.poll() is not None:
            raise RuntimeError(f"iTunes exited during post-readiness settling: {process.returncode}")
        windows = [window for window in desktop_snapshot() if window["pid"] == process.pid]
        for window in windows:
            texts = " ".join(child["text"] for child in window["children"])
            if "problem with your audio configuration" in texts:
                buttons = [
                    child
                    for child in window["children"]
                    if child["id"] == 1 and child["class"] == "Button" and child["text"] == "OK"
                ]
                if len(buttons) != 1:
                    log.append({"action": "ambiguous_audio_warning_during_settle", "window": window})
                    raise RuntimeError("Known audio warning lacked exactly one OK button")
                log.append({"action": "dismiss_audio_warning_during_settle", "window": window})
                win32gui.PostMessage(buttons[0]["hwnd"], win32con.BM_CLICK, 0, 0)
                time.sleep(0.25)
                continue
            if window["class"] in {"iTunesCustomModalDialog", "#32770"}:
                log.append({"action": "unexpected_modal_during_settle", "window": window})
                raise RuntimeError("Unexpected modal during post-readiness settling")
        time.sleep(0.1)


def worker(spec_path: Path, output: Path) -> int:
    import pythoncom
    import win32com.client
    from native_worker import snapshot

    spec = json.loads(spec_path.read_text(encoding="utf-8"))
    result = {"schema_version": 1, "started_utc": utc_now(), "spec": spec, "samples": []}
    app = None
    pythoncom.CoInitialize()
    try:
        app = win32com.client.dynamic.Dispatch("iTunes.Application")
        for index, delay in enumerate((0.0, 2.0), start=1):
            deadline = time.monotonic() + delay
            while time.monotonic() < deadline:
                pythoncom.PumpWaitingMessages()
                time.sleep(min(0.1, max(0.001, deadline - time.monotonic())))
            state = snapshot(app)
            errors = expected_state_errors(spec["expected"], state)
            result["samples"].append({"index": index, "state": state, "errors": errors})
            write_json(output, result)
        result["errors"] = [error for sample in result["samples"] for error in sample["errors"]]
        if result["errors"]:
            result["accepted"] = False
            result["quit_requested"] = False
        else:
            result["accepted"] = True
            app.Quit()
            result["quit_requested"] = True
        result["finished_utc"] = utc_now()
        write_json(output, result)
        return 0 if result["accepted"] else 2
    except Exception as exc:
        result.update(
            accepted=False,
            quit_requested=False,
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
            finished_utc=utc_now(),
        )
        write_json(output, result)
        return 2
    finally:
        app = None
        pythoncom.CoUninitialize()


def run_cycle(
    case: dict,
    native_expected: dict,
    root: Path,
    case_evidence: Path,
    cycle_number: int,
    previous_sha256: str,
) -> dict:
    from desktop_probe import snapshot as desktop_snapshot
    from native_driver import wait_ready

    live = root / "live" / "iTunes Library.itl"
    cycle = case_evidence / f"cycle-{cycle_number}"
    cycle.mkdir(parents=True, exist_ok=False)
    result = {
        "cycle": cycle_number,
        "started_utc": utc_now(),
        "expected_prelaunch_sha256": previous_sha256,
        "ui": [],
    }
    process: subprocess.Popen | None = None
    try:
        require_stopped()
        result["prelaunch"] = file_facts(live)
        if result["prelaunch"]["sha256"] != previous_sha256:
            raise RuntimeError("cycle input hash does not match the prior saved output")
        result["inventory_before"] = inventory(root / "live")
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
        spec = {
            "schema_version": 2,
            "case": case["name"],
            "cycle": cycle_number,
            "expected_input": case["expected"],
            "expected": native_expected,
        }
        spec_path = cycle / "worker-spec.json"
        output_path = cycle / "com.json"
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
        worker = subprocess.run(
            command,
            cwd=str(REPO_ROOT),
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            timeout=120,
        )
        (cycle / "worker.log").write_text(worker.stdout, encoding="utf-8")
        result["worker_exit_code"] = worker.returncode
        result["worker"] = json.loads(output_path.read_text(encoding="utf-8"))
        if worker.returncode or not result["worker"].get("accepted"):
            raise RuntimeError("native COM identity/semantic gate failed")
        process.wait(timeout=45)
        result["itunes_exit_code"] = process.returncode
        if process.returncode != 0:
            raise RuntimeError("iTunes exited nonzero after native Quit")
        require_stopped()
        time.sleep(0.5)
        result["inventory_after"] = inventory(root / "live")
        result["forbidden_after"] = forbidden_artifacts(result["inventory_after"])
        if result["forbidden_after"]:
            raise RuntimeError("XML, Previous iTunes Libraries, or damaged-library artifacts appeared")
        if not live.is_file() or live.read_bytes()[:4] != b"hdfm":
            raise RuntimeError("native-saved live library is missing or lacks hdfm magic")
        saved = cycle / "native-saved.itl"
        shutil.copy2(live, saved)
        result["saved"] = file_facts(saved)
        result["reference_summary"] = reference_summary(saved)
        result["reference_summary_errors"] = reference_summary_errors(native_expected, result["reference_summary"])
        if result["reference_summary_errors"]:
            raise RuntimeError("native-saved ITL failed independent semantic identity gates")
        result["status"] = "passed"
    except Exception as exc:
        result.update(status="failed", error=type(exc).__name__ + ": " + str(exc), traceback=traceback.format_exc())
        if process is not None:
            result["itunes_poll_at_failure"] = process.poll()
            result["windows_at_failure"] = [window for window in desktop_snapshot() if window["pid"] == process.pid]
            if process.poll() is None:
                process.kill()
                process.wait(timeout=10)
            result["itunes_exit_after_kill"] = process.returncode
        if live.is_file():
            failure_copy = cycle / "live-at-failure.itl"
            shutil.copy2(live, failure_copy)
            result["live_at_failure"] = file_facts(failure_copy)
        result["inventory_at_failure"] = inventory(root / "live")
    result["finished_utc"] = utc_now()
    write_json(cycle / "result.json", result)
    return result


def run_case(
    case: dict,
    root_parent: Path,
    evidence: Path,
    cycles: int,
    profile: Path,
    expected_native_version: str,
) -> dict:
    if not re.fullmatch(r"[A-Za-z0-9_-]+", case["name"]):
        raise ValueError("unsafe case name")
    candidate = (REPO_ROOT / case["candidate"]).resolve()
    if not candidate.is_relative_to(REPO_ROOT) or not candidate.is_file():
        raise RuntimeError("candidate path is not a repository file")
    if sha256_file(candidate) != case["sha256"]:
        raise RuntimeError("candidate hash differs from the pinned manifest")
    case_root = root_parent / case["name"]
    live_dir = case_root / "live"
    case_evidence = evidence / "cases" / case["name"]
    case_evidence.mkdir(parents=True, exist_ok=False)
    live_dir.mkdir(parents=True, exist_ok=False)
    (case_root / OWNED_MARKER).write_text("owned disposable GHA reference-writer test\n", encoding="ascii")
    live = live_dir / "iTunes Library.itl"
    shutil.copy2(candidate, live)
    native_expected = expected_with_version(case["expected"], expected_native_version)
    result = {
        "name": case["name"],
        "candidate": file_facts(candidate),
        "candidate_relative_path": case["candidate"],
        "expected": case["expected"],
        "expected_input": case["expected"],
        "expected_native": native_expected,
        "started_utc": utc_now(),
        "cycles_requested": cycles,
        "cycles": [],
    }
    result["candidate_reference_summary"] = reference_summary(candidate)
    result["candidate_reference_summary_errors"] = reference_summary_errors(
        case["expected"], result["candidate_reference_summary"]
    )
    if result["candidate_reference_summary_errors"]:
        raise RuntimeError("pinned candidate disagrees with its native-test manifest")
    try:
        result["profile_junction_create"] = create_profile_junction(profile, live_dir)
        previous_sha256 = case["sha256"]
        for cycle_number in range(1, cycles + 1):
            cycle = run_cycle(case, native_expected, case_root, case_evidence, cycle_number, previous_sha256)
            result["cycles"].append(cycle)
            write_json(case_evidence / "result.json", result)
            if cycle["status"] != "passed":
                break
            previous_sha256 = cycle["saved"]["sha256"]
        result["passed"] = len(result["cycles"]) == cycles and all(row["status"] == "passed" for row in result["cycles"])
        result["status"] = "passed" if result["passed"] else "failed"
    except Exception as exc:
        result.update(passed=False, status="failed", error=type(exc).__name__ + ": " + str(exc), traceback=traceback.format_exc())
    finally:
        try:
            require_stopped()
        except Exception as exc:
            result["stopped_gate_error"] = type(exc).__name__ + ": " + str(exc)
        try:
            result["profile_junction_remove"] = remove_profile_junction(profile, live_dir)
        except Exception as exc:
            result["profile_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
            result["passed"] = False
            result["status"] = "failed"
        result["final_inventory"] = inventory(live_dir)
        result["final_forbidden_artifacts"] = forbidden_artifacts(result["final_inventory"])
        result["finished_utc"] = utc_now()
        write_json(case_evidence / "result.json", result)
    return result


def authenticode(path: Path) -> dict:
    quoted = str(path).replace("'", "''")
    script = (
        f"$s=Get-AuthenticodeSignature -LiteralPath '{quoted}'; "
        "[pscustomobject]@{Status=[string]$s.Status;Subject=$s.SignerCertificate.Subject;"
        "Thumbprint=$s.SignerCertificate.Thumbprint}|ConvertTo-Json -Compress"
    )
    return run_text(["pwsh", "-NoLogo", "-NoProfile", "-Command", script])


def run(args: argparse.Namespace) -> int:
    if os.name != "nt":
        raise RuntimeError("native qualification requires Windows")
    if not args.confirm_disposable:
        raise RuntimeError("native qualification requires --confirm-disposable")
    if args.cycles < 2:
        raise RuntimeError("at least two native cycles are mandatory")
    root_parent = args.root_parent.resolve()
    evidence = args.evidence.resolve()
    manifest = args.manifest.resolve()
    runner_temp = Path(os.environ["RUNNER_TEMP"]).resolve()
    if not root_parent.is_relative_to(runner_temp):
        raise RuntimeError("disposable root parent must be below RUNNER_TEMP")
    if root_parent.exists() or evidence.exists():
        raise RuntimeError("root parent and evidence directory must both be new")
    if not manifest.is_file():
        raise RuntimeError("native case manifest is missing")
    if not re.fullmatch(r"[0-9]+(?:\.[0-9]+){3}", args.expected_executable_version):
        raise RuntimeError("expected executable version must contain four numeric components")
    if not re.fullmatch(r"[0-9a-fA-F]{64}", args.expected_executable_sha256):
        raise RuntimeError("expected executable SHA-256 must be exactly 64 hexadecimal characters")
    if not re.fullmatch(r"[0-9]+(?:\.[0-9]+){3}", args.expected_native_version):
        raise RuntimeError("expected native version must contain four numeric components")
    itunes_identity = validate_executable_identity(
        ITUNES_EXE, args.expected_executable_version, args.expected_executable_sha256
    )
    require_stopped()
    profile = Path.home() / "Music" / "iTunes"
    if profile.exists() or profile.is_symlink():
        raise RuntimeError("per-user iTunes directory exists; refusing reuse")
    cases = json.loads(manifest.read_text(encoding="utf-8"))
    root_parent.mkdir(parents=True)
    evidence.mkdir(parents=True)
    shutil.copy2(manifest, evidence / "case-manifest.json")
    summary = {
        "schema_version": 1,
        "started_utc": utc_now(),
        "status": "running",
        "cycles_required": args.cycles,
        "root_parent": str(root_parent),
        "profile_path": str(profile),
        "manifest": {"path": str(manifest), "sha256": sha256_file(manifest)},
        "qualification_parameters": {
            "expected_executable_version": args.expected_executable_version,
            "expected_executable_sha256": args.expected_executable_sha256.lower(),
            "expected_native_version": args.expected_native_version,
            "input_versions": sorted({case["expected"]["version"] for case in cases}),
        },
        "invocation": [str(value) for value in sys.argv],
        "environment": {
            "platform": platform.platform(),
            "python": sys.version,
            "culture": locale.getlocale(),
            "timezone": run_text(["tzutil", "/g"]),
            "itunes": {
                **itunes_identity,
                "authenticode": authenticode(ITUNES_EXE),
            },
        },
        "isolation_policy": {
            "initial_live_inventory": "candidate ITL only",
            "xml_allowed": False,
            "previous_itunes_libraries_allowed": False,
            "damaged_library_modal_allowed": False,
            "fallback_identity_allowed": False,
            "normal_quit_required": True,
        },
        "cases": [],
    }
    write_json(evidence / "summary.json", summary)
    for case in cases:
        try:
            outcome = run_case(
                case, root_parent, evidence, args.cycles, profile, args.expected_native_version
            )
        except Exception as exc:
            outcome = {
                "name": case.get("name"),
                "status": "failed",
                "passed": False,
                "error": type(exc).__name__ + ": " + str(exc),
                "traceback": traceback.format_exc(),
            }
        summary["cases"].append(outcome)
        write_json(evidence / "summary.json", summary)
    summary["passed_cases"] = sum(bool(row.get("passed")) for row in summary["cases"])
    summary["failed_cases"] = len(summary["cases"]) - summary["passed_cases"]
    summary["all_passed"] = summary["failed_cases"] == 0 and len(summary["cases"]) == len(cases)
    summary["status"] = "passed" if summary["all_passed"] else "failed_with_preserved_evidence"
    summary["finished_utc"] = utc_now()
    write_json(evidence / "summary.json", summary)
    print(json.dumps({
        "status": summary["status"],
        "passed_cases": summary["passed_cases"],
        "failed_cases": summary["failed_cases"],
        "evidence": str(evidence),
    }, ensure_ascii=True), flush=True)
    return 0 if summary["all_passed"] else 1


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="mode", required=True)
    native = subparsers.add_parser("run")
    native.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    native.add_argument("--root-parent", type=Path, required=True)
    native.add_argument("--evidence", type=Path, required=True)
    native.add_argument("--cycles", type=int, default=2)
    native.add_argument("--expected-executable-version", default=EXPECTED_ITUNES_VERSION)
    native.add_argument("--expected-executable-sha256", default=EXPECTED_ITUNES_SHA256)
    native.add_argument("--expected-native-version", default=EXPECTED_ITUNES_VERSION)
    native.add_argument("--confirm-disposable", action="store_true")
    worker_parser = subparsers.add_parser("_worker", help=argparse.SUPPRESS)
    worker_parser.add_argument("--spec", type=Path, required=True)
    worker_parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args(argv)
    if args.mode == "_worker":
        return worker(args.spec, args.output)
    return run(args)


if __name__ == "__main__":
    raise SystemExit(main())
