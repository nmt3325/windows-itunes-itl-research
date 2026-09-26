"""Predeclared U-01 setup and product-facing negative for iTunes 12.12.10.1.

This harness intentionally separates three claims:

* ``setup`` asks the pinned native iTunes build to author one controlled input;
* the existing ``reference_generated_native.py`` runner qualifies that exact
  locked input for two sequential native open/save/restart cycles; and
* ``negative`` repeats one predeclared newer-version rejection from fresh
  copies, preserving the exact product UI and refusing post-hoc substitution.

Apple installers and executables are never copied into the repository.
"""
from __future__ import annotations

import argparse
import datetime as dt
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

REPO_ROOT = Path(__file__).resolve().parents[2]
WINDOWS_SCRIPTS = Path(__file__).resolve().parent
for entry in (str(REPO_ROOT), str(WINDOWS_SCRIPTS)):
    if entry not in sys.path:
        sys.path.insert(0, entry)

from scripts.windows import reference_generated_native as native

ITUNES_EXE = Path(r"C:\Program Files\iTunes\iTunes.exe")
VERSION = "12.12.10.1"
EXE_SHA256 = "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b"
NEGATIVE_RELATIVE = Path("TEST_CORPUS/generated/reference-one-track-raw.itl")
NEGATIVE_SHA256 = "c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74"
NEGATIVE_FILE_PID = "5245464552454E43"
NEGATIVE_TRACK_PID = "A17E000000000001"
NEGATIVE_PLAYLIST_PID = "A17E000000000002"
TRACK_VALUES = {
    "name": "U01 12.12.10.1 Native α",
    "artist": "Distinct Build Artist Ω",
    "album": "Distinct Build Album 2023",
    "album_artist": "Distinct Album Artist β",
    "comment": "Predeclared native baseline — 20260927",
    "rating": 80,
    "play_count": 2,
    "skip_count": 1,
    "track_number": 1,
    "year": 2023,
}
COM_FIELDS = {
    "name": "Name",
    "artist": "Artist",
    "album": "Album",
    "album_artist": "AlbumArtist",
    "comment": "Comment",
    "rating": "Rating",
    "play_count": "PlayedCount",
    "skip_count": "SkippedCount",
    "track_number": "TrackNumber",
    "year": "Year",
}
PLAYLIST_NAME = "Synthetic U01 12.12.10.1"


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def write_json(path: Path, value: object) -> None:
    native.write_json(path, value)


def generate_wav(path: Path) -> None:
    """Generate the exact predeclared mono PCM witness."""
    path.parent.mkdir(parents=True, exist_ok=True)
    frames = 22_050
    rate = 44_100
    frequency = 523
    pcm = bytearray()
    for index in range(frames):
        sample = round(12_000 * math.sin(2 * math.pi * frequency * index / rate))
        pcm.extend(int(sample).to_bytes(2, "little", signed=True))
    with wave.open(str(path), "wb") as output:
        output.setnchannels(1)
        output.setsampwidth(2)
        output.setframerate(rate)
        output.writeframes(bytes(pcm))


def click(child: dict) -> None:
    import win32con
    import win32gui

    win32gui.PostMessage(child["hwnd"], win32con.BM_CLICK, 0, 0)


def text_of(window: dict) -> str:
    return " ".join(
        [window.get("title", "")] + [str(child.get("text", "")) for child in window.get("children", [])]
    ).strip()


def product_modal_matches(window: dict) -> bool:
    normalized = " ".join(text_of(window).lower().split())
    return (
        "cannot be read because it was created by a newer version of itunes" in normalized
        or (
            "created by a newer version of itunes" in normalized
            and ("cannot be read" in normalized or "can't be read" in normalized)
        )
    )


def dismiss_audio_warning(window: dict, log: list[dict]) -> bool:
    if "problem with your audio configuration" not in text_of(window).lower():
        return False
    buttons = [
        child
        for child in window["children"]
        if child["class"] == "Button"
        and child["id"] == 1
        and child["enabled"]
        and child["text"].strip().lower() == "ok"
    ]
    if len(buttons) != 1:
        raise RuntimeError("known audio warning lacked exactly one enabled OK button")
    log.append({"action": "dismiss_known_audio_warning", "window": window})
    click(buttons[0])
    time.sleep(0.5)
    return True


def wait_first_launch(process: subprocess.Popen, log: list[dict]) -> None:
    from desktop_probe import snapshot

    deadline = time.monotonic() + 120
    main_seen_at: float | None = None
    while time.monotonic() < deadline:
        if process.poll() is not None:
            raise RuntimeError(f"iTunes exited during controlled first launch: {process.returncode}")
        windows = [window for window in snapshot() if window["pid"] == process.pid]
        acted = False
        for window in windows:
            if window["title"] == "iTunes Software License Agreement":
                buttons = [
                    child
                    for child in window["children"]
                    if child["class"] == "Button" and child["id"] == 1 and child["enabled"]
                ]
                if len(buttons) != 1:
                    raise RuntimeError("EULA lacked exactly one enabled Agree button")
                log.append({"action": "accept_eula", "window": window})
                click(buttons[0])
                acted = True
                time.sleep(0.7)
                break
            if dismiss_audio_warning(window, log):
                acted = True
                break
            lower = text_of(window).lower()
            if "new version of itunes" in lower and "available" in lower:
                boxes = [
                    child
                    for child in window["children"]
                    if child["class"] == "Button" and child["id"] == 107 and child["visible"]
                ]
                if len(boxes) == 1:
                    click(boxes[0])
                    time.sleep(0.2)
                buttons = [
                    child
                    for child in window["children"]
                    if child["class"] == "Button" and child["id"] == 102 and child["visible"]
                ]
                if len(buttons) != 1:
                    raise RuntimeError("update offer lacked exactly one refusal button")
                log.append({"action": "decline_update_and_do_not_ask", "window": window})
                click(buttons[0])
                acted = True
                time.sleep(0.8)
                break
            if window["class"] in {"iTunesCustomModalDialog", "#32770"}:
                log.append({"action": "unexpected_first_launch_modal", "window": window})
                raise RuntimeError("unexpected first-launch modal")
        if acted:
            main_seen_at = None
            continue
        if any(window["class"] == "iTunes" for window in windows):
            if main_seen_at is None:
                main_seen_at = time.monotonic()
            if time.monotonic() - main_seen_at >= 3:
                return
        else:
            main_seen_at = None
        time.sleep(0.2)
    raise TimeoutError("controlled first launch did not reach a stable main window")


def semantic_expected(state: dict, parser_summary: dict) -> dict:
    tracks = state.get("tracks", [])
    if len(tracks) != 1:
        raise RuntimeError(f"setup expected one COM track, got {len(tracks)}")
    playlists = [row for row in state.get("playlists", []) if row.get("name") == PLAYLIST_NAME]
    if len(playlists) != 1:
        raise RuntimeError(f"setup expected one ordinary playlist, got {len(playlists)}")
    track = tracks[0]
    playlist = playlists[0]
    expected_track = {"persistent_id": track["persistent_id"], **TRACK_VALUES}
    return {
        "version": VERSION,
        "file_persistent_id": parser_summary["file_persistent_id"],
        "library_persistent_id": state["library_persistent_id"],
        "track_count": 1,
        "tracks": [expected_track],
        "playlists": [
            {
                "persistent_id": playlist["persistent_id"],
                "name": PLAYLIST_NAME,
                "members": [track["persistent_id"]],
            }
        ],
    }


def run_setup(args: argparse.Namespace) -> int:
    if os.name != "nt":
        raise RuntimeError("setup requires Windows")
    if not args.confirm_disposable:
        raise RuntimeError("setup requires --confirm-disposable")
    root = args.root.resolve()
    evidence = args.evidence.resolve()
    runner_temp = Path(os.environ["RUNNER_TEMP"]).resolve()
    if not root.is_relative_to(runner_temp):
        raise RuntimeError("setup root must be below RUNNER_TEMP")
    if root.exists() or evidence.exists():
        raise RuntimeError("setup root and evidence directory must both be new")
    profile = Path.home() / "Music" / "iTunes"
    native.require_stopped()
    if profile.exists() or profile.is_symlink():
        raise RuntimeError("per-user iTunes profile exists; refusing setup reuse")
    identity = native.validate_executable_identity(ITUNES_EXE, VERSION, EXE_SHA256)
    root.mkdir(parents=True)
    evidence.mkdir(parents=True)
    live = root / "live"
    live.mkdir()
    media = live / "media" / "u01-12.12.10.1-523hz.wav"
    generate_wav(media)
    result: dict = {
        "schema_version": 1,
        "classification": "native input generation; not a qualification cycle or independent writer",
        "started_utc": utc_now(),
        "status": "running",
        "executable": {**identity, "authenticode": native.authenticode(ITUNES_EXE)},
        "platform": platform.platform(),
        "profile": str(profile),
        "root": str(root),
        "media_before_launch": native.file_facts(media),
        "ui": [],
        "forced_termination": False,
    }
    write_json(evidence / "setup-result.json", result)
    process: subprocess.Popen | None = None
    app = None
    junction_created = False
    try:
        result["profile_junction_create"] = native.create_profile_junction(profile, live)
        junction_created = True
        process = subprocess.Popen(
            [str(ITUNES_EXE)],
            cwd=str(root),
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        result["itunes_pid"] = process.pid
        wait_first_launch(process, result["ui"])

        import pythoncom
        import win32com.client
        from native_worker import file_interface, snapshot

        pythoncom.CoInitialize()
        app = win32com.client.dynamic.Dispatch("iTunes.Application")
        result["com_version"] = str(app.Version)
        if result["com_version"] != VERSION:
            raise RuntimeError("COM version differs from pinned build")
        status = app.LibraryPlaylist.AddFile(str(media))
        deadline = time.monotonic() + 60
        while status.InProgress:
            if time.monotonic() > deadline:
                raise TimeoutError("AddFile remained in progress for 60 seconds")
            pythoncom.PumpWaitingMessages()
            time.sleep(0.1)
        if status.Tracks.Count != 1:
            raise RuntimeError(f"AddFile returned {status.Tracks.Count} tracks")
        track = file_interface(app, status.Tracks.Item(1))
        for key, value in TRACK_VALUES.items():
            field = COM_FIELDS[key]
            setattr(track, field, value)
            observed = getattr(track, field)
            if observed != value:
                raise RuntimeError(f"COM setter mismatch for {field}: {observed!r} != {value!r}")
        playlist = app.CreatePlaylist(PLAYLIST_NAME)
        playlist.AddTrack(track)
        samples = []
        for index, delay in enumerate((0.0, 2.0), 1):
            deadline = time.monotonic() + delay
            while time.monotonic() < deadline:
                pythoncom.PumpWaitingMessages()
                time.sleep(min(0.1, max(0.001, deadline - time.monotonic())))
            state = snapshot(app)
            samples.append(state)
            write_json(evidence / f"com-state-{index}.json", state)
        if samples[0] != samples[1]:
            raise RuntimeError("setup COM snapshots were not stable")
        result["com_samples_stable"] = True
        app.Quit()
        result["normal_com_quit_requested"] = True
        app = None
        process.wait(timeout=45)
        result["itunes_exit_code"] = process.returncode
        if process.returncode != 0:
            raise RuntimeError("iTunes exited nonzero after setup COM Quit")
        native.require_stopped()
        time.sleep(0.5)
        library = live / "iTunes Library.itl"
        if not library.is_file() or library.read_bytes()[:4] != b"hdfm":
            raise RuntimeError("native-authored setup ITL is missing or lacks hdfm magic")
        result["inventory_after"] = native.inventory(live)
        result["forbidden_after"] = native.forbidden_artifacts(result["inventory_after"])
        if result["forbidden_after"]:
            raise RuntimeError("forbidden fallback artifacts appeared during setup")
        parser_summary = native.reference_summary(library)
        expected = semantic_expected(samples[-1], parser_summary)
        com_errors = native.expected_state_errors(expected, samples[-1])
        parser_errors = native.reference_summary_errors(expected, parser_summary)
        if com_errors or parser_errors:
            raise RuntimeError(
                "setup semantics failed lock gates: "
                + json.dumps({"com": com_errors, "parser": parser_errors}, ensure_ascii=True)
            )
        retained_itl = evidence / "native-authored-input.itl"
        retained_media = evidence / "media" / media.name
        retained_media.parent.mkdir(parents=True)
        shutil.copy2(library, retained_itl)
        shutil.copy2(media, retained_media)
        write_json(evidence / "parser-summary.json", parser_summary)
        manifest = [
            {
                "name": "native-authored-one-track-positive",
                "candidate": retained_itl.relative_to(REPO_ROOT).as_posix(),
                "sha256": native.sha256_file(retained_itl),
                "expected": expected,
            }
        ]
        write_json(evidence / "positive-case-manifest.json", manifest)
        lock = {
            "schema_version": 1,
            "locked_utc": utc_now(),
            "classification": "exact native-authored positive input; no independent-writer claim",
            "executable": {**identity, "authenticode": native.authenticode(ITUNES_EXE)},
            "input": native.file_facts(retained_itl),
            "media": native.file_facts(retained_media),
            "expected": expected,
            "outer_file_persistent_id": expected["file_persistent_id"],
            "com_library_persistent_id": expected["library_persistent_id"],
            "identity_domains_are_distinct": expected["file_persistent_id"] != expected["library_persistent_id"],
            "reference_detect": subprocess.run(
                [sys.executable, "-X", "utf8", "-B", "-m", "REFERENCE_PARSER", "detect", str(retained_itl)],
                cwd=str(REPO_ROOT),
                text=True,
                encoding="utf-8",
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                timeout=60,
            ).stdout,
            "com_gate_errors": com_errors,
            "reference_summary_errors": parser_errors,
        }
        write_json(evidence / "input-lock.json", lock)
        result.update(
            status="passed",
            input_lock=lock,
            positive_manifest=manifest,
            finished_utc=utc_now(),
        )
    except Exception as exc:
        result.update(
            status="failed_with_preserved_evidence",
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
            finished_utc=utc_now(),
        )
    finally:
        if app is not None:
            app = None
        try:
            import pythoncom
            pythoncom.CoUninitialize()
        except Exception:
            pass
        if process is not None and process.poll() is None:
            process.kill()
            process.wait(timeout=15)
            result["forced_termination"] = True
            result["itunes_exit_after_kill"] = process.returncode
        if junction_created:
            try:
                result["profile_junction_remove"] = native.remove_profile_junction(profile, live)
            except Exception as exc:
                result["profile_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
                result["status"] = "failed_with_preserved_evidence"
        result["profile_exists_after"] = profile.exists() or profile.is_symlink()
        try:
            native.require_stopped()
            result["process_cleanup_passed"] = True
        except Exception as exc:
            result["process_cleanup_passed"] = False
            result["process_cleanup_error"] = str(exc)
            result["status"] = "failed_with_preserved_evidence"
        write_json(evidence / "setup-result.json", result)
    print(json.dumps({"status": result["status"], "evidence": str(evidence)}, ensure_ascii=True))
    return 0 if result["status"] == "passed" else 1


def negative_preflight_errors(summary: dict) -> list[dict]:
    errors: list[dict] = []

    def check(name: str, expected, actual) -> None:
        if expected != actual:
            errors.append({"property": name, "expected": expected, "actual": actual})

    check("version", "12.13.10.3", summary.get("version"))
    check("file_persistent_id", NEGATIVE_FILE_PID, summary.get("file_persistent_id"))
    tracks = {row.get("persistent_id"): row for row in summary.get("tracks", [])}
    check("track_count", 1, len(tracks))
    check("track_name", "Reference Track", tracks.get(NEGATIVE_TRACK_PID, {}).get("name"))
    playlists = {row.get("persistent_id"): row for row in summary.get("playlists", [])}
    check("playlist_name", "Reference Playlist", playlists.get(NEGATIVE_PLAYLIST_PID, {}).get("name"))
    return errors


def normal_close_after_modal(process: subprocess.Popen, pid: int, result: dict) -> None:
    from desktop_probe import snapshot
    import win32con
    import win32gui

    try:
        process.wait(timeout=12)
        result["normal_close_method"] = "target_modal_ok_process_exit"
        return
    except subprocess.TimeoutExpired:
        pass
    mains = [window for window in snapshot() if window["pid"] == pid and window["class"] == "iTunes"]
    if len(mains) != 1:
        raise RuntimeError(f"expected one iTunes main window after modal dismissal, got {len(mains)}")
    result["normal_close_method"] = "target_modal_ok_then_wm_close_main"
    result["main_window_before_close"] = mains[0]
    win32gui.PostMessage(mains[0]["hwnd"], win32con.WM_CLOSE, 0, 0)
    process.wait(timeout=30)


def run_negative_attempt(candidate: Path, root: Path, evidence: Path, attempt: int, profile: Path) -> dict:
    from desktop_probe import snapshot

    attempt_root = root / f"attempt-{attempt}"
    live = attempt_root / "live"
    live.mkdir(parents=True)
    target = live / "iTunes Library.itl"
    shutil.copy2(candidate, target)
    output = evidence / f"attempt-{attempt}"
    output.mkdir(parents=True)
    result: dict = {
        "attempt": attempt,
        "started_utc": utc_now(),
        "status": "running",
        "input_before": native.file_facts(target),
        "inventory_before": native.inventory(live),
        "ui": [],
        "target_modal_observed": False,
        "target_modal_dismissed": False,
        "forced_termination": False,
    }
    process: subprocess.Popen | None = None
    junction_created = False
    try:
        native.require_stopped()
        result["profile_junction_create"] = native.create_profile_junction(profile, live)
        junction_created = True
        process = subprocess.Popen(
            [str(ITUNES_EXE)],
            cwd=str(attempt_root),
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        result["itunes_pid"] = process.pid
        deadline = time.monotonic() + 90
        modal = None
        while time.monotonic() < deadline:
            if process.poll() is not None:
                raise RuntimeError(f"iTunes exited before target modal: {process.returncode}")
            windows = [window for window in snapshot() if window["pid"] == process.pid]
            acted = False
            for window in windows:
                if dismiss_audio_warning(window, result["ui"]):
                    acted = True
                    break
                if product_modal_matches(window):
                    modal = window
                    break
            if modal is not None:
                break
            if acted:
                continue
            time.sleep(0.15)
        if modal is None:
            result["windows_without_target"] = [window for window in snapshot() if window["pid"] == process.pid]
            raise TimeoutError("predeclared newer-version product modal was not observed")
        result["target_modal_observed"] = True
        result["target_modal"] = modal
        result["input_while_modal"] = native.file_facts(target)
        if result["input_while_modal"]["sha256"] != NEGATIVE_SHA256:
            raise RuntimeError("negative input changed before product-modal dismissal")
        buttons = [
            child
            for child in modal["children"]
            if child["class"] == "Button"
            and child["enabled"]
            and child["visible"]
            and (child["id"] == 1 or child["text"].strip().lower() == "ok")
        ]
        unique = {child["hwnd"]: child for child in buttons}
        if len(unique) != 1:
            raise RuntimeError(f"target product modal lacked exactly one dismiss button: {list(unique.values())}")
        button = next(iter(unique.values()))
        result["dismiss_button"] = button
        click(button)
        result["target_modal_dismissed"] = True
        normal_close_after_modal(process, process.pid, result)
        result["itunes_exit_code"] = process.returncode
        if process.returncode != 0:
            raise RuntimeError("iTunes exited nonzero after normal product-modal dismissal/close")
        native.require_stopped()
        time.sleep(0.5)
        result["input_after"] = native.file_facts(target)
        result["input_hash_unchanged"] = result["input_after"]["sha256"] == NEGATIVE_SHA256
        result["inventory_after"] = native.inventory(live)
        result["forbidden_after"] = native.forbidden_artifacts(result["inventory_after"])
        result["reference_summary_after"] = native.reference_summary(target)
        result["reference_summary_after_errors"] = negative_preflight_errors(result["reference_summary_after"])
        gates = {
            "target_modal_observed": result["target_modal_observed"],
            "target_modal_dismissed": result["target_modal_dismissed"],
            "input_hash_unchanged": result["input_hash_unchanged"],
            "no_forbidden_fallback": not result["forbidden_after"],
            "independent_parser_unchanged": not result["reference_summary_after_errors"],
            "normal_exit_zero": result["itunes_exit_code"] == 0,
            "no_forced_termination": not result["forced_termination"],
        }
        result["gates"] = gates
        if not all(gates.values()):
            raise RuntimeError("one or more negative qualification gates failed")
        result["status"] = "passed"
        result["classification"] = "structurally valid product-facing native semantic/version negative"
    except Exception as exc:
        result.update(
            status="failed_with_preserved_evidence",
            classification="predeclared negative did not reproduce; no post-hoc substitution",
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
        )
        if process is not None:
            result["windows_at_failure"] = [window for window in snapshot() if window["pid"] == process.pid]
    finally:
        if process is not None and process.poll() is None:
            process.kill()
            process.wait(timeout=15)
            result["forced_termination"] = True
            result["itunes_exit_after_kill"] = process.returncode
            if result["status"] == "passed":
                result["status"] = "failed_with_preserved_evidence"
        if junction_created:
            try:
                result["profile_junction_remove"] = native.remove_profile_junction(profile, live)
            except Exception as exc:
                result["profile_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
                result["status"] = "failed_with_preserved_evidence"
        result["profile_exists_after"] = profile.exists() or profile.is_symlink()
        try:
            native.require_stopped()
            result["process_cleanup_passed"] = True
        except Exception as exc:
            result["process_cleanup_passed"] = False
            result["process_cleanup_error"] = str(exc)
            result["status"] = "failed_with_preserved_evidence"
        result["finished_utc"] = utc_now()
        write_json(output / "result.json", result)
    return result


def run_negative(args: argparse.Namespace) -> int:
    if os.name != "nt":
        raise RuntimeError("negative qualification requires Windows")
    if not args.confirm_disposable:
        raise RuntimeError("negative qualification requires --confirm-disposable")
    root = args.root.resolve()
    evidence = args.evidence.resolve()
    runner_temp = Path(os.environ["RUNNER_TEMP"]).resolve()
    if not root.is_relative_to(runner_temp):
        raise RuntimeError("negative root must be below RUNNER_TEMP")
    if root.exists() or evidence.exists():
        raise RuntimeError("negative root and evidence directory must both be new")
    profile = Path.home() / "Music" / "iTunes"
    native.require_stopped()
    if profile.exists() or profile.is_symlink():
        raise RuntimeError("per-user iTunes profile exists; refusing negative reuse")
    identity = native.validate_executable_identity(ITUNES_EXE, VERSION, EXE_SHA256)
    candidate = (REPO_ROOT / NEGATIVE_RELATIVE).resolve()
    if native.sha256_file(candidate) != NEGATIVE_SHA256:
        raise RuntimeError("predeclared negative candidate hash mismatch")
    parser_summary = native.reference_summary(candidate)
    preflight_errors = negative_preflight_errors(parser_summary)
    if preflight_errors:
        raise RuntimeError("predeclared negative independent-parser preflight failed")
    root.mkdir(parents=True)
    evidence.mkdir(parents=True)
    summary = {
        "schema_version": 1,
        "started_utc": utc_now(),
        "status": "running",
        "classification": "predeclared exact-input product-facing negative qualification",
        "candidate": native.file_facts(candidate),
        "candidate_relative_path": NEGATIVE_RELATIVE.as_posix(),
        "reference_summary_before": parser_summary,
        "reference_summary_before_errors": preflight_errors,
        "executable": {**identity, "authenticode": native.authenticode(ITUNES_EXE)},
        "platform": platform.platform(),
        "attempts_required": 2,
        "attempts": [],
    }
    write_json(evidence / "summary.json", summary)
    for attempt in (1, 2):
        result = run_negative_attempt(candidate, root, evidence, attempt, profile)
        summary["attempts"].append(result)
        write_json(evidence / "summary.json", summary)
    summary["all_passed"] = len(summary["attempts"]) == 2 and all(
        result["status"] == "passed" for result in summary["attempts"]
    )
    summary["passed_attempts"] = sum(result["status"] == "passed" for result in summary["attempts"])
    summary["status"] = "passed" if summary["all_passed"] else "failed_with_preserved_evidence"
    summary["finished_utc"] = utc_now()
    write_json(evidence / "summary.json", summary)
    print(json.dumps({"status": summary["status"], "passed_attempts": summary["passed_attempts"]}, ensure_ascii=True))
    return 0 if summary["all_passed"] else 1


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="mode", required=True)
    setup = sub.add_parser("setup")
    setup.add_argument("--root", type=Path, required=True)
    setup.add_argument("--evidence", type=Path, required=True)
    setup.add_argument("--confirm-disposable", action="store_true")
    negative = sub.add_parser("negative")
    negative.add_argument("--root", type=Path, required=True)
    negative.add_argument("--evidence", type=Path, required=True)
    negative.add_argument("--confirm-disposable", action="store_true")
    args = parser.parse_args(argv)
    if args.mode == "setup":
        return run_setup(args)
    return run_negative(args)


if __name__ == "__main__":
    raise SystemExit(main())
