"""Regressions for the predeclared iTunes 12.12.10.1 U-01 experiment."""
from __future__ import annotations

import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/summarize_u01_distinct_build_20260927.py"
REPORT = ROOT / "evidence/research/20260927/u01-distinct-build-12.12.10.1/distinct-build-summary.json"


def load_module():
    spec = importlib.util.spec_from_file_location("u01_distinct_build", SCRIPT)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_distinct_build_positive_is_exact_and_u01_stays_open() -> None:
    module = load_module()
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    assert report["schema"] == "windows-itl.u01-distinct-build-12.12.10.1-20260927.v1"
    assert report["status"] == "bounded_distinct_build_positive_passed_predeclared_negative_failed_u01_open"
    assert report["provenance"]["executable"] == {
        "authenticode": {
            "status": "Valid",
            "subject": "CN=Apple Inc., O=Apple Inc., L=Cupertino, S=California, C=US",
            "thumbprint": module.THUMBPRINT,
        },
        "binary_retained": False,
        "bytes": module.EXE_BYTES,
        "sha256": module.EXE_SHA256,
        "version": module.VERSION,
    }
    setup = report["setup"]
    assert setup["input"]["sha256"] == module.INPUT_SHA256
    assert setup["media"]["sha256"] == module.MEDIA_SHA256
    assert setup["outer_file_persistent_id"] == module.OUTER_PID
    assert setup["com_library_persistent_id"] == module.COM_LIBRARY_PID
    assert setup["outer_file_persistent_id"] != setup["com_library_persistent_id"]
    assert setup["reference_detector_status"] == "unsupported"
    positive = report["positive_qualification"]
    assert positive["status"] == "passed"
    assert positive["passed_cycles"] == 2
    assert [row["saved"]["sha256"] for row in positive["cycles"]] == list(module.POSITIVE_SAVED_HASHES)
    assert positive["cycles"][1]["prelaunch_sha256"] == positive["cycles"][0]["saved"]["sha256"]
    assert all(row["selected_track_semantics"] == module.SELECTED_SEMANTICS for row in positive["cycles"])
    assert all(row["normal_com_quit"] and row["worker_exit_code"] == row["itunes_exit_code"] == 0 for row in positive["cycles"])
    result = report["result"]
    assert result["genuinely_nonadjacent_version_pinned_build_added"] is True
    assert result["native_authored_positive_two_cycle_qualification_passed"] is True
    assert result["independent_writer_qualified"] is False
    assert result["arbitrary_12_12_10_1_editing_qualified"] is False
    assert result["version_12_12_10_1_reference_parser_profile_admitted"] is False
    assert result["u01_closed"] is False
    assert result["universal_itl_support"] is False
    assert result["full_analysis_specification_gate"] is False


def test_predeclared_negative_failed_and_was_not_replaced_post_hoc() -> None:
    module = load_module()
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    provenance = report["provenance"]
    assert provenance["predeclared_before_native_launch_or_candidate_outcome"] is True
    assert provenance["post_hoc_negative_substitution_allowed"] is False
    negative = report["negative_qualification"]
    assert negative["status"] == "failed_with_preserved_evidence"
    assert negative["input"]["sha256"] == module.NEGATIVE_INPUT_SHA256
    assert negative["attempts_required"] == 2
    assert negative["attempts_passed"] == 0
    assert negative["target_product_modals_observed"] == 0
    assert negative["normally_closed_attempts"] == 0
    assert negative["force_terminated_after_timeout_attempts"] == 2
    assert negative["product_facing_native_rejection_established"] is False
    assert [row["post_timeout_output"]["sha256"] for row in negative["attempts"]] == list(module.NEGATIVE_OUTPUT_HASHES)
    assert all(row["fresh_input_sha256"] == module.NEGATIVE_INPUT_SHA256 for row in negative["attempts"])
    assert all(row["serialized_version_after"] == module.VERSION for row in negative["attempts"])
    assert all(row["selected_semantics_preserved_ignoring_version"] for row in negative["attempts"])
    assert all(row["forced_termination_after_timeout"] for row in negative["attempts"])
    result = report["result"]
    assert result["predeclared_product_facing_negative_reproduced"] is False
    assert result["product_facing_native_negative_established"] is False
    assert result["post_timeout_native_mutation_observed_on_both_failed_negative_attempts"] is True
    assert result["negative_timeout_mutations_are_normal_native_cycles"] is False


def test_distinct_build_summary_rebuilds_byte_exactly() -> None:
    module = load_module()
    rebuilt = (json.dumps(module.build_summary(), ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode()
    assert rebuilt == REPORT.read_bytes()
