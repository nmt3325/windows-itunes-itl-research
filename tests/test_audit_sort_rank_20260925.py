"""Targeted regression tests for the retained U-10 sort/rank audit."""
from __future__ import annotations

import importlib.util
from pathlib import Path
import sys

import pytest

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/audit_sort_rank_20260925.py"
SPEC = importlib.util.spec_from_file_location("audit_sort_rank_20260925", SCRIPT)
assert SPEC is not None and SPEC.loader is not None
AUDIT = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = AUDIT
SPEC.loader.exec_module(AUDIT)
CHECKED_IN = ROOT / "evidence/research/20260925/sort-rank-audit"


@pytest.fixture(scope="module")
def generated(tmp_path_factory):
    output = tmp_path_factory.mktemp("sort-rank-audit")
    return AUDIT.generate(ROOT, output)


def by_case(rows):
    return {row["case"]: row for row in rows}


def test_field_matrix_exact_first_and_verification_save_vectors(generated):
    cases = by_case(generated["audit"]["field_matrix_cases"])
    expected = {
        "name-unicode": [0, 1000, 1000, 1000, 1000, 1000, 1000],
        "sort-name": [0, 1000, 1000, 1000, 1000, 1000, 1000],
        "sort-artist": [1000, 1000, 0, 1000, 1000, 1000, 0],
        "sort-album": [1000, 0, 1000, 1000, 1000, 1000, 1000],
        "sort-album-artist": [1000, 1000, 1000, 1000, 1000, 1000, 1000],
        "artist-unicode": [1000, 1000, 0, 1000, 1000, 1000, 0],
        "album-unicode": [1000, 0, 1000, 1000, 1000, 1000, 1000],
        "album-artist-unicode": [1000, 1000, 1000, 1000, 1000, 0, 0],
        "composer-unicode": [1000, 1000, 1000, 1000, 0, 1000, 1000],
    }
    assert {name: row["mutation"]["rank_vector"] for name, row in cases.items()} == expected
    assert all(row["verification"]["rank_vector"] == [1000] * 7 for row in cases.values())
    assert all(row["native_case_count_contribution"] == 1 and row["stage_count"] == 2 for row in cases.values())


def test_sort_album_artist_is_a_decisive_no_universal_zeroing_counterexample(generated):
    case = by_case(generated["audit"]["field_matrix_cases"])["sort-album-artist"]
    atom = case["mutation"]["requested_text_atom"]
    assert atom["state"] == "nonempty" and atom["type_code"] == 33
    assert atom["text"] == "Album Artist, Field"
    assert case["source_to_mutation_rank_changes"] == []
    assert case["mutation_to_verification_rank_changes"] == []
    assert generated["audit"]["production_change"]["made"] is False
    assert generated["audit"]["u10"]["closed"] is False


def test_text_states_and_decomposed_name_are_kept_separate(generated):
    state = generated["census"]["state_census"]
    expected = {
        "name": {"nonempty": 94},
        "album": {"missing": 68, "nonempty": 26},
        "artist": {"missing": 68, "nonempty": 26},
        "album_artist": {"missing": 68, "nonempty": 26},
        "composer": {"missing": 92, "nonempty": 2},
        "sort_name": {"missing": 92, "nonempty": 2},
        "sort_album": {"missing": 92, "nonempty": 2},
        "sort_artist": {"missing": 92, "nonempty": 2},
        "sort_album_artist": {"missing": 92, "nonempty": 2},
    }
    assert {field: detail["state_occurrences"] for field, detail in state["fields"].items()} == expected
    assert state["empty_target_text_occurrence_count"] == 0
    name = by_case(generated["audit"]["field_matrix_cases"])["name-unicode"]
    mutation = name["mutation"]["requested_text_atom"]
    verification = name["verification"]["requested_text_atom"]
    assert mutation["encoding_raw"] == verification["encoding_raw"] == 1
    assert mutation["normalization"]["NFD"] is True and mutation["normalization"]["NFC"] is False
    assert mutation["raw_text_hex"] == verification["raw_text_hex"]
    assert mutation["external_id_raw"] == 3 and verification["external_id_raw"] == 1


def test_phase3_first_save_regenerates_then_second_save_is_vector_stable(generated):
    cases = by_case(generated["audit"]["phase3_cases"])
    assert len(cases) == 6
    assert all(row["any_candidate_to_reload1_rank_change"] for row in cases.values())
    assert all(row["all_reload1_to_reload2_rank_vectors_stable"] for row in cases.values())
    assert all(
        track["reload1_to_reload2_rank_changes"] == []
        for row in cases.values()
        for track in row["tracks"]
    )
    fresh = cases["fresh-constructed-wav-003-v2"]
    assert any(
        change == {"offset": "0x290", "before": 0, "after": 3000}
        for track in fresh["tracks"]
        for change in track["candidate_to_reload1_rank_changes"]
    )
    cow_values = {
        value
        for track in cases["crud3-cross-shared-COW-037"]["tracks"]
        for value in track["reload1_rank_vector"]
    }
    assert {125, 250, 500, 750, 1000}.issubset(cow_values)


def test_manifest_counting_and_checked_in_outputs_are_reproducible(generated):
    manifest = generated["manifest"]
    baseline = next(row for row in manifest["files"] if row["path"] == AUDIT.BASELINE_REL)
    assert baseline["bytes"] == 10566
    assert baseline["sha256"] == AUDIT.BASELINE_SHA256
    assert len(manifest["files"]) == 60
    assert sum(row["native_case_count_contribution"] for row in manifest["files"]) == 15
    assert generated["census"]["state_census"]["raw_track_occurrence_count"] == 94
    assert generated["audit"]["evidence_identity"]["total_archived_native_cases"] == 15
    assert generated["audit"]["evidence_identity"]["raw_occurrences_are_independent_runs"] is False
    for name in AUDIT.OUTPUT_NAMES:
        assert (CHECKED_IN / name).read_bytes() == generated["outputs"][name]
