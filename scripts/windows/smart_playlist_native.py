"""Create and verify one default Smart Playlist in an isolated native iTunes profile.

This probe is intentionally fail-closed: it only clicks an explicit Smart Playlist
modal with one enabled OK button, requires stable COM snapshots, a normal Quit,
a clean restart, stable playlist identity/membership, and independent parsing.
"""
from __future__ import annotations

import argparse
import datetime as dt
import gc
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time
import traceback

REPO_ROOT = Path(__file__).resolve().parents[2]
WINDOWS_SCRIPTS = Path(__file__).resolve().parent
for entry in (str(REPO_ROOT), str(WINDOWS_SCRIPTS)):
    if entry not in sys.path:
        sys.path.insert(0, entry)

from desktop_probe import snapshot as desktop_snapshot
from native_driver import wait_ready
from native_worker import snapshot as com_snapshot
from reference_generated_native import (
    ITUNES_EXE,
    EXPECTED_ITUNES_SHA256,
    create_profile_junction,
    file_facts,
    forbidden_artifacts,
    inventory,
    reference_summary,
    remove_profile_junction,
    require_stopped,
    settle_no_unexpected_modal,
    sha256_file,
    write_json,
)

EXPECTED_INPUT_SHA256 = "c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74"
OWNED_MARKER = ".smart-playlist-native-owned"
EXPECTED_RULE_WARNING = (
    "This smart playlist contains one or more conditions that are empty or "
    "conflict with each other. This may result in never matching any item. "
    "Are you sure you want to save this playlist?"
)


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def pid_windows(pid: int) -> list[dict]:
    return [row for row in desktop_snapshot() if row["pid"] == pid]


def main_window(pid: int) -> dict:
    candidates = [
        row
        for row in pid_windows(pid)
        if row["class"] not in {"iTunesCustomModalDialog", "#32770"}
    ]
    if len(candidates) != 1:
        raise RuntimeError(f"expected exactly one non-modal iTunes window, got {len(candidates)}")
    return candidates[0]


def send_ctrl_alt_n(hwnd: int) -> dict:
    import ctypes
    import win32api
    import win32con
    import win32gui

    win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)
    user32 = ctypes.windll.user32
    current_thread = ctypes.windll.kernel32.GetCurrentThreadId()
    target_thread = user32.GetWindowThreadProcessId(hwnd, None)
    attached: list[int] = []
    try:
        foreground_before = win32gui.GetForegroundWindow()
        foreground_thread = (
            user32.GetWindowThreadProcessId(foreground_before, None)
            if foreground_before
            else 0
        )
        for thread_id in {int(target_thread), int(foreground_thread)}:
            if thread_id and thread_id != current_thread:
                if user32.AttachThreadInput(current_thread, thread_id, True):
                    attached.append(thread_id)
        user32.BringWindowToTop(hwnd)
        user32.SetForegroundWindow(hwnd)
        user32.SetActiveWindow(hwnd)
        time.sleep(0.25)
    finally:
        for thread_id in reversed(attached):
            user32.AttachThreadInput(current_thread, thread_id, False)
    foreground = win32gui.GetForegroundWindow()
    if foreground != hwnd:
        raise RuntimeError(
            f"failed to focus iTunes main window: foreground={foreground}, expected={hwnd}"
        )
    events: list[dict] = []
    for key, name in ((win32con.VK_CONTROL, "CTRL"), (win32con.VK_MENU, "ALT"), (ord("N"), "N")):
        win32api.keybd_event(key, 0, 0, 0)
        events.append({"key": name, "event": "down"})
        time.sleep(0.05)
    for key, name in ((ord("N"), "N"), (win32con.VK_MENU, "ALT"), (win32con.VK_CONTROL, "CTRL")):
        win32api.keybd_event(key, 0, win32con.KEYEVENTF_KEYUP, 0)
        events.append({"key": name, "event": "up"})
        time.sleep(0.05)
    return {"foreground": foreground, "events": events}


def wait_smart_dialog(pid: int, timeout: float = 8.0) -> dict:
    deadline = time.monotonic() + timeout
    observations: list[list[dict]] = []
    while time.monotonic() < deadline:
        windows = pid_windows(pid)
        observations.append(windows)
        dialogs = [
            row
            for row in windows
            if row["class"] in {"iTunesCustomModalDialog", "#32770"}
        ]
        if dialogs:
            if len(dialogs) != 1:
                raise RuntimeError(f"ambiguous modal count after shortcut: {len(dialogs)}")
            dialog = dialogs[0]
            text = " ".join([dialog["title"], *(child["text"] for child in dialog["children"])])
            if "Smart Playlist" not in text:
                raise RuntimeError("shortcut produced an unexpected modal: " + text)
            return {"dialog": dialog, "observation_count": len(observations)}
        time.sleep(0.1)
    raise RuntimeError("Ctrl+Alt+N did not produce a Smart Playlist dialog")


def combo_items(hwnd: int) -> list[str]:
    import ctypes
    import win32api
    import win32con
    import win32gui

    count = int(win32gui.SendMessage(hwnd, win32con.CB_GETCOUNT, 0, 0))
    if count < 0 or count > 512:
        raise RuntimeError(f"invalid combo item count: {count}")
    values: list[str] = []
    for index in range(count):
        length = int(
            win32gui.SendMessage(hwnd, win32con.CB_GETLBTEXTLEN, index, 0)
        )
        buffer = ctypes.create_unicode_buffer(max(1, length + 1))
        copied = ctypes.windll.user32.SendMessageW(
            hwnd, win32con.CB_GETLBTEXT, index, ctypes.byref(buffer)
        )
        if copied < 0:
            raise RuntimeError(f"failed to read combo item {index}")
        values.append(buffer.value)
    return values


def inspect_dialog_controls(dialog: dict) -> list[dict]:
    """Record combo entries and button check states via Win32 messages."""
    import win32con
    import win32gui

    rows: list[dict] = []
    for child in dialog["children"]:
        row = dict(child)
        hwnd = child["hwnd"]
        row["text"] = win32gui.GetWindowText(hwnd)
        if child["class"] == "ComboBox":
            items = combo_items(hwnd)
            selected = int(win32gui.SendMessage(hwnd, win32con.CB_GETCURSEL, 0, 0))
            row["items"] = items
            row["selected_index"] = selected
            row["selected_text"] = (
                items[selected] if 0 <= selected < len(items) else None
            )
        elif child["class"] == "Button":
            row["check_state"] = int(
                win32gui.SendMessage(hwnd, win32con.BM_GETCHECK, 0, 0)
            )
        rows.append(row)
    return rows


def configure_artist_contains_rule(dialog: dict) -> dict:
    """Populate the verified Edit and reproduce its complete focus lifecycle."""
    import ctypes
    import win32api
    import win32con
    import win32gui

    edits = [
        child
        for child in dialog["children"]
        if child["class"] == "Edit"
        and child["id"] == 223
        and child["visible"]
        and child["enabled"]
    ]
    ok_buttons = [
        child
        for child in dialog["children"]
        if child["class"] == "Button"
        and child["id"] == 101
        and child["text"] == "OK"
        and child["visible"]
        and child["enabled"]
    ]
    if len(edits) != 1 or len(ok_buttons) != 1:
        raise RuntimeError("Smart Playlist edit/OK controls were not unique")
    edit = edits[0]
    ok_button = ok_buttons[0]
    if win32gui.GetWindowText(edit["hwnd"]):
        raise RuntimeError("Smart Playlist rule edit control was not initially empty")
    left, top, right, bottom = win32gui.GetWindowRect(edit["hwnd"])
    if right <= left or bottom <= top:
        raise RuntimeError(f"invalid Smart Playlist rule edit rectangle: {(left, top, right, bottom)}")
    point = ((left + right) // 2, (top + bottom) // 2)

    value = "Independent Artist"
    user32 = ctypes.windll.user32
    kernel32 = ctypes.windll.kernel32
    current_thread = int(kernel32.GetCurrentThreadId())
    target_thread = int(user32.GetWindowThreadProcessId(edit["hwnd"], None))
    foreground_before = int(win32gui.GetForegroundWindow())
    foreground_thread = (
        int(user32.GetWindowThreadProcessId(foreground_before, None))
        if foreground_before
        else 0
    )
    cursor_before = win32gui.GetCursorPos()
    attached: list[int] = []
    notification_results: list[dict] = []
    focused_edit = 0
    focused_ok = 0
    try:
        for thread_id in {target_thread, foreground_thread}:
            if thread_id and thread_id != current_thread:
                if user32.AttachThreadInput(current_thread, thread_id, True):
                    attached.append(thread_id)
        win32gui.BringWindowToTop(dialog["hwnd"])
        win32gui.SetForegroundWindow(dialog["hwnd"])
        win32gui.SetActiveWindow(dialog["hwnd"])
        win32api.SetCursorPos(point)
        win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
        time.sleep(0.05)
        win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
        time.sleep(0.2)
        focused_edit = int(user32.GetFocus())
        if focused_edit != edit["hwnd"]:
            raise RuntimeError(f"physical click did not focus Smart Playlist rule edit: {focused_edit}")
        win32gui.SetWindowText(edit["hwnd"], value)
        for name, code in (
            ("EN_UPDATE", 0x0400),
            ("EN_CHANGE", 0x0300),
            ("EN_KILLFOCUS", 0x0200),
        ):
            wparam = (code << 16) | (edit["id"] & 0xFFFF)
            notification_results.append(
                {
                    "name": name,
                    "code": code,
                    "result": int(
                        win32gui.SendMessage(
                            dialog["hwnd"], win32con.WM_COMMAND, wparam, edit["hwnd"]
                        )
                    ),
                }
            )
        time.sleep(0.25)
        user32.SetFocus(ok_button["hwnd"])
        time.sleep(0.25)
        focused_ok = int(user32.GetFocus())
    finally:
        for thread_id in reversed(attached):
            user32.AttachThreadInput(current_thread, thread_id, False)
    text_after_input = win32gui.GetWindowText(edit["hwnd"])
    if text_after_input != value or focused_ok != ok_button["hwnd"]:
        raise RuntimeError(
            "Smart Playlist edit focus lifecycle did not pass exact gating: "
            f"text_after_input={text_after_input!r}, notifications={notification_results!r}, "
            f"focused_ok={focused_ok}, expected_ok={ok_button['hwnd']}"
        )
    time.sleep(0.25)

    state = inspect_dialog_controls(dialog)
    field_rows = [row for row in state if row.get("id") == 218]
    operator_rows = [row for row in state if row.get("id") == 219]
    edit_rows = [row for row in state if row.get("id") == 223]
    if (
        len(field_rows) != 1
        or field_rows[0].get("selected_text") != "Artist"
        or len(operator_rows) != 1
        or operator_rows[0].get("selected_text") != "contains"
        or len(edit_rows) != 1
        or edit_rows[0].get("text") != value
    ):
        raise RuntimeError("Smart Playlist rule controls did not retain requested values")
    return {
        "field": "Artist",
        "operator": "contains",
        "value": value,
        "input_method": "focused SetWindowText with exact Edit notifications",
        "edit_rectangle": [left, top, right, bottom],
        "click_point": list(point),
        "cursor_before": list(cursor_before),
        "foreground_before": foreground_before,
        "foreground_after": int(win32gui.GetForegroundWindow()),
        "focused_edit": focused_edit,
        "focused_ok": focused_ok,
        "notification_results": notification_results,
        "control_state_after": state,
    }


def click_default_ok(dialog: dict) -> dict:
    import win32con
    import win32gui

    buttons = [
        child
        for child in dialog["children"]
        if child["class"] == "Button"
        and child["text"] == "OK"
        and child["id"] == 101
        and child["enabled"]
        and child["visible"]
    ]
    if len(buttons) != 1:
        raise RuntimeError(f"Smart Playlist modal did not have exactly one explicit OK button: {buttons}")
    button = buttons[0]
    result: dict = {"button": button, "warning_confirmation": None}
    win32gui.PostMessage(button["hwnd"], win32con.BM_CLICK, 0, 0)
    deadline = time.monotonic() + 8.0
    warning_hwnd: int | None = None
    while time.monotonic() < deadline:
        original_open = bool(win32gui.IsWindow(dialog["hwnd"]))
        warning_open = bool(warning_hwnd and win32gui.IsWindow(warning_hwnd))
        if not original_open and not warning_open:
            result["dialog_closed"] = True
            return result
        other_modals = [
            row
            for row in pid_windows(dialog["pid"])
            if row["hwnd"] != dialog["hwnd"]
            and row["class"] in {"iTunesCustomModalDialog", "#32770"}
        ]
        if other_modals and warning_hwnd is None:
            if len(other_modals) != 1:
                raise RuntimeError(f"ambiguous modal count after Smart Playlist OK: {len(other_modals)}")
            warning = other_modals[0]
            visible = [child for child in warning["children"] if child["visible"]]
            messages = [child for child in visible if child["class"] == "Static" and child["text"]]
            yes = [
                child for child in visible
                if child["class"] == "Button" and child["id"] == 101
                and child["text"] == "&Yes" and child["enabled"]
            ]
            cancel = [
                child for child in visible
                if child["class"] == "Button" and child["id"] == 102
                and child["text"] == "&Cancel" and child["enabled"]
            ]
            if (
                warning["title"] != "iTunes"
                or len(messages) != 1
                or messages[0]["text"] != EXPECTED_RULE_WARNING
                or len(yes) != 1
                or len(cancel) != 1
            ):
                raise RuntimeError("unexpected modal after explicit Smart Playlist OK click")
            warning_hwnd = warning["hwnd"]
            result["warning_confirmation"] = {
                "dialog": warning,
                "message": messages[0]["text"],
                "button": yes[0],
            }
            win32gui.PostMessage(yes[0]["hwnd"], win32con.BM_CLICK, 0, 0)
        time.sleep(0.1)
    raise RuntimeError("Smart Playlist dialogs did not close after exact confirmation")


def smart_definition_summary(path: Path, persistent_id: str) -> dict:
    from itlkit import Library

    playlist = Library.read(path).playlist(persistent_id)
    definition = playlist.smart_definition
    if definition is None or definition.rules is None or definition.preferences is None:
        raise RuntimeError("created playlist did not expose complete smart-playlist objects")
    return {
        "persistent_id": f"{playlist.persistent_id:016X}",
        "name": playlist.name,
        "rules": definition.rules.to_dict(),
        "preferences": definition.preferences.to_dict(),
        "issues": [issue.to_dict() for issue in definition.issues],
    }


def require_artist_rule(summary: dict) -> None:
    errors = [issue for issue in summary.get("issues", []) if issue.get("severity") == "error"]
    if errors:
        raise RuntimeError(f"created Smart Playlist has parser errors: {errors}")

    leaves: list[dict] = []
    def visit(rule_set: dict) -> None:
        for rule in rule_set.get("rules", []):
            nested = rule.get("nested_group_candidate")
            if isinstance(nested, dict):
                visit(nested)
            else:
                leaves.append(rule)

    visit(summary.get("rules", {}))
    matches = [
        rule for rule in leaves
        if rule.get("field_id") == 0x04
        and rule.get("action_id") == 0x01000002
    ]
    if len(matches) != 1 or matches[0].get("string_value_candidate") != "Independent Artist":
        raise RuntimeError(f"serialized smart rule did not match the native controls: {matches}")


def stable_snapshot(app, label: str) -> dict:
    import pythoncom

    first = com_snapshot(app)
    deadline = time.monotonic() + 2.0
    while time.monotonic() < deadline:
        pythoncom.PumpWaitingMessages()
        time.sleep(min(0.1, max(0.001, deadline - time.monotonic())))
    second = com_snapshot(app)
    if first != second:
        raise RuntimeError(f"COM state was unstable at {label}")
    return {"label": label, "first": first, "second": second}


def playlist_index(state: dict) -> dict[str, dict]:
    rows: dict[str, dict] = {}
    for playlist in state.get("playlists", []):
        pid = playlist.get("persistent_id")
        if pid:
            if pid in rows:
                raise RuntimeError(f"duplicate COM playlist persistent ID: {pid}")
            rows[pid] = playlist
    return rows


def launch_ready(root: Path, ui: list[dict]) -> subprocess.Popen:
    process = subprocess.Popen(
        [str(ITUNES_EXE)],
        cwd=str(root),
        stdin=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    wait_ready(process, ui)
    settle_no_unexpected_modal(process, ui)
    return process


def normal_quit(app, process: subprocess.Popen) -> int:
    app.Quit()
    process.wait(timeout=45)
    if process.returncode != 0:
        raise RuntimeError(f"iTunes exited nonzero after Quit: {process.returncode}")
    require_stopped()
    return process.returncode


def run(args: argparse.Namespace) -> int:
    import pythoncom
    import win32com.client

    if os.name != "nt":
        raise RuntimeError("native Smart Playlist probe requires Windows")
    if not args.confirm_disposable:
        raise RuntimeError("native Smart Playlist probe requires --confirm-disposable")
    root = args.root.resolve()
    evidence = args.evidence.resolve()
    candidate = args.candidate.resolve()
    runner_temp = Path(os.environ["RUNNER_TEMP"]).resolve()
    if not root.is_relative_to(runner_temp):
        raise RuntimeError("disposable root must be below RUNNER_TEMP")
    if root.exists() or evidence.exists():
        raise RuntimeError("root and evidence must both be new")
    if not candidate.is_relative_to(REPO_ROOT) or not candidate.is_file():
        raise RuntimeError("candidate must be an existing repository file")
    if sha256_file(candidate) != EXPECTED_INPUT_SHA256:
        raise RuntimeError("candidate does not match the pinned raw reference hash")
    if not ITUNES_EXE.is_file() or sha256_file(ITUNES_EXE) != EXPECTED_ITUNES_SHA256:
        raise RuntimeError("installed iTunes executable is not the pinned build")

    require_stopped()
    profile = Path.home() / "Music" / "iTunes"
    if profile.exists() or profile.is_symlink():
        raise RuntimeError("per-user iTunes directory exists; refusing reuse")

    live_dir = root / "live"
    live_dir.mkdir(parents=True)
    evidence.mkdir(parents=True)
    (root / OWNED_MARKER).write_text("owned disposable Smart Playlist test\n", encoding="ascii")
    live = live_dir / "iTunes Library.itl"
    shutil.copy2(candidate, live)
    result: dict = {
        "schema_version": 1,
        "started_utc": utc_now(),
        "status": "running",
        "candidate": file_facts(candidate),
        "itunes": file_facts(ITUNES_EXE),
        "profile": str(profile),
        "root": str(root),
        "evidence": str(evidence),
        "sessions": [],
    }
    process: subprocess.Popen | None = None
    app = None
    pythoncom.CoInitialize()
    try:
        result["profile_junction_create"] = create_profile_junction(profile, live_dir)

        create_session: dict = {"name": "create-default", "started_utc": utc_now(), "ui": []}
        result["sessions"].append(create_session)
        process = launch_ready(root, create_session["ui"])
        create_session["itunes_pid"] = process.pid
        app = win32com.client.dynamic.Dispatch("iTunes.Application")
        before = stable_snapshot(app, "before-artist-seed")
        create_session["before"] = before
        tracks = app.LibraryPlaylist.Tracks
        if int(tracks.Count) != 1:
            raise RuntimeError(f"expected exactly one library track, got {int(tracks.Count)}")
        tracks.Item(1).Artist = "Independent Artist"
        seeded = stable_snapshot(app, "after-artist-seed")
        create_session["artist_seed"] = seeded
        seeded_tracks = seeded["second"].get("tracks", [])
        if (
            len(seeded_tracks) != 1
            or seeded_tracks[0].get("persistent_id") != "A17E000000000001"
            or seeded_tracks[0].get("Artist") != "Independent Artist"
        ):
            raise RuntimeError("native Artist seed did not pass exact COM gating")
        create_session["desktop_before"] = pid_windows(process.pid)
        main = main_window(process.pid)
        create_session["main_window"] = main
        create_session["shortcut"] = send_ctrl_alt_n(main["hwnd"])
        observed = wait_smart_dialog(process.pid)
        create_session["smart_dialog"] = observed
        observed["control_state_before"] = inspect_dialog_controls(observed["dialog"])
        observed["configured_rule"] = configure_artist_contains_rule(observed["dialog"])
        create_session["dialog_accept"] = click_default_ok(observed["dialog"])
        after = stable_snapshot(app, "after-default-create")
        create_session["after"] = after
        before_index = playlist_index(seeded["second"])
        after_index = playlist_index(after["second"])
        new_ids = sorted(set(after_index) - set(before_index))
        create_session["new_playlist_ids"] = new_ids
        if len(new_ids) != 1:
            raise RuntimeError(f"default Smart Playlist creation added {len(new_ids)} COM playlists")
        created = after_index[new_ids[0]]
        create_session["created_playlist"] = created
        if created.get("special_kind") not in (0, None):
            raise RuntimeError("created Smart Playlist unexpectedly has a system SpecialKind")
        created_member_ids = [row.get("persistent_id") for row in created.get("members", [])]
        create_session["created_member_ids"] = created_member_ids
        create_session["itunes_exit_code"] = normal_quit(app, process)
        app = None
        process = None
        gc.collect()
        time.sleep(0.5)
        create_session["inventory_after"] = inventory(live_dir)
        create_session["forbidden_after"] = forbidden_artifacts(create_session["inventory_after"])
        if create_session["forbidden_after"]:
            raise RuntimeError("forbidden fallback artifacts appeared after Smart Playlist creation")
        created_copy = evidence / "native-created.itl"
        shutil.copy2(live, created_copy)
        create_session["saved"] = file_facts(created_copy)
        create_session["reference_summary"] = reference_summary(created_copy)
        create_session["smart_definition"] = smart_definition_summary(
            created_copy, created["persistent_id"]
        )
        parsed_created = {
            row.get("persistent_id"): row
            for row in create_session["reference_summary"].get("playlists", [])
        }.get(created["persistent_id"])
        create_session["parsed_created_playlist"] = parsed_created
        positive_gate_errors: list[str] = []
        if created_member_ids != ["A17E000000000001"]:
            positive_gate_errors.append(
                f"COM membership did not evaluate to the seeded track: {created_member_ids}"
            )
        try:
            require_artist_rule(create_session["smart_definition"])
        except RuntimeError as exc:
            positive_gate_errors.append(str(exc))
        if parsed_created is None:
            positive_gate_errors.append(
                "independent parser did not find the created playlist persistent ID"
            )
        else:
            if parsed_created.get("name") != created.get("name"):
                positive_gate_errors.append(
                    "COM and independent parser disagree on created playlist name"
                )
            if parsed_created.get("smart_rule_objects", 0) < 2:
                positive_gate_errors.append(
                    "created playlist lacks the expected Smart Playlist rule objects"
                )
        create_session["positive_gate_errors"] = positive_gate_errors
        if positive_gate_errors:
            raise RuntimeError(
                "Smart Playlist positive gates failed: " + "; ".join(positive_gate_errors)
            )
        create_session["status"] = "passed"
        create_session["finished_utc"] = utc_now()
        write_json(evidence / "result.json", result)

        verify_session: dict = {"name": "restart-verify", "started_utc": utc_now(), "ui": []}
        result["sessions"].append(verify_session)
        process = launch_ready(root, verify_session["ui"])
        verify_session["itunes_pid"] = process.pid
        app = win32com.client.dynamic.Dispatch("iTunes.Application")
        verified = stable_snapshot(app, "restart-verify")
        verify_session["snapshot"] = verified
        verified_index = playlist_index(verified["second"])
        verify_session["verified_playlist"] = verified_index.get(created["persistent_id"])
        if verify_session["verified_playlist"] != created:
            raise RuntimeError("created Smart Playlist identity or membership changed after restart")
        verify_session["itunes_exit_code"] = normal_quit(app, process)
        app = None
        process = None
        gc.collect()
        time.sleep(0.5)
        verify_session["inventory_after"] = inventory(live_dir)
        verify_session["forbidden_after"] = forbidden_artifacts(verify_session["inventory_after"])
        if verify_session["forbidden_after"]:
            raise RuntimeError("forbidden fallback artifacts appeared after restart verification")
        verified_copy = evidence / "native-verified.itl"
        shutil.copy2(live, verified_copy)
        verify_session["saved"] = file_facts(verified_copy)
        verify_session["reference_summary"] = reference_summary(verified_copy)
        verify_session["smart_definition"] = smart_definition_summary(
            verified_copy, created["persistent_id"]
        )
        require_artist_rule(verify_session["smart_definition"])
        parsed_verified = {
            row.get("persistent_id"): row
            for row in verify_session["reference_summary"].get("playlists", [])
        }.get(created["persistent_id"])
        verify_session["parsed_verified_playlist"] = parsed_verified
        if parsed_verified is None:
            raise RuntimeError("independent parser lost the created playlist after restart")
        if (
            parsed_verified.get("name") != parsed_created.get("name")
            or parsed_verified.get("members") != parsed_created.get("members")
            or parsed_verified.get("smart_rule_objects") != parsed_created.get("smart_rule_objects")
        ):
            raise RuntimeError("parsed Smart Playlist semantics changed after restart")
        verify_session["status"] = "passed"
        verify_session["finished_utc"] = utc_now()
        result["created_playlist"] = created
        result["parsed_created_playlist"] = parsed_created
        result["parsed_verified_playlist"] = parsed_verified
        result["status"] = "passed"
        result["passed"] = True
        return_code = 0
    except Exception as exc:
        result.update(
            status="failed_with_preserved_evidence",
            passed=False,
            error=type(exc).__name__ + ": " + str(exc),
            traceback=traceback.format_exc(),
        )
        if result.get("sessions"):
            result["sessions"][-1]["windows_at_failure"] = pid_windows(process.pid) if process else []
        return_code = 2
    finally:
        if app is not None:
            try:
                app.Quit()
                result["cleanup_quit_requested"] = True
            except Exception as exc:
                result["cleanup_quit_error"] = type(exc).__name__ + ": " + str(exc)
            app = None
            gc.collect()
        if process is not None and process.poll() is None:
            try:
                process.wait(timeout=10)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait(timeout=10)
                result["cleanup_killed_process"] = process.pid
        try:
            require_stopped()
        except Exception as exc:
            result["stopped_gate_error"] = type(exc).__name__ + ": " + str(exc)
            return_code = 2
        if live.is_file():
            final_copy = evidence / "final-live.itl"
            shutil.copy2(live, final_copy)
            result["final_live"] = file_facts(final_copy)
        result["final_inventory"] = inventory(live_dir)
        result["final_forbidden_artifacts"] = forbidden_artifacts(result["final_inventory"])
        try:
            result["profile_junction_remove"] = remove_profile_junction(profile, live_dir)
        except Exception as exc:
            result["profile_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
            result["status"] = "failed_with_preserved_evidence"
            result["passed"] = False
            return_code = 2
        result["profile_absent_after_cleanup"] = not profile.exists() and not profile.is_symlink()
        result["finished_utc"] = utc_now()
        write_json(evidence / "result.json", result)
        pythoncom.CoUninitialize()
    print(json.dumps({"status": result["status"], "passed": result.get("passed"), "evidence": str(evidence)}, ensure_ascii=True), flush=True)
    return return_code


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--candidate", type=Path, default=REPO_ROOT / "TEST_CORPUS/generated/reference-one-track-raw.itl")
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--evidence", type=Path, required=True)
    parser.add_argument("--confirm-disposable", action="store_true")
    return parser


if __name__ == "__main__":
    raise SystemExit(run(build_parser().parse_args()))
