"""Offline regressions for cross-version native iTunes qualification."""
from __future__ import annotations

from scripts.windows import reference_generated_native as native
from scripts.windows import u01_distinct_build_20260927 as distinct


def expected(version: str = "12.13.10.3") -> dict:
    return {
        "version": version,
        "library_persistent_id": "5245464552454E43",
        "track_count": 0,
        "tracks": [],
        "playlists": [],
    }


def test_input_and_native_versions_are_independent() -> None:
    input_expected = expected()
    native_expected = native.expected_with_version(input_expected, "12.13.11.1")

    assert input_expected["version"] == "12.13.10.3"
    assert native_expected["version"] == "12.13.11.1"
    assert native_expected is not input_expected


def test_candidate_preflight_keeps_input_version_gate() -> None:
    input_expected = expected()
    summary = {
        "version": "12.13.10.3",
        "file_persistent_id": "5245464552454E43",
        "tracks": [],
        "playlists": [],
    }

    assert native.reference_summary_errors(input_expected, summary) == []
    errors = native.reference_summary_errors(
        native.expected_with_version(input_expected, "12.13.11.1"), summary
    )
    assert errors == [
        {"property": "version", "expected": "12.13.11.1", "actual": "12.13.10.3"}
    ]


def test_file_and_com_master_persistent_ids_can_be_pinned_independently() -> None:
    input_expected = expected()
    input_expected["library_persistent_id"] = "9751B29CECF5340B"
    input_expected["file_persistent_id"] = "D2F61BE0A69CA302"
    reference_summary = {
        "version": "12.13.10.3",
        "file_persistent_id": "D2F61BE0A69CA302",
        "tracks": [],
        "playlists": [],
    }
    com_snapshot = {
        "version": "12.13.10.3",
        "library_persistent_id": "9751B29CECF5340B",
        "track_count": 0,
        "tracks": [],
        "playlists": [],
    }

    assert native.reference_summary_errors(input_expected, reference_summary) == []
    assert native.expected_state_errors(input_expected, com_snapshot) == []


def test_outer_file_persistent_id_mismatch_is_fail_closed() -> None:
    input_expected = expected()
    input_expected["file_persistent_id"] = "D2F61BE0A69CA302"
    summary = {
        "version": "12.13.10.3",
        "file_persistent_id": "9751B29CECF5340B",
        "tracks": [],
        "playlists": [],
    }

    assert native.reference_summary_errors(input_expected, summary) == [
        {
            "property": "file_persistent_id",
            "expected": "D2F61BE0A69CA302",
            "actual": "9751B29CECF5340B",
        }
    ]


def test_executable_identity_accepts_only_exact_version_and_hash() -> None:
    observed_hash = "a" * 64
    assert native.executable_identity_errors(
        expected_version="12.13.11.1",
        expected_sha256=observed_hash.upper(),
        observed_sha256=observed_hash,
        observed_file_version="12.13.11.1",
        observed_product_version="12.13.11.1",
    ) == []


def test_executable_identity_refuses_hash_mismatch() -> None:
    errors = native.executable_identity_errors(
        expected_version="12.13.11.1",
        expected_sha256="a" * 64,
        observed_sha256="b" * 64,
        observed_file_version="12.13.11.1",
        observed_product_version="12.13.11.1",
    )
    assert [error["property"] for error in errors] == ["sha256"]


def test_executable_identity_refuses_file_or_product_version_mismatch() -> None:
    errors = native.executable_identity_errors(
        expected_version="12.13.11.1",
        expected_sha256="a" * 64,
        observed_sha256="a" * 64,
        observed_file_version="12.13.10.3",
        observed_product_version="12.13.11.0",
    )
    assert [error["property"] for error in errors] == ["file_version", "product_version"]



def semantic_expected() -> dict:
    return {
        "version": "12.12.10.1",
        "file_persistent_id": "1111111111111111",
        "library_persistent_id": "2222222222222222",
        "track_count": 1,
        "tracks": [{
            "persistent_id": "3333333333333333",
            "name": "n",
            "artist": "a",
            "album": "b",
            "album_artist": "aa",
            "comment": "c",
            "rating": 80,
            "play_count": 2,
            "skip_count": 1,
            "track_number": 1,
            "year": 2023,
        }],
        "playlists": [],
    }


def test_optional_selected_semantics_gate_com_and_parser() -> None:
    wanted = semantic_expected()
    track = wanted["tracks"][0]
    com = {
        "version": wanted["version"],
        "library_persistent_id": wanted["library_persistent_id"],
        "track_count": 1,
        "tracks": [{
            "persistent_id": track["persistent_id"],
            "Name": track["name"],
            "Artist": track["artist"],
            "Album": track["album"],
            "AlbumArtist": track["album_artist"],
            "Comment": track["comment"],
            "Rating": track["rating"],
            "PlayedCount": track["play_count"],
            "SkippedCount": track["skip_count"],
            "TrackNumber": track["track_number"],
            "Year": track["year"],
        }],
        "playlists": [],
    }
    summary = {
        "version": wanted["version"],
        "file_persistent_id": wanted["file_persistent_id"],
        "tracks": [dict(track)],
        "playlists": [],
    }
    assert native.expected_state_errors(wanted, com) == []
    assert native.reference_summary_errors(wanted, summary) == []
    com["tracks"][0]["PlayedCount"] = 3
    summary["tracks"][0]["album_artist"] = "wrong"
    assert [row["property"] for row in native.expected_state_errors(wanted, com)] == [
        "track[3333333333333333].PlayedCount"
    ]
    assert [row["property"] for row in native.reference_summary_errors(wanted, summary)] == [
        "track[3333333333333333].album_artist"
    ]


def test_legacy_name_only_manifest_remains_supported() -> None:
    wanted = semantic_expected()
    wanted["tracks"] = [{"persistent_id": "3333333333333333", "name": "n"}]
    com = {
        "version": wanted["version"],
        "library_persistent_id": wanted["library_persistent_id"],
        "track_count": 1,
        "tracks": [{"persistent_id": "3333333333333333", "Name": "n"}],
        "playlists": [],
    }
    summary = {
        "version": wanted["version"],
        "file_persistent_id": wanted["file_persistent_id"],
        "tracks": [{"persistent_id": "3333333333333333", "name": "n"}],
        "playlists": [],
    }
    assert native.expected_state_errors(wanted, com) == []
    assert native.reference_summary_errors(wanted, summary) == []



def test_predeclared_product_modal_match_is_semantic_not_title_only() -> None:
    modal = {
        "title": "iTunes",
        "children": [{
            "text": "The file “iTunes Library.itl” cannot be read because it was created by a newer version of iTunes."
        }],
    }
    assert distinct.product_modal_matches(modal)
    assert not distinct.product_modal_matches({
        "title": "iTunes",
        "children": [{"text": "The iTunes Library.itl file is locked."}],
    })


def test_negative_preflight_is_exact_and_fail_closed() -> None:
    summary = {
        "version": "12.13.10.3",
        "file_persistent_id": distinct.NEGATIVE_FILE_PID,
        "tracks": [{"persistent_id": distinct.NEGATIVE_TRACK_PID, "name": "Reference Track"}],
        "playlists": [{
            "persistent_id": distinct.NEGATIVE_PLAYLIST_PID,
            "name": "Reference Playlist",
        }],
    }
    assert distinct.negative_preflight_errors(summary) == []
    summary["tracks"][0]["name"] = "post-hoc replacement"
    assert [row["property"] for row in distinct.negative_preflight_errors(summary)] == ["track_name"]
