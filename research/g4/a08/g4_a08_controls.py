"""Synthetic positive and negative controls for the a08 acceptance protocol.

Every bundle in this module is fabricated on the linux runner. Nothing here
launches iTunes, calls COM, drives a UI, or reads a native library directory:
the point is to synthesize recorded observations of known-bad outcomes so the
checker can be shown to reject them.

A protocol that has never failed on purpose is not validated, so each entry in
NEGATIVE_CONTROLS names the codes it MUST provoke.
"""

from __future__ import annotations

import copy

LIB_DIR = "C:/Users/runner/Music/iTunes"
LIB_PATH = LIB_DIR + "/iTunes Library.itl"
OTHER_LIB_PATH = LIB_DIR + "/iTunes Library 2.itl"
MEDIA_DIR = "C:/Users/runner/Music/synthetic"

LIBRARY_ID = "LIB0000000000001"
REBUILT_LIBRARY_ID = "LIB00000000BEEF1"

SHA_BASE = "1" * 64
SHA_APPLIED = "2" * 64
SHA_MEDIA = "3" * 64
SHA_DECLARATION = "4" * 64

AUTHORIZED_VERSION = "12.13.11.1"
AUTHORIZED_INSTALLER = (
    "25b28905a81406a5edbf482f7f3ee4831a8641d32d29dceda5d1eb3e8d534c08"
)
HISTORICAL_VERSION = "12.13.10.3"

TRACK_A = "AAAA000000000001"
TRACK_B = "BBBB000000000002"
TRACK_NEW = "CCCC000000000003"
PLAYLIST_LIB = "PPPP000000000001"
PLAYLIST_EXTRA = "PPPP000000000002"

WIN_SEP = chr(92)

TRACK_META = {
    TRACK_A: {
        "name": "Synthetic A",
        "artist": "a09-fixtures",
        "album": "controls",
        "location": MEDIA_DIR + "/synthetic-a.m4a",
        "size": 111111,
        "total_time_ms": 1000,
    },
    TRACK_B: {
        "name": "Synthetic B",
        "artist": "a09-fixtures",
        "album": "controls",
        "location": MEDIA_DIR + "/synthetic-b.m4a",
        "size": 222222,
        "total_time_ms": 2000,
    },
    TRACK_NEW: {
        "name": "Synthetic NEW",
        "artist": "a09-fixtures",
        "album": "controls",
        "location": MEDIA_DIR + "/synthetic-new.m4a",
        "size": 333333,
        "total_time_ms": 3000,
    },
}

BASE_TRACKS = [TRACK_A, TRACK_B]
APPLIED_TRACKS = [TRACK_A, TRACK_B, TRACK_NEW]


def windows_style(path):
    """Same path, Windows separators and upper case. Must NOT trip G1."""
    return path.replace("/", WIN_SEP).upper()


def _disk_observation(track_ids, playlist_items, sha, library_id=LIBRARY_ID,
                      snapshots=(), siblings=None):
    return {
        "path": LIB_PATH,
        "sha256": sha,
        "size": 40960 + 1024 * len(track_ids),
        "library_persistent_id": library_id,
        "track_ids": list(track_ids),
        "tracks": {tid: dict(TRACK_META[tid]) for tid in track_ids},
        "playlists": [
            {
                "persistent_id": PLAYLIST_LIB,
                "name": "Library",
                "item_ids": list(playlist_items),
            }
        ],
        "siblings": list(
            siblings
            if siblings is not None
            else ["iTunes Library.itl", "iTunes Library Extras.itdb"]
        ),
        "prev_library_snapshots": list(snapshots),
    }


def _com_view(disk):
    return {
        "available": True,
        "library_persistent_id": disk["library_persistent_id"],
        "track_ids": list(disk["track_ids"]),
        "tracks": copy.deepcopy(disk["tracks"]),
        "playlists": copy.deepcopy(disk["playlists"]),
    }


def _process(exit_kind="normal_quit", exit_code=0, dialogs=(), crash_dumps=(),
             repair_log_lines=(), launch=True, killed=False):
    return {
        "launch": launch,
        "exit_kind": exit_kind,
        "exit_code": exit_code,
        "killed": killed,
        "dialogs": list(dialogs),
        "crash_dumps": list(crash_dumps),
        "repair_log_lines": list(repair_log_lines),
    }


def _step(index, phase, track_ids, playlist_items, sha, opened=LIB_PATH, **kw):
    disk = _disk_observation(
        track_ids,
        playlist_items,
        sha,
        library_id=kw.pop("library_id", LIBRARY_ID),
        snapshots=kw.pop("snapshots", ()),
        siblings=kw.pop("siblings", None),
    )
    return {
        "index": index,
        "phase": phase,
        "opened_library_paths": [opened],
        "process": _process(**kw),
        "disk": disk,
        "com": _com_view(disk),
    }


def declaration():
    return {
        "schema": "g4/a08/candidate-declaration/v1",
        "declaration_id": "a10-cand-0001",
        "declaration_sha256": SHA_DECLARATION,
        "author": "a10",
        "created_at": "2026-09-11T12:00:00+09:00",
        "itunes_version_target": AUTHORIZED_VERSION,
        "installer_sha256": AUTHORIZED_INSTALLER,
        "reviews": {"a08": "approved", "a11": "approved"},
        "coordinator_scheduled": True,
        "input": {
            "library_path": LIB_PATH,
            "library_sha256": SHA_BASE,
            "media_files": [
                {"path": MEDIA_DIR + "/synthetic-new.m4a", "sha256": SHA_MEDIA}
            ],
        },
        "output": {
            "library_sha256_expected": None,
            "library_sha256_predicted": None,
        },
        "ids": {
            "old": {
                "track_persistent_ids": list(BASE_TRACKS),
                "playlist_persistent_ids": [PLAYLIST_LIB],
                "library_persistent_id": LIBRARY_ID,
            },
            "new": {
                "track_persistent_ids": list(APPLIED_TRACKS),
                "playlist_persistent_ids": [PLAYLIST_LIB],
                "library_persistent_id": LIBRARY_ID,
            },
        },
        "metadata": {TRACK_NEW: dict(TRACK_META[TRACK_NEW])},
        "locations": {TRACK_NEW: TRACK_META[TRACK_NEW]["location"]},
        "playlists": [
            {
                "persistent_id": PLAYLIST_LIB,
                "name": "Library",
                "member_ids_expected": list(APPLIED_TRACKS),
                "order_expected": list(APPLIED_TRACKS),
            }
        ],
        "permitted_native_changes": ["add_track", "add_to_playlist"],
        "forbidden": ["rebuild", "repair", "consolidate", "upgrade_library"],
        "rollback": {
            "input_copy_sha256": SHA_BASE,
            "restore_procedure": "restore the pristine copy, then re-verify sha256",
        },
    }


def good_bundle():
    """A capture that satisfies every gate. The positive control."""
    return {
        "schema": "g4/a08/native-capture/v1",
        "capture_id": "a10-capture-0001",
        "declaration": declaration(),
        "environment": {
            "operator": "a10",
            "env_id": "win-r6qwbqfz",
            "itunes_version": AUTHORIZED_VERSION,
            "installer_sha256": AUTHORIZED_INSTALLER,
            "version_evidence": "FileVersion of the installed iTunes.exe, read after install",
        },
        "comparison": {
            "baseline_kind": "phase_observed",
            "baseline_ref": "g4b-synthetic-baseline-0001",
            "baseline_itunes_version": AUTHORIZED_VERSION,
            "version_difference_flagged": False,
        },
        "library": {
            "intended_path": LIB_PATH,
            "intended_pre_sha256": SHA_BASE,
        },
        "com_calls": [
            {"name": "AddFile", "result": "ok", "phase": "candidate_apply"}
        ],
        "steps": [
            _step(0, "baseline", BASE_TRACKS, BASE_TRACKS, SHA_BASE),
            _step(1, "candidate_apply", APPLIED_TRACKS, APPLIED_TRACKS, SHA_APPLIED),
            _step(2, "restart_1", APPLIED_TRACKS, APPLIED_TRACKS, SHA_APPLIED),
            _step(3, "restart_2", APPLIED_TRACKS, APPLIED_TRACKS, SHA_APPLIED),
        ],
        "playback": {
            "attempted": True,
            "outcome": "played",
            "reported_separately": True,
            "folded_into_acceptance": False,
        },
    }


def _find_step(bundle, phase):
    for step in bundle["steps"]:
        if step.get("phase") == phase:
            return step
    raise KeyError(phase)


def _set_state(bundle, phase, track_ids, playlist_items, sha, **kw):
    step = _find_step(bundle, phase)
    step["disk"] = _disk_observation(track_ids, playlist_items, sha, **kw)
    step["com"] = _com_view(step["disk"])
    return step


def control_silent_rebuild():
    """iTunes silently rebuilt the library instead of editing it."""
    bundle = good_bundle()
    snapshot = ["Previous iTunes Libraries/iTunes Library 2026-09-11.itl"]
    for phase in ("candidate_apply", "restart_1", "restart_2"):
        _set_state(
            bundle,
            phase,
            APPLIED_TRACKS,
            APPLIED_TRACKS,
            SHA_APPLIED,
            library_id=REBUILT_LIBRARY_ID,
            snapshots=snapshot,
            siblings=["iTunes Library.itl", "iTunes Library (Damaged).itl"],
        )
    _find_step(bundle, "candidate_apply")["process"]["dialogs"] = [
        "The file iTunes Library.itl cannot be read. A new library will be created."
    ]
    return bundle


def control_reverted_after_restart():
    """The edit is visible after apply, then gone after restart."""
    bundle = good_bundle()
    for phase in ("restart_1", "restart_2"):
        _set_state(bundle, phase, BASE_TRACKS, BASE_TRACKS, SHA_BASE)
    return bundle


def control_written_but_not_persisted():
    """COM reports the addition; the bytes on disk never changed."""
    bundle = good_bundle()
    apply_step = _find_step(bundle, "candidate_apply")
    apply_step["disk"] = _disk_observation(BASE_TRACKS, BASE_TRACKS, SHA_BASE)
    for phase in ("restart_1", "restart_2"):
        _set_state(bundle, phase, BASE_TRACKS, BASE_TRACKS, SHA_BASE)
    return bundle


def control_wrong_library_opened():
    """The mutation went to a different .itl than the declared one."""
    bundle = good_bundle()
    for phase in ("candidate_apply", "restart_1", "restart_2"):
        _find_step(bundle, phase)["opened_library_paths"] = [OTHER_LIB_PATH]
    return bundle


def control_empty_library_generated():
    """A fresh empty library opens cleanly and could masquerade as success."""
    bundle = good_bundle()
    for phase in ("candidate_apply", "restart_1", "restart_2"):
        _set_state(
            bundle,
            phase,
            [],
            [],
            SHA_APPLIED,
            library_id=REBUILT_LIBRARY_ID,
            snapshots=["Previous iTunes Libraries/iTunes Library 2026-09-11.itl"],
        )
    return bundle


def control_com_call_only():
    """A successful COM AddFile and nothing else. Never acceptance."""
    bundle = good_bundle()
    bundle["steps"] = [
        step
        for step in bundle["steps"]
        if step.get("phase") in ("baseline", "candidate_apply")
    ]
    return bundle


def control_abnormal_exit():
    bundle = good_bundle()
    _find_step(bundle, "candidate_apply")["process"] = _process(
        exit_kind="crash",
        exit_code=3221225477,
        crash_dumps=["iTunes.exe.6816.dmp"],
    )
    return bundle


def control_killed_restart_cycle():
    bundle = good_bundle()
    _find_step(bundle, "restart_1")["process"] = _process(
        exit_kind="killed", exit_code=1, killed=True
    )
    return bundle


def control_missing_com_observation():
    bundle = good_bundle()
    _find_step(bundle, "restart_2")["com"] = {
        "available": False,
        "reason": "COM was not queried at this step",
    }
    return bundle


def control_missing_disk_observation():
    bundle = good_bundle()
    _find_step(bundle, "restart_1")["disk"] = None
    return bundle


def control_disk_com_disagreement():
    """COM shows an order the bytes do not contain."""
    bundle = good_bundle()
    step = _find_step(bundle, "restart_2")
    step["com"]["playlists"][0]["item_ids"] = [TRACK_NEW, TRACK_A, TRACK_B]
    return bundle


def control_metadata_drift():
    bundle = good_bundle()
    for phase in ("restart_1", "restart_2"):
        step = _find_step(bundle, phase)
        step["disk"]["tracks"][TRACK_NEW]["name"] = "Synthetic NEW (rewritten)"
        step["com"] = _com_view(step["disk"])
    return bundle


def control_playlist_order_drift():
    bundle = good_bundle()
    for phase in ("restart_1", "restart_2"):
        step = _find_step(bundle, phase)
        step["disk"]["playlists"][0]["item_ids"] = [TRACK_NEW, TRACK_A, TRACK_B]
        step["com"] = _com_view(step["disk"])
    return bundle


def control_version_not_stated():
    bundle = good_bundle()
    bundle["environment"]["itunes_version"] = None
    bundle["environment"]["version_evidence"] = ""
    return bundle


def control_historical_version_comparison():
    """Compared against a 12.13.10.3 result without flagging the difference."""
    bundle = good_bundle()
    bundle["comparison"] = {
        "baseline_kind": "historical",
        "baseline_ref": "g3-native-20260908",
        "baseline_itunes_version": HISTORICAL_VERSION,
        "version_difference_flagged": False,
    }
    return bundle


def control_installer_hash_mismatch():
    bundle = good_bundle()
    bundle["environment"]["installer_sha256"] = "0" * 64
    return bundle


def control_playback_folded():
    bundle = good_bundle()
    bundle["playback"] = {
        "attempted": True,
        "outcome": "played",
        "reported_separately": False,
        "folded_into_acceptance": True,
    }
    return bundle


def control_unreviewed_declaration():
    bundle = good_bundle()
    bundle["declaration"]["reviews"] = {"a08": "approved"}
    bundle["declaration"]["coordinator_scheduled"] = False
    return bundle


def control_declaration_missing():
    bundle = good_bundle()
    bundle["declaration"] = None
    return bundle


def control_change_not_permitted():
    """An undeclared playlist appears alongside the permitted changes."""
    bundle = good_bundle()
    for phase in ("candidate_apply", "restart_1", "restart_2"):
        step = _find_step(bundle, phase)
        step["disk"]["playlists"].append(
            {
                "persistent_id": PLAYLIST_EXTRA,
                "name": "Recently Added",
                "item_ids": [TRACK_NEW],
            }
        )
        step["com"] = _com_view(step["disk"])
    return bundle


def control_windows_path_variant():
    """Positive control: separators and case must not be treated as a mismatch."""
    bundle = good_bundle()
    for step in bundle["steps"]:
        step["opened_library_paths"] = [windows_style(LIB_PATH)]
    return bundle


def control_playback_failed_but_separate():
    """Positive control: a failed playback must not retract acceptance."""
    bundle = good_bundle()
    bundle["playback"] = {
        "attempted": True,
        "outcome": "failed: no audio endpoint on the runner",
        "reported_separately": True,
        "folded_into_acceptance": False,
    }
    return bundle


NEGATIVE_CONTROLS = (
    {
        "name": "silent_rebuild",
        "failure_mode": "library silently rebuilt instead of edited",
        "builder": control_silent_rebuild,
        "must_include": (
            "G2_DAMAGED_DIALOG",
            "G2_DAMAGED_SIBLING",
            "G2_NEW_PREV_LIBRARY_SNAPSHOT",
            "G2_LIBRARY_IDENTITY_CHANGED",
        ),
    },
    {
        "name": "reverted_after_restart",
        "failure_mode": "edit present after apply, gone after restart",
        "builder": control_reverted_after_restart,
        "must_include": ("G6_CANDIDATE_REVERTED",),
    },
    {
        "name": "written_but_not_persisted",
        "failure_mode": "candidate visible over COM but never written to disk",
        "builder": control_written_but_not_persisted,
        "must_include": (
            "G3_NO_SAVE_OBSERVED",
            "G5_DISK_COM_TRACK_MISMATCH",
            "G6_CANDIDATE_ABSENT_AFTER_APPLY",
        ),
    },
    {
        "name": "wrong_library_opened",
        "failure_mode": "a different .itl than the declared one was opened",
        "builder": control_wrong_library_opened,
        "must_include": (
            "G1_WRONG_LIBRARY_OPENED",
            "G1_MULTIPLE_LIBRARIES_OPENED",
        ),
    },
    {
        "name": "empty_library_generated",
        "failure_mode": "empty library generated and opened cleanly",
        "builder": control_empty_library_generated,
        "must_include": ("G7_EMPTY_LIBRARY",),
    },
    {
        "name": "com_call_only",
        "failure_mode": "successful COM AddFile treated as acceptance",
        "builder": control_com_call_only,
        "must_include": (
            "G7_COM_CALL_ONLY",
            "G4_INSUFFICIENT_RESTART_CYCLES",
            "G0_MISSING_PHASE",
        ),
    },
    {
        "name": "abnormal_exit",
        "failure_mode": "crash instead of a normal save and exit",
        "builder": control_abnormal_exit,
        "must_include": (
            "G3_ABNORMAL_EXIT",
            "G3_NONZERO_EXIT_CODE",
            "G3_CRASH_DUMP",
        ),
    },
    {
        "name": "killed_restart_cycle",
        "failure_mode": "restart cycle terminated by kill",
        "builder": control_killed_restart_cycle,
        "must_include": ("G3_PROCESS_KILLED", "G4_RESTART_NOT_FULL_CYCLE"),
    },
    {
        "name": "missing_com_observation",
        "failure_mode": "a step with no COM observation to compare",
        "builder": control_missing_com_observation,
        "must_include": ("G5_MISSING_COM_OBSERVATION",),
    },
    {
        "name": "missing_disk_observation",
        "failure_mode": "a step with no raw disk observation to compare",
        "builder": control_missing_disk_observation,
        "must_include": ("G5_MISSING_DISK_OBSERVATION",),
    },
    {
        "name": "disk_com_disagreement",
        "failure_mode": "COM and raw bytes disagree about playlist order",
        "builder": control_disk_com_disagreement,
        "must_include": ("G5_DISK_COM_PLAYLIST_MISMATCH",),
    },
    {
        "name": "metadata_drift",
        "failure_mode": "persisted metadata differs from the declaration",
        "builder": control_metadata_drift,
        "must_include": ("G6_METADATA_DRIFT",),
    },
    {
        "name": "playlist_order_drift",
        "failure_mode": "declared playlist order not persisted",
        "builder": control_playlist_order_drift,
        "must_include": ("G6_PLAYLIST_ORDER_DRIFT",),
    },
    {
        "name": "version_not_stated",
        "failure_mode": "native result does not state the version actually used",
        "builder": control_version_not_stated,
        "must_include": (
            "G8_VERSION_NOT_STATED",
            "G8_VERSION_EVIDENCE_MISSING",
        ),
    },
    {
        "name": "historical_version_comparison",
        "failure_mode": "compared to a historical native result without flagging the version difference",
        "builder": control_historical_version_comparison,
        "must_include": ("G8_UNFLAGGED_HISTORICAL_COMPARISON",),
    },
    {
        "name": "installer_hash_mismatch",
        "failure_mode": "installer hash is not the authorized one for this phase",
        "builder": control_installer_hash_mismatch,
        "must_include": ("G8_INSTALLER_HASH_MISMATCH",),
    },
    {
        "name": "playback_folded",
        "failure_mode": "playback folded into the acceptance verdict",
        "builder": control_playback_folded,
        "must_include": (
            "G9_PLAYBACK_FOLDED",
            "G9_PLAYBACK_NOT_SEPARATELY_REPORTED",
        ),
    },
    {
        "name": "unreviewed_declaration",
        "failure_mode": "executed without a08 plus a11 review and coordinator scheduling",
        "builder": control_unreviewed_declaration,
        "must_include": ("G10_PREFLIGHT_REVIEW_MISSING", "G10_NOT_SCHEDULED"),
    },
    {
        "name": "declaration_missing",
        "failure_mode": "no candidate declaration at all",
        "builder": control_declaration_missing,
        "must_include": ("G10_DECLARATION_MISSING",),
    },
    {
        "name": "change_not_permitted",
        "failure_mode": "a native change outside the permitted allow-list",
        "builder": control_change_not_permitted,
        "must_include": ("G10_CHANGE_NOT_PERMITTED",),
    },
)

POSITIVE_CONTROLS = (
    {"name": "good_bundle", "builder": good_bundle},
    {"name": "windows_path_variant", "builder": control_windows_path_variant},
    {
        "name": "playback_failed_but_separate",
        "builder": control_playback_failed_but_separate,
    },
)
