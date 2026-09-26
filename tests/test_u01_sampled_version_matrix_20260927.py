"""Regressions for the bounded 2026-09-27 U-01 sampled version matrix."""
from __future__ import annotations

import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/summarize_u01_sampled_version_matrix_20260927.py"
REPORT = ROOT / "evidence/research/20260927/u01-sampled-version-matrix/matrix-summary.json"


def load_module():
    spec = importlib.util.spec_from_file_location("u01_sampled_version_matrix", SCRIPT)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_sampled_matrix_is_exact_bounded_and_keeps_u01_open() -> None:
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    assert report["schema"] == "windows-itl.u01-sampled-version-matrix-20260927.v1"
    assert report["status"] == "bounded_sampled_multi_version_matrix_completed_u01_open"
    assert report["totals"] == {
        "failed_native_cycles": 0,
        "forbidden_fallback_cycles": 0,
        "native_builds": 2,
        "normal_quit_process_exit_zero_cycles": 24,
        "passed_native_cycles": 24,
        "positive_cases": 12,
        "structural_negatives_that_launched_itunes": 0,
        "structural_preflight_negatives": 2,
        "worker_or_independent_parser_error_cycles": 0,
    }
    assert report["result"] == {
        "exact_hash_downgrade_open_save_restart_qualified": True,
        "exact_hash_upgrade_open_save_restart_qualified": True,
        "full_analysis_specification_gate": False,
        "historical_candidate_113_failure_reproduced": False,
        "historical_candidate_113_is_stable_negative": False,
        "independently_implemented_harness": False,
        "independently_sourced_executable": False,
        "separate_runner_12_13_11_1_reproduction": True,
        "structural_negative_is_native_itunes_rejection": False,
        "u01_closed": False,
        "universal_itl_support": False,
        "version_specific_semantic_candidate_112_passed_on_both_builds": True,
    }


def test_matrix_pins_builds_cycles_semantics_and_negative_classification() -> None:
    module = load_module()
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    builds = {row["key"]: row for row in report["builds"]}
    assert set(builds) == {"12.13.9.1", "12.13.11.1-independent"}
    assert builds["12.13.9.1"]["compatibility_direction"] == "downgrade_from_12.13.10.3_input"
    assert builds["12.13.11.1-independent"]["compatibility_direction"] == "upgrade_from_12.13.10.3_input"
    assert builds["12.13.9.1"]["executable"]["sha256"] == "6805f52ca3a3a55b31418e302acd8862023078e2f726e44880ab53df48ad2bc5"
    assert builds["12.13.11.1-independent"]["executable"]["sha256"] == "c69e719cd3f2f9374e71c954a6de87002b6988af65129943983a2f17490dd73c"

    for key, build in builds.items():
        assert build["positive_case_count"] == 6
        assert build["passed_native_cycles"] == 12
        assert build["normal_quit_cycles"] == 12
        cases = {row["name"]: row for row in build["cases"]}
        assert set(cases) == set(module.EXPECTED_INPUT_HASHES)
        for name, case in cases.items():
            assert case["input"]["sha256"] == module.EXPECTED_INPUT_HASHES[name]
            assert [cycle["saved"]["sha256"] for cycle in case["cycles"]] == module.EXPECTED_SAVED_HASHES[key][name]
            assert all(cycle["normal_com_quit"] for cycle in case["cycles"])
            assert all(cycle["worker_exit_code"] == cycle["itunes_exit_code"] == 0 for cycle in case["cycles"])
            assert all(cycle["worker_errors"] == cycle["independent_parser_errors"] == 0 for cycle in case["cycles"])
            assert all(cycle["forbidden_artifacts"] == 0 for cycle in case["cycles"])
        semantic = cases["u01-codec-track-indexed-positive"]
        historical = cases["u01-codec-fresh-modified-negative"]
        assert semantic["expected_outer_file_persistent_id"] == module.OUTER_FILE_PID
        assert semantic["expected_com_library_persistent_id"] == module.COM_LIBRARY_PID
        assert semantic["expected_outer_file_persistent_id"] != semantic["expected_com_library_persistent_id"]
        assert historical["classification"] == "historical_negative_113_replay_passed_not_stable_negative"
        for cycle in semantic["cycles"]:
            observed = cycle["selected_semantics"]
            assert observed["independent_parser"] == module.SEMANTIC_112_PARSER
            assert observed["itunes_com"] == module.SEMANTIC_112_COM
            assert observed["selected_playlist"] == {
                "members": ["8F11E62B0DC9F837", "C8ADF4DC10AFC270"],
                "name": "Synthetic 調査 🎼",
                "persistent_id": module.PLAYLIST_PID,
            }
        for cycle in historical["cycles"]:
            observed = cycle["selected_semantics"]
            assert observed["independent_parser"] == module.SEMANTIC_113_PARSER
            assert observed["itunes_com"] == module.SEMANTIC_113_COM
            assert observed["selected_playlist"] is None

        negative = build["negative"]
        assert negative["candidate"]["sha256"] == module.TRUNCATED_SHA256
        assert negative["classification"] == "structural_independent_parser_preflight_negative_itunes_not_launched"
        assert negative["harness_exit_code"] == 1
        assert negative["native_cycles_started"] == 0
        assert negative["itunes_process_count_before"] == negative["itunes_process_count_after"] == 0
        assert negative["profile_existed_before"] is negative["profile_existed_after"] is False
        assert negative["native_itunes_rejection_established"] is False

    scope = report["reproduction_scope"]
    assert scope["current_runner_env_id"] == "win-p0qfbqby"
    assert scope["prior_runner_env_id"] == "win-7h5jwzza"
    assert scope["separate_runtime_from_prior_12_13_11_1_experiment"] is True
    assert scope["same_runner_first_ran_12_13_9_1_then_upgraded_in_place"] is True
    assert scope["independently_implemented_harness"] is False
    assert scope["independently_sourced_executable"] is False


def test_sampled_matrix_summary_rebuilds_byte_exactly() -> None:
    module = load_module()
    rebuilt = (json.dumps(module.build_summary(), ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode()
    assert rebuilt == REPORT.read_bytes()
