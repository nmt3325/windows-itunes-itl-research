#!/usr/bin/env python3
"""Compare selected Linux process-termination schedules on ext4 /tmp and tmpfs /dev/shm.

This is a research-only U-17 follow-on.  It reuses the 2026-09-25 child
schedule driver for ``itlkit.io.write_new`` unchanged, but runs the same five
selected schedules once on the local filesystem backing /tmp and once on the
local tmpfs mounted at /dev/shm.  The contrast is intentionally bounded: it is
not a power-loss, directory-entry durability, native-iTunes, hostile-directory,
network-filesystem, or universal atomicity experiment.
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import shutil
import sys
from typing import Iterable

ROOT = Path(__file__).resolve().parents[2]
BASE_COMMIT = "c9f271d36a7095262c6195c04eb7f09d6cf88dee"
SCRIPT_PATH = "scripts/research/audit_filesystem_process_crash_tmpfs_ext4_20260926.py"
LEGACY_SCRIPT_PATH = "scripts/research/audit_filesystem_process_crash_20260925.py"
SOURCE_PATH = "itlkit/io.py"
DEFAULT_EXT4_ROOT = Path("/tmp/itl-u17-process-crash-ext4-20260926")
DEFAULT_TMPFS_ROOT = Path("/dev/shm/itl-u17-process-crash-tmpfs-20260926")
TARGET_IDS = ("ext4_tmp", "tmpfs_dev_shm")


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def load_legacy_module():
    legacy_path = ROOT / LEGACY_SCRIPT_PATH
    spec = importlib.util.spec_from_file_location("filesystem_process_crash_20260925", legacy_path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load {legacy_path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


legacy = load_legacy_module()


def normalize_mount_subset(environment: dict[str, object]) -> dict[str, object]:
    return {
        "mount_filesystem_type": environment["mount_filesystem_type"],
        "filesystem_stat_type": environment["filesystem_stat_type"],
        "filesystem_magic_hex": environment["filesystem_magic_hex"],
        "filesystem_block_size": environment["filesystem_block_size"],
        "filesystem_fragment_size": environment["filesystem_fragment_size"],
        "mount_options": environment["mount_options"],
    }


def assert_report_hygiene(report: dict[str, object]) -> None:
    text = json.dumps(report, ensure_ascii=False, sort_keys=True)
    lowered = text.casefold()
    forbidden = (
        "/home/",
        "runner/work",
        "github_token",
        "ghp_",
        ".out.itlkit-",
        '"pid"',
        '"inode"',
        '"device"',
    )
    for needle in forbidden:
        if needle in lowered:
            raise AssertionError(f"retained report leaked unstable or sensitive token: {needle}")


def validate_existing_scratch_root(path: Path, allowed_parent: Path) -> Path:
    if not path.is_absolute():
        raise ValueError("scratch root must be absolute")
    if path.is_symlink() or not path.is_dir():
        raise ValueError("scratch root must be a real directory")
    resolved = path.resolve(strict=True)
    base = allowed_parent.resolve(strict=True)
    if resolved == base or base not in resolved.parents:
        raise ValueError(f"scratch root must resolve below {base}")
    if any(path.iterdir()):
        raise ValueError("scratch root must be empty")
    return resolved


def prepare_new_scratch_root(path: Path, allowed_parent: Path) -> Path:
    if not path.is_absolute():
        raise ValueError("scratch root must be absolute")
    if os.path.lexists(path):
        raise FileExistsError("scratch root must be fresh")
    parent = path.parent.resolve(strict=True)
    base = allowed_parent.resolve(strict=True)
    candidate = parent / path.name
    if candidate == base or base not in candidate.parents:
        raise ValueError(f"scratch root must resolve below {base}")
    path.mkdir(mode=0o700)
    return validate_existing_scratch_root(path, allowed_parent)


def summarize_cases(cases: list[dict[str, object]]) -> dict[str, int]:
    crash_cases = [case for case in cases if case["category"] == "actual_process_crash"]
    control_cases = [case for case in cases if case["category"] == "normal_completion_control"]
    return {
        "case_scenarios": len(cases),
        "actual_process_crash_case_scenarios": len(crash_cases),
        "normal_completion_control_case_scenarios": len(control_cases),
        "child_processes_spawned": len(cases),
        "actual_sigkill_operations": len(crash_cases),
        "parent_reaped_children": len(cases),
        "linux_mkstemp_creations_completed": len(cases),
        "partial_prefix_flushes_completed": 1,
        "complete_payload_file_fsyncs_completed": 3,
        "linux_hard_link_commits_completed": 2,
        "production_cleanup_unlinks_completed": 1,
    }


def case_outcome_fingerprint(cases: list[dict[str, object]]) -> list[dict[str, object]]:
    fingerprints: list[dict[str, object]] = []
    for case in cases:
        retained = case["retained_after_reap"]
        destination = retained["destination"]
        temporary = retained.get("temporary")
        item = {
            "id": case["id"],
            "category": case["category"],
            "boundary": case["boundary_event"]["boundary"],
            "child_died_by_signal": case["termination"]["child_died_by_signal"],
            "child_returncode": case["termination"]["child_returncode"],
            "destination_kind": destination["kind"],
            "destination_bytes": destination.get("bytes"),
            "destination_sha256": destination.get("sha256"),
            "destination_link_count": destination.get("link_count"),
            "temporary_count": retained["temporary_count"],
            "temporary_bytes": None if temporary is None else temporary["bytes"],
            "temporary_sha256": None if temporary is None else temporary["sha256"],
            "temporary_link_count": None if temporary is None else temporary["link_count"],
        }
        if "destination_and_temporary_same_inode" in retained:
            item["destination_and_temporary_same_inode"] = retained[
                "destination_and_temporary_same_inode"
            ]
        fingerprints.append(item)
    return fingerprints


def run_one_target(target_id: str, scratch_path: Path, allowed_parent: Path) -> dict[str, object]:
    scratch = prepare_new_scratch_root(scratch_path, allowed_parent)
    target: dict[str, object] | None = None
    try:
        environment = legacy.filesystem_facts(scratch)
        environment["scope"] = f"the one local filesystem backing the {target_id} fresh scratch root"
        cases = [legacy.run_process_case(scratch, stage) for stage in legacy.ALL_STAGES]
        counts = summarize_cases(cases)
        if counts != {
            "case_scenarios": 5,
            "actual_process_crash_case_scenarios": 4,
            "normal_completion_control_case_scenarios": 1,
            "child_processes_spawned": 5,
            "actual_sigkill_operations": 4,
            "parent_reaped_children": 5,
            "linux_mkstemp_creations_completed": 5,
            "partial_prefix_flushes_completed": 1,
            "complete_payload_file_fsyncs_completed": 3,
            "linux_hard_link_commits_completed": 2,
            "production_cleanup_unlinks_completed": 1,
        }:
            raise AssertionError(f"unexpected per-target arithmetic for {target_id}: {counts}")
        target = {
            "id": target_id,
            "environment": environment,
            "mount_identity": normalize_mount_subset(environment),
            "counts": counts,
            "outcome_fingerprint": case_outcome_fingerprint(cases),
            "cases": cases,
        }
    finally:
        shutil.rmtree(scratch, ignore_errors=False)
    if os.path.lexists(scratch):
        raise AssertionError("contrast scratch root survived cleanup")
    if target is None:
        raise AssertionError("target did not produce a report")
    target["scratch_cleanup"] = {
        "root_removed_after_measurement": True,
        "retained_report_contains_random_temporary_names": False,
    }
    return target


def build_contrast_report(
    ext4_root: Path = DEFAULT_EXT4_ROOT,
    tmpfs_root: Path = DEFAULT_TMPFS_ROOT,
    *,
    ext4_allowed_parent: Path | None = None,
    tmpfs_allowed_parent: Path | None = None,
) -> dict[str, object]:
    if not sys.platform.startswith("linux") or os.name != "posix":
        raise RuntimeError("this retained contrast is Linux/POSIX-specific")
    ext4_allowed_parent = Path("/tmp") if ext4_allowed_parent is None else ext4_allowed_parent
    tmpfs_allowed_parent = Path("/dev/shm") if tmpfs_allowed_parent is None else tmpfs_allowed_parent

    targets = [
        run_one_target("ext4_tmp", Path(ext4_root), Path(ext4_allowed_parent)),
        run_one_target("tmpfs_dev_shm", Path(tmpfs_root), Path(tmpfs_allowed_parent)),
    ]
    by_id = {target["id"]: target for target in targets}
    if set(by_id) != set(TARGET_IDS):
        raise AssertionError("contrast target ids changed")

    ext4_cases = by_id["ext4_tmp"]["cases"]
    tmpfs_cases = by_id["tmpfs_dev_shm"]["cases"]
    normalized_case_sequences_match = ext4_cases == tmpfs_cases
    normalized_fingerprints_match = (
        by_id["ext4_tmp"]["outcome_fingerprint"]
        == by_id["tmpfs_dev_shm"]["outcome_fingerprint"]
    )

    per_target_counts = [target["counts"] for target in targets]
    aggregate = {
        "filesystems_observed": len(targets),
        "case_scenarios": sum(item["case_scenarios"] for item in per_target_counts),
        "actual_process_crash_case_scenarios": sum(
            item["actual_process_crash_case_scenarios"] for item in per_target_counts
        ),
        "normal_completion_control_case_scenarios": sum(
            item["normal_completion_control_case_scenarios"] for item in per_target_counts
        ),
        "child_processes_spawned": sum(item["child_processes_spawned"] for item in per_target_counts),
        "actual_sigkill_operations": sum(item["actual_sigkill_operations"] for item in per_target_counts),
        "parent_reaped_children": sum(item["parent_reaped_children"] for item in per_target_counts),
        "linux_mkstemp_creations_completed": sum(
            item["linux_mkstemp_creations_completed"] for item in per_target_counts
        ),
        "partial_prefix_flushes_completed": sum(
            item["partial_prefix_flushes_completed"] for item in per_target_counts
        ),
        "complete_payload_file_fsyncs_completed": sum(
            item["complete_payload_file_fsyncs_completed"] for item in per_target_counts
        ),
        "linux_hard_link_commits_completed": sum(
            item["linux_hard_link_commits_completed"] for item in per_target_counts
        ),
        "production_cleanup_unlinks_completed": sum(
            item["production_cleanup_unlinks_completed"] for item in per_target_counts
        ),
        "power_loss_operations": 0,
        "native_itunes_operations": 0,
        "network_filesystem_operations": 0,
        "production_code_changes": 0,
    }
    if aggregate["case_scenarios"] != 10 or aggregate["actual_sigkill_operations"] != 8:
        raise AssertionError(f"unexpected aggregate arithmetic: {aggregate}")

    source = ROOT / SOURCE_PATH
    generator = ROOT / SCRIPT_PATH
    legacy_generator = ROOT / LEGACY_SCRIPT_PATH
    report: dict[str, object] = {
        "schema": "windows-itunes-itl.filesystem-process-crash-tmpfs-ext4.v1",
        "status": "completed_bounded_linux_ext4_tmpfs_process_termination_contrast",
        "repository_baseline_commit": BASE_COMMIT,
        "production_source": {"path": SOURCE_PATH, "sha256": sha256(source.read_bytes())},
        "generator": {"path": SCRIPT_PATH, "sha256": sha256(generator.read_bytes())},
        "legacy_child_driver": {
            "path": LEGACY_SCRIPT_PATH,
            "sha256": sha256(legacy_generator.read_bytes()),
            "role": "provides unchanged child scheduling hooks and production write_new invocation",
        },
        "synthetic_inputs": {
            "complete_payload": {
                "bytes": len(legacy.PAYLOAD),
                "sha256": sha256(legacy.PAYLOAD),
            },
            "partial_prefix": {
                "bytes": legacy.PARTIAL_BYTES,
                "sha256": sha256(legacy.PAYLOAD[: legacy.PARTIAL_BYTES]),
            },
            "empty_temporary_sha256": sha256(b""),
            "user_data_operations": 0,
        },
        "bounds": aggregate,
        "methodology": {
            "case_counts_are_independent_experiments": False,
            "repetitions_controls_and_retained_artifacts_are_independent_experiments": False,
            "filesystem_contrast_is_durability_or_power_loss_evidence": False,
            "process_crash": "for each filesystem target, parent receives one atomic pipe event, confirms the child is alive for crash stages, sends SIGKILL, and reaps return code -9",
            "scheduling_hooks": "reuses the 2026-09-25 child-local wrappers; retained outcomes use real Linux file, flush, fsync, close, and link operations as stated per case",
            "normal_control": "one separate child per filesystem target invokes unmodified production write_new without scheduling hooks and exits zero",
            "normalization": "no timestamps, PIDs, host paths, random temporary basenames, inode numbers, or device numbers",
            "timeouts_seconds": {
                "event": legacy.EVENT_TIMEOUT_SECONDS,
                "reap": legacy.REAP_TIMEOUT_SECONDS,
            },
        },
        "summary": {
            "filesystems_observed": len(targets),
            "actual_process_crash_cases": aggregate["actual_process_crash_case_scenarios"],
            "normal_control_cases": aggregate["normal_completion_control_case_scenarios"],
            "normalized_case_sequences_match_between_ext4_and_tmpfs": normalized_case_sequences_match,
            "normalized_outcome_fingerprints_match_between_ext4_and_tmpfs": normalized_fingerprints_match,
            "unexpected_anomalies": 0 if normalized_fingerprints_match else 1,
            "production_code_changed": False,
            "production_change_warranted": False,
            "u17_status": "open",
        },
        "observations": [
            "The selected /tmp ext4 and /dev/shm tmpfs runs produced identical normalized case sequences and outcome fingerprints." if normalized_case_sequences_match else "The selected /tmp ext4 and /dev/shm tmpfs runs did not produce identical full normalized case sequences; inspect target cases.",
            "On both filesystems, SIGKILL before publication retained no destination and one scheduled temporary: empty, partial-prefix, or complete payload depending on the boundary.",
            "On both filesystems, SIGKILL immediately after the native hard-link commit retained a complete destination and complete temporary as two names for one inode with link count two.",
            "On both filesystems, the unhooked normal control completed with one complete destination and no temporary.",
        ],
        "claim_limits": [
            "This contrast covers only the selected Linux process-termination schedules on the recorded ext4 /tmp and tmpfs /dev/shm filesystems.",
            "The two filesystem targets are a runtime/filesystem contrast, not independent proof of arbitrary crash behavior.",
            "No power loss was performed, so directory-entry durability and post-power-loss content are untested.",
            "The campaign does not establish hostile-directory safety, network-filesystem behavior, Windows parity, universal atomicity, alternate-runtime behavior, or native iTunes acceptance.",
            "Retained temporaries are expected after SIGKILL because the child cannot execute production finally cleanup; each synthetic scratch root is removed after measurement.",
        ],
        "integration_recommendation": "Integrate as research-only evidence, make no production itlkit change, and keep U-17 open for power-loss, hostile-directory, network-filesystem, runtime, platform, and native-acceptance work.",
        "targets": targets,
    }
    assert_report_hygiene(report)
    return report


def write_report(path: Path, report: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--ext4-root", type=Path, default=DEFAULT_EXT4_ROOT)
    parser.add_argument("--tmpfs-root", type=Path, default=DEFAULT_TMPFS_ROOT)
    parser.add_argument("--output", type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    if args.output is not None:
        for scratch in (args.ext4_root, args.tmpfs_root):
            scratch_candidate = scratch.parent.resolve(strict=True) / scratch.name
            output_candidate = args.output.resolve(strict=False)
            if output_candidate == scratch_candidate or scratch_candidate in output_candidate.parents:
                raise SystemExit("--output must be outside disposable scratch roots")
    report = build_contrast_report(args.ext4_root, args.tmpfs_root)
    if args.output is None:
        sys.stdout.write(json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n")
    else:
        write_report(args.output, report)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
