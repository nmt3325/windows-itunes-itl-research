"""Offline gates for the exact-state native Lyrics authority harness."""
from __future__ import annotations

import copy

import pytest

pytest.importorskip("win32gui")

from scripts.research.analyze_mp3_rewrite import parse_id3v22
from scripts.windows import native_lyrics_authority as authority


def synchsafe(value: int) -> bytes:
    return bytes(((value >> 21) & 0x7F, (value >> 14) & 0x7F, (value >> 7) & 0x7F, value & 0x7F))


def retained_shape(text: str = authority.ORIGINAL_LYRICS) -> bytes:
    payload = b"\x00eng\x00" + text.encode("latin-1") + b"\x00"
    frame = b"ULT" + len(payload).to_bytes(3, "big") + payload
    tag_payload = frame + b"\x00" * 64
    return b"ID3\x02\x00\x00" + synchsafe(len(tag_payload)) + tag_payload + b"\xff\xfbsynthetic"


def state() -> dict:
    return {
        "version": authority.EXPECTED_ITUNES_VERSION,
        "library_persistent_id": "1111111111111111",
        "track_count": 1,
        "tracks": [{
            "persistent_id": "2222222222222222",
            "Location": r"D:\probe\field-followup.mp3",
            "Lyrics": authority.ORIGINAL_LYRICS,
            "Size": 19066,
            "ModificationDate": "2026-09-22T03:53:44+00:00",
            "Artist": "",
        }],
        "playlists": [{
            "persistent_id": "1111111111111111",
            "members": [{"persistent_id": "2222222222222222"}],
        }],
    }


def sample(state_hash: str, media_hash: str) -> dict:
    return {"state_sha256": state_hash, "media": {"sha256": media_hash}}


def test_stable_suffix_requires_three_equal_state_and_media_hashes() -> None:
    assert authority.stable_suffix([sample("a", "m"), sample("a", "m"), sample("a", "m")]) is True
    assert authority.stable_suffix([sample("a", "m"), sample("b", "m"), sample("b", "m")]) is False
    assert authority.stable_suffix([sample("a", "m"), sample("a", "x"), sample("a", "x")]) is False
    assert authority.stable_suffix([sample("a", "m"), sample("a", "m")]) is False


def test_authority_projection_allows_only_declared_track_fields() -> None:
    expected = state()
    observed = copy.deepcopy(expected)
    observed["tracks"][0].update(Lyrics="", Size=8777, ModificationDate="changed")
    assert authority.authority_projection_errors(expected, observed) == []
    observed["tracks"][0]["Artist"] = "unexpected"
    errors = authority.authority_projection_errors(expected, observed)
    assert [error["property"] for error in errors] == ["complete_snapshot_except_authority_fields"]


def test_identity_gate_keeps_master_track_and_location_locked() -> None:
    expected = state()
    assert authority.identity_errors(expected, copy.deepcopy(expected)) == []
    observed = copy.deepcopy(expected)
    observed["playlists"][0]["members"] = []
    assert [error["property"] for error in authority.identity_errors(expected, observed)] == ["master_members"]


def test_conflict_variant_changes_only_equal_length_ult_text() -> None:
    tagged = retained_shape()
    conflict = authority.replace_exact_ult_text(tagged, authority.ORIGINAL_LYRICS, authority.CONFLICT_LYRICS)
    assert len(conflict) == len(tagged)
    changed = [index for index, pair in enumerate(zip(tagged, conflict)) if pair[0] != pair[1]]
    assert changed
    before = parse_id3v22(tagged)
    after = parse_id3v22(conflict)
    assert before["audio_offset"] == after["audio_offset"]
    assert tagged[before["audio_offset"] :] == conflict[after["audio_offset"] :]
    assert after["frames"][0]["unsynchronized_lyrics"]["text"] == authority.CONFLICT_LYRICS


def test_conflict_variant_refuses_length_change() -> None:
    with pytest.raises(ValueError, match="exact byte length"):
        authority.replace_exact_ult_text(retained_shape(), authority.ORIGINAL_LYRICS, "short")
