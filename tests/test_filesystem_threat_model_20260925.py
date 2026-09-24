"""Regressions for the bounded U-17 Linux publication threat-model audit."""
from __future__ import annotations

import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import sys
import tempfile

import pytest


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "audit_filesystem_publication_20260925.py"
REPORT = ROOT / "evidence" / "research" / "20260925" / "filesystem-threat-model" / "report.json"
SOURCE = ROOT / "itlkit" / "io.py"
BASE_COMMIT = "bc31fd860576b25f47ff1c3f409a9d97b04114fb"


def load_campaign_module():
    spec = importlib.util.spec_from_file_location("filesystem_publication_audit_20260925", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def retained_report() -> dict:
    return json.loads(REPORT.read_text(encoding="utf-8"))


def cases_by_id(report: dict) -> dict[str, dict]:
    cases = {case["id"]: case for case in report["cases"]}
    assert len(cases) == len(report["cases"])
    return cases


def test_retained_report_is_hash_pinned_path_free_and_arithmetically_consistent() -> None:
    text = REPORT.read_text(encoding="utf-8")
    report = json.loads(text)
    assert report["schema"] == "windows-itunes-itl.filesystem-publication-threat-model.v1"
    assert report["status"] == "completed_bounded_offline_linux_campaign"
    assert report["production_baseline_commit"] == BASE_COMMIT
    assert report["production_source"] == {
        "path": "itlkit/io.py",
        "sha256": hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
    }
    assert report["generator"] == {
        "path": "scripts/research/audit_filesystem_publication_20260925.py",
        "sha256": hashlib.sha256(SCRIPT.read_bytes()).hexdigest(),
    }
    assert report["bounds"] == {
        "actual_process_crashes": 0,
        "case_scenarios": 21,
        "hostile_directory_safety_claims": 0,
        "native_itunes_operations": 0,
        "power_loss_operations": 0,
        "scratch_root_policy": "fresh absolute path resolving below /tmp; removed by CLI",
    }
    assert report["summary"] == {
        "category_counts": {
            "fault_injection": 8,
            "native_direct": 8,
            "scheduler_assisted_native_syscall": 5,
        },
        "production_change_warranted": False,
        "production_code_changed": False,
        "scope_counts": {
            "documented_out_of_model_limit": 3,
            "stable_directory_model": 18,
        },
        "unexpected_anomalies": 0,
    }
    assert len(report["cases"]) == 21
    assert sum(report["summary"]["category_counts"].values()) == 21
    assert sum(report["summary"]["scope_counts"].values()) == 21
    assert report["methodology"]["case_counts_are_independent_experiments"] is False
    assert report["methodology"]["repeated_cases_and_controls_are_independent"] is False
    for forbidden in ("/home/", "/tmp/itl-", "github_token", "ghp_"):
        assert forbidden not in text.casefold()


def test_retained_cases_distinguish_guarantees_fault_injection_and_limits() -> None:
    report = retained_report()
    cases = cases_by_id(report)

    race = cases["destination_created_before_link_refused"]["observed"]
    assert race["error"]["errno_name"] == "EEXIST"
    assert race["racing_destination_unchanged"] is True
    assert race["temporary_count"] == 0

    publishers = cases["two_publishers_single_winner"]["observed"]
    assert publishers["normalized_outcomes"] == ["exists", "published"]
    assert publishers["destination_is_one_complete_payload"] is True
    assert publishers["destination_is_merged_payload"] is False

    hardlink = cases["hardlink_refusal_refused_clean"]["observed"]
    assert hardlink["error"]["errno_name"] == "EPERM"
    assert hardlink["destination_absent"] is True
    assert hardlink["rename_fallback_observed"] is False

    cleanup = cases["cleanup_failure_after_publish_reports_complete_destination"]["observed"]
    assert cleanup["message_identifies_complete_publication"] is True
    assert cleanup["destination_matches_payload"] is True
    assert cleanup["destination_and_temporary_same_inode"] is True

    renamed = cases["parent_rename_without_replacement_leaves_temporary"]
    assert renamed["claim_scope"] == "documented_out_of_model_limit"
    assert renamed["observed"]["error"]["errno_name"] == "ENOENT"
    assert renamed["observed"]["displaced_temporary_matches_payload"] is True

    for case_id in ("parent_directory_swap_can_publish_spoof", "parent_symlink_retarget_can_publish_spoof"):
        case = cases[case_id]
        assert case["claim_scope"] == "documented_out_of_model_limit"
        assert case["observed"]["returned"] is True
        assert case["observed"]["destination_matches_requested_payload"] is False
        assert case["observed"]["destination_matches_spoof"] is True

    assert "keep U-17 open" in report["integration_recommendation"]


@pytest.mark.skipif(not sys.platform.startswith("linux"), reason="retained campaign is Linux-specific")
def test_campaign_replays_byte_exact_across_two_fresh_tmp_roots() -> None:
    campaign = load_campaign_module()
    roots = [Path(tempfile.mkdtemp(prefix="itl-u17-replay-a-", dir="/tmp")),
             Path(tempfile.mkdtemp(prefix="itl-u17-replay-b-", dir="/tmp"))]
    try:
        first = campaign.run_campaign(roots[0])
        second = campaign.run_campaign(roots[1])
    finally:
        for root in roots:
            shutil.rmtree(root, ignore_errors=True)
    assert first == second == retained_report()


def test_scratch_guard_rejects_relative_outside_and_existing_roots() -> None:
    campaign = load_campaign_module()
    with pytest.raises(ValueError, match="absolute"):
        campaign.prepare_new_scratch_root(Path("relative-scratch"))
    with pytest.raises(ValueError, match="below /tmp"):
        campaign.prepare_new_scratch_root(Path("/usr/itl-u17-must-not-create"))

    existing = Path(tempfile.mkdtemp(prefix="itl-u17-existing-", dir="/tmp"))
    try:
        with pytest.raises(FileExistsError, match="fresh"):
            campaign.prepare_new_scratch_root(existing)
    finally:
        existing.rmdir()
