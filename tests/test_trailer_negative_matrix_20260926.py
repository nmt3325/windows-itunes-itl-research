"""Regressions for the 2026-09-26 U-13 trailer negative matrix."""
from __future__ import annotations

import hashlib
import importlib.util
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "audit_trailer_negative_matrix_20260926.py"
LEGACY_SCRIPT = ROOT / "scripts" / "research" / "audit_trailer_coverage.py"
REPORT = ROOT / "evidence" / "research" / "20260926" / "trailer-negative-matrix" / "report.json"
SOURCE = ROOT / "TEST_CORPUS" / "generated" / "reference-one-track-zlib.itl"


def load_module():
    spec = importlib.util.spec_from_file_location("trailer_negative_matrix_20260926", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def retained_report() -> dict:
    return json.loads(REPORT.read_text(encoding="utf-8"))


def test_report_is_hash_pinned_bounded_and_keeps_u13_open() -> None:
    report = retained_report()
    assert report["schema"] == "windows-itl.trailer-negative-matrix-20260926.v1"
    assert report["status"] == "passed_bounded_offline_u13_negative_matrix_u13_open"
    assert report["generator"] == {
        "path": "scripts/research/audit_trailer_negative_matrix_20260926.py",
        "sha256": hashlib.sha256(SCRIPT.read_bytes()).hexdigest(),
    }
    assert report["legacy_audit_driver"] == {
        "path": "scripts/research/audit_trailer_coverage.py",
        "sha256": hashlib.sha256(LEGACY_SCRIPT.read_bytes()).hexdigest(),
    }
    assert report["source"] == {
        "path": "TEST_CORPUS/generated/reference-one-track-zlib.itl",
        "sha256": hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
    }
    assert report["bounds"] == {
        "aes_cap_unused_data_intersection_cases": 4,
        "case_scenarios": 17,
        "multi_member_zlib_cases": 3,
        "native_itunes_operations": 0,
        "network_operations": 0,
        "outer_size_collision_cases": 3,
        "power_loss_operations": 0,
        "production_code_changes": 0,
        "proprietary_binary_reads": 0,
        "public_prior_art_analogue_tail_cases": 3,
        "reference_looking_tail_cases": 4,
        "semantic_write_refusal_checks": 14,
        "trailer_outer_size_collision_cases": 3,
        "trailer_valid_cases": 14,
    }
    assert report["summary"] == {
        "all_trailer_valid_cases_have_scope_warning": True,
        "all_trailer_valid_cases_refuse_semantic_write": True,
        "independent_reimplementation_passed": False,
        "native_acceptance_operations": 0,
        "outer_size_collision_strict_rejects_relaxed_accepts": True,
        "production_code_changed": False,
        "u13_status": "open",
        "unexpected_anomalies": 0,
        "universal_itl_support": False,
    }


def test_case_families_exercise_expected_negative_boundaries() -> None:
    report = retained_report()
    rows = {row["id"]: row for row in report["coverage"]["case_index"]}
    assert set(report["coverage"]["families"]) == {
        "aes_cap_unused_data_intersection",
        "multi_member_zlib",
        "public_prior_art_analogue_tail",
        "reference_looking_tail",
        "trailer_outer_size_collision",
    }
    for case_id, row in rows.items():
        if row["expectation"] == "trailer_valid":
            assert row["primary_container"] == "accept", case_id
            assert row["reference_envelope"] == "accept", case_id
            assert row["validator"] == "accept", case_id
            assert "scope.compressed_trailer" in row["validator_issue_codes"], case_id
            assert row["semantic_write_refused"] is True, case_id
            assert row["trailer_bytes"] > 0, case_id
        else:
            assert row["expectation"] == "outer_size_mismatch", case_id
            assert row["primary_container"] == "reject", case_id
            assert row["primary_container_relaxed"] == "accept", case_id
            assert row["reference_envelope"] == "reject", case_id
            assert row["validator"] == "reject", case_id


def test_report_regenerates_byte_exactly(tmp_path: Path) -> None:
    module = load_module()
    output = tmp_path / "report.json"
    module.write_report(output, module.build_report())
    assert output.read_bytes() == REPORT.read_bytes()
