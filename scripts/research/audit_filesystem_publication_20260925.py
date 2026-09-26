#!/usr/bin/env python3
"""Deterministic Linux threat-model audit for ``itlkit.io.write_new``.

Every exercised filesystem object lives below a caller-supplied fresh /tmp
root.  The report intentionally omits timestamps, host paths, kernel versions,
and random temporary names.  Scheduler hooks only place real Linux filesystem
operations at deterministic interleavings; they are not evidence of safety in
a hostile directory.  Fault injection characterizes error boundaries and is
reported separately from native filesystem observations.
"""
from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor
import errno
import hashlib
import json
import os
from pathlib import Path
import shutil
import sys
from threading import Barrier
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
BASE_COMMIT = "bc31fd860576b25f47ff1c3f409a9d97b04114fb"
SCRIPT_PATH = "scripts/research/audit_filesystem_publication_20260925.py"
SOURCE_PATH = "itlkit/io.py"
PAYLOAD = (b"itlkit-u17-complete-publication-payload\n" * 17) + b"end\n"
PAYLOAD_A = b"A" * 65537
PAYLOAD_B = b"B" * 65537
EXISTING = b"preexisting-destination\n"
RACER = b"racing-writer-owned-destination\n"
SPOOF = b"hostile-parent-spoof\n"

sys.path.insert(0, str(ROOT))
import itlkit.io as output  # noqa: E402


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def file_state(path: Path) -> dict[str, object]:
    if not os.path.lexists(path):
        return {"kind": "absent"}
    if path.is_symlink():
        return {"kind": "symlink", "target": os.readlink(path)}
    if path.is_file():
        data = path.read_bytes()
        return {"kind": "regular", "bytes": len(data), "sha256": sha256(data)}
    if path.is_dir():
        return {"kind": "directory"}
    return {"kind": "other"}


def error_state(exc: BaseException) -> dict[str, object]:
    number = getattr(exc, "errno", None)
    return {
        "type": type(exc).__name__,
        "errno": number,
        "errno_name": errno.errorcode.get(number) if isinstance(number, int) else None,
    }


def invoke(action) -> tuple[bool, dict[str, object] | None, BaseException | None]:
    try:
        action()
    except BaseException as exc:  # write_new deliberately handles BaseException too
        return False, error_state(exc), exc
    return True, None, None


def temporary_files(directory: Path, destination_name: str = "out") -> list[Path]:
    return sorted(directory.glob(f".{destination_name}.itlkit-*.tmp"))


def new_case(root: Path, case_id: str) -> Path:
    path = root / case_id
    path.mkdir()
    return path


def record(case_id: str, category: str, claim_scope: str, observed: dict[str, object]) -> dict[str, object]:
    return {
        "id": case_id,
        "category": category,
        "claim_scope": claim_scope,
        "observed": observed,
    }


def case_new_destination(root: Path) -> dict[str, object]:
    case_id = "new_destination_success"
    directory = new_case(root, case_id)
    destination = directory / "out"
    output.write_new(destination, PAYLOAD)
    assert destination.read_bytes() == PAYLOAD
    assert temporary_files(directory) == []
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": True,
        "destination": file_state(destination),
        "temporary_count": 0,
    })


def case_existing_regular(root: Path) -> dict[str, object]:
    case_id = "existing_regular_refused"
    directory = new_case(root, case_id)
    destination = directory / "out"
    destination.write_bytes(EXISTING)
    returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error == {"type": "FileExistsError", "errno": errno.EEXIST, "errno_name": "EEXIST"}
    assert destination.read_bytes() == EXISTING and temporary_files(directory) == []
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "existing_destination_unchanged": True,
        "temporary_count": 0,
    })


def case_existing_hardlink(root: Path) -> dict[str, object]:
    case_id = "existing_hardlink_alias_refused"
    directory = new_case(root, case_id)
    source = directory / "source"
    destination = directory / "out"
    source.write_bytes(EXISTING)
    os.link(source, destination)
    returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.EEXIST
    assert source.read_bytes() == EXISTING and destination.read_bytes() == EXISTING
    assert os.path.samefile(source, destination) and source.stat().st_nlink == 2
    assert temporary_files(directory) == []
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "alias_unchanged": True,
        "same_inode": True,
        "link_count": 2,
        "temporary_count": 0,
    })


def case_existing_symlink(root: Path) -> dict[str, object]:
    case_id = "existing_symlink_alias_refused"
    directory = new_case(root, case_id)
    victim = directory / "victim"
    destination = directory / "out"
    victim.write_bytes(EXISTING)
    destination.symlink_to(victim.name)
    returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.EEXIST
    assert destination.is_symlink() and os.readlink(destination) == victim.name
    assert victim.read_bytes() == EXISTING and temporary_files(directory) == []
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "symlink_unchanged": True,
        "victim_unchanged": True,
        "temporary_count": 0,
    })


def case_existing_dangling_symlink(root: Path) -> dict[str, object]:
    case_id = "existing_dangling_symlink_refused"
    directory = new_case(root, case_id)
    destination = directory / "out"
    destination.symlink_to("missing")
    returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.EEXIST
    assert destination.is_symlink() and not destination.exists()
    assert temporary_files(directory) == []
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "dangling_symlink_unchanged": True,
        "temporary_count": 0,
    })


def case_stable_parent_symlink(root: Path) -> dict[str, object]:
    case_id = "stable_parent_symlink_success"
    directory = new_case(root, case_id)
    real_parent = directory / "real-parent"
    alias_parent = directory / "alias-parent"
    real_parent.mkdir()
    alias_parent.symlink_to(real_parent, target_is_directory=True)
    destination = alias_parent / "out"
    output.write_new(destination, PAYLOAD)
    real_destination = real_parent / "out"
    assert destination.read_bytes() == PAYLOAD == real_destination.read_bytes()
    assert os.path.samefile(destination, real_destination)
    assert temporary_files(real_parent) == []
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": True,
        "destination_matches_payload": True,
        "alias_and_real_destination_same_inode": True,
        "temporary_count": 0,
    })


def case_lexical_parent_alias(root: Path) -> dict[str, object]:
    case_id = "lexical_parent_alias_success"
    directory = new_case(root, case_id)
    real_parent = directory / "real-parent"
    nested = real_parent / "nested"
    nested.mkdir(parents=True)
    destination = nested / ".." / "out"
    output.write_new(destination, PAYLOAD)
    canonical = real_parent / "out"
    assert canonical.read_bytes() == PAYLOAD and os.path.samefile(destination, canonical)
    assert temporary_files(real_parent) == []
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": True,
        "destination_matches_payload": True,
        "lexical_and_canonical_destination_same_inode": True,
        "temporary_count": 0,
    })


def case_missing_parent(root: Path) -> dict[str, object]:
    case_id = "missing_parent_refused"
    directory = new_case(root, case_id)
    destination = directory / "missing" / "out"
    returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.ENOENT
    assert not os.path.lexists(destination) and not (directory / "missing").exists()
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "destination_absent": True,
        "parent_not_created": True,
    })


def case_destination_creation_race(root: Path) -> dict[str, object]:
    case_id = "destination_created_before_link_refused"
    directory = new_case(root, case_id)
    destination = directory / "out"
    real_link = os.link

    def race_link(source, target, *args, **kwargs):
        Path(target).write_bytes(RACER)
        return real_link(source, target, *args, **kwargs)

    with patch.object(output.os, "link", race_link):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.EEXIST
    assert destination.read_bytes() == RACER and temporary_files(directory) == []
    return record(case_id, "scheduler_assisted_native_syscall", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "racing_destination_unchanged": True,
        "temporary_count": 0,
        "schedule_hook_only": True,
        "final_link_syscall_was_native": True,
    })


def case_two_publishers(root: Path) -> dict[str, object]:
    case_id = "two_publishers_single_winner"
    directory = new_case(root, case_id)
    destination = directory / "out"
    barrier = Barrier(2)
    real_link = os.link

    def synchronized_link(source, target, *args, **kwargs):
        barrier.wait(timeout=10)
        return real_link(source, target, *args, **kwargs)

    def publish(payload: bytes) -> str:
        try:
            output.write_new(destination, payload)
        except FileExistsError:
            return "exists"
        return "published"

    with patch.object(output.os, "link", synchronized_link):
        with ThreadPoolExecutor(max_workers=2) as workers:
            outcomes = sorted(workers.map(publish, (PAYLOAD_A, PAYLOAD_B)))
    final = destination.read_bytes()
    assert outcomes == ["exists", "published"]
    assert final in (PAYLOAD_A, PAYLOAD_B) and temporary_files(directory) == []
    return record(case_id, "scheduler_assisted_native_syscall", "stable_directory_model", {
        "normalized_outcomes": outcomes,
        "winner_count": 1,
        "destination_is_one_complete_payload": True,
        "destination_is_merged_payload": False,
        "temporary_count": 0,
        "schedule_hook_only": True,
        "final_link_syscalls_were_native": True,
    })


def case_partial_write_failure(root: Path) -> dict[str, object]:
    case_id = "partial_write_exception_refused_clean"
    directory = new_case(root, case_id)
    destination = directory / "out"

    def fail_write(stream, data):
        stream.write(data[:11])
        stream.flush()
        raise OSError(errno.ENOSPC, "injected write failure")

    with patch.object(output, "_write_payload", fail_write):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.ENOSPC
    assert not destination.exists() and temporary_files(directory) == []
    return record(case_id, "fault_injection", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "destination_absent": True,
        "temporary_count": 0,
    })


class FaultStream:
    def __init__(self, inner, mode: str):
        self.inner = inner
        self.mode = mode

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, traceback):
        if self.mode == "close":
            self.inner.close()
            raise OSError(errno.EIO, "injected close failure")
        return self.inner.__exit__(exc_type, exc, traceback)

    def write(self, data: bytes) -> int:
        if self.mode == "short":
            return self.inner.write(data[:11])
        return self.inner.write(data)

    def flush(self) -> None:
        if self.mode == "flush":
            raise OSError(errno.EIO, "injected flush failure")
        self.inner.flush()

    def fileno(self) -> int:
        return self.inner.fileno()


def stream_fault_case(root: Path, mode: str) -> dict[str, object]:
    case_id = f"{mode}_failure_refused_clean" if mode != "short" else "short_write_refused_clean"
    directory = new_case(root, case_id)
    destination = directory / "out"
    real_fdopen = os.fdopen

    def faulting_fdopen(*args, **kwargs):
        return FaultStream(real_fdopen(*args, **kwargs), mode)

    with patch.object(output.os, "fdopen", faulting_fdopen):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.EIO
    assert not destination.exists() and temporary_files(directory) == []
    return record(case_id, "fault_injection", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "destination_absent": True,
        "temporary_count": 0,
    })


def case_fsync_failure(root: Path) -> dict[str, object]:
    case_id = "fsync_failure_refused_clean"
    directory = new_case(root, case_id)
    destination = directory / "out"

    def fail_fsync(_fd):
        raise OSError(errno.EIO, "injected fsync failure")

    with patch.object(output.os, "fsync", fail_fsync):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.EIO
    assert not destination.exists() and temporary_files(directory) == []
    return record(case_id, "fault_injection", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "destination_absent": True,
        "temporary_count": 0,
    })


def case_hardlink_refusal(root: Path) -> dict[str, object]:
    case_id = "hardlink_refusal_refused_clean"
    directory = new_case(root, case_id)
    destination = directory / "out"

    def refuse_link(*_args, **_kwargs):
        raise OSError(errno.EPERM, "injected hard-link refusal")

    with patch.object(output.os, "link", refuse_link):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.EPERM
    assert not destination.exists() and temporary_files(directory) == []
    return record(case_id, "fault_injection", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "destination_absent": True,
        "temporary_count": 0,
        "rename_fallback_observed": False,
    })


def cleanup_denial(real_unlink):
    def deny(self: Path, *args, **kwargs):
        if self.name.startswith(".out.itlkit-") and self.name.endswith(".tmp"):
            raise PermissionError(errno.EACCES, "injected cleanup failure")
        return real_unlink(self, *args, **kwargs)
    return deny


def case_cleanup_failure_before_publish(root: Path) -> dict[str, object]:
    case_id = "cleanup_failure_before_publish_preserves_primary_error"
    directory = new_case(root, case_id)
    destination = directory / "out"
    real_unlink = Path.unlink

    def fail_write(stream, data):
        stream.write(data[:13])
        raise OSError(errno.ENOSPC, "injected primary write failure")

    with patch.object(output, "_write_payload", fail_write), patch.object(Path, "unlink", cleanup_denial(real_unlink)):
        returned, error, exc = invoke(lambda: output.write_new(destination, PAYLOAD))
    temps = temporary_files(directory)
    notes = list(getattr(exc, "__notes__", ())) if exc is not None else []
    assert not returned and error and error["errno"] == errno.ENOSPC
    assert not destination.exists() and len(temps) == 1 and temps[0].stat().st_size == 13
    assert any("cleanup also failed" in note for note in notes)
    return record(case_id, "fault_injection", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "destination_absent": True,
        "primary_error_retained": True,
        "cleanup_failure_note_present": True,
        "retained_temporary_count": 1,
        "retained_temporary_bytes": 13,
    })


def case_cleanup_failure_after_publish(root: Path) -> dict[str, object]:
    case_id = "cleanup_failure_after_publish_reports_complete_destination"
    directory = new_case(root, case_id)
    destination = directory / "out"
    real_unlink = Path.unlink
    with patch.object(Path, "unlink", cleanup_denial(real_unlink)):
        returned, error, exc = invoke(lambda: output.write_new(destination, PAYLOAD))
    temps = temporary_files(directory)
    assert not returned and error and error["type"] == "OSError" and error["errno"] is None
    assert exc is not None and "complete output was published" in str(exc)
    assert destination.read_bytes() == PAYLOAD and len(temps) == 1
    assert temps[0].read_bytes() == PAYLOAD and os.path.samefile(destination, temps[0])
    assert destination.stat().st_nlink == 2
    return record(case_id, "fault_injection", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "message_identifies_complete_publication": True,
        "destination_matches_payload": True,
        "retained_temporary_matches_payload": True,
        "destination_and_temporary_same_inode": True,
        "link_count": 2,
        "retained_temporary_count": 1,
    })


def case_parent_rename(root: Path) -> dict[str, object]:
    case_id = "parent_rename_without_replacement_leaves_temporary"
    directory = new_case(root, case_id)
    parent = directory / "parent"
    moved = directory / "moved-parent"
    parent.mkdir()
    destination = parent / "out"
    real_link = os.link

    def rename_then_link(source, target, *args, **kwargs):
        parent.rename(moved)
        return real_link(source, target, *args, **kwargs)

    with patch.object(output.os, "link", rename_then_link):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    moved_temps = temporary_files(moved)
    assert not returned and error and error["errno"] == errno.ENOENT
    assert not parent.exists() and len(moved_temps) == 1
    assert moved_temps[0].read_bytes() == PAYLOAD
    return record(case_id, "scheduler_assisted_native_syscall", "documented_out_of_model_limit", {
        "returned": returned,
        "error": error,
        "destination_absent": True,
        "displaced_complete_temporary_count": 1,
        "displaced_temporary_matches_payload": True,
        "schedule_hook_only": True,
        "rename_and_link_syscalls_were_native": True,
    })


def case_parent_directory_swap(root: Path) -> dict[str, object]:
    case_id = "parent_directory_swap_can_publish_spoof"
    directory = new_case(root, case_id)
    parent = directory / "parent"
    moved = directory / "moved-parent"
    parent.mkdir()
    destination = parent / "out"
    real_link = os.link

    def swap_then_link(source, target, *args, **kwargs):
        parent.rename(moved)
        parent.mkdir()
        (parent / Path(source).name).write_bytes(SPOOF)
        return real_link(source, target, *args, **kwargs)

    with patch.object(output.os, "link", swap_then_link):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    moved_temps = temporary_files(moved)
    assert returned and error is None
    assert destination.read_bytes() == SPOOF and destination.read_bytes() != PAYLOAD
    assert temporary_files(parent) == [] and len(moved_temps) == 1
    assert moved_temps[0].read_bytes() == PAYLOAD
    return record(case_id, "scheduler_assisted_native_syscall", "documented_out_of_model_limit", {
        "returned": returned,
        "destination_matches_requested_payload": False,
        "destination_matches_spoof": True,
        "replacement_parent_temporary_count": 0,
        "displaced_complete_temporary_count": 1,
        "displaced_temporary_matches_payload": True,
        "schedule_hook_only": True,
        "rename_mkdir_write_and_link_syscalls_were_native": True,
    })


def case_parent_symlink_retarget(root: Path) -> dict[str, object]:
    case_id = "parent_symlink_retarget_can_publish_spoof"
    directory = new_case(root, case_id)
    first = directory / "first-parent"
    second = directory / "second-parent"
    alias = directory / "parent-alias"
    first.mkdir()
    second.mkdir()
    alias.symlink_to(first, target_is_directory=True)
    destination = alias / "out"
    real_link = os.link

    def retarget_then_link(source, target, *args, **kwargs):
        alias.unlink()
        alias.symlink_to(second, target_is_directory=True)
        (second / Path(source).name).write_bytes(SPOOF)
        return real_link(source, target, *args, **kwargs)

    with patch.object(output.os, "link", retarget_then_link):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    first_temps = temporary_files(first)
    assert returned and error is None
    assert destination.read_bytes() == SPOOF and destination.read_bytes() != PAYLOAD
    assert temporary_files(second) == [] and len(first_temps) == 1
    assert first_temps[0].read_bytes() == PAYLOAD
    return record(case_id, "scheduler_assisted_native_syscall", "documented_out_of_model_limit", {
        "returned": returned,
        "destination_matches_requested_payload": False,
        "destination_matches_spoof": True,
        "retargeted_parent_temporary_count": 0,
        "original_parent_complete_temporary_count": 1,
        "original_temporary_matches_payload": True,
        "schedule_hook_only": True,
        "symlink_write_and_link_syscalls_were_native": True,
    })


def validate_existing_scratch_root(path: Path) -> Path:
    if not path.is_absolute():
        raise ValueError("scratch root must be absolute")
    resolved = path.resolve(strict=True)
    tmp = Path("/tmp").resolve(strict=True)
    if resolved == tmp or tmp not in resolved.parents:
        raise ValueError("scratch root must resolve below /tmp")
    if path.is_symlink() or not path.is_dir():
        raise ValueError("scratch root must be a real directory")
    if any(path.iterdir()):
        raise ValueError("scratch root must be empty")
    return resolved


def prepare_new_scratch_root(path: Path) -> Path:
    if not path.is_absolute():
        raise ValueError("scratch root must be absolute")
    if os.path.lexists(path):
        raise FileExistsError(errno.EEXIST, "scratch root must be fresh")
    unresolved_parent = path.parent.resolve(strict=True)
    tmp = Path("/tmp").resolve(strict=True)
    candidate = unresolved_parent / path.name
    if candidate == tmp or tmp not in candidate.parents:
        raise ValueError("scratch root must resolve below /tmp")
    path.mkdir(mode=0o700)
    return validate_existing_scratch_root(path)


def run_campaign(scratch_root: Path) -> dict[str, object]:
    if not sys.platform.startswith("linux") or os.name != "posix":
        raise RuntimeError("this retained campaign is Linux/POSIX-specific")
    root = validate_existing_scratch_root(Path(scratch_root))
    cases = [
        case_new_destination(root),
        case_existing_regular(root),
        case_existing_hardlink(root),
        case_existing_symlink(root),
        case_existing_dangling_symlink(root),
        case_stable_parent_symlink(root),
        case_lexical_parent_alias(root),
        case_missing_parent(root),
        case_destination_creation_race(root),
        case_two_publishers(root),
        case_partial_write_failure(root),
        stream_fault_case(root, "short"),
        stream_fault_case(root, "flush"),
        case_fsync_failure(root),
        stream_fault_case(root, "close"),
        case_hardlink_refusal(root),
        case_cleanup_failure_before_publish(root),
        case_cleanup_failure_after_publish(root),
        case_parent_rename(root),
        case_parent_directory_swap(root),
        case_parent_symlink_retarget(root),
    ]
    category_counts = {
        category: sum(case["category"] == category for case in cases)
        for category in ("native_direct", "scheduler_assisted_native_syscall", "fault_injection")
    }
    scope_counts = {
        scope: sum(case["claim_scope"] == scope for case in cases)
        for scope in ("stable_directory_model", "documented_out_of_model_limit")
    }
    assert category_counts == {
        "native_direct": 8,
        "scheduler_assisted_native_syscall": 5,
        "fault_injection": 8,
    }
    assert scope_counts == {"stable_directory_model": 18, "documented_out_of_model_limit": 3}
    source = ROOT / SOURCE_PATH
    generator = ROOT / SCRIPT_PATH
    return {
        "schema": "windows-itunes-itl.filesystem-publication-threat-model.v1",
        "status": "completed_bounded_offline_linux_campaign",
        "production_baseline_commit": BASE_COMMIT,
        "production_source": {"path": SOURCE_PATH, "sha256": sha256(source.read_bytes())},
        "generator": {"path": SCRIPT_PATH, "sha256": sha256(generator.read_bytes())},
        "bounds": {
            "actual_process_crashes": 0,
            "case_scenarios": len(cases),
            "hostile_directory_safety_claims": 0,
            "native_itunes_operations": 0,
            "power_loss_operations": 0,
            "scratch_root_policy": "fresh absolute path resolving below /tmp; removed by CLI",
        },
        "methodology": {
            "case_counts_are_independent_experiments": False,
            "normalization": "no timestamps, host paths, runner names, kernel versions, or random temporary names",
            "native_direct": "unmodified production calls using the scratch filesystem",
            "scheduler_assisted_native_syscall": "Python hooks control interleaving only; reported rename, symlink, mkdir, write, and link outcomes use real Linux syscalls",
            "fault_injection": "Python substitution at one documented I/O boundary; not a hostile-filesystem safety claim",
            "repeated_cases_and_controls_are_independent": False,
        },
        "summary": {
            "category_counts": category_counts,
            "scope_counts": scope_counts,
            "unexpected_anomalies": 0,
            "production_code_changed": False,
            "production_change_warranted": False,
        },
        "observed_guarantees": [
            "With a stable parent pathname, existing regular files, hard links, symlinks, dangling symlinks, and a destination created before link publication were not replaced.",
            "Two synchronized publishers produced one complete winner and one EEXIST refusal; no merged destination was observed.",
            "Injected write, short-write, flush, fsync, close, and hard-link failures occurred before publication and left no destination when ordinary cleanup succeeded.",
            "A cleanup failure before publication retained the primary error and annotated it; a cleanup failure after publication raised an explicit complete-publication error while preserving the complete destination.",
            "A stable parent symlink and a lexical parent alias resolved to one destination and cleaned the sibling temporary file in these bounded cases.",
        ],
        "observed_limits": [
            "Renaming the parent away before link publication caused ENOENT and left the complete temporary file in the displaced directory.",
            "Replacing a parent directory or retargeting a parent symlink while spoofing the random temporary basename allowed the pathname-based link step to publish spoof bytes while the requested complete temporary remained in the original directory.",
            "These parent replacement cases are deterministic witnesses for the existing hostile-directory disclaimer, not a claim that all adversarial schedules were explored.",
            "The campaign did not interrupt a process, cut power, exercise network filesystems, or verify directory-entry durability; file fsync alone does not answer those questions.",
            "A filesystem that refuses hard links remains unsupported and fails closed in the injected boundary case; no rename fallback was observed.",
        ],
        "integration_recommendation": "Retain the trusted/stable parent-directory and power-loss disclaimers, keep U-17 open, and integrate this research-only audit without changing production publication code.",
        "cases": cases,
    }


def write_report(path: Path, report: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8", newline="\n")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch-root", required=True, type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    scratch = prepare_new_scratch_root(args.scratch_root)
    try:
        report = run_campaign(scratch)
    finally:
        shutil.rmtree(scratch)
    text = json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    if args.output is None:
        sys.stdout.write(text)
    else:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8", newline="\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
