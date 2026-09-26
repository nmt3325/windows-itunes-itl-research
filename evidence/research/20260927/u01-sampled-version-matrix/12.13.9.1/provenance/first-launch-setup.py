from __future__ import annotations
import json
import os
from pathlib import Path
import shutil
import subprocess
import time

import pythoncom
import win32com.client
import win32con
import win32gui

REPO = Path(r"D:\a\_temp\gha-mcp\win-p0qfbqby\work\repo")
os.sys.path.insert(0, str(REPO / "scripts" / "windows"))
from desktop_probe import snapshot

PROFILE = Path.home() / "Music" / "iTunes"
TARGET = Path(os.environ["RUNNER_TEMP"]) / "u01-first-launch-profile-12.13.9.1"
REPORT = Path(os.environ["RUNNER_TEMP"]) / "u01-first-launch-setup-12.13.9.1.json"
EXE = Path(r"C:\Program Files\iTunes\iTunes.exe")

def click(child: dict) -> None:
    win32gui.PostMessage(child["hwnd"], win32con.BM_CLICK, 0, 0)

if any(w["class"] in ("iTunes", "iTunesCustomModalDialog") for w in snapshot()):
    raise RuntimeError("iTunes already running")
if PROFILE.exists() or PROFILE.is_symlink():
    raise RuntimeError(f"profile path already exists: {PROFILE}")
if TARGET.exists():
    shutil.rmtree(TARGET)
TARGET.mkdir(parents=True)
(TARGET / "sentinel").write_text("u01-9.1", encoding="ascii")
PROFILE.parent.mkdir(parents=True, exist_ok=True)
junction = subprocess.run(["cmd", "/c", "mklink", "/J", str(PROFILE), str(TARGET)], text=True, capture_output=True)
if junction.returncode:
    raise RuntimeError(junction.stdout + junction.stderr)
result = {
    "schema_version": 1,
    "purpose": "controlled first-launch setup before U-01 native qualification",
    "version_target": "12.13.9.1",
    "junction_create": {"returncode": junction.returncode, "output": junction.stdout + junction.stderr},
    "actions": [],
}
proc = subprocess.Popen([str(EXE)], stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
result["itunes_pid"] = proc.pid
try:
    deadline = time.monotonic() + 90
    main_seen_at = None
    while time.monotonic() < deadline:
        if proc.poll() is not None:
            raise RuntimeError(f"iTunes exited during setup: {proc.returncode}")
        windows = [w for w in snapshot() if w["pid"] == proc.pid]
        acted = False
        for w in windows:
            texts = " ".join(c["text"] for c in w["children"])
            if w["title"] == "iTunes Software License Agreement":
                buttons = [c for c in w["children"] if c["class"] == "Button" and c["id"] == 1 and c["enabled"]]
                if len(buttons) != 1:
                    raise RuntimeError("EULA Agree button not uniquely found")
                result["actions"].append({"action": "accept_eula", "window": w})
                click(buttons[0]); acted = True; time.sleep(0.6); break
            if "problem with your audio configuration" in texts:
                buttons = [c for c in w["children"] if c["class"] == "Button" and c["id"] == 1 and c["text"] == "OK"]
                if len(buttons) != 1:
                    raise RuntimeError("audio warning OK button not uniquely found")
                result["actions"].append({"action": "dismiss_known_audio_warning", "window": w})
                click(buttons[0]); acted = True; time.sleep(0.6); break
            if "new version of iTunes" in texts and "available" in texts:
                boxes = [c for c in w["children"] if c["class"] == "Button" and c["id"] == 107 and c["visible"]]
                if len(boxes) == 1:
                    click(boxes[0]); time.sleep(0.2)
                buttons = [c for c in w["children"] if c["class"] == "Button" and c["id"] == 102 and c["visible"]]
                if len(buttons) != 1:
                    raise RuntimeError("update refusal button not uniquely found")
                result["actions"].append({"action": "decline_update_and_do_not_ask", "window": w})
                click(buttons[0]); acted = True; time.sleep(0.8); break
            if w["class"] in ("iTunesCustomModalDialog", "#32770"):
                result["unexpected_modal"] = w
                raise RuntimeError("unexpected first-launch modal")
        if acted:
            continue
        if any(w["class"] == "iTunes" for w in windows):
            if main_seen_at is None:
                main_seen_at = time.monotonic()
            if time.monotonic() - main_seen_at >= 3.0:
                break
        time.sleep(0.25)
    else:
        raise TimeoutError("main window did not become stable")
    result["main_window_stable"] = True
    pythoncom.CoInitialize()
    app = win32com.client.Dispatch("iTunes.Application")
    result["com_version"] = str(app.Version)
    app.Quit()
    result["com_quit_requested"] = True
    try:
        proc.wait(timeout=15)
        result["com_quit_timed_out"] = False
    except subprocess.TimeoutExpired:
        result["com_quit_timed_out"] = True
        proc.kill(); proc.wait(timeout=15)
    result["itunes_exit_after_setup"] = proc.returncode
finally:
    if proc.poll() is None:
        proc.kill(); proc.wait(timeout=15)
    remove = subprocess.run(["cmd", "/c", "rmdir", str(PROFILE)], text=True, capture_output=True)
    result["junction_remove"] = {"returncode": remove.returncode, "output": remove.stdout + remove.stderr}
    result["profile_exists_after"] = PROFILE.exists() or PROFILE.is_symlink()
    result["itunes_processes_after"] = subprocess.run(["pwsh", "-NoLogo", "-NoProfile", "-Command", "@(Get-Process iTunes -ErrorAction SilentlyContinue).Count"], text=True, capture_output=True).stdout.strip()
    result["finished"] = True
    REPORT.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
print(json.dumps({"report": str(REPORT), "com_version": result.get("com_version"), "actions": [a["action"] for a in result["actions"]], "profile_exists_after": result["profile_exists_after"], "itunes_processes_after": result["itunes_processes_after"]}, ensure_ascii=True))
