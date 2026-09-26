"""Regressions for the bounded U-17 ext4/tmpfs process-termination contrast."""
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
SCRIPT = ROOT / "scripts" / "research" / "audit_filesystem_process_crash_tmpfs_ext4_20260926.py"
LEGACY_SCRIPT = ROOT / "scripts" / "research" / "audit_filesystem_process_crash_20260925.py"
REPORT = (
    ROOT
    / "evidence"
    / "research"
    / "20260926"
    / "filesystem-process-crash-tmpfs-ext4"
    / "report.json"
)
SOURCE = ROOT / "itlkit" / "io.py"
BASE_COMMIT = "c9f271d36a7095262c6195c04eb7f09d6cf88dee"
LINUX_SIGKILL_NUMBER = 9


def load_campaign_module():
    spec = importlib.util.spec_from_file_location("filesystem_process_crash_tmpfs_ext4_20260926", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def retained_report() -> dict:
    return json.loads(REPORT.read_text(encoding="utf-8"))


def assert_path_and_name_hygiene(report: dict) -> None:
    text = json.dumps(report, ensure_ascii=False, sort_keys=True)
    lowered = text.casefold()
    for forbidden in ("/home/", "runner/work", "github_token", "ghp_", "/tmp/itl-", "/dev/shm/itl-"):
        assert forbidden not in lowered
    assert re.search(r"\.out\.itlkit-[a-z0-9_-]+\.tmp", text, re.IGNORECASE) is None
    assert re.search(r'"pid"\s*:', text) is None
    assert re.search(r'"inode"\s*:', text) is None
    assert re.search(r'"device"\s*:', text) is None


def without_environment(report: dict) -> dict:
    result = deepcopy(report)
    for target in result["targets"]:
        target.pop("environment")
        target.pop("mount_identity")
    return result


def target_by_id(report: dict) -> dict[str, dict]:
    targets = {target["id"]: target for target in report["targets"]}
    assert set(targets) == {"ext4_tmp", "tmpfs_dev_shm"}
    return targets


def test_retained_report_is_hash_pinned_bounded_and_arithmetically_consistent() -> None:
    report = retained_report()
    assert report["schema"] == "windows-itunes-itl.filesystem-process-crash-tmpfs-ext4.v1"
    assert report["status"] == "completed_bounded_linux_ext4_tmpfs_process_termination_contrast"
    assert report["repository_baseline_commit"] == BASE_COMMIT
    assert report["production_source"] == {
        "path": "itlkit/io.py",
        "sha256": hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
    }
    assert report["generator"] == {
        "path": "scripts/research/audit_filesystem_process_crash_tmpfs_ext4_20260926.py",
        "sha256": hashlib.sha256(SCRIPT.read_bytes()).hexdigest(),
    }
    assert report["legacy_child_driver"] == {
        "path": "scripts/research/audit_filesystem_process_crash_20260925.py",
        "sha256": hashlib.sha256(LEGACY_SCRIPT.read_bytes()).hexdigest(),
        "role": "provides unchanged child scheduling hooks and production write_new invocation",
    }
    assert report["bounds"] == {
        "actual_process_crash_case_scenarios": 8,
        "actual_sigkill_operations": 8,
        "case_scenarios": 10,
        "child_processes_spawned": 10,
        "complete_payload_file_fsyncs_completed": 6,
        "filesystems_observed": 2,
        "linux_hard_link_commits_completed": 4,
        "linux_mkstemp_creations_completed": 10,
        "native_itunes_operations": 0,
        "network_filesystem_operations": 0,
        "normal_completion_control_case_scenarios": 2,
        "parent_reaped_children": 10,
        "partial_prefix_flushes_completed": 2,
        "power_loss_operations": 0,
        "production_cleanup_unlinks_completed": 2,
        "production_code_changes": 0,
    }
    assert report["summary"] == {
        "actual_process_crash_cases": 8,
        "filesystems_observed": 2,
        "normal_control_cases": 2,
        "normalized_case_sequences_match_between_ext4_and_tmpfs": True,
        "normalized_outcome_fingerprints_match_between_ext4_and_tmpfs": True,
        "production_change_warranted": False,
        "production_code_changed": False,
        "u17_status": "open",
        "unexpected_anomalies": 0,
    }
    assert report["methodology"]["case_counts_are_independent_experiments"] is False
    assert report["methodology"]["filesystem_contrast_is_durability_or_power_loss_evidence"] is False
    assert_path_and_name_hygiene(report)


def test_targets_retain_expected_filesystem_identities_and_matching_outcomes() -> None:
    report = retained_report()
    targets = target_by_id(report)
    assert targets["ext4_tmp"]["environment"]["operating_system"] == "Linux"
    assert targets["tmpfs_dev_shm"]["environment"]["operating_system"] == "Linux"
    assert targets["ext4_tmp"]["environment"]["mount_filesystem_type"] == "ext4"
    assert targets["tmpfs_dev_shm"]["environment"]["mount_filesystem_type"] == "tmpfs"
    assert targets["ext4_tmp"]["environment"]["filesystem_magic_hex"] == "ef53"
    assert targets["tmpfs_dev_shm"]["environment"]["filesystem_magic_hex"] in {"1021994", "1021994"}

    for target in targets.values():
        assert target["counts"] == {
            "actual_process_crash_case_scenarios": 4,
            "actual_sigkill_operations": 4,
            "case_scenarios": 5,
            "child_processes_spawned": 5,
            "complete_payload_file_fsyncs_completed": 3,
            "linux_hard_link_commits_completed": 2,
            "linux_mkstemp_creations_completed": 5,
            "normal_completion_control_case_scenarios": 1,
            "parent_reaped_children": 5,
            "partial_prefix_flushes_completed": 1,
            "production_cleanup_unlinks_completed": 1,
        }
        assert target["scratch_cleanup"] == {
            "root_removed_after_measurement": True,
            "retained_report_contains_random_temporary_names": False,
        }
        crash_cases = [case for case in target["cases"] if case["category"] == "actual_process_crash"]
        assert len(crash_cases) == 4
        for case in crash_cases:
            assert case["termination"] == {
                "child_died_by_signal": True,
                "child_exited_normally": False,
                "child_returncode": -LINUX_SIGKILL_NUMBER,
                "parent_reaped_child": True,
                "parent_sent_signal": "SIGKILL",
                "signal_number": LINUX_SIGKILL_NUMBER,
            }
            assert case["hook"]["production_write_new_source_changed"] is False
            assert case["hook"]["production_write_new_invoked"] is True

    assert targets["ext4_tmp"]["cases"] == targets["tmpfs_dev_shm"]["cases"]
    assert targets["ext4_tmp"]["outcome_fingerprint"] == targets["tmpfs_dev_shm"]["outcome_fingerprint"]


@pytest.mark.skipif(not sys.platform.startswith("linux"), reason="campaign requires Linux SIGKILL and /proc")
def test_contrast_replays_from_fresh_roots_with_only_environment_variance(tmp_path: Path) -> None:
    shm = Path("/dev/shm")
    if not shm.is_dir() or not os.access(shm, os.W_OK):
        pytest.skip("/dev/shm is not available for the tmpfs contrast")
    campaign = load_campaign_module()
    ext4_root = tmp_path / "ext4-root"
    tmpfs_root = shm / f"itl-u17-test-{os.getpid()}-tmpfs-root"
    if os.path.lexists(tmpfs_root):
        raise AssertionError(f"unexpected stale tmpfs root: {tmpfs_root}")
    try:
        replay = campaign.build_contrast_report(
            ext4_root,
            tmpfs_root,
            ext4_allowed_parent=tmp_path,
            tmpfs_allowed_parent=shm,
        )
    finally:
        if os.path.lexists(tmpfs_root):
            import shutil
            shutil.rmtree(tmpfs_root)
    assert not os.path.lexists(ext4_root)
    assert not os.path.lexists(tmpfs_root)
    assert without_environment(replay) == without_environment(retained_report())
    assert_path_and_name_hygiene(replay)


@pytest.mark.skipif(not sys.platform.startswith("linux"), reason="scratch guard is Linux-specific")
def test_scratch_guard_rejects_relative_outside_and_existing_roots(tmp_path: Path) -> None:
    campaign = load_campaign_module()
    with pytest.raises(ValueError, match="absolute"):
        campaign.prepare_new_scratch_root(Path("relative-scratch"), tmp_path)
    with pytest.raises(ValueError, match="below"):
        campaign.prepare_new_scratch_root(Path("/usr/itl-u17-must-not-create"), tmp_path)
    existing = tmp_path / "existing"
    existing.mkdir()
    with pytest.raises(FileExistsError, match="fresh"):
        campaign.prepare_new_scratch_root(existing, tmp_path)
