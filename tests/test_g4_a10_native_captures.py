"""Structural regression over real Windows iTunes 12.13.11.1 output (G4-B / a10).

The captures under research/g4/a10/captures were written by native iTunes
12.13.11.1 inside an isolated, disposable library: an empty library plus one
generated 440 Hz WAV tone. They are synthetic evidence, not user data.

These tests exercise the itlkit protocol against genuine native bytes. They
assert nothing about native acceptance of codec-written files.
"""
from __future__ import annotations

import hashlib
import json
from pathlib import Path

import pytest

from itlkit import Library

CAPTURES = Path(__file__).resolve().parents[1] / "research" / "g4" / "a10" / "captures"

WRITER_VERSION = "12.13.11.1"
FILE_PERSISTENT_ID = "90A10F416B212186"
LIBRARY_PERSISTENT_ID = "5EE1AA7E252C2FB3"
TONE_PERSISTENT_ID = "C54F0D3E83DBDA0F"
TONE_ITEM_PERSISTENT_ID = "5167CE30B1D56179"
TONE_NAME = "a10-tone-440hz-2s"
TONE_KIND = "WAV audio file"
TONE_FILE_SIZE = 176444
TONE_TOTAL_TIME = 2000
PLAYLIST_COUNT = 14

SNAPSHOT_SHA256 = {
    "lib01-empty-baseline": "291ec968ac90e56cb8d0f7606977a966618015fa5ea33a8209cd8ab6fbe69f6b",
    "lib01-import": "7305ae1de4b54f1975d48745fee8d78d6dc82977010f9f6cae688bfca5de7ff7",
    "lib01-restart1": "5f93c86af87d7b687af9c1bbc3d8768b2db17c56fea2dff8c0caf108c932f294",
    "lib01-restart2": "19d088455f692cc86f3d4f70c5fc74fd039d1efca0ce22f80f25547b8b876dcb",
}
SNAPSHOTS = tuple(SNAPSHOT_SHA256)
SNAPSHOTS_WITH_TRACK = ("lib01-import", "lib01-restart1", "lib01-restart2")

# track_id, album_id, artist_id as actually observed. The in-session values from
# the importing process are renumbered once the library is reopened.
NUMERIC_IDS = {
    "lib01-import": (139, 141, 142),
    "lib01-restart1": (71, 69, 70),
    "lib01-restart2": (71, 69, 70),
}


def _capture(name: str) -> Path:
    path = CAPTURES / (name + ".itl")
    if not path.exists():
        pytest.skip("native capture not present: " + path.name)
    return path


def _summary(name: str) -> dict:
    return Library.read(_capture(name)).summary()


def _only_track(name: str) -> dict:
    tracks = _summary(name)["tracks"]
    assert len(tracks) == 1
    return tracks[0]


def _master(summary: dict) -> dict:
    masters = [item for item in summary["playlists"] if item.get("is_master")]
    assert len(masters) == 1
    return masters[0]


@pytest.mark.parametrize("name", SNAPSHOTS)
def test_capture_bytes_match_recorded_digest(name):
    digest = hashlib.sha256(_capture(name).read_bytes()).hexdigest()
    assert digest == SNAPSHOT_SHA256[name]


@pytest.mark.parametrize("name", SNAPSHOTS)
def test_noop_write_of_native_file_is_bit_exact(name):
    path = _capture(name)
    assert Library.read(path).to_bytes() == path.read_bytes()


@pytest.mark.parametrize("name", SNAPSHOTS)
def test_forced_rebuild_preserves_native_payload(name):
    library = Library.read(_capture(name))
    rebuilt = Library.from_bytes(library.to_bytes(rebuild=True))
    assert rebuilt.container.payload == library.container.payload


@pytest.mark.parametrize("name", SNAPSHOTS)
def test_writer_version_and_container_identity(name):
    summary = _summary(name)
    assert summary["version"] == WRITER_VERSION
    assert summary["file_persistent_id"] == FILE_PERSISTENT_ID
    assert summary["library_persistent_id"] == LIBRARY_PERSISTENT_ID
    assert len(summary["playlists"]) == PLAYLIST_COUNT


def test_empty_baseline_carries_no_tracks():
    summary = _summary("lib01-empty-baseline")
    assert summary["tracks"] == []
    assert _master(summary)["track_ids"] == []


@pytest.mark.parametrize("name", SNAPSHOTS_WITH_TRACK)
def test_single_imported_tone_is_described_identically(name):
    track = _only_track(name)
    assert track["persistent_id"] == TONE_PERSISTENT_ID
    assert track["name"] == TONE_NAME
    assert track["kind"] == TONE_KIND
    assert track["file_size"] == TONE_FILE_SIZE
    assert track["total_time"] == TONE_TOTAL_TIME


@pytest.mark.parametrize("name", SNAPSHOTS_WITH_TRACK)
def test_master_playlist_membership_is_stable(name):
    summary = _summary(name)
    master = _master(summary)
    assert master["track_ids"] == [_only_track(name)["track_id"]]
    assert master["item_persistent_ids"] == [TONE_ITEM_PERSISTENT_ID]


@pytest.mark.parametrize("name", SNAPSHOTS_WITH_TRACK)
def test_numeric_ids_match_observed_values(name):
    track = _only_track(name)
    observed = (track["track_id"], track["album_id"], track["artist_id"])
    assert observed == NUMERIC_IDS[name]


def test_reopen_renumbers_numeric_ids_but_not_persistent_identity():
    imported = _only_track("lib01-import")
    reopened = _only_track("lib01-restart1")
    assert imported["track_id"] != reopened["track_id"]
    assert imported["album_id"] != reopened["album_id"]
    assert imported["artist_id"] != reopened["artist_id"]
    assert imported["persistent_id"] == reopened["persistent_id"]
    assert imported["date_added"] == reopened["date_added"]
    assert imported["date_modified"] == reopened["date_modified"]
    assert imported["file_size"] == reopened["file_size"]


def test_both_restart_cycles_are_semantically_identical():
    assert _summary("lib01-restart1") == _summary("lib01-restart2")


_PATH_KEYS = ("url", "path", "location")


def _basename(value: str) -> str:
    return value.replace("\", "/").rstrip("/").rsplit("/", 1)[-1]


def _normalise_paths(value):
    """Reduce path-bearing fields to their final component.

    The published sidecars have their CI directory prefixes redacted under
    docs/g4/redaction-policy.md, while the .itl captures beside them are
    untouched native bytes. Comparing the two verbatim would compare a redacted
    string against a real one. A directory prefix is a property of the machine
    that produced the capture, not of the format, so it is normalised away
    here. The file name, which the format does bind to the track, is still
    compared exactly, and the test below asserts the redaction happened at all.
    """
    if isinstance(value, dict):
        return {
            key: _basename(item)
            if key in _PATH_KEYS and isinstance(item, str)
            else _normalise_paths(item)
            for key, item in value.items()
        }
    if isinstance(value, list):
        return [_normalise_paths(item) for item in value]
    return value


@pytest.mark.parametrize("name", SNAPSHOTS)
def test_sidecar_inspect_json_matches_library_summary(name):
    sidecar = CAPTURES / ("itlkit-inspect-" + name + ".json")
    if not sidecar.exists():
        pytest.skip("sidecar not present: " + sidecar.name)
    recorded = json.loads(sidecar.read_text(encoding="utf-8"))
    computed = json.loads(json.dumps(_summary(name)))
    assert _normalise_paths(recorded) == _normalise_paths(computed)


@pytest.mark.parametrize("name", SNAPSHOTS_WITH_TRACK)
def test_sidecar_media_paths_are_redacted_but_keep_the_file_name(name):
    sidecar = CAPTURES / ("itlkit-inspect-" + name + ".json")
    if not sidecar.exists():
        pytest.skip("sidecar not present: " + sidecar.name)
    track = json.loads(sidecar.read_text(encoding="utf-8"))["tracks"][0]
    for field in ("path", "url"):
        assert "<CI_" in track[field] or "RUNNER-" in track[field]
        assert _basename(track[field]) == TONE_NAME + ".wav"
    assert _basename(_only_track(name)["path"]) == _basename(track["path"])
