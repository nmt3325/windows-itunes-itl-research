import hashlib
import importlib.util
import json
from pathlib import Path

from itlkit.library import Library
from REFERENCE_PARSER.core import ReferenceLibrary
from test_core_support import library_bytes


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "windows" / "native_rating_kind_20260925.py"
EVIDENCE = ROOT / "evidence" / "research" / "20260925" / "native-rating-kind"
REPORT = EVIDENCE / "report.json"
ORACLE = EVIDENCE / "oracle.json"
EVIDENCE_README = EVIDENCE / "README.md"
SPEC = importlib.util.spec_from_file_location("native_rating_kind_20260925", SCRIPT)
assert SPEC and SPEC.loader
research = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(research)


def test_cases_use_pinned_candidate_and_complete_rating_ladder():
    manifest = json.loads(research.DEFAULT_CASES.read_text(encoding="utf-8"))
    assert research._manifest_errors(manifest) == []
    assert manifest["candidate"] == "TEST_CORPUS/generated/reference-one-track-raw.itl"
    assert [case["rating"] for case in manifest["cases"] if case["mode"] == "rating"] == [
        0,
        20,
        40,
        60,
        80,
        100,
    ]


def test_byte_diff_reports_ranges_and_size_changes():
    report = research.diff_ranges(b"abcde", b"abXYef")
    assert report["changed_byte_positions"] == 3
    assert report["ranges"] == [
        {"start": 2, "end_exclusive": 4, "length": 2, "before_hex": "6364", "after_hex": "5859"},
        {"start": 5, "end_exclusive": 6, "length": 1, "before_hex": "", "after_hex": "66"},
    ]


def test_primary_and_independent_parser_agree_on_pinned_candidate():
    analysis = research.analyze_snapshot(research.CANDIDATE)
    assert analysis["passed"] is True
    assert analysis["primary"]["rating"] == 0
    assert analysis["primary"]["legacy_loved_bit"] is False
    assert analysis["independent"]["track"]["legacy_loved_bit"] is False
    assert analysis["primary"]["high_level_library"]["outcome"] == "blocked"


def test_independent_parser_tracks_bounded_legacy_loved_bit():
    library = Library.from_bytes(library_bytes())
    track = library.tracks[0]
    track.set(loved=True)
    independent = ReferenceLibrary.from_bytes(library.to_bytes()).track_semantics()[0]
    assert independent["legacy_loved_bit"] is True
    assert independent["legacy_loved_byte_raw"] & 0x02


def test_capability_classification_separates_blocked_from_observed():
    typelib = {
        "file_track_members": {
            "RatingKind": [{"invkind_name": "property_get"}],
            "Loved": [],
        }
    }
    blocked = {"attempted": True, "outcome": "blocked", "error": {"type": "AttributeError"}}
    probes = {
        "getters": {
            "RatingKind": {"attempted": True, "outcome": "observed", "value": 1},
            "Loved": blocked,
        },
        "setters": {"RatingKind": blocked, "Loved": blocked},
    }
    result = research.classify_capabilities(typelib, probes)
    assert result["RatingKind"]["classification"] == "read_only"
    assert result["Loved"]["classification"] == "unsupported"
    assert result["Disliked"]["classification"] == "inconclusive"


def test_committed_native_oracle_is_a_deterministic_report_derivative():
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    expected = json.loads(ORACLE.read_text(encoding="utf-8"))
    rebuilt = research.build_oracle(report)
    canonical_report = (
        json.dumps(report, indent=2, ensure_ascii=False, sort_keys=True) + "\n"
    ).encode("utf-8")
    assert rebuilt == expected
    assert expected["source_report"] == {
        "path": "report.json",
        "sha256": hashlib.sha256(canonical_report).hexdigest(),
        "hash_basis": "UTF-8 JSON; ensure_ascii=false; sorted keys; indent=2; LF terminator",
    }
    assert research.render_readme(rebuilt) == EVIDENCE_README.read_text(encoding="utf-8")


def test_native_oracle_records_capabilities_persistence_and_bounded_gates():
    oracle = json.loads(ORACLE.read_text(encoding="utf-8"))
    assert oracle["passed"] is True
    assert {name: row["classification"] for name, row in oracle["capabilities"].items()} == {
        "Rating": "writable",
        "RatingKind": "read_only",
        "AlbumRating": "writable",
        "AlbumRatingKind": "read_only",
        "Loved": "unsupported",
        "Disliked": "unsupported",
    }
    assert oracle["loved_disliked_interaction"]["outcome"] == "blocked"
    assert oracle["counts"]["snapshot_analyses"] == 27
    assert oracle["counts"]["unique_snapshot_sha256"] == 21
    assert oracle["counts"]["primary_independent_validator_passed"] == 27
    assert oracle["counts"]["high_level_library_outcomes"] == {"blocked": 7, "observed": 20}
    assert [row["expected"] for row in oracle["rating_ladder"]] == [0, 20, 40, 60, 80, 100]

    for row in oracle["rating_ladder"]:
        expected = row["expected"]
        assert row["observed"] == {
            "mutation": expected,
            "same-value-repeat": expected,
            "restart-verification": expected,
        }
        final_projection = row["sessions"][-1]["projection_sequence"][-1]
        assert final_projection["Rating"] == expected
        assert final_projection["RatingKind"] == (1 if expected == 0 else 0)
        assert final_projection["AlbumRating"] == expected
        assert final_projection["AlbumRatingKind"] == 1
        assert row["transitions"]["mutation_to_same-value-repeat"]["track_header_diff"][
            "changed_byte_positions"
        ] == 0
        assert row["transitions"]["same-value-repeat_to_restart-verification"][
            "track_header_diff"
        ]["changed_byte_positions"] == 0
        assert all(
            snapshot["name_refresh_flag_raw"] == 0
            and snapshot["legacy_loved_byte_raw"] == 0
            and snapshot["legacy_loved_bit"] is False
            for snapshot in row["snapshots"].values()
        )

    gates = oracle["global_gates"]
    assert gates["saved_snapshot_validations_passed"] == gates["saved_snapshot_validations_total"] == 20
    assert gates["forbidden_artifacts_observed"] == 0
    assert gates["ui_actions"] == ["dismiss_audio_warning"]
    assert all(
        gates[key]
        for key in (
            "all_worker_exit_zero",
            "all_itunes_exit_zero",
            "all_sessions_accepted",
            "all_sessions_requested_normal_quit",
            "all_before_after_samples_stable",
            "all_identity_gates_passed",
            "all_target_name_refresh_zero",
            "all_target_legacy_loved_zero",
        )
    )
