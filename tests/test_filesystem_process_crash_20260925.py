"""Regressions for the bounded U-17 Linux process-termination campaign."""
from __future__ import annotations

from copy import deepcopy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import sys

import pytest


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "audit_filesystem_process_crash_20260925.py"
REPORT = (
    ROOT
    / "evidence"
    / "research"
    / "20260925"
    / "filesystem-process-crash"
    / "report.json"
)
SOURCE = ROOT / "itlkit" / "io.py"
BASE_COMMIT = "c9f271d36a7095262c6195c04eb7f09d6cf88dee"
LINUX_SIGKILL_NUMBER = 9  # POSIX/Linux SIGKILL retained in report.json.


def load_campaign_module():
    spec = importlib.util.spec_from_file_location("filesystem_process_crash_20260925", SCRIPT)
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


def assert_path_and_name_hygiene(report: dict) -> None:
    text = json.dumps(report, ensure_ascii=False, sort_keys=True)
    lowered = text.casefold()
    for forbidden in ("/home/", "/tmp/itl-", "github_token", "ghp_", "runner/work"):
        assert forbidden not in lowered
    assert re.search(r"\.out\.itlkit-[a-z0-9_-]+\.tmp", text, re.IGNORECASE) is None
    assert re.search(r'"pid"\s*:', text) is None
    assert re.search(r'"inode"\s*:', text) is None
    assert re.search(r'"device"\s*:', text) is None


def without_environment(report: dict) -> dict:
    result = deepcopy(report)
    result.pop("environment")
    return result


def test_retained_report_is_hash_pinned_bounded_and_arithmetically_consistent() -> None:
    report = retained_report()
    assert report["schema"] == "windows-itunes-itl.filesystem-process-crash.v1"
    assert report["status"] == "completed_bounded_linux_process_termination_campaign"
    assert report["repository_baseline_commit"] == BASE_COMMIT
    assert report["production_source"] == {
        "path": "itlkit/io.py",
        "sha256": hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
    }
    assert report["generator"] == {
        "path": "scripts/research/audit_filesystem_process_crash_20260925.py",
        "sha256": hashlib.sha256(SCRIPT.read_bytes()).hexdigest(),
    }
    assert report["bounds"] == {
        "actual_process_crash_case_scenarios": 4,
        "actual_sigkill_operations": 4,
        "case_scenarios": 5,
        "child_processes_spawned": 5,
        "complete_payload_file_fsyncs_completed": 3,
        "linux_hard_link_commits_completed": 2,
        "linux_mkstemp_creations_completed": 5,
        "native_itunes_operations": 0,
        "network_filesystem_operations": 0,
        "normal_completion_control_case_scenarios": 1,
        "parent_reaped_children": 5,
        "partial_prefix_flushes_completed": 1,
        "power_loss_operations": 0,
        "production_cleanup_unlinks_completed": 1,
        "production_code_changes": 0,
        "scratch_root_policy": "fresh absolute path resolving below /tmp; removed after measurement",
    }
    assert report["summary"] == {
        "actual_process_crash_cases": 4,
        "normal_control_cases": 1,
        "production_change_warranted": False,
        "production_code_changed": False,
        "u17_status": "open",
        "unexpected_anomalies": 0,
    }
    assert report["methodology"]["case_counts_are_independent_experiments"] is False
    assert (
        report["methodology"]
        ["repetitions_controls_and_retained_artifacts_are_independent_experiments"]
        is False
    )
    assert report["scratch_cleanup"] == {
        "retained_report_contains_random_temporary_names": False,
        "root_removed_after_measurement": True,
    }
    environment = report["environment"]
    assert environment["operating_system"] == "Linux"
    assert environment["python_implementation"] == "CPython"
    assert environment["mount_filesystem_type"] == "ext4"
    assert environment["filesystem_magic_hex"] == "ef53"
    assert environment["filesystem_block_size"] == 4096
    assert environment["filesystem_fragment_size"] == 4096
    assert_path_and_name_hygiene(report)


def test_crash_stages_prove_sigkill_reap_and_exact_retained_outcomes() -> None:
    report = retained_report()
    cases = cases_by_id(report)
    inputs = report["synthetic_inputs"]
    full = inputs["complete_payload"]
    partial = inputs["partial_prefix"]
    empty_hash = inputs["empty_temporary_sha256"]

    crash_ids = [
        "after_temp_create_before_write",
        "after_partial_write_flush_before_publication",
        "after_complete_fsync_close_before_link",
        "after_native_link_before_cleanup",
    ]
    for case_id in crash_ids:
        case = cases[case_id]
        assert case["category"] == "actual_process_crash"
        assert case["hook"]["used"] is True
        assert case["hook"]["production_write_new_invoked"] is True
        assert case["hook"]["production_write_new_source_changed"] is False
        assert case["boundary_observation"]["child_alive_and_paused"] is True
        assert case["termination"] == {
            "child_died_by_signal": True,
            "child_exited_normally": False,
            "child_returncode": -LINUX_SIGKILL_NUMBER,
            "parent_reaped_child": True,
            "parent_sent_signal": "SIGKILL",
            "signal_number": LINUX_SIGKILL_NUMBER,
        }
        assert case["retained_after_reap"]["temporary_count"] == 1
        assert case["retained_after_reap"][
            "temporary_retained_because_child_finally_did_not_run"
        ] is True
        assert case["retained_after_reap"]["temporary"]["mode"] == "-rw-------"

    first = cases["after_temp_create_before_write"]
    assert first["retained_after_reap"]["destination"]["kind"] == "absent"
    assert first["retained_after_reap"]["temporary"]["bytes"] == 0
    assert first["retained_after_reap"]["temporary"]["sha256"] == empty_hash
    assert first["retained_after_reap"]["temporary"]["link_count"] == 1
    assert first["boundary_observation"]["child_open_fd_count_for_temporary"] == 1

    second = cases["after_partial_write_flush_before_publication"]
    assert second["retained_after_reap"]["destination"]["kind"] == "absent"
    assert second["retained_after_reap"]["temporary"]["bytes"] == partial["bytes"]
    assert second["retained_after_reap"]["temporary"]["sha256"] == partial["sha256"]
    assert second["retained_after_reap"]["temporary"]["link_count"] == 1
    assert second["boundary_observation"]["child_open_fd_count_for_temporary"] == 1
    assert second["boundary_event"]["real_flush_completed"] is True

    third = cases["after_complete_fsync_close_before_link"]
    assert third["retained_after_reap"]["destination"]["kind"] == "absent"
    assert third["retained_after_reap"]["temporary"]["bytes"] == full["bytes"]
    assert third["retained_after_reap"]["temporary"]["sha256"] == full["sha256"]
    assert third["retained_after_reap"]["temporary"]["link_count"] == 1
    assert third["boundary_observation"]["child_open_fd_count_for_temporary"] == 0
    assert third["boundary_event"]["native_link_completed"] is False

    fourth = cases["after_native_link_before_cleanup"]
    destination = fourth["retained_after_reap"]["destination"]
    temporary = fourth["retained_after_reap"]["temporary"]
    assert destination["bytes"] == temporary["bytes"] == full["bytes"]
    assert destination["sha256"] == temporary["sha256"] == full["sha256"]
    assert destination["link_count"] == temporary["link_count"] == 2
    assert destination["mode"] == temporary["mode"] == "-rw-------"
    assert fourth["retained_after_reap"]["destination_and_temporary_same_inode"] is True
    assert fourth["boundary_observation"]["child_open_fd_count_for_temporary"] == 0
    assert fourth["boundary_event"]["native_link_completed"] is True

    control = cases["normal_completion_control"]
    assert control["category"] == "normal_completion_control"
    assert control["hook"]["used"] is False
    assert control["termination"] == {
        "child_died_by_signal": False,
        "child_exited_normally": True,
        "child_returncode": 0,
        "parent_reaped_child": True,
        "parent_sent_signal": None,
        "signal_number": None,
    }
    assert control["retained_after_reap"]["destination"]["bytes"] == full["bytes"]
    assert control["retained_after_reap"]["destination"]["sha256"] == full["sha256"]
    assert control["retained_after_reap"]["destination"]["link_count"] == 1
    assert control["retained_after_reap"]["destination"]["mode"] == "-rw-------"
    assert control["retained_after_reap"]["temporary_count"] == 0
    assert control["retained_after_reap"]["production_cleanup_removed_temporary"] is True


@pytest.mark.skipif(not sys.platform.startswith("linux"), reason="campaign requires Linux SIGKILL and /proc")
def test_campaign_replays_twice_from_fresh_roots_with_only_environment_variance(tmp_path: Path) -> None:
    campaign = load_campaign_module()
    first_root = tmp_path / "fresh-a"
    second_root = tmp_path / "fresh-b"
    first = campaign.run_campaign_and_cleanup(first_root)
    second = campaign.run_campaign_and_cleanup(second_root)
    assert not os.path.lexists(first_root)
    assert not os.path.lexists(second_root)
    assert first == second
    assert without_environment(first) == without_environment(retained_report())
    assert_path_and_name_hygiene(first)


@pytest.mark.skipif(not sys.platform.startswith("linux"), reason="scratch guard is Linux-specific")
def test_scratch_guard_rejects_relative_outside_and_existing_roots(tmp_path: Path) -> None:
    campaign = load_campaign_module()
    with pytest.raises(ValueError, match="absolute"):
        campaign.prepare_new_scratch_root(Path("relative-scratch"))
    with pytest.raises(ValueError, match="below /tmp"):
        campaign.prepare_new_scratch_root(Path("/usr/itl-u17-must-not-create"))
    existing = tmp_path / "existing"
    existing.mkdir()
    with pytest.raises(FileExistsError, match="fresh"):
        campaign.prepare_new_scratch_root(existing)
