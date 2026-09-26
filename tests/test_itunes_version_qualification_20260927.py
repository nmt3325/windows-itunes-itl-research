"""Regressions for the exact-hash iTunes 12.13.11.1 qualification report."""
from __future__ import annotations

import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/summarize_itunes_version_qualification_20260927.py"
REPORT = ROOT / "evidence/research/20260927/itunes-12.13.11.1-version-qualification/qualification-summary.json"


def load_module():
    spec = importlib.util.spec_from_file_location("itunes_version_qualification", SCRIPT)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_exact_hash_upgrade_qualification_is_bounded_and_complete() -> None:
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    assert report["schema"] == "windows-itl.itunes-version-qualification-20260927.v1"
    assert report["status"] == "passed_exact_hash_upgrade_qualification"
    assert report["input_itl_version"] == "12.13.10.3"
    assert report["native_itunes_version"] == "12.13.11.1"
    assert report["executable_sha256"] == "c69e719cd3f2f9374e71c954a6de87002b6988af65129943983a2f17490dd73c"
    assert report["totals"] == {
        "exact_input_hashes": 4,
        "failed_cases": 0,
        "failed_native_cycles": 0,
        "forbidden_artifact_cycles": 0,
        "normal_quit_cycles": 8,
        "passed_cases": 4,
        "passed_native_cycles": 8,
    }
    assert report["executable_identity_negative_preflights"]["runs"] == 2
    assert report["executable_identity_negative_preflights"]["all_refused_before_root_or_evidence_creation"]
    assert all(row["classification"] == "environment_setup_failure_not_itl_rejection" for row in report["preflight_failures"])
    assert all(row["candidate_unchanged"] and not row["native_semantic_gate_reached"] for row in report["preflight_failures"])
    assert report["result"] == {
        "exact_hash_upgrade_open_save_restart_qualified": True,
        "full_analysis_specification_gate": False,
        "input_version_rewritten_to_native_version": True,
        "u01_closed": False,
        "universal_itl_support": False,
    }


def test_qualification_summary_rebuilds_byte_exactly() -> None:
    module = load_module()
    rebuilt = (json.dumps(module.build_summary(), ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode()
    assert rebuilt == REPORT.read_bytes()
