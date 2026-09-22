"""Offline regressions for the Windows native-evidence harnesses.

These tests never launch iTunes, create a profile junction, or touch COM.  They
exercise the fail-closed tree and identity gates used after native capture.
"""
from __future__ import annotations

import datetime as dt
import json

import pytest

pytest.importorskip("win32gui")

from scripts.windows import native_field_matrix as field_matrix
from scripts.windows import native_media_field_followup as media_followup
from scripts.windows import reference_generated_native as reference_native
from scripts.windows import smart_playlist_native as smart_native


def artist_leaf(value: str = "Independent Artist") -> dict:
    return {
        "field_id": 0x04,
        "action_id": 0x01000002,
        "string_value_candidate": value,
    }


def nested_summary(*leaves: dict, issues: list[dict] | None = None) -> dict:
    return {
        "issues": issues or [],
        "rules": {
            "rules": [
                {
                    "nested_group_candidate": {
                        "rules": [
                            {"nested_group_candidate": {"rules": list(leaves)}}
                        ]
                    }
                }
            ]
        },
    }


def test_nested_artist_rule_is_accepted() -> None:
    smart_native.require_artist_rule(nested_summary(artist_leaf()))


@pytest.mark.parametrize(
    "summary",
    [
        nested_summary(artist_leaf("")),
        nested_summary(artist_leaf(), artist_leaf()),
        nested_summary({"field_id": 5, "action_id": 0x01000002, "string_value_candidate": "Independent Artist"}),
        nested_summary(artist_leaf(), issues=[{"severity": "error", "message": "bad rule"}]),
    ],
)
def test_artist_rule_gate_rejects_empty_duplicate_wrong_or_invalid(summary: dict) -> None:
    with pytest.raises(RuntimeError):
        smart_native.require_artist_rule(summary)


def test_playlist_index_rejects_duplicate_persistent_ids() -> None:
    state = {
        "playlists": [
            {"persistent_id": "A", "name": "one"},
            {"persistent_id": "A", "name": "two"},
        ]
    }
    with pytest.raises(RuntimeError, match="duplicate COM playlist persistent ID"):
        smart_native.playlist_index(state)


def test_playlist_index_ignores_missing_ids_and_preserves_rows() -> None:
    row = {"persistent_id": "A", "members": []}
    assert smart_native.playlist_index({"playlists": [{"name": "missing"}, row]}) == {"A": row}


def test_field_matrix_canonicalizes_only_unavailable_error_payloads() -> None:
    value = {
        "field": {"unavailable": "localized COM text"},
        "nested": [{"unavailable": 123}, {"unavailable": "x", "other": 1}],
    }
    assert field_matrix.canonical(value) == {
        "field": {"unavailable": True},
        "nested": [{"unavailable": True}, {"unavailable": "x", "other": 1}],
    }


def test_normalize_com_value_is_deterministic() -> None:
    assert field_matrix.normalize_com_value(dt.datetime(2026, 9, 22, 1, 2, 3)) == "2026-09-22T01:02:03"
    assert field_matrix.normalize_com_value(7) == 7
    assert field_matrix.normalize_com_value(object()).startswith("<object object at ")


def test_target_track_requires_exactly_one_match() -> None:
    target = {"persistent_id": field_matrix.TARGET_TRACK, "Name": "Reference Track"}
    assert field_matrix.target_track({"tracks": [target]}) is target
    with pytest.raises(RuntimeError, match="exactly one target track"):
        field_matrix.target_track({"tracks": []})
    with pytest.raises(RuntimeError, match="exactly one target track"):
        field_matrix.target_track({"tracks": [target, dict(target)]})


def test_reference_summary_uses_utf8_for_unicode_candidates() -> None:
    manifest_path = reference_native.WINDOWS_SCRIPTS / "reference_generated_multi_track_cases.json"
    cases = json.loads(manifest_path.read_text(encoding="utf-8"))
    case = cases[0]
    summary = reference_native.reference_summary(reference_native.REPO_ROOT / case["candidate"])

    assert [row["name"] for row in summary["tracks"]] == [
        "Reference Alpha",
        "Reference Beta 日本語 🎵",
        "Reference Gamma e\u0301",
    ]
    assert reference_native.reference_summary_errors(case["expected"], summary) == []



def media_identity_fixture() -> tuple[dict, dict, dict]:
    master_pid = "1111111111111111"
    track_pid = "2222222222222222"
    expected_state = {
        "version": media_followup.EXPECTED_ITUNES_VERSION,
        "library_persistent_id": master_pid,
        "track_count": 1,
        "tracks": [{"persistent_id": track_pid, "Location": r"D:\media\track.wav"}],
        "playlists": [
            {
                "persistent_id": master_pid,
                "members": [{"persistent_id": track_pid}],
            }
        ],
    }
    summary = {
        "version": media_followup.EXPECTED_ITUNES_VERSION,
        "file_persistent_id": "3333333333333333",
        "tracks": [{"persistent_id": track_pid}],
        "playlists": [
            {
                "persistent_id": master_pid,
                "members": [{"track_persistent_id": track_pid}],
            }
        ],
    }
    return expected_state, summary, {"valid": True}


def test_media_followup_keeps_file_and_master_identity_domains_distinct() -> None:
    expected_state, summary, validation = media_identity_fixture()
    assert summary["file_persistent_id"] != expected_state["library_persistent_id"]
    assert media_followup.independent_identity_errors(summary, validation, expected_state) == []


@pytest.mark.parametrize("file_pid", ["0000000000000000", "not-a-pid"])
def test_media_followup_rejects_invalid_outer_file_identity(file_pid: str) -> None:
    expected_state, summary, validation = media_identity_fixture()
    summary["file_persistent_id"] = file_pid
    errors = media_followup.independent_identity_errors(summary, validation, expected_state)
    assert any(error["property"] == "file_persistent_id" for error in errors)


def test_media_followup_rejects_duplicate_serialized_master_identity() -> None:
    expected_state, summary, validation = media_identity_fixture()
    summary["playlists"].append(dict(summary["playlists"][0]))
    errors = media_followup.independent_identity_errors(summary, validation, expected_state)
    assert {error["property"] for error in errors} >= {
        "serialized_master_instances",
        "serialized_master_members",
    }


def test_media_followup_rejects_wrong_serialized_master_membership() -> None:
    expected_state, summary, validation = media_identity_fixture()
    summary["playlists"][0]["members"] = [{"track_persistent_id": "4444444444444444"}]
    errors = media_followup.independent_identity_errors(summary, validation, expected_state)
    assert [error["property"] for error in errors] == ["serialized_master_members"]


@pytest.mark.parametrize(
    "states",
    [
        [],
        [{"value": 1}],
        [{"value": 1}, {"value": 2}, {"value": 1}],
    ],
)
def test_media_followup_convergence_refuses_without_adjacent_equal_states(states: list[dict]) -> None:
    assert media_followup.consecutive_snapshot_convergence(states) is None


def test_media_followup_convergence_returns_first_equal_pair_end_read() -> None:
    states = [{"value": 1}, {"value": 2}, {"value": 2}, {"value": 3}, {"value": 3}]
    assert media_followup.consecutive_snapshot_convergence(states) == 3
