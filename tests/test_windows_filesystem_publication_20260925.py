"""Regressions for the bounded U-17 Windows/NTFS publication audit."""
from __future__ import annotations

from copy import deepcopy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import sys
import tempfile

import pytest


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "audit_windows_filesystem_publication_20260925.py"
REPORT = ROOT / "evidence" / "research" / "20260925" / "windows-filesystem-publication" / "report.json"
SOURCE = ROOT / "itlkit" / "io.py"
BASE_COMMIT = "c9f271d36a7095262c6195c04eb7f09d6cf88dee"
REPORT_SHA256 = "867e68693aa74d2c1a19def1483f64a243f242d4e5b1348ee017b2a87669eda1"


def load_campaign_module():
    spec = importlib.util.spec_from_file_location("windows_filesystem_publication_audit_20260925", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def retained_report() -> dict:
    return json.loads(REPORT.read_text(encoding="utf-8"))


def without_environment(report: dict) -> dict:
    result = deepcopy(report)
    result.pop("environment")
    return result


def test_without_environment_preserves_every_non_environment_field() -> None:
    report = retained_report()
    projected = without_environment(report)
    assert set(projected) == set(report) - {"environment"}
    assert all(projected[key] == report[key] for key in projected)
    changed = deepcopy(report)
    changed["bounds"]["power_loss_operations"] = 1
    assert without_environment(changed) != projected


def cases_by_id(report: dict) -> dict[str, dict]:
    cases = {case["id"]: case for case in report["cases"]}
    assert len(cases) == len(report["cases"])
    return cases


def test_retained_report_is_hash_pinned_path_free_and_arithmetically_consistent() -> None:
    raw = REPORT.read_bytes()
    text = raw.decode("utf-8")
    report = json.loads(text)
    assert hashlib.sha256(raw).hexdigest() == REPORT_SHA256
    assert report["schema"] == "windows-itunes-itl.windows-filesystem-publication-audit.v1"
    assert report["status"] == "completed_bounded_windows_ntfs_campaign"
    assert report["repository_baseline_commit"] == BASE_COMMIT
    assert report["production_source"] == {
        "path": "itlkit/io.py",
        "sha256": hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
    }
    assert report["generator"] == {
        "path": "scripts/research/audit_windows_filesystem_publication_20260925.py",
        "sha256": hashlib.sha256(SCRIPT.read_bytes()).hexdigest(),
    }
    assert report["environment"] == {
        "filesystem": {
            "filesystem_name": "NTFS",
            "maximum_component_length": 255,
            "query_api": "GetVolumePathNameW+GetVolumeInformationW",
            "supports_hard_links_flag": True,
            "supports_posix_unlink_rename_flag": True,
            "supports_reparse_points_flag": True,
            "volume_path_and_serial_retained": False,
        },
        "machine": "AMD64",
        "os_name": "nt",
        "python_implementation": "CPython",
        "python_version": "3.12.10",
        "qualification": "one GitHub-hosted Windows runner temporary volume; not universal Windows or NTFS behavior",
        "release": "2025Server",
        "sys_platform": "win32",
        "system": "Windows",
        "version": "10.0.26100",
    }
    assert all(value == {"available": True} for value in report["capabilities"].values())
    assert report["bounds"] == {
        "actual_process_termination_scenarios": 2,
        "case_scenarios": 25,
        "executed_case_scenarios": 25,
        "hostile_directory_safety_claims": 0,
        "native_itunes_operations": 0,
        "network_filesystem_operations": 0,
        "power_loss_operations": 0,
        "scratch_root_policy": "fresh absolute path resolving below tempfile.gettempdir(); removed by CLI",
        "unavailable_case_scenarios": 0,
        "uncontrolled_process_crashes": 0,
    }
    assert report["summary"] == {
        "category_counts": {
            "actual_process_termination": 2,
            "fault_injection": 8,
            "native_direct": 9,
            "scheduler_assisted_native_syscall": 6,
        },
        "production_change_warranted": False,
        "production_code_changed": False,
        "scope_counts": {
            "documented_out_of_model_limit": 4,
            "stable_directory_model": 21,
        },
        "unavailable_by_intended_category": {
            "actual_process_termination": 0,
            "fault_injection": 0,
            "native_direct": 0,
            "scheduler_assisted_native_syscall": 0,
        },
        "unexpected_anomalies": 0,
    }
    assert len(report["cases"]) == 25
    assert sum(report["summary"]["category_counts"].values()) == 25
    assert sum(report["summary"]["scope_counts"].values()) == 25
    assert report["methodology"]["case_counts_are_independent_experiments"] is False
    assert report["methodology"]["competing_publishers_are_independent_experiments"] is False
    assert report["methodology"]["repetitions_and_controls_are_independent_experiments"] is False
    assert not re.search(r"(?i)[a-z]:\\", text)
    for forbidden in ("win-jjxdmhmx", "runneradmin", "github_token", "ghp_"):
        assert forbidden not in text.casefold()


def test_retained_cases_separate_native_injection_limits_and_termination() -> None:
    report = retained_report()
    cases = cases_by_id(report)

    race = cases["destination_created_before_link_refused"]["observed"]
    assert race["error"] == {
        "errno": 17,
        "errno_name": "EEXIST",
        "type": "FileExistsError",
        "winerror": 183,
        "winerror_name": "ERROR_ALREADY_EXISTS",
    }
    assert race["racing_destination_unchanged"] is True
    assert race["final_link_syscall_was_native"] is True

    publishers = cases["two_publishers_single_winner"]["observed"]
    assert publishers["normalized_outcomes"] == ["exists", "published"]
    assert publishers["destination_is_one_complete_payload"] is True
    assert publishers["destination_is_merged_payload"] is False

    for alias_case in (
        "existing_hardlink_alias_refused",
        "existing_symlink_alias_refused",
        "existing_dangling_symlink_refused",
        "stable_parent_symlink_success",
        "stable_parent_junction_success",
        "lexical_parent_alias_success",
    ):
        assert cases[alias_case]["status"] == "executed"
        assert cases[alias_case]["claim_scope"] == "stable_directory_model"

    hardlink_fault = cases["hardlink_refusal_refused_clean"]["observed"]
    assert hardlink_fault["rename_fallback_observed"] is False
    assert hardlink_fault["destination_absent"] is True

    renamed = cases["parent_rename_without_replacement_leaves_temporary"]
    assert renamed["claim_scope"] == "documented_out_of_model_limit"
    assert renamed["observed"]["error"]["errno_name"] == "ENOENT"
    assert renamed["observed"]["error"]["winerror_name"] == "ERROR_PATH_NOT_FOUND"
    assert renamed["observed"]["displaced_temporary_matches_payload"] is True

    for case_id in (
        "parent_directory_swap_can_publish_spoof",
        "parent_symlink_retarget_can_publish_spoof",
        "parent_junction_retarget_can_publish_spoof",
    ):
        case = cases[case_id]
        assert case["claim_scope"] == "documented_out_of_model_limit"
        assert case["observed"]["returned"] is True
        assert case["observed"]["destination_matches_requested_payload"] is False
        assert case["observed"]["destination_matches_spoof"] is True
        assert (
            case["observed"].get("original_temporary_matches_payload") is True
            or case["observed"].get("displaced_temporary_matches_payload") is True
        )

    before = cases["terminate_process_before_link"]["observed"]
    assert before["parent_called_win32_TerminateProcess"] is True
    assert before["child_reaped"] is True
    assert before["termination_exit_code"] == 0x66
    assert before["native_link_calls_before_termination"] == 0
    assert before["destination_absent"] is True
    assert before["retained_temporary_matches_payload"] is True

    after = cases["terminate_process_after_link_before_cleanup"]["observed"]
    assert after["parent_called_win32_TerminateProcess"] is True
    assert after["child_reaped"] is True
    assert after["termination_exit_code"] == 0x66
    assert after["native_link_calls_before_termination"] == 1
    assert after["destination_matches_payload"] is True
    assert after["destination_and_temporary_same_file_identity"] is True
    assert after["link_count"] == 2
    assert before["power_loss_operation"] is after["power_loss_operation"] is False
    assert before["linux_SIGKILL_operation"] is after["linux_SIGKILL_operation"] is False

    assert "keep U-17 open" in report["integration_recommendation"]


@pytest.mark.skipif(os.name != "nt" or sys.platform != "win32", reason="retained campaign is Windows-specific")
def test_campaign_replays_twice_from_fresh_windows_temp_roots_with_only_environment_variance() -> None:
    campaign = load_campaign_module()
    roots = [
        Path(tempfile.mkdtemp(prefix="itl-u17-win-replay-a-")),
        Path(tempfile.mkdtemp(prefix="itl-u17-win-replay-b-")),
    ]
    try:
        first = campaign.run_campaign(roots[0])
        second = campaign.run_campaign(roots[1])
    finally:
        for root in roots:
            shutil.rmtree(root, ignore_errors=True)
    assert first == second
    assert first["environment"]["python_implementation"] == platform.python_implementation()
    assert first["environment"]["python_version"] == platform.python_version()
    assert first["environment"]["filesystem"]["filesystem_name"] == "NTFS"
    assert first["observed_guarantees"][0].startswith(
        "On the recorded Windows/NTFS environment above, "
    )
    retained = retained_report()
    assert without_environment(first) == without_environment(retained)
    if first["environment"] == retained["environment"]:
        assert first == retained


@pytest.mark.skipif(os.name != "nt" or sys.platform != "win32", reason="scratch guard is Windows-specific")
def test_scratch_guard_rejects_relative_outside_and_existing_roots() -> None:
    campaign = load_campaign_module()
    with pytest.raises(ValueError, match="absolute"):
        campaign.prepare_new_scratch_root(Path("relative-scratch"))

    outside = ROOT / "itl-u17-must-not-create"
    assert not os.path.lexists(outside)
    with pytest.raises(ValueError, match="tempfile.gettempdir"):
        campaign.prepare_new_scratch_root(outside)
    assert not os.path.lexists(outside)

    existing = Path(tempfile.mkdtemp(prefix="itl-u17-win-existing-"))
    try:
        with pytest.raises(FileExistsError, match="fresh"):
            campaign.prepare_new_scratch_root(existing)
    finally:
        existing.rmdir()
