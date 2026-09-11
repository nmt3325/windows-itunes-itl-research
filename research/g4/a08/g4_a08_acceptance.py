"""Offline native-acceptance checker for G4-B, task a08.

Pure stdlib. No network, no COM, no iTunes, no UI. The checker only reads a
capture bundle that a10 recorded, and judges it against
docs/g4/a08/native-acceptance-protocol.md.

Absence of evidence is a blocking finding, never a pass.
"""

from __future__ import annotations

import json
import sys

CAPTURE_SCHEMA = "g4/a08/native-capture/v1"
DECLARATION_SCHEMA = "g4/a08/candidate-declaration/v1"
VERDICT_SCHEMA = "g4/a08/acceptance-verdict/v1"

AUTHORIZED_ITUNES_VERSION = "12.13.11.1"
AUTHORIZED_INSTALLER_SHA256 = (
    "25b28905a81406a5edbf482f7f3ee4831a8641d32d29dceda5d1eb3e8d534c08"
)
HISTORICAL_ITUNES_VERSION = "12.13.10.3"

REQUIRED_PHASES = ("baseline", "candidate_apply", "restart_1", "restart_2")
RESTART_PHASES = ("restart_1", "restart_2")

CHANGE_KINDS = frozenset(
    {
        "add_track",
        "remove_track",
        "edit_metadata",
        "add_to_playlist",
        "remove_from_playlist",
        "reorder_playlist",
        "create_playlist",
        "delete_playlist",
    }
)

COM_MUTATING_CALLS = frozenset(
    {"addfile", "addfiles", "adddirectory", "addurl", "createplaylist", "delete"}
)

DAMAGE_KEYWORDS = (
    "damaged",
    "rebuild",
    "rebuilt",
    "repair",
    "recreate",
    "recreated",
    "cannot be read",
    "could not be read",
    "new library",
)

DAMAGED_SIBLING_MARKERS = ("(damaged)", "damaged.itl", ".itl.damaged")

HEX = frozenset("0123456789abcdef")


def _finding(code, gate, message, evidence=None, severity="blocking"):
    return {
        "code": code,
        "gate": gate,
        "severity": severity,
        "message": message,
        "evidence": evidence or {},
    }


def _norm_path(value):
    if value is None:
        return None
    text = str(value).replace("\\", "/").strip()
    while "//" in text:
        text = text.replace("//", "/")
    return text.rstrip("/").lower()


def _is_sha256(value):
    text = str(value or "").lower()
    return len(text) == 64 and all(ch in HEX for ch in text)


def _steps(bundle):
    steps = [s for s in (bundle.get("steps") or []) if isinstance(s, dict)]
    if steps and all(isinstance(s.get("index"), int) for s in steps):
        steps.sort(key=lambda s: s["index"])
    return steps


def _step_by_phase(bundle):
    out = {}
    for step in _steps(bundle):
        phase = step.get("phase")
        if phase and phase not in out:
            out[phase] = step
    return out


def _disk(step):
    return (step or {}).get("disk") or None


def _com(step):
    return (step or {}).get("com") or None


def _com_usable(obs):
    return bool(obs) and obs.get("available", True) is not False


def _track_ids(obs):
    if not obs:
        return []
    ids = obs.get("track_ids")
    if ids is None:
        ids = list((obs.get("tracks") or {}).keys())
    return [str(i) for i in ids]


def _playlist_map(obs):
    out = {}
    for entry in (obs or {}).get("playlists") or []:
        pid = entry.get("persistent_id") or entry.get("name")
        if pid is None:
            continue
        out[str(pid)] = {
            "name": entry.get("name"),
            "item_ids": [str(i) for i in entry.get("item_ids") or []],
        }
    return out


def validate_declaration(decl):
    """Validate a candidate declaration a10 submits BEFORE native execution."""
    if not isinstance(decl, dict):
        return [_finding("D_NOT_AN_OBJECT", "D", "declaration is not a JSON object")]
    out = []
    if decl.get("schema") != DECLARATION_SCHEMA:
        out.append(
            _finding(
                "D_SCHEMA_MISMATCH",
                "D",
                "unexpected declaration schema",
                {"schema": decl.get("schema"), "expected": DECLARATION_SCHEMA},
            )
        )
    for field in (
        "declaration_id",
        "author",
        "itunes_version_target",
        "installer_sha256",
        "input",
        "output",
        "ids",
        "metadata",
        "locations",
        "playlists",
        "permitted_native_changes",
        "rollback",
    ):
        if decl.get(field) in (None, "", [], {}):
            out.append(
                _finding(
                    "D_MISSING_FIELD",
                    "D",
                    "required field is missing or empty: " + field,
                    {"field": field},
                )
            )
    target = decl.get("itunes_version_target")
    if target and target != AUTHORIZED_ITUNES_VERSION:
        out.append(
            _finding(
                "D_VERSION_TARGET_MISMATCH",
                "D",
                "declaration targets a version other than the installer available now",
                {"declared": target, "authorized": AUTHORIZED_ITUNES_VERSION},
            )
        )
    ish = decl.get("installer_sha256")
    if ish and not _is_sha256(ish):
        out.append(
            _finding(
                "D_HASH_FORMAT",
                "D",
                "installer_sha256 is not 64 lowercase hex characters",
                {"value": ish},
            )
        )
    elif ish and str(ish).lower() != AUTHORIZED_INSTALLER_SHA256:
        out.append(
            _finding(
                "D_INSTALLER_HASH_MISMATCH",
                "D",
                "installer_sha256 is not the authorized installer for this phase",
                {"value": ish, "authorized": AUTHORIZED_INSTALLER_SHA256},
            )
        )
    inp = decl.get("input") or {}
    if not inp.get("library_path"):
        out.append(
            _finding(
                "D_MISSING_FIELD",
                "D",
                "input.library_path is required",
                {"field": "input.library_path"},
            )
        )
    if not _is_sha256(inp.get("library_sha256")):
        out.append(
            _finding(
                "D_HASH_FORMAT",
                "D",
                "input.library_sha256 must be 64 lowercase hex characters",
                {"value": inp.get("library_sha256")},
            )
        )
    for media in inp.get("media_files") or []:
        if not _is_sha256(media.get("sha256")):
            out.append(
                _finding(
                    "D_HASH_FORMAT",
                    "D",
                    "declared media file sha256 is malformed",
                    {"path": media.get("path"), "value": media.get("sha256")},
                )
            )
    ids = decl.get("ids") or {}
    old = ids.get("old") or {}
    new = ids.get("new") or {}
    if old.get("track_persistent_ids") is None or new.get("track_persistent_ids") is None:
        out.append(
            _finding(
                "D_IDS_INCOMPLETE",
                "D",
                "ids.old and ids.new must both enumerate complete id sets, not the delta",
            )
        )
    if not old.get("library_persistent_id") or not new.get("library_persistent_id"):
        out.append(
            _finding(
                "D_IDS_INCOMPLETE",
                "D",
                "library_persistent_id must appear in both ids.old and ids.new",
            )
        )
    elif old.get("library_persistent_id") != new.get("library_persistent_id"):
        out.append(
            _finding(
                "D_LIBRARY_ID_CHANGE",
                "D",
                "declaration plans to change library_persistent_id, which declares a rebuild",
                {
                    "old": old.get("library_persistent_id"),
                    "new": new.get("library_persistent_id"),
                },
            )
        )
    old_tracks = set(old.get("track_persistent_ids") or [])
    metadata = decl.get("metadata") or {}
    locations = decl.get("locations") or {}
    for tid in new.get("track_persistent_ids") or []:
        if tid in old_tracks:
            continue
        if tid not in metadata:
            out.append(
                _finding(
                    "D_METADATA_MISSING",
                    "D",
                    "new track id has no declared metadata",
                    {"track_persistent_id": tid},
                )
            )
        if tid not in locations:
            out.append(
                _finding(
                    "D_LOCATION_MISSING",
                    "D",
                    "new track id has no declared location",
                    {"track_persistent_id": tid},
                )
            )
    for entry in decl.get("playlists") or []:
        pid = entry.get("persistent_id")
        members = list(entry.get("member_ids_expected") or [])
        order = list(entry.get("order_expected") or [])
        if not members:
            out.append(
                _finding(
                    "D_MISSING_FIELD",
                    "D",
                    "playlist entry has no member_ids_expected",
                    {"playlist": pid},
                )
            )
        if not order:
            out.append(
                _finding(
                    "D_MISSING_FIELD",
                    "D",
                    "playlist entry has no order_expected",
                    {"playlist": pid},
                )
            )
            continue
        if len(set(order)) != len(order):
            out.append(
                _finding(
                    "D_ORDER_DUPLICATE",
                    "D",
                    "order_expected contains duplicate ids",
                    {"playlist": pid, "order": order},
                )
            )
        if set(order) != set(members):
            out.append(
                _finding(
                    "D_ORDER_NOT_PERMUTATION",
                    "D",
                    "order_expected is not a permutation of member_ids_expected",
                    {"playlist": pid},
                )
            )
    permitted = list(decl.get("permitted_native_changes") or [])
    if not permitted:
        out.append(
            _finding(
                "D_NO_PERMITTED_CHANGES",
                "D",
                "permitted_native_changes must be a non-empty allow-list",
            )
        )
    unknown = sorted(set(permitted) - CHANGE_KINDS)
    if unknown:
        out.append(
            _finding(
                "D_UNKNOWN_CHANGE_KIND",
                "D",
                "permitted_native_changes contains kinds outside the closed set",
                {"unknown": unknown},
            )
        )
    return out


def gate_g1_intended_library(bundle):
    out = []
    lib = bundle.get("library") or {}
    intended = lib.get("intended_path")
    if not intended:
        out.append(_finding("G1_NO_INTENDED_PATH", "G1", "library.intended_path is missing"))
    opened_all = set()
    for step in _steps(bundle):
        phase = step.get("phase")
        proc = step.get("process") or {}
        opened = list(step.get("opened_library_paths") or [])
        if proc.get("launch") and not opened:
            out.append(
                _finding(
                    "G1_NO_OPEN_RECORD",
                    "G1",
                    "a launched step recorded no opened library path",
                    {"phase": phase},
                )
            )
        for path in opened:
            opened_all.add(_norm_path(path))
            if intended and _norm_path(path) != _norm_path(intended):
                out.append(
                    _finding(
                        "G1_WRONG_LIBRARY_OPENED",
                        "G1",
                        "a step opened a library other than the intended one",
                        {"phase": phase, "expected": intended, "actual": path},
                    )
                )
    if len(opened_all) > 1:
        out.append(
            _finding(
                "G1_MULTIPLE_LIBRARIES_OPENED",
                "G1",
                "more than one distinct library file was opened during the capture",
                {"opened": sorted(p for p in opened_all if p)},
            )
        )
    baseline_disk = _disk(_step_by_phase(bundle).get("baseline"))
    pre = lib.get("intended_pre_sha256")
    if baseline_disk and pre and baseline_disk.get("sha256"):
        if baseline_disk["sha256"] != pre:
            out.append(
                _finding(
                    "G1_BASELINE_HASH_MISMATCH",
                    "G1",
                    "baseline on-disk sha256 differs from the declared input library",
                    {"expected": pre, "actual": baseline_disk["sha256"]},
                )
            )
    return out


def gate_g2_no_fallback(bundle):
    out = []
    by_phase = _step_by_phase(bundle)
    base_disk = _disk(by_phase.get("baseline")) or {}
    base_snapshots = set(base_disk.get("prev_library_snapshots") or [])
    base_library_id = base_disk.get("library_persistent_id")
    for step in _steps(bundle):
        phase = step.get("phase")
        proc = step.get("process") or {}
        for text in proc.get("dialogs") or []:
            low = str(text).lower()
            if any(keyword in low for keyword in DAMAGE_KEYWORDS):
                out.append(
                    _finding(
                        "G2_DAMAGED_DIALOG",
                        "G2",
                        "a damaged, rebuild or repair dialog was observed",
                        {"phase": phase, "dialog": text},
                    )
                )
        for line in proc.get("repair_log_lines") or []:
            out.append(
                _finding(
                    "G2_REPAIR_LOG",
                    "G2",
                    "a repair or rebuild log line was observed",
                    {"phase": phase, "line": line},
                )
            )
        disk = _disk(step) or {}
        for sibling in disk.get("siblings") or []:
            low = str(sibling).lower()
            if any(marker in low for marker in DAMAGED_SIBLING_MARKERS):
                out.append(
                    _finding(
                        "G2_DAMAGED_SIBLING",
                        "G2",
                        "a damaged-library sibling file is present",
                        {"phase": phase, "sibling": sibling},
                    )
                )
        snapshots = set(disk.get("prev_library_snapshots") or [])
        appeared = sorted(snapshots - base_snapshots)
        if appeared and phase != "baseline":
            out.append(
                _finding(
                    "G2_NEW_PREV_LIBRARY_SNAPSHOT",
                    "G2",
                    "a new Previous iTunes Libraries snapshot appeared, which fingerprints a rebuild or upgrade",
                    {"phase": phase, "new_snapshots": appeared},
                )
            )
        library_id = disk.get("library_persistent_id")
        if base_library_id and library_id and library_id != base_library_id:
            out.append(
                _finding(
                    "G2_LIBRARY_IDENTITY_CHANGED",
                    "G2",
                    "library_persistent_id changed, so this is a different library rather than an edited one",
                    {"phase": phase, "baseline": base_library_id, "actual": library_id},
                )
            )
    return out


def gate_g3_normal_save_exit(bundle):
    out = []
    by_phase = _step_by_phase(bundle)
    for step in _steps(bundle):
        phase = step.get("phase")
        proc = step.get("process") or {}
        if not proc.get("launch"):
            out.append(
                _finding(
                    "G3_NOT_LAUNCHED",
                    "G3",
                    "phase has no process launch record",
                    {"phase": phase},
                )
            )
            continue
        if proc.get("killed"):
            out.append(
                _finding(
                    "G3_PROCESS_KILLED",
                    "G3",
                    "the process was killed rather than quit normally",
                    {"phase": phase},
                )
            )
        exit_kind = proc.get("exit_kind")
        if exit_kind != "normal_quit":
            out.append(
                _finding(
                    "G3_ABNORMAL_EXIT",
                    "G3",
                    "exit was not a normal quit",
                    {"phase": phase, "exit_kind": exit_kind},
                )
            )
        if proc.get("exit_code") != 0:
            out.append(
                _finding(
                    "G3_NONZERO_EXIT_CODE",
                    "G3",
                    "exit code is not zero or was not recorded",
                    {"phase": phase, "exit_code": proc.get("exit_code")},
                )
            )
        if proc.get("crash_dumps"):
            out.append(
                _finding(
                    "G3_CRASH_DUMP",
                    "G3",
                    "a crash dump was produced",
                    {"phase": phase, "crash_dumps": list(proc.get("crash_dumps"))},
                )
            )
    base_disk = _disk(by_phase.get("baseline")) or {}
    apply_disk = _disk(by_phase.get("candidate_apply")) or {}
    if (
        base_disk.get("sha256")
        and apply_disk.get("sha256")
        and base_disk["sha256"] == apply_disk["sha256"]
    ):
        out.append(
            _finding(
                "G3_NO_SAVE_OBSERVED",
                "G3",
                "on-disk bytes after candidate_apply are identical to baseline, so nothing was saved",
                {"sha256": base_disk["sha256"]},
            )
        )
    return out


def gate_g4_restart_cycles(bundle):
    out = []
    by_phase = _step_by_phase(bundle)
    present = [phase for phase in RESTART_PHASES if phase in by_phase]
    if len(present) < 2:
        out.append(
            _finding(
                "G4_INSUFFICIENT_RESTART_CYCLES",
                "G4",
                "two full restart cycles are required",
                {"found": present, "required": list(RESTART_PHASES)},
            )
        )
    for phase in present:
        proc = by_phase[phase].get("process") or {}
        if not proc.get("launch") or proc.get("exit_kind") != "normal_quit":
            out.append(
                _finding(
                    "G4_RESTART_NOT_FULL_CYCLE",
                    "G4",
                    "a restart phase is not a full launch-to-normal-exit cycle",
                    {
                        "phase": phase,
                        "launch": proc.get("launch"),
                        "exit_kind": proc.get("exit_kind"),
                    },
                )
            )
    return out


def gate_g5_paired_comparison(bundle):
    out = []
    for step in _steps(bundle):
        phase = step.get("phase")
        disk = _disk(step)
        com = _com(step)
        if not disk:
            out.append(
                _finding(
                    "G5_MISSING_DISK_OBSERVATION",
                    "G5",
                    "no raw on-disk observation was recorded at this step",
                    {"phase": phase},
                )
            )
        if not _com_usable(com):
            out.append(
                _finding(
                    "G5_MISSING_COM_OBSERVATION",
                    "G5",
                    "no usable COM observation was recorded at this step",
                    {"phase": phase, "com": com},
                )
            )
        if not disk or not _com_usable(com):
            continue
        disk_ids = set(_track_ids(disk))
        com_ids = set(_track_ids(com))
        if disk_ids != com_ids:
            out.append(
                _finding(
                    "G5_DISK_COM_TRACK_MISMATCH",
                    "G5",
                    "raw disk bytes and COM disagree about which tracks exist",
                    {
                        "phase": phase,
                        "disk_only": sorted(disk_ids - com_ids),
                        "com_only": sorted(com_ids - disk_ids),
                    },
                )
            )
        disk_playlists = _playlist_map(disk)
        com_playlists = _playlist_map(com)
        if set(disk_playlists) != set(com_playlists):
            out.append(
                _finding(
                    "G5_DISK_COM_PLAYLIST_MISMATCH",
                    "G5",
                    "raw disk bytes and COM disagree about which playlists exist",
                    {
                        "phase": phase,
                        "disk_only": sorted(set(disk_playlists) - set(com_playlists)),
                        "com_only": sorted(set(com_playlists) - set(disk_playlists)),
                    },
                )
            )
        for pid in sorted(set(disk_playlists) & set(com_playlists)):
            if disk_playlists[pid]["item_ids"] != com_playlists[pid]["item_ids"]:
                out.append(
                    _finding(
                        "G5_DISK_COM_PLAYLIST_MISMATCH",
                        "G5",
                        "raw disk bytes and COM disagree about playlist membership or order",
                        {
                            "phase": phase,
                            "playlist": pid,
                            "disk": disk_playlists[pid]["item_ids"],
                            "com": com_playlists[pid]["item_ids"],
                        },
                    )
                )
        disk_tracks = disk.get("tracks") or {}
        com_tracks = com.get("tracks") or {}
        for tid in sorted(set(disk_tracks) & set(com_tracks)):
            keys = set(disk_tracks[tid] or {}) | set(com_tracks[tid] or {})
            diff = {
                key: {
                    "disk": (disk_tracks[tid] or {}).get(key),
                    "com": (com_tracks[tid] or {}).get(key),
                }
                for key in sorted(keys)
                if (disk_tracks[tid] or {}).get(key) != (com_tracks[tid] or {}).get(key)
            }
            if diff:
                out.append(
                    _finding(
                        "G5_DISK_COM_METADATA_MISMATCH",
                        "G5",
                        "raw disk bytes and COM disagree about track metadata",
                        {"phase": phase, "track": tid, "fields": diff},
                    )
                )
    return out


def gate_g6_persistence(bundle):
    out = []
    decl = bundle.get("declaration") or {}
    ids = decl.get("ids") or {}
    old_ids = set((ids.get("old") or {}).get("track_persistent_ids") or [])
    new_ids = set((ids.get("new") or {}).get("track_persistent_ids") or [])
    added = new_ids - old_ids
    removed = old_ids - new_ids
    by_phase = _step_by_phase(bundle)
    checks = [("candidate_apply", "G6_CANDIDATE_ABSENT_AFTER_APPLY")]
    for phase in RESTART_PHASES:
        checks.append((phase, "G6_CANDIDATE_REVERTED"))
    for phase, code in checks:
        step = by_phase.get(phase)
        if step is None:
            continue
        sources = []
        disk = _disk(step)
        if disk:
            sources.append(("disk", disk))
        com = _com(step)
        if _com_usable(com):
            sources.append(("com", com))
        for label, obs in sources:
            present = set(_track_ids(obs))
            missing = sorted(added - present)
            if missing:
                out.append(
                    _finding(
                        code,
                        "G6",
                        "declared new track ids are absent",
                        {"phase": phase, "source": label, "missing": missing},
                    )
                )
            lingering = sorted(removed & present)
            if lingering:
                out.append(
                    _finding(
                        code,
                        "G6",
                        "declared removed track ids are still present",
                        {"phase": phase, "source": label, "still_present": lingering},
                    )
                )
    final_disk = _disk(by_phase.get("restart_2")) or _disk(by_phase.get("restart_1")) or {}
    tracks = final_disk.get("tracks") or {}
    for tid, expected in (decl.get("metadata") or {}).items():
        actual = tracks.get(tid)
        if actual is None or not isinstance(expected, dict):
            continue
        diff = {
            key: {"expected": value, "actual": actual.get(key)}
            for key, value in expected.items()
            if actual.get(key) != value
        }
        if diff:
            out.append(
                _finding(
                    "G6_METADATA_DRIFT",
                    "G6",
                    "persisted metadata differs from the declaration",
                    {"track": tid, "fields": diff},
                )
            )
    for tid, expected_location in (decl.get("locations") or {}).items():
        actual = tracks.get(tid)
        if actual is None:
            continue
        if _norm_path(actual.get("location")) != _norm_path(expected_location):
            out.append(
                _finding(
                    "G6_LOCATION_DRIFT",
                    "G6",
                    "persisted location differs from the declaration",
                    {
                        "track": tid,
                        "expected": expected_location,
                        "actual": actual.get("location"),
                    },
                )
            )
    playlists = _playlist_map(final_disk)
    for entry in decl.get("playlists") or []:
        pid = str(entry.get("persistent_id"))
        got = playlists.get(pid)
        if got is None:
            out.append(
                _finding(
                    "G6_PLAYLIST_MEMBERSHIP_DRIFT",
                    "G6",
                    "declared playlist is absent after the final restart",
                    {"playlist": pid},
                )
            )
            continue
        members = [str(i) for i in entry.get("member_ids_expected") or []]
        order = [str(i) for i in entry.get("order_expected") or []]
        if members and set(got["item_ids"]) != set(members):
            out.append(
                _finding(
                    "G6_PLAYLIST_MEMBERSHIP_DRIFT",
                    "G6",
                    "persisted playlist membership differs from the declaration",
                    {"playlist": pid, "expected": members, "actual": got["item_ids"]},
                )
            )
        elif order and got["item_ids"] != order:
            out.append(
                _finding(
                    "G6_PLAYLIST_ORDER_DRIFT",
                    "G6",
                    "persisted playlist order differs from the declaration",
                    {"playlist": pid, "expected": order, "actual": got["item_ids"]},
                )
            )
    return out


def gate_g7_sentinels(bundle):
    out = []
    by_phase = _step_by_phase(bundle)
    mutating = [
        call
        for call in (bundle.get("com_calls") or [])
        if str(call.get("name", "")).lower() in COM_MUTATING_CALLS
        and call.get("result") == "ok"
    ]
    completed = [
        phase
        for phase in RESTART_PHASES
        if phase in by_phase
        and (by_phase[phase].get("process") or {}).get("exit_kind") == "normal_quit"
    ]
    if mutating and len(completed) < 2:
        out.append(
            _finding(
                "G7_COM_CALL_ONLY",
                "G7",
                "a successful COM mutation exists without two completed restart cycles; a COM call is not acceptance",
                {
                    "com_calls": [call.get("name") for call in mutating],
                    "completed_restarts": completed,
                },
            )
        )
    decl = bundle.get("declaration") or {}
    expected_ids = ((decl.get("ids") or {}).get("new") or {}).get("track_persistent_ids") or []
    if expected_ids:
        for phase in ("candidate_apply",) + RESTART_PHASES:
            step = by_phase.get(phase)
            if step is None:
                continue
            sources = []
            disk = _disk(step)
            if disk:
                sources.append(("disk", disk))
            com = _com(step)
            if _com_usable(com):
                sources.append(("com", com))
            for label, obs in sources:
                if not _track_ids(obs):
                    out.append(
                        _finding(
                            "G7_EMPTY_LIBRARY",
                            "G7",
                            "an empty library is not acceptance",
                            {"phase": phase, "source": label},
                        )
                    )
    return out


def gate_g8_version(bundle):
    out = []
    env = bundle.get("environment") or {}
    version = env.get("itunes_version")
    if not version:
        out.append(
            _finding(
                "G8_VERSION_NOT_STATED",
                "G8",
                "the native result does not state the iTunes version actually used",
            )
        )
    if not env.get("version_evidence"):
        out.append(
            _finding(
                "G8_VERSION_EVIDENCE_MISSING",
                "G8",
                "no evidence was recorded for the stated iTunes version",
            )
        )
    installer = env.get("installer_sha256")
    if not installer:
        out.append(
            _finding(
                "G8_INSTALLER_HASH_NOT_STATED",
                "G8",
                "the sha256 of the installer actually used was not stated",
            )
        )
    elif str(installer).lower() != AUTHORIZED_INSTALLER_SHA256:
        out.append(
            _finding(
                "G8_INSTALLER_HASH_MISMATCH",
                "G8",
                "the installer used is not the authorized installer for this phase",
                {"actual": installer, "authorized": AUTHORIZED_INSTALLER_SHA256},
            )
        )
    comparison = bundle.get("comparison") or {}
    if not comparison.get("baseline_ref") or not comparison.get("baseline_kind"):
        out.append(
            _finding(
                "G8_BASELINE_NOT_NAMED",
                "G8",
                "the baseline being compared against is not named",
                {"comparison": comparison},
            )
        )
    baseline_version = comparison.get("baseline_itunes_version")
    historical = comparison.get("baseline_kind") == "historical"
    differs = bool(version and baseline_version and version != baseline_version)
    if (historical or differs) and not comparison.get("version_difference_flagged"):
        out.append(
            _finding(
                "G8_UNFLAGGED_HISTORICAL_COMPARISON",
                "G8",
                "a comparison against a result from another iTunes version is not flagged",
                {
                    "version_used": version,
                    "baseline_version": baseline_version,
                    "baseline_kind": comparison.get("baseline_kind"),
                    "historical_build": HISTORICAL_ITUNES_VERSION,
                },
            )
        )
    return out


def gate_g9_playback(bundle):
    out = []
    playback = bundle.get("playback")
    if not playback:
        return out
    if playback.get("folded_into_acceptance"):
        out.append(
            _finding(
                "G9_PLAYBACK_FOLDED",
                "G9",
                "playback was folded into the acceptance verdict; it is a separate endpoint",
            )
        )
    if playback.get("attempted") and not playback.get("reported_separately"):
        out.append(
            _finding(
                "G9_PLAYBACK_NOT_SEPARATELY_REPORTED",
                "G9",
                "playback was attempted but not reported as a separate endpoint",
            )
        )
    return out


def observed_change_kinds(bundle):
    """Infer which change kinds the capture actually shows, baseline to final."""
    by_phase = _step_by_phase(bundle)
    before = _disk(by_phase.get("baseline"))
    after = (
        _disk(by_phase.get("restart_2"))
        or _disk(by_phase.get("restart_1"))
        or _disk(by_phase.get("candidate_apply"))
    )
    kinds = set()
    if not before or not after:
        return kinds
    before_ids = set(_track_ids(before))
    after_ids = set(_track_ids(after))
    if after_ids - before_ids:
        kinds.add("add_track")
    if before_ids - after_ids:
        kinds.add("remove_track")
    before_tracks = before.get("tracks") or {}
    after_tracks = after.get("tracks") or {}
    for tid in sorted(set(before_tracks) & set(after_tracks)):
        if (before_tracks[tid] or {}) != (after_tracks[tid] or {}):
            kinds.add("edit_metadata")
            break
    before_playlists = _playlist_map(before)
    after_playlists = _playlist_map(after)
    if set(after_playlists) - set(before_playlists):
        kinds.add("create_playlist")
    if set(before_playlists) - set(after_playlists):
        kinds.add("delete_playlist")
    for pid in sorted(set(before_playlists) & set(after_playlists)):
        old_items = before_playlists[pid]["item_ids"]
        new_items = after_playlists[pid]["item_ids"]
        if set(new_items) - set(old_items):
            kinds.add("add_to_playlist")
        if set(old_items) - set(new_items):
            kinds.add("remove_from_playlist")
        if set(old_items) == set(new_items) and old_items != new_items:
            kinds.add("reorder_playlist")
    return kinds


def gate_g10_declaration(bundle):
    decl = bundle.get("declaration")
    if not isinstance(decl, dict) or not decl:
        return [
            _finding(
                "G10_DECLARATION_MISSING",
                "G10",
                "no candidate declaration accompanies this capture",
            )
        ]
    out = []
    if not decl.get("declaration_id"):
        out.append(
            _finding("G10_DECLARATION_MISSING", "G10", "the declaration has no declaration_id")
        )
    if not _is_sha256(decl.get("declaration_sha256")):
        out.append(
            _finding(
                "G10_DECLARATION_HASH_MISSING",
                "G10",
                "the declaration sha256 is missing or malformed, so the reviewed text is not pinned",
                {"value": decl.get("declaration_sha256")},
            )
        )
    reviews = decl.get("reviews") or {}
    if reviews.get("a08") != "approved" or reviews.get("a11") != "approved":
        out.append(
            _finding(
                "G10_PREFLIGHT_REVIEW_MISSING",
                "G10",
                "both a08 and a11 must record an approved preflight review",
                {"reviews": reviews},
            )
        )
    if not decl.get("coordinator_scheduled"):
        out.append(
            _finding(
                "G10_NOT_SCHEDULED",
                "G10",
                "the coordinator did not schedule this candidate",
            )
        )
    permitted = set(decl.get("permitted_native_changes") or [])
    if not permitted:
        out.append(
            _finding("G10_NO_PERMITTED_CHANGES", "G10", "the declaration permits no native changes")
        )
    unknown = sorted(permitted - CHANGE_KINDS)
    if unknown:
        out.append(
            _finding(
                "G10_UNKNOWN_CHANGE_KIND",
                "G10",
                "the declaration permits change kinds outside the closed set",
                {"unknown": unknown},
            )
        )
    observed = observed_change_kinds(bundle)
    not_permitted = sorted(observed - permitted)
    if not_permitted:
        out.append(
            _finding(
                "G10_CHANGE_NOT_PERMITTED",
                "G10",
                "native changes were observed that the declaration did not permit",
                {
                    "observed": sorted(observed),
                    "permitted": sorted(permitted),
                    "not_permitted": not_permitted,
                },
            )
        )
    for item in validate_declaration(decl):
        out.append(dict(item, gate="G10"))
    return out


GATES = (
    ("G1", gate_g1_intended_library),
    ("G2", gate_g2_no_fallback),
    ("G3", gate_g3_normal_save_exit),
    ("G4", gate_g4_restart_cycles),
    ("G5", gate_g5_paired_comparison),
    ("G6", gate_g6_persistence),
    ("G7", gate_g7_sentinels),
    ("G8", gate_g8_version),
    ("G9", gate_g9_playback),
    ("G10", gate_g10_declaration),
)


def check_capture(bundle):
    """Judge one capture bundle. Acceptance requires every gate to be clean."""
    findings = []
    if not isinstance(bundle, dict):
        findings.append(
            _finding("G0_NOT_AN_OBJECT", "G0", "the capture is not a JSON object")
        )
        bundle = {}
    if bundle.get("schema") != CAPTURE_SCHEMA:
        findings.append(
            _finding(
                "G0_SCHEMA_MISMATCH",
                "G0",
                "unexpected capture schema",
                {"schema": bundle.get("schema"), "expected": CAPTURE_SCHEMA},
            )
        )
    by_phase = _step_by_phase(bundle)
    missing = [phase for phase in REQUIRED_PHASES if phase not in by_phase]
    if missing:
        findings.append(
            _finding(
                "G0_MISSING_PHASE",
                "G0",
                "the capture is missing required phases",
                {"missing": missing, "required": list(REQUIRED_PHASES)},
            )
        )
    gates_evaluated = []
    for gate_id, gate_fn in GATES:
        gates_evaluated.append(gate_id)
        findings.extend(gate_fn(bundle))
    blocking = [item for item in findings if item.get("severity") == "blocking"]
    playback = bundle.get("playback") or {}
    return {
        "schema": VERDICT_SCHEMA,
        "capture_id": bundle.get("capture_id"),
        "accepted": not blocking,
        "version_used": (bundle.get("environment") or {}).get("itunes_version"),
        "authorized_version": AUTHORIZED_ITUNES_VERSION,
        "gates_evaluated": gates_evaluated,
        "failed_gates": sorted({item["gate"] for item in blocking}),
        "codes": sorted({item["code"] for item in findings}),
        "findings": findings,
        "persistence_endpoint": {
            "gate": "G6",
            "clean": not [item for item in blocking if item["gate"] == "G6"],
        },
        "playback_endpoint": {
            "attempted": bool(playback.get("attempted")),
            "outcome": playback.get("outcome"),
            "reported_separately": bool(playback.get("reported_separately")),
            "note": "playback is a separate endpoint and never contributes to accepted",
        },
    }


def main(argv=None):
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        sys.stderr.write("usage: python3 g4_a08_acceptance.py <capture.json>" + chr(10))
        return 2
    with open(args[0], "r", encoding="utf-8") as handle:
        bundle = json.load(handle)
    verdict = check_capture(bundle)
    sys.stdout.write(json.dumps(verdict, indent=2, sort_keys=True) + chr(10))
    return 0 if verdict["accepted"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
