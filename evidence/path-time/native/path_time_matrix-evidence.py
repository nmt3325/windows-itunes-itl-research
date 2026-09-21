"""Reproducible Windows iTunes path/time matrix.

The default ``offline`` mode is platform neutral and makes no native-iTunes
claim.  The opt-in ``native`` mode is intentionally strict: it requires a new
owned root under RUNNER_TEMP, an empty 12.13.10.3 seed library, an absent
per-user iTunes directory, and the exact pinned iTunes executable hash.

Native execution never signs in, opens the Store, connects a device, or reuses
a pre-existing library.  Every iTunes mutation runs in a bounded subprocess;
source bytes are hash-pinned and every observed COM location must resolve to
one of those bytes before the next mutation is permitted.
"""
from __future__ import annotations

import argparse
import array
import ctypes
import datetime as dt
import difflib
import hashlib
import json
import math
import ntpath
import os
from pathlib import Path, PureWindowsPath
import shutil
import stat
import subprocess
import sys
import time
import traceback
import unicodedata
from urllib.parse import quote, unquote, urlsplit
import wave
from zoneinfo import ZoneInfo

REPO_ROOT = Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

SCHEMA_VERSION = 1
ITUNES_EXE = Path(r"C:\Program Files\iTunes\iTunes.exe")
EXPECTED_ITUNES_VERSION = "12.13.10.3"
EXPECTED_ITUNES_SHA256 = "30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d"
OWNED_MARKER = ".path-time-matrix-owned"
HFS_EPOCH = dt.datetime(1904, 1, 1)
UINT32_MAX = 2**32 - 1


def utc_now() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def write_json(path: Path, value: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def windows_file_url(value: str) -> str:
    """Return an ASCII, UTF-8-percent-encoded file URL without touching I/O."""
    if value.lower().startswith("file:"):
        raise ValueError("expected a Windows path, not a URL")
    path = value.replace("/", "\\")
    if path.startswith("\\\\"):
        tail = path[2:]
        pieces = tail.split("\\")
        if len(pieces) < 2 or not pieces[0] or not pieces[1]:
            raise ValueError("UNC path must include server and share")
        host = pieces[0]
        url_path = "/" + "/".join(pieces[1:])
        return "file://" + host + quote(url_path, safe="/")
    drive, tail = ntpath.splitdrive(path)
    if not drive or not tail.startswith("\\"):
        raise ValueError("file URL conversion requires an absolute drive or UNC path")
    forward = drive + tail.replace("\\", "/")
    return "file:///" + quote(forward, safe="/:")


def windows_path_from_file_url(value: str) -> str:
    """Decode a local-drive or UNC file URL into Windows spelling."""
    parsed = urlsplit(value)
    if parsed.scheme.lower() != "file" or parsed.query or parsed.fragment:
        raise ValueError("expected a plain file URL")
    host = parsed.netloc
    decoded = unquote(parsed.path, encoding="utf-8", errors="strict")
    drive_form = len(decoded) >= 3 and decoded[0] == "/" and decoded[2] == ":"
    if host and not (host.lower() == "localhost" and drive_form):
        return "\\\\" + host + decoded.replace("/", "\\")
    if drive_form:
        decoded = decoded[1:]
    return decoded.replace("/", "\\")


def lexical_windows_identity(value: str, cwd: str = r"C:\PTM") -> str:
    """A lexical comparison key; deliberately not a same-file claim."""
    raw = windows_path_from_file_url(value) if value.lower().startswith("file:") else value
    if not ntpath.isabs(raw):
        raw = ntpath.join(cwd, raw)
    return ntpath.normcase(ntpath.normpath(raw))


def classify_windows_spelling(value: str, cwd: str = r"C:\PTM") -> dict:
    raw = windows_path_from_file_url(value) if value.lower().startswith("file:") else value
    if raw.startswith("\\\\"):
        kind = "unc"
    elif ntpath.isabs(raw) and ntpath.splitdrive(raw)[0]:
        kind = "drive_absolute"
    else:
        kind = "relative"
    return {
        "input": value,
        "decoded_path": raw,
        "kind": kind,
        "drive": ntpath.splitdrive(raw)[0],
        "contains_forward_slash": "/" in raw,
        "lexical_normalized": ntpath.normpath(raw),
        "lexical_identity": lexical_windows_identity(value, cwd),
        "unicode_form": (
            "NFC" if unicodedata.is_normalized("NFC", raw)
            else "NFD" if unicodedata.is_normalized("NFD", raw)
            else "other"
        ),
    }


def wall_time_state(value: dt.datetime, zone: ZoneInfo) -> dict:
    if value.tzinfo is not None:
        raise ValueError("wall_time_state expects a naive wall time")
    candidates = []
    for fold in (0, 1):
        aware = value.replace(tzinfo=zone, fold=fold)
        roundtrip = aware.astimezone(dt.timezone.utc).astimezone(zone).replace(tzinfo=None)
        if roundtrip == value:
            candidates.append({
                "fold": fold,
                "offset_seconds": int(aware.utcoffset().total_seconds()),
                "utc": aware.astimezone(dt.timezone.utc).isoformat(),
            })
    unique = {(x["offset_seconds"], x["utc"]) for x in candidates}
    if not candidates:
        classification = "nonexistent_gap"
    elif len(unique) > 1:
        classification = "ambiguous_fold"
    else:
        classification = "unique"
    return {"wall": value.isoformat(), "zone": zone.key, "classification": classification,
            "candidates": candidates}


def _capture_hfs(value: dt.datetime) -> dict:
    from itlkit import hfs_from_datetime
    try:
        return {"accepted": True, "raw": hfs_from_datetime(value)}
    except Exception as exc:
        return {"accepted": False, "error": type(exc).__name__ + ": " + str(exc)}


def offline_time_matrix() -> list[dict]:
    from itlkit import hfs_to_datetime
    utc = dt.timezone.utc
    est = dt.timezone(dt.timedelta(hours=-5))
    cases: list[dict] = []
    values = [
        ("epoch_collision", dt.datetime(1904, 1, 1, tzinfo=utc)),
        ("epoch_plus_one", dt.datetime(1904, 1, 1, 0, 0, 1, tzinfo=utc)),
        ("unix_epoch_utc", dt.datetime(1970, 1, 1, tzinfo=utc)),
        ("same_wall_different_offset", dt.datetime(1970, 1, 1, tzinfo=est)),
        ("naive_rejected", dt.datetime(2026, 1, 15, 12, 34, 56)),
        ("pre_epoch_fraction_rejected", dt.datetime(1903, 12, 31, 23, 59, 59, 500000, tzinfo=utc)),
    ]
    for name, value in values:
        cases.append({"name": name, "input": value.isoformat(), **_capture_hfs(value),
                      "evidence_class": "repository_codec"})
    same_instant_utc = dt.datetime(2026, 3, 8, 6, 30, tzinfo=utc)
    same_instant_est = same_instant_utc.astimezone(est)
    cases.append({
        "name": "same_instant_different_wall",
        "inputs": [same_instant_utc.isoformat(), same_instant_est.isoformat()],
        "raw_values": [_capture_hfs(same_instant_utc).get("raw"),
                       _capture_hfs(same_instant_est).get("raw")],
        "same_instant": same_instant_utc.timestamp() == same_instant_est.timestamp(),
        "evidence_class": "repository_codec",
    })
    cases.append({
        "name": "raw_sentinel_and_bounds",
        "decode_zero": None,
        "decode_one": hfs_to_datetime(1, utc_offset_seconds=0).isoformat(),
        "decode_uint32_max": hfs_to_datetime(UINT32_MAX, utc_offset_seconds=0).isoformat(),
        "zero_meaning": "unset sentinel; exact epoch encodes to the same raw value",
        "evidence_class": "repository_codec",
    })
    ny = ZoneInfo("America/New_York")
    for name, wall in [
        ("dst_fold", dt.datetime(2026, 11, 1, 1, 30)),
        ("dst_gap", dt.datetime(2026, 3, 8, 2, 30)),
        ("dst_unique", dt.datetime(2026, 3, 8, 3, 30)),
    ]:
        row = {"name": name, **wall_time_state(wall, ny), "evidence_class": "python_zoneinfo"}
        row["codec_fold0"] = _capture_hfs(wall.replace(tzinfo=ny, fold=0))
        row["codec_fold1"] = _capture_hfs(wall.replace(tzinfo=ny, fold=1))
        cases.append(row)
    return cases


def offline_path_matrix() -> list[dict]:
    nfc = r"C:\PTM\日本語\café-🎵.wav"
    nfd = unicodedata.normalize("NFD", nfc)
    long_path = "C:\\PTM\\" + "\\".join(["segment" + str(i).zfill(2) + "x" * 28 for i in range(8)]) + "\\track.wav"
    examples = [
        ("drive_absolute", r"C:\PTM\media\track.wav"),
        ("drive_lowercase", r"c:\PTM\media\track.wav"),
        ("relative", r"media\track.wav"),
        ("forward_slashes", "C:/PTM/media/track.wav"),
        ("local_file_url", "file:///C:/PTM/media/track.wav"),
        ("localhost_file_url", "file://localhost/C:/PTM/media/track.wav"),
        ("unc", r"\\server\share\track.wav"),
        ("unc_file_url", "file://server/share/track.wav"),
        ("unicode_nfc", nfc),
        ("unicode_nfd", nfd),
        ("long", long_path),
        ("missing_lexical_only", r"C:\PTM\missing.wav"),
        ("readonly_lexical_only", r"C:\PTM\readonly.wav"),
        ("extended_length", r"\\?\C:\PTM\media\track.wav"),
    ]
    rows = []
    for name, value in examples:
        row = {"name": name, **classify_windows_spelling(value),
               "evidence_class": "stdlib_lexical"}
        if not value.lower().startswith("file:") and (ntpath.isabs(value) or value.startswith("\\\\")):
            try:
                row["file_url"] = windows_file_url(value)
                row["file_url_roundtrip"] = windows_path_from_file_url(row["file_url"])
            except ValueError as exc:
                row["file_url_error"] = str(exc)
        rows.append(row)
    return rows


def build_offline_report() -> dict:
    script = Path(__file__).resolve()
    return {
        "schema_version": SCHEMA_VERSION,
        "mode": "offline",
        "generated_utc": utc_now(),
        "script_sha256": sha256_file(script),
        "evidence_classes": {
            "repository_codec": "executed itlkit source behavior; not native-iTunes proof",
            "python_zoneinfo": "Python/tzdata classification; not native-iTunes proof",
            "stdlib_lexical": "pure Windows-spelling calculation; no filesystem claim",
        },
        "path_matrix": offline_path_matrix(),
        "time_matrix": offline_time_matrix(),
        "limitations": [
            "Offline rows do not establish that iTunes accepts an input spelling.",
            "lexical_identity is not a Windows same-file or filesystem-normalization claim.",
            "ZoneInfo fold/gap classification does not prove COM or iTunes behavior.",
        ],
    }


def _jsonable(value):
    if value is None or isinstance(value, (str, int, float, bool)):
        return value
    if hasattr(value, "isoformat"):
        return value.isoformat()
    return str(value)


def _items(collection):
    return [collection.Item(i) for i in range(1, collection.Count + 1)]


def _pid(app, obj) -> str:
    hi, lo = app.GetITObjectPersistentIDs(obj)
    return f"{hi & 0xffffffff:08X}{lo & 0xffffffff:08X}"


def _file_interface(app, obj):
    import pythoncom
    import win32com.client
    library = app._oleobj_.GetTypeInfo().GetContainingTypeLib()[0]
    for index in range(library.GetTypeInfoCount()):
        if library.GetDocumentation(index)[0] == "IITFileOrCDTrack":
            iid = library.GetTypeInfo(index).GetTypeAttr().iid
            dispatch = obj._oleobj_.QueryInterface(iid, pythoncom.IID_IDispatch)
            return win32com.client.dynamic.Dispatch(dispatch)
    raise RuntimeError("IITFileOrCDTrack interface missing")


def _com_track(app, track) -> dict:
    track = _file_interface(app, track)
    row = {"persistent_id": _pid(app, track)}
    for field in ("Name", "Location", "DateAdded", "ModificationDate", "PlayedDate",
                  "SkippedDate", "PlayedCount", "SkippedCount", "Size", "Kind"):
        try:
            row[field] = _jsonable(getattr(track, field))
        except Exception as exc:
            row[field] = {"unavailable": type(exc).__name__ + ": " + str(exc)}
    return row


def _com_snapshot(app) -> dict:
    tracks = [_com_track(app, item) for item in _items(app.LibraryPlaylist.Tracks)]
    return {
        "version": app.Version,
        "library_persistent_id": _pid(app, app.LibraryPlaylist),
        "track_count": len(tracks),
        "tracks": tracks,
    }


def _candidate_path(value: str, root: Path) -> Path | None:
    try:
        raw = windows_path_from_file_url(value) if value.lower().startswith("file:") else value
    except ValueError:
        return None
    path = Path(raw)
    if not path.is_absolute():
        path = root / path
    return path


def _guard_com_locations(snapshot: dict, allowed_hashes: set[str]) -> list[dict]:
    checked = []
    for track in snapshot["tracks"]:
        location = track.get("Location")
        if not isinstance(location, str):
            raise RuntimeError("COM returned a track without a usable Location")
        path = Path(location)
        if not path.is_file():
            raise RuntimeError("COM track location is absent: " + location)
        digest = sha256_file(path)
        if digest not in allowed_hashes:
            raise RuntimeError("COM track bytes are outside the immutable source inventory")
        checked.append({"persistent_id": track["persistent_id"], "location": location,
                        "sha256": digest})
    return checked


def native_worker(spec_path: Path, output: Path) -> int:
    import gc
    import pythoncom
    import pywintypes
    import win32com.client

    spec = json.loads(spec_path.read_text(encoding="utf-8"))
    root = Path(spec["root"]).resolve()
    result = {"schema_version": SCHEMA_VERSION, "started_utc": utc_now(), "spec": spec}
    app = None
    pythoncom.CoInitialize()
    try:
        app = win32com.client.dynamic.Dispatch("iTunes.Application")
        before = _com_snapshot(app)
        result["before"] = before
        if before["version"] != EXPECTED_ITUNES_VERSION:
            raise RuntimeError("unexpected iTunes COM version")
        if before["track_count"] != spec["expected_before_count"]:
            raise RuntimeError("unexpected initial track count; refusing possible fallback library")
        allowed = set(spec["allowed_hashes"])
        result["before_location_guard"] = _guard_com_locations(before, allowed)
        action = spec["action"]
        observed: dict = {"kind": action["kind"]}
        if action["kind"] == "add":
            source = Path(action["source_path"])
            if action.get("source_sha256"):
                if not source.is_file() or sha256_file(source) != action["source_sha256"]:
                    raise RuntimeError("canonical source hash gate failed")
            candidate = _candidate_path(action["input"], root)
            if action.get("expect_input_exists"):
                if candidate is None or not candidate.is_file():
                    raise RuntimeError("input alias did not resolve before AddFile")
                observed["input_sha256"] = sha256_file(candidate)
                if observed["input_sha256"] != action["source_sha256"]:
                    raise RuntimeError("input alias bytes differ from canonical source")
                try:
                    observed["samefile"] = os.path.samefile(candidate, source)
                except OSError as exc:
                    observed["samefile_error"] = str(exc)
            try:
                status = app.LibraryPlaylist.AddFile(action["input"])
                deadline = time.monotonic() + 60
                while status.InProgress:
                    if time.monotonic() > deadline:
                        raise TimeoutError("AddFile remained in progress for 60 seconds")
                    pythoncom.PumpWaitingMessages()
                    time.sleep(0.1)
                returned = [_com_track(app, item) for item in _items(status.Tracks)]
                observed["returned_tracks"] = returned
                observed["returned_track_count"] = len(returned)
                observed["outcome"] = "returned"
            except Exception as exc:
                observed["outcome"] = "rejected_or_failed"
                observed["error"] = type(exc).__name__ + ": " + str(exc)
        elif action["kind"] == "set_played_date":
            target = None
            for item in _items(app.LibraryPlaylist.Tracks):
                if _pid(app, item) == action["track_persistent_id"]:
                    target = _file_interface(app, item)
                    break
            if target is None:
                raise RuntimeError("target track was not found")
            value = dt.datetime.fromisoformat(action["value"])
            observed["python_input"] = {"iso": value.isoformat(), "aware": value.tzinfo is not None,
                                        "fold": value.fold}
            try:
                com_value = pywintypes.Time(value)
                target.PlayedDate = com_value
                observed["outcome"] = "accepted"
                observed["com_readback"] = _jsonable(target.PlayedDate)
            except Exception as exc:
                observed["outcome"] = "rejected_or_failed"
                observed["error"] = type(exc).__name__ + ": " + str(exc)
        elif action["kind"] != "snapshot":
            raise ValueError("unknown worker action")
        after = _com_snapshot(app)
        result["action_result"] = observed
        result["after"] = after
        result["after_location_guard"] = _guard_com_locations(after, allowed)
        before_ids = {x["persistent_id"] for x in before["tracks"]}
        result["added_persistent_ids"] = [x["persistent_id"] for x in after["tracks"]
                                             if x["persistent_id"] not in before_ids]
        result["ok"] = True
    except Exception as exc:
        result["ok"] = False
        result["error"] = type(exc).__name__ + ": " + str(exc)
        result["traceback"] = traceback.format_exc()
    finally:
        if app is not None:
            try:
                app.Quit()
                result["quit_requested"] = True
            except Exception as exc:
                result["quit_error"] = type(exc).__name__ + ": " + str(exc)
            app = None
        gc.collect()
        pythoncom.CoUninitialize()
        result["finished_utc"] = utc_now()
        write_json(output, result)
    return 0 if result.get("ok") else 2


def _wait_ready(proc: subprocess.Popen, ui_log: list[dict]) -> None:
    import win32con
    import win32gui
    from desktop_probe import snapshot

    deadline = time.monotonic() + 45
    while time.monotonic() < deadline:
        if proc.poll() is not None:
            raise RuntimeError(f"iTunes exited during startup: {proc.returncode}")
        windows = [window for window in snapshot() if window["pid"] == proc.pid]
        for window in windows:
            text = " ".join(child["text"] for child in window["children"])
            if "problem with your audio configuration" in text:
                buttons = [child for child in window["children"]
                           if child["id"] == 1 and child["class"] == "Button" and child["text"] == "OK"]
                if len(buttons) != 1:
                    raise RuntimeError("known audio warning did not have exactly one OK button")
                ui_log.append({"action": "dismiss_known_audio_warning", "window": window})
                win32gui.PostMessage(buttons[0]["hwnd"], win32con.BM_CLICK, 0, 0)
                time.sleep(0.25)
            elif window["class"] in ("iTunesCustomModalDialog", "#32770"):
                ui_log.append({"action": "refused_unexpected_modal", "window": window})
                raise RuntimeError("unexpected iTunes modal; refusing auto-dismiss")
        if any(window["class"] == "iTunes" for window in windows):
            time.sleep(0.8)
            return
        time.sleep(0.25)
    raise TimeoutError("iTunes main window was not ready in 45 seconds")


def _decode_itl(path: Path) -> dict:
    from itlkit import Library
    library = Library.from_bytes(path.read_bytes())
    rows = []
    fields = ("name", "url", "path", "date_added", "date_modified", "play_date", "skip_date")
    for track in library.tracks:
        row = {"persistent_id": f"{track.persistent_id:016X}", "track_id": track.track_id}
        for field in fields:
            try:
                row[field] = track.get(field)
            except Exception as exc:
                row[field] = {"unavailable": type(exc).__name__ + ": " + str(exc)}
        direct = []
        for child in track.node.children or ():
            if child.tag == b"mhoh" and child.type_code == 1:
                direct.append({"payload_bytes": len(child.payload),
                               "payload_sha256": sha256_bytes(child.payload)})
        row["opaque_location_objects"] = direct
        rows.append(row)
    return {"sha256": sha256_file(path), "bytes": path.stat().st_size,
            "version": library.container.version, "track_count": len(rows), "tracks": rows}


def _byte_diff(before: Path, after: Path) -> dict:
    left, right = before.read_bytes(), after.read_bytes()
    limit = min(len(left), len(right))
    changed = [i for i in range(limit) if left[i] != right[i]]
    spans = []
    if changed:
        start = previous = changed[0]
        for offset in changed[1:]:
            if offset != previous + 1:
                spans.append([start, previous + 1])
                start = offset
            previous = offset
        spans.append([start, previous + 1])
    return {"before_sha256": sha256_bytes(left), "after_sha256": sha256_bytes(right),
            "before_bytes": len(left), "after_bytes": len(right),
            "overlap_changed_bytes": len(changed), "length_delta": len(right) - len(left),
            "changed_spans_first_32": spans[:32], "span_count": len(spans)}


def _semantic_diff(before: dict, after: dict) -> dict:
    old = {row["persistent_id"]: row for row in before["tracks"]}
    new = {row["persistent_id"]: row for row in after["tracks"]}
    changed = {}
    for pid in old.keys() & new.keys():
        delta = {key: {"before": old[pid].get(key), "after": new[pid].get(key)}
                 for key in sorted(set(old[pid]) | set(new[pid]))
                 if old[pid].get(key) != new[pid].get(key)}
        if delta:
            changed[pid] = delta
    return {"added": sorted(new.keys() - old.keys()), "removed": sorted(old.keys() - new.keys()),
            "changed": changed}


def _run_text(command: list[str], timeout: int = 60, cwd: Path | None = None) -> dict:
    process = subprocess.run(command, cwd=str(cwd) if cwd else None, text=True,
                             stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=timeout)
    return {"argv": command, "returncode": process.returncode, "output": process.stdout}


def _timezone_name() -> str:
    result = subprocess.run(["tzutil", "/g"], text=True, stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT, timeout=15)
    if result.returncode:
        raise RuntimeError("tzutil /g failed: " + result.stdout)
    return result.stdout.strip()


def _set_timezone(name: str) -> dict:
    before = _timezone_name()
    command = _run_text(["tzutil", "/s", name], timeout=20)
    after = _timezone_name()
    if command["returncode"] or after != name:
        raise RuntimeError("failed to set Windows timezone")
    return {"before": before, "requested": name, "after": after, "command": command}


def _choose_free_drive(candidates: str) -> str:
    mask = ctypes.windll.kernel32.GetLogicalDrives()
    for letter in candidates:
        if not (mask & (1 << (ord(letter.upper()) - ord("A")))):
            return letter.upper() + ":"
    raise RuntimeError("no free test drive letter")


def _drive_type(root: str) -> int:
    return int(ctypes.windll.kernel32.GetDriveTypeW(ctypes.c_wchar_p(root)))


def _create_wav(path: Path, frequency: int) -> dict:
    path.parent.mkdir(parents=True, exist_ok=True)
    frames = 8000
    samples = array.array("h", (int(4000 * math.sin(2 * math.pi * frequency * i / 8000))
                                for i in range(frames)))
    if sys.byteorder != "little":
        samples.byteswap()
    with wave.open(str(path), "wb") as handle:
        handle.setparams((1, 2, 8000, frames, "NONE", "not compressed"))
        handle.writeframes(samples.tobytes())
    return {"path": str(path), "sha256": sha256_file(path), "bytes": path.stat().st_size,
            "frequency_hz": frequency}


def _make_sources(root: Path) -> tuple[dict[str, dict], list[dict], dict]:
    records: dict[str, dict] = {}
    cases: list[dict] = []
    setup: dict = {"failures": []}

    def add_source(label: str, relative: str, frequency: int) -> Path:
        path = root / relative
        records[label] = _create_wav(path, frequency)
        return path

    def add_case(label: str, source: Path, input_value: str, category: str,
                 evidence_note: str = "native iTunes/COM plus serialized ITL") -> None:
        cases.append({"name": label, "category": category, "source_path": str(source),
                      "source_sha256": sha256_file(source), "input": input_value,
                      "expect_input_exists": True, "evidence_note": evidence_note})

    ordinary = add_source("drive_absolute", r"media\drive-absolute.wav", 311)
    add_case("001-drive-absolute", ordinary, str(ordinary), "absolute_drive")
    lower = add_source("drive_lowercase", r"media\drive-letter-case.wav", 313)
    lower_input = lower.drive.lower() + str(lower)[len(lower.drive):]
    add_case("002-drive-letter-lowercase", lower, lower_input, "drive_letter_case")
    relative = add_source("relative", r"media\relative.wav", 317)
    add_case("003-relative", relative, r"media\relative.wav", "relative")
    slash = add_source("forward_slash", r"media\forward-slash.wav", 331)
    add_case("004-forward-slashes", slash, str(slash).replace("\\", "/"), "slash")
    url_source = add_source("file_url", r"media\file-url.wav", 337)
    add_case("005-file-url", url_source, windows_file_url(str(url_source)), "file_url")
    localhost = add_source("localhost_file_url", r"media\localhost-url.wav", 347)
    local_url = windows_file_url(str(localhost)).replace("file:///", "file://localhost/")
    add_case("006-localhost-file-url", localhost, local_url, "file_url")
    encoded = add_source("percent_unicode_url", "media\\URL-日本語-🎵.wav", 349)
    add_case("007-percent-encoded-unicode-url", encoded, windows_file_url(str(encoded)), "file_url_unicode")
    nfc = add_source("unicode_nfc", "media\\café-NFC.wav", 353)
    add_case("008-unicode-nfc", nfc, str(nfc), "unicode")
    nfd_name = unicodedata.normalize("NFD", "café-NFD.wav")
    nfd = add_source("unicode_nfd", "media\\" + nfd_name, 359)
    add_case("009-unicode-nfd", nfd, str(nfd), "unicode")
    emoji = add_source("emoji", "media\\emoji-🚒-🎶.wav", 367)
    add_case("010-emoji", emoji, str(emoji), "unicode")
    readonly = add_source("readonly", r"media\readonly.wav", 373)
    os.chmod(readonly, stat.S_IREAD)
    subprocess.run(["attrib", "+R", str(readonly)], stdout=subprocess.DEVNULL,
                   stderr=subprocess.DEVNULL, timeout=15)
    records["readonly"]["readonly"] = not os.access(readonly, os.W_OK) or bool(readonly.stat().st_file_attributes & stat.FILE_ATTRIBUTE_READONLY)
    add_case("011-readonly", readonly, str(readonly), "readonly")
    case_path = add_source("case_original", r"media\CaseSensitiveName.WAV", 379)
    add_case("012-case-original", case_path, str(case_path), "case_alias")
    add_case("013-case-variant-same-file", case_path, str(case_path).replace("CaseSensitiveName.WAV", "casesensitivename.wav"), "case_alias")
    alias_source = add_source("alias_source", r"media\alias-source.wav", 383)
    add_case("014-alias-source", alias_source, str(alias_source), "alias")
    hardlink = root / r"media\alias-hardlink.wav"
    os.link(alias_source, hardlink)
    records["hardlink"] = {"path": str(hardlink), "sha256": sha256_file(hardlink),
                           "samefile": os.path.samefile(alias_source, hardlink)}
    add_case("015-hardlink-alias", alias_source, str(hardlink), "alias")
    symlink = root / r"media\alias-symlink.wav"
    try:
        os.symlink(alias_source, symlink)
        records["symlink"] = {"path": str(symlink), "sha256": sha256_file(symlink),
                              "samefile": os.path.samefile(alias_source, symlink)}
        add_case("016-symlink-alias", alias_source, str(symlink), "alias")
    except OSError as exc:
        setup["failures"].append({"case": "symlink_alias", "error": type(exc).__name__ + ": " + str(exc)})
    long_dir = root / "media" / "long" / ("a" * 48) / ("b" * 48) / ("c" * 48) / ("d" * 48)
    try:
        long_source = add_source("long_path", str(long_dir.relative_to(root) / "long-track.wav"), 389)
        records["long_path"]["characters"] = len(str(long_source))
        add_case("017-long-path", long_source, str(long_source), "long_path")
        add_case("018-extended-long-path", long_source, "\\\\?\\" + str(long_source), "long_path")
    except OSError as exc:
        setup["failures"].append({"case": "long_path", "error": type(exc).__name__ + ": " + str(exc)})
    missing = root / r"media\intentionally-missing.wav"
    cases.append({"name": "019-missing", "category": "missing", "source_path": str(missing),
                  "source_sha256": None, "input": str(missing), "expect_input_exists": False,
                  "evidence_note": "native AddFile acceptance/rejection observation"})

    unc_source = add_source("unc", r"unc-volume\unc.wav", 397)
    mapped_source = add_source("mapped_network", r"unc-volume\mapped-network.wav", 401)
    external_source = add_source("subst_external", r"external-volume\external.wav", 409)
    setup["alias_sources"] = {"unc": str(unc_source), "mapped": str(mapped_source),
                              "external": str(external_source)}
    return records, cases, setup


def _setup_aliases(root: Path, sources: dict[str, dict], cases: list[dict], setup: dict) -> dict:
    share = "PTM_" + hashlib.sha256(str(root).encode()).hexdigest()[:8] + "$"
    share_result = _run_text(["net", "share", f"{share}={root / 'unc-volume'}", "/GRANT:Everyone,FULL"])
    setup["share"] = {"name": share, **share_result}
    if share_result["returncode"] == 0:
        unc_source = Path(sources["unc"]["path"])
        unc_input = rf"\\localhost\{share}\unc.wav"
        cases.append({"name": "020-unc-local-share", "category": "unc_local_backing",
                      "source_path": str(unc_source), "source_sha256": sources["unc"]["sha256"],
                      "input": unc_input, "expect_input_exists": Path(unc_input).is_file(),
                      "evidence_note": "UNC namespace backed by local storage; not a remote-server proof"})
        try:
            drive = _choose_free_drive("NMLKJ")
            mapping = _run_text(["net", "use", drive, rf"\\localhost\{share}", "/persistent:no"])
            setup["mapped_drive"] = {"drive": drive, **mapping}
            if mapping["returncode"] == 0:
                mapped = Path(sources["mapped_network"]["path"])
                mapped_input = drive + r"\mapped-network.wav"
                cases.append({"name": "021-mapped-network-drive", "category": "mapped_network_local_backing",
                              "source_path": str(mapped), "source_sha256": sources["mapped_network"]["sha256"],
                              "input": mapped_input, "expect_input_exists": Path(mapped_input).is_file(),
                              "evidence_note": "mapped SMB namespace backed by localhost; not a remote-server proof"})
        except Exception as exc:
            setup["failures"].append({"case": "mapped_network", "error": type(exc).__name__ + ": " + str(exc)})
    else:
        setup["failures"].append({"case": "unc_local_share", "error": share_result["output"]})
    try:
        drive = _choose_free_drive("PQRST")
        subst = _run_text(["subst", drive, str(root / "external-volume")])
        setup["subst"] = {"drive": drive, **subst}
        if subst["returncode"] == 0:
            external = Path(sources["subst_external"]["path"])
            external_input = drive + r"\external.wav"
            cases.append({"name": "022-subst-fixed-drive", "category": "fixed_volume_equivalent",
                          "source_path": str(external), "source_sha256": sources["subst_external"]["sha256"],
                          "input": external_input, "expect_input_exists": Path(external_input).is_file(),
                          "evidence_note": "SUBST namespace with GetDriveType result; not removable-media proof"})
            setup["subst"]["get_drive_type"] = _drive_type(drive + "\\")
    except Exception as exc:
        setup["failures"].append({"case": "subst", "error": type(exc).__name__ + ": " + str(exc)})
    return setup


def _remove_junction(profile: Path, expected_target: Path) -> dict:
    if not profile.exists():
        return {"removed": False, "reason": "absent"}
    attributes = os.lstat(profile).st_file_attributes
    if not attributes & stat.FILE_ATTRIBUTE_REPARSE_POINT:
        raise RuntimeError("refusing to remove non-reparse profile directory")
    if profile.resolve() != expected_target.resolve():
        raise RuntimeError("profile junction target changed; refusing removal")
    result = _run_text(["cmd.exe", "/d", "/c", "rmdir", str(profile)])
    if result["returncode"] or profile.exists():
        raise RuntimeError("failed to remove owned profile junction")
    return {"removed": True, "command": result}


def _cleanup_aliases(setup: dict) -> list[dict]:
    results = []
    mapped = setup.get("mapped_drive")
    if mapped and mapped.get("drive"):
        results.append(_run_text(["net", "use", mapped["drive"], "/delete", "/y"]))
    subst = setup.get("subst")
    if subst and subst.get("drive"):
        results.append(_run_text(["subst", subst["drive"], "/d"]))
    share = setup.get("share")
    if share and share.get("name"):
        results.append(_run_text(["net", "share", share["name"], "/delete", "/y"]))
    return results


def _authenticode(path: Path) -> dict:
    command = ["pwsh", "-NoLogo", "-NoProfile", "-Command",
               "$s=Get-AuthenticodeSignature -LiteralPath $args[0]; "
               "[pscustomobject]@{Status=[string]$s.Status;Subject=$s.SignerCertificate.Subject;"
               "Thumbprint=$s.SignerCertificate.Thumbprint}|ConvertTo-Json -Compress", str(path)]
    result = _run_text(command)
    data = {"command": result}
    if result["returncode"] == 0:
        try:
            data["signature"] = json.loads(result["output"])
        except json.JSONDecodeError:
            pass
    return data


def _run_native_case(root: Path, evidence: Path, live: Path, snapshots: Path,
                     spec: dict, allowed_hashes: set[str], previous_snapshot: Path,
                     index: int) -> tuple[dict, Path]:
    case_name = spec["name"]
    case_dir = evidence / "runs" / case_name
    case_dir.mkdir(parents=True, exist_ok=False)
    before_decoded = _decode_itl(previous_snapshot)
    action = {"kind": "add", **{key: spec[key] for key in
              ("input", "source_path", "source_sha256", "expect_input_exists")}}
    worker_spec = {"schema_version": SCHEMA_VERSION, "root": str(root), "case": case_name,
                   "expected_before_count": before_decoded["track_count"],
                   "allowed_hashes": sorted(allowed_hashes), "action": action}
    spec_file, output_file = case_dir / "spec.json", case_dir / "com.json"
    write_json(spec_file, worker_spec)
    ui_log: list[dict] = []
    process = subprocess.Popen([str(ITUNES_EXE)], cwd=str(root), stdin=subprocess.DEVNULL,
                               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        _wait_ready(process, ui_log)
        command = [sys.executable, "-u", str(Path(__file__).resolve()), "_worker",
                   "--spec", str(spec_file), "--output", str(output_file)]
        worker = subprocess.run(command, cwd=str(root), text=True, stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT, timeout=120)
        (case_dir / "worker.log").write_text(worker.stdout, encoding="utf-8")
        if worker.returncode:
            raise RuntimeError(f"native worker failed with {worker.returncode}")
        process.wait(timeout=40)
        if process.returncode:
            raise RuntimeError(f"iTunes exited with {process.returncode}")
    finally:
        if process.poll() is None:
            process.kill()
            process.wait(timeout=10)
    time.sleep(0.4)
    data = live.read_bytes()
    if not data.startswith(b"hdfm"):
        raise RuntimeError("native-saved library lacks hdfm container magic")
    snapshot = snapshots / f"{index:03d}-{case_name}.itl"
    snapshot.write_bytes(data)
    after_decoded = _decode_itl(snapshot)
    worker_result = json.loads(output_file.read_text(encoding="utf-8"))
    summary = {"case": spec, "timezone": _timezone_name(), "ui": ui_log,
               "worker_ok": worker_result.get("ok"), "action_result": worker_result.get("action_result"),
               "added_persistent_ids": worker_result.get("added_persistent_ids", []),
               "snapshot": str(snapshot.relative_to(evidence.parent)),
               "decoded_after": after_decoded, "byte_diff": _byte_diff(previous_snapshot, snapshot),
               "semantic_diff": _semantic_diff(before_decoded, after_decoded)}
    write_json(case_dir / "summary.json", summary)
    return summary, snapshot


def _run_date_case(root: Path, evidence: Path, live: Path, snapshots: Path,
                   name: str, pid: str, value: str, allowed_hashes: set[str],
                   previous_snapshot: Path, index: int) -> tuple[dict, Path]:
    case_dir = evidence / "runs" / name
    case_dir.mkdir(parents=True, exist_ok=False)
    before_decoded = _decode_itl(previous_snapshot)
    worker_spec = {"schema_version": SCHEMA_VERSION, "root": str(root), "case": name,
                   "expected_before_count": before_decoded["track_count"],
                   "allowed_hashes": sorted(allowed_hashes),
                   "action": {"kind": "set_played_date", "track_persistent_id": pid, "value": value}}
    spec_file, output_file = case_dir / "spec.json", case_dir / "com.json"
    write_json(spec_file, worker_spec)
    ui_log: list[dict] = []
    process = subprocess.Popen([str(ITUNES_EXE)], cwd=str(root), stdin=subprocess.DEVNULL,
                               stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        _wait_ready(process, ui_log)
        command = [sys.executable, "-u", str(Path(__file__).resolve()), "_worker",
                   "--spec", str(spec_file), "--output", str(output_file)]
        worker = subprocess.run(command, cwd=str(root), text=True, stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT, timeout=120)
        (case_dir / "worker.log").write_text(worker.stdout, encoding="utf-8")
        if worker.returncode:
            raise RuntimeError(f"date worker failed with {worker.returncode}")
        process.wait(timeout=40)
    finally:
        if process.poll() is None:
            process.kill(); process.wait(timeout=10)
    time.sleep(0.4)
    snapshot = snapshots / f"{index:03d}-{name}.itl"
    snapshot.write_bytes(live.read_bytes())
    after_decoded = _decode_itl(snapshot)
    worker_result = json.loads(output_file.read_text(encoding="utf-8"))
    summary = {"name": name, "timezone": _timezone_name(), "input": value, "ui": ui_log,
               "action_result": worker_result.get("action_result"), "decoded_after": after_decoded,
               "byte_diff": _byte_diff(previous_snapshot, snapshot),
               "semantic_diff": _semantic_diff(before_decoded, after_decoded)}
    write_json(case_dir / "summary.json", summary)
    return summary, snapshot


def run_native(args) -> int:
    if os.name != "nt":
        raise RuntimeError("native mode requires Windows")
    if not args.confirm_disposable:
        raise RuntimeError("native mode requires --confirm-disposable")
    root = args.root.resolve()
    evidence = args.evidence.resolve()
    seed = args.seed.resolve()
    runner_temp = Path(os.environ["RUNNER_TEMP"]).resolve()
    if not root.is_relative_to(runner_temp):
        raise RuntimeError("owned root must be below RUNNER_TEMP")
    if root.exists() or evidence.exists():
        raise RuntimeError("owned root and native evidence directory must both be new")
    if sha256_file(ITUNES_EXE) != EXPECTED_ITUNES_SHA256:
        raise RuntimeError("installed iTunes executable hash does not match the pinned build")
    from itlkit import Library
    seed_library = Library.from_bytes(seed.read_bytes())
    if seed_library.container.version != EXPECTED_ITUNES_VERSION or seed_library.tracks:
        raise RuntimeError("seed must be an empty 12.13.10.3 library")
    profile = Path.home() / "Music" / "iTunes"
    if profile.exists():
        raise RuntimeError("per-user iTunes directory exists; refusing to reuse or overwrite it")

    evidence.mkdir(parents=True)
    root.mkdir(parents=True)
    (root / OWNED_MARKER).write_text("owned disposable GHA path/time experiment\n", encoding="ascii")
    live_dir = root / "live"
    live_dir.mkdir()
    live = live_dir / "iTunes Library.itl"
    shutil.copy2(seed, live)
    snapshots = evidence / "snapshots"
    snapshots.mkdir()
    baseline = snapshots / "000-seed.itl"
    shutil.copy2(seed, baseline)
    original_timezone = _timezone_name()
    report: dict = {
        "schema_version": SCHEMA_VERSION, "started_utc": utc_now(), "mode": "native",
        "root": str(root), "profile_path": str(profile), "original_timezone": original_timezone,
        "seed": _decode_itl(seed), "itunes_exe": {"path": str(ITUNES_EXE),
        "sha256": sha256_file(ITUNES_EXE), "expected_version": EXPECTED_ITUNES_VERSION,
        "authenticode": _authenticode(ITUNES_EXE)}, "cases": [], "date_cases": [],
        "evidence_classes": {
            "native": "iTunes 12.13.10.3 UI/COM observation on the isolated runner",
            "serialized": "decoded native-saved ITL plus immutable byte differential",
            "windows_only": "Windows namespace/filesystem observation without a native acceptance claim",
        },
    }
    setup: dict = {"failures": []}
    previous = baseline
    try:
        profile.parent.mkdir(parents=True, exist_ok=True)
        junction = _run_text(["cmd.exe", "/d", "/c", "mklink", "/J", str(profile), str(live_dir)])
        if junction["returncode"] or profile.resolve() != live_dir.resolve():
            raise RuntimeError("failed to create isolated profile junction")
        report["profile_junction"] = junction
        records, path_cases, setup = _make_sources(root)
        setup = _setup_aliases(root, records, path_cases, setup)
        write_json(evidence / "input-manifest.json", {"sources": records, "setup": setup,
                                                       "path_cases": path_cases})
        allowed_hashes = {row["sha256"] for row in records.values() if row.get("sha256")}
        report["timezone_to_utc"] = _set_timezone("UTC")
        index = 1
        time_targets: dict[str, str] = {}
        for case in path_cases:
            if case["name"].startswith(("020-", "021-", "022-")) and not case["expect_input_exists"]:
                report["cases"].append({"case": case, "status": "not_run_setup_failed"})
                continue
            summary, previous = _run_native_case(root, evidence, live, snapshots, case,
                                                 allowed_hashes, previous, index)
            report["cases"].append(summary)
            index += 1
        # Dedicated tracks make date-property experiments independent of path-case de-duplication.
        date_sources = [
            ("date-naive-utc", 421), ("date-aware-utc", 431),
            ("date-naive-eastern", 433), ("date-aware-instant", 439),
            ("date-fold", 443), ("date-gap", 449),
            ("date-epoch", 457), ("date-epoch-plus-one", 461),
        ]
        for label, frequency in date_sources:
            source = root / "time-media" / (label + ".wav")
            fact = _create_wav(source, frequency)
            records[label] = fact
            allowed_hashes.add(fact["sha256"])
            case = {"name": f"{index:03d}-add-{label}", "category": "time_track_seed",
                    "source_path": str(source), "source_sha256": fact["sha256"],
                    "input": str(source), "expect_input_exists": True,
                    "evidence_note": "native seed for a later PlayedDate experiment"}
            summary, previous = _run_native_case(root, evidence, live, snapshots, case,
                                                 allowed_hashes, previous, index)
            report["cases"].append(summary)
            added = summary.get("added_persistent_ids", [])
            if len(added) == 1:
                time_targets[label] = added[0]
            index += 1
        write_json(evidence / "input-manifest-final.json", {"sources": records,
                                                             "allowed_hashes": sorted(allowed_hashes),
                                                             "setup": setup})
        date_plan = [
            ("date-naive-utc", "2026-01-15T12:34:56", "UTC"),
            ("date-aware-utc", "2026-01-15T12:34:56+00:00", "UTC"),
            ("date-naive-eastern", "2026-01-15T12:34:56", "Eastern Standard Time"),
            ("date-aware-instant", "2026-01-15T17:34:56+00:00", "Eastern Standard Time"),
            ("date-fold", "2026-11-01T01:30:00", "Eastern Standard Time"),
            ("date-gap", "2026-03-08T02:30:00", "Eastern Standard Time"),
            ("date-epoch", "1904-01-01T00:00:00", "Eastern Standard Time"),
            ("date-epoch-plus-one", "1904-01-01T00:00:01", "Eastern Standard Time"),
        ]
        active_zone = _timezone_name()
        for label, value, zone in date_plan:
            if label not in time_targets:
                report["date_cases"].append({"name": label, "status": "not_run_missing_target"})
                continue
            if active_zone != zone:
                change = _set_timezone(zone)
                report.setdefault("timezone_changes", []).append(change)
                active_zone = zone
            name = f"{index:03d}-set-{label}"
            summary, previous = _run_date_case(root, evidence, live, snapshots, name,
                                               time_targets[label], value, allowed_hashes,
                                               previous, index)
            report["date_cases"].append(summary)
            index += 1
        report["status"] = "completed_with_recorded_case_outcomes"
    except Exception as exc:
        report["status"] = "failed"
        report["error"] = type(exc).__name__ + ": " + str(exc)
        report["traceback"] = traceback.format_exc()
    finally:
        try:
            if _timezone_name() != original_timezone:
                report["timezone_restore"] = _set_timezone(original_timezone)
        except Exception as exc:
            report["timezone_restore_error"] = type(exc).__name__ + ": " + str(exc)
        try:
            report["alias_cleanup"] = _cleanup_aliases(setup)
        except Exception as exc:
            report["alias_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
        try:
            report["profile_cleanup"] = _remove_junction(profile, live_dir)
        except Exception as exc:
            report["profile_cleanup_error"] = type(exc).__name__ + ": " + str(exc)
        report["finished_utc"] = utc_now()
        report["final_snapshot"] = _decode_itl(previous)
        write_json(evidence / "native-summary.json", report)
    return 0 if report.get("status") == "completed_with_recorded_case_outcomes" else 1


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="mode", required=True)
    offline = sub.add_parser("offline")
    offline.add_argument("--output", required=True, type=Path)
    native = sub.add_parser("native")
    native.add_argument("--root", required=True, type=Path)
    native.add_argument("--evidence", required=True, type=Path)
    native.add_argument("--seed", required=True, type=Path)
    native.add_argument("--confirm-disposable", action="store_true")
    worker = sub.add_parser("_worker", help=argparse.SUPPRESS)
    worker.add_argument("--spec", required=True, type=Path)
    worker.add_argument("--output", required=True, type=Path)
    args = parser.parse_args(argv)
    if args.mode == "offline":
        write_json(args.output, build_offline_report())
        return 0
    if args.mode == "native":
        return run_native(args)
    return native_worker(args.spec, args.output)


if __name__ == "__main__":
    raise SystemExit(main())
