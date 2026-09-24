#!/usr/bin/env python3
"""Deterministic Windows/NTFS audit for ``itlkit.io.write_new``.

All filesystem objects are synthetic and live below a caller-supplied fresh
runner-temporary root. Direct observations, scheduling hooks around real
Windows syscalls, injected failures, unavailable cases, and explicit child
termination are accounted separately. Retained output omits absolute paths,
random temporary names, PIDs, timestamps, runner IDs, and volume serials.
"""
from __future__ import annotations

import argparse
from concurrent.futures import ThreadPoolExecutor
import ctypes
from ctypes import wintypes
import errno
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
import tempfile
from threading import Barrier
import time
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
BASE_COMMIT = "c9f271d36a7095262c6195c04eb7f09d6cf88dee"
SCRIPT_PATH = "scripts/research/audit_windows_filesystem_publication_20260925.py"
SOURCE_PATH = "itlkit/io.py"
PAYLOAD = (b"itlkit-u17-windows-complete-publication-payload\n" * 17) + b"end\n"
PAYLOAD_A = b"A" * 65537
PAYLOAD_B = b"B" * 65537
EXISTING = b"preexisting-destination\n"
RACER = b"racing-writer-owned-destination\n"
SPOOF = b"hostile-parent-spoof\n"
TERMINATE_EXIT_CODE = 0x66

WINERROR_NAMES = {
    2: "ERROR_FILE_NOT_FOUND",
    3: "ERROR_PATH_NOT_FOUND",
    5: "ERROR_ACCESS_DENIED",
    80: "ERROR_FILE_EXISTS",
    87: "ERROR_INVALID_PARAMETER",
    183: "ERROR_ALREADY_EXISTS",
    1314: "ERROR_PRIVILEGE_NOT_HELD",
}

sys.path.insert(0, str(ROOT))
import itlkit.io as output  # noqa: E402


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def file_state(path: Path) -> dict[str, object]:
    if not os.path.lexists(path):
        return {"kind": "absent"}
    if path.is_symlink():
        return {"kind": "symlink"}
    if path.is_file():
        data = path.read_bytes()
        return {"kind": "regular", "bytes": len(data), "sha256": sha256(data)}
    if path.is_dir():
        return {"kind": "directory"}
    return {"kind": "other"}


def error_state(exc: BaseException) -> dict[str, object]:
    number = getattr(exc, "errno", None)
    winerror = getattr(exc, "winerror", None)
    return {
        "type": type(exc).__name__,
        "errno": number,
        "errno_name": errno.errorcode.get(number) if isinstance(number, int) else None,
        "winerror": winerror,
        "winerror_name": WINERROR_NAMES.get(winerror) if isinstance(winerror, int) else None,
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
        "status": "executed",
        "category": category,
        "claim_scope": claim_scope,
        "observed": observed,
    }


def unavailable_record(
    case_id: str,
    intended_category: str,
    capability: str,
    capability_result: dict[str, object],
) -> dict[str, object]:
    return {
        "id": case_id,
        "status": "unavailable",
        "category": "unavailable",
        "intended_category": intended_category,
        "claim_scope": "unavailable_on_observed_runner",
        "observed": {
            "required_capability": capability,
            "capability_probe": capability_result,
        },
    }


def create_junction(link: Path, target: Path) -> None:
    completed = subprocess.run(
        ["cmd.exe", "/d", "/c", "mklink", "/J", str(link), str(target)],
        stdin=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        errors="replace",
        check=False,
    )
    if completed.returncode != 0:
        raise OSError(errno.EPERM, f"mklink /J failed with exit {completed.returncode}")


def probe_capabilities(root: Path) -> dict[str, dict[str, object]]:
    directory = new_case(root, "_capability_probe")
    source = directory / "source"
    source.write_bytes(b"capability-probe")
    real_directory = directory / "real-directory"
    real_directory.mkdir()

    results: dict[str, dict[str, object]] = {}

    def attempt(name: str, action, cleanup) -> None:
        try:
            action()
        except OSError as exc:
            results[name] = {"available": False, "error": error_state(exc)}
        else:
            results[name] = {"available": True}
            cleanup()

    hardlink = directory / "hardlink"
    attempt("hard_link", lambda: os.link(source, hardlink), lambda: hardlink.unlink())

    file_symlink = directory / "file-symlink"
    attempt(
        "file_symlink",
        lambda: file_symlink.symlink_to(source.name),
        lambda: file_symlink.unlink(),
    )

    dangling = directory / "dangling-symlink"
    attempt(
        "dangling_symlink",
        lambda: dangling.symlink_to("missing"),
        lambda: dangling.unlink(),
    )

    directory_symlink = directory / "directory-symlink"
    attempt(
        "directory_symlink",
        lambda: directory_symlink.symlink_to(real_directory, target_is_directory=True),
        lambda: directory_symlink.unlink(),
    )

    junction = directory / "junction"
    attempt(
        "directory_junction",
        lambda: create_junction(junction, real_directory),
        lambda: junction.rmdir(),
    )

    shutil.rmtree(directory)
    return results


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
        "destination_link_count_after_cleanup": destination.stat().st_nlink,
        "temporary_count": 0,
    })


def case_existing_regular(root: Path) -> dict[str, object]:
    case_id = "existing_regular_refused"
    directory = new_case(root, case_id)
    destination = directory / "out"
    destination.write_bytes(EXISTING)
    returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    assert not returned and error and error["errno"] == errno.EEXIST
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
    assert os.path.samefile(source, destination)
    assert temporary_files(directory) == []
    return record(case_id, "native_direct", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "alias_unchanged": True,
        "same_file_identity": True,
        "link_count": source.stat().st_nlink,
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
    assert destination.is_symlink() and victim.read_bytes() == EXISTING
    assert temporary_files(directory) == []
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
    observed = {
        "returned": True,
        "destination_matches_payload": True,
        "alias_and_real_destination_same_file_identity": True,
        "temporary_count": 0,
    }
    alias_parent.unlink()
    return record(case_id, "native_direct", "stable_directory_model", observed)


def case_stable_parent_junction(root: Path) -> dict[str, object]:
    case_id = "stable_parent_junction_success"
    directory = new_case(root, case_id)
    real_parent = directory / "real-parent"
    alias_parent = directory / "alias-parent"
    real_parent.mkdir()
    create_junction(alias_parent, real_parent)
    destination = alias_parent / "out"
    output.write_new(destination, PAYLOAD)
    real_destination = real_parent / "out"
    assert destination.read_bytes() == PAYLOAD == real_destination.read_bytes()
    assert os.path.samefile(destination, real_destination)
    assert temporary_files(real_parent) == []
    observed = {
        "returned": True,
        "destination_matches_payload": True,
        "alias_and_real_destination_same_file_identity": True,
        "alias_kind": "NTFS_directory_junction",
        "temporary_count": 0,
    }
    alias_parent.rmdir()
    return record(case_id, "native_direct", "stable_directory_model", observed)


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
        "lexical_and_canonical_destination_same_file_identity": True,
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
    return record(case_id, "fault_injection", "stable_directory_model", {
        "returned": returned,
        "error": error,
        "message_identifies_complete_publication": True,
        "destination_matches_payload": True,
        "retained_temporary_matches_payload": True,
        "destination_and_temporary_same_file_identity": True,
        "link_count": destination.stat().st_nlink,
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
    observed = {
        "returned": returned,
        "destination_matches_requested_payload": False,
        "destination_matches_spoof": True,
        "retargeted_parent_temporary_count": 0,
        "original_parent_complete_temporary_count": 1,
        "original_temporary_matches_payload": True,
        "schedule_hook_only": True,
        "symlink_write_and_link_syscalls_were_native": True,
    }
    alias.unlink()
    return record(case_id, "scheduler_assisted_native_syscall", "documented_out_of_model_limit", observed)


def case_parent_junction_retarget(root: Path) -> dict[str, object]:
    case_id = "parent_junction_retarget_can_publish_spoof"
    directory = new_case(root, case_id)
    first = directory / "first-parent"
    second = directory / "second-parent"
    alias = directory / "parent-alias"
    first.mkdir()
    second.mkdir()
    create_junction(alias, first)
    destination = alias / "out"
    real_link = os.link

    def retarget_then_link(source, target, *args, **kwargs):
        alias.rmdir()
        create_junction(alias, second)
        (second / Path(source).name).write_bytes(SPOOF)
        return real_link(source, target, *args, **kwargs)

    with patch.object(output.os, "link", retarget_then_link):
        returned, error, _ = invoke(lambda: output.write_new(destination, PAYLOAD))
    first_temps = temporary_files(first)
    assert returned and error is None
    assert destination.read_bytes() == SPOOF and destination.read_bytes() != PAYLOAD
    assert temporary_files(second) == [] and len(first_temps) == 1
    assert first_temps[0].read_bytes() == PAYLOAD
    observed = {
        "returned": returned,
        "destination_matches_requested_payload": False,
        "destination_matches_spoof": True,
        "retargeted_parent_temporary_count": 0,
        "original_parent_complete_temporary_count": 1,
        "original_temporary_matches_payload": True,
        "alias_kind": "NTFS_directory_junction",
        "schedule_hook_only": True,
        "junction_retarget_write_and_link_operations_were_native": True,
    }
    alias.rmdir()
    return record(case_id, "scheduler_assisted_native_syscall", "documented_out_of_model_limit", observed)


def _child_wait_forever(ready: Path) -> None:
    ready.write_bytes(b"ready\n")
    while True:
        time.sleep(60)


def child_boundary(boundary: str, parent: Path, ready: Path) -> int:
    destination = parent / "out"
    if boundary == "before_link":
        def blocked_link(*_args, **_kwargs):
            _child_wait_forever(ready)
        with patch.object(output.os, "link", blocked_link):
            output.write_new(destination, PAYLOAD)
    elif boundary == "after_link_before_cleanup":
        real_unlink = Path.unlink

        def blocked_unlink(self: Path, *args, **kwargs):
            if self.name.startswith(".out.itlkit-") and self.name.endswith(".tmp"):
                _child_wait_forever(ready)
            return real_unlink(self, *args, **kwargs)

        with patch.object(Path, "unlink", blocked_unlink):
            output.write_new(destination, PAYLOAD)
    else:
        raise ValueError(f"unsupported child boundary: {boundary}")
    raise AssertionError("child boundary unexpectedly resumed")


def terminate_child_at_boundary(root: Path, boundary: str) -> dict[str, object]:
    case_id = f"terminate_process_{boundary}"
    directory = new_case(root, case_id)
    parent = directory / "parent"
    parent.mkdir()
    ready = directory / "ready.signal"
    process = subprocess.Popen(
        [
            sys.executable,
            "-B",
            str(Path(__file__).resolve()),
            "--child-boundary",
            boundary,
            "--child-parent",
            str(parent),
            "--child-ready",
            str(ready),
        ],
        stdin=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    deadline = time.monotonic() + 20
    while not ready.exists():
        code = process.poll()
        if code is not None:
            stderr = process.stderr.read() if process.stderr is not None else ""
            raise RuntimeError(f"child exited before boundary with {code}: {stderr[-1000:]}")
        if time.monotonic() >= deadline:
            process.kill()
            process.wait(timeout=10)
            raise TimeoutError(f"child did not reach {boundary}")
        time.sleep(0.02)

    kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
    kernel32.TerminateProcess.argtypes = [wintypes.HANDLE, wintypes.UINT]
    kernel32.TerminateProcess.restype = wintypes.BOOL
    if not kernel32.TerminateProcess(wintypes.HANDLE(int(process._handle)), TERMINATE_EXIT_CODE):
        raise ctypes.WinError(ctypes.get_last_error())
    returncode = process.wait(timeout=10)
    if process.stderr is not None:
        process.stderr.close()
    assert returncode == TERMINATE_EXIT_CODE
    ready.unlink()

    destination = parent / "out"
    temps = temporary_files(parent)
    assert len(temps) == 1 and temps[0].read_bytes() == PAYLOAD
    if boundary == "before_link":
        assert not destination.exists()
        observed = {
            "explicit_boundary": "after_payload_fsync_and_stream_close_before_link_call",
            "destination_absent": True,
            "retained_complete_temporary_count": 1,
            "retained_temporary_matches_payload": True,
            "native_link_calls_before_termination": 0,
        }
    else:
        assert destination.read_bytes() == PAYLOAD
        assert os.path.samefile(destination, temps[0])
        observed = {
            "explicit_boundary": "after_native_link_before_temporary_unlink",
            "destination_matches_payload": True,
            "retained_complete_temporary_count": 1,
            "retained_temporary_matches_payload": True,
            "destination_and_temporary_same_file_identity": True,
            "link_count": destination.stat().st_nlink,
            "native_link_calls_before_termination": 1,
        }
    observed.update({
        "parent_called_win32_TerminateProcess": True,
        "child_reaped": True,
        "termination_exit_code": TERMINATE_EXIT_CODE,
        "power_loss_operation": False,
        "linux_SIGKILL_operation": False,
    })
    return record(case_id, "actual_process_termination", "stable_directory_model", observed)


def volume_info(path: Path) -> dict[str, object]:
    kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
    volume_path = ctypes.create_unicode_buffer(32768)
    if not kernel32.GetVolumePathNameW(str(path), volume_path, len(volume_path)):
        raise ctypes.WinError(ctypes.get_last_error())
    serial = wintypes.DWORD()
    maximum_component_length = wintypes.DWORD()
    flags = wintypes.DWORD()
    filesystem_name = ctypes.create_unicode_buffer(261)
    if not kernel32.GetVolumeInformationW(
        volume_path.value,
        None,
        0,
        ctypes.byref(serial),
        ctypes.byref(maximum_component_length),
        ctypes.byref(flags),
        filesystem_name,
        len(filesystem_name),
    ):
        raise ctypes.WinError(ctypes.get_last_error())
    return {
        "query_api": "GetVolumePathNameW+GetVolumeInformationW",
        "filesystem_name": filesystem_name.value,
        "maximum_component_length": maximum_component_length.value,
        "supports_hard_links_flag": bool(flags.value & 0x00400000),
        "supports_reparse_points_flag": bool(flags.value & 0x00000080),
        "supports_posix_unlink_rename_flag": bool(flags.value & 0x00000400),
        "volume_path_and_serial_retained": False,
    }


def platform_info(path: Path) -> dict[str, object]:
    return {
        "os_name": os.name,
        "sys_platform": sys.platform,
        "system": platform.system(),
        "release": platform.release(),
        "version": platform.version(),
        "machine": platform.machine(),
        "python_implementation": platform.python_implementation(),
        "python_version": platform.python_version(),
        "filesystem": volume_info(path),
        "qualification": "one GitHub-hosted Windows runner temporary volume; not universal Windows or NTFS behavior",
    }


def _is_below(candidate: Path, parent: Path) -> bool:
    candidate_text = os.path.normcase(str(candidate))
    parent_text = os.path.normcase(str(parent))
    try:
        common = os.path.commonpath([candidate_text, parent_text])
    except ValueError:
        # Windows paths on different drives cannot share a common path.
        return False
    return common == parent_text and candidate_text != parent_text


def validate_existing_scratch_root(path: Path) -> Path:
    if not path.is_absolute():
        raise ValueError("scratch root must be absolute")
    resolved = path.resolve(strict=True)
    runner_temp = Path(tempfile.gettempdir()).resolve(strict=True)
    if not _is_below(resolved, runner_temp):
        raise ValueError("scratch root must resolve below tempfile.gettempdir()")
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
    runner_temp = Path(tempfile.gettempdir()).resolve(strict=True)
    candidate = unresolved_parent / path.name
    if not _is_below(candidate, runner_temp):
        raise ValueError("scratch root must resolve below tempfile.gettempdir()")
    path.mkdir()
    return validate_existing_scratch_root(path)


def run_campaign(scratch_root: Path) -> dict[str, object]:
    if os.name != "nt" or sys.platform != "win32":
        raise RuntimeError("this retained campaign is Windows-specific")
    root = validate_existing_scratch_root(Path(scratch_root))
    environment = platform_info(root)
    capabilities = probe_capabilities(root)
    if not capabilities["hard_link"]["available"]:
        raise RuntimeError("native hard links are required for this campaign")

    cases: list[dict[str, object]] = [
        case_new_destination(root),
        case_existing_regular(root),
        case_existing_hardlink(root),
    ]
    cases.append(
        case_existing_symlink(root)
        if capabilities["file_symlink"]["available"]
        else unavailable_record("existing_symlink_alias_refused", "native_direct", "file_symlink", capabilities["file_symlink"])
    )
    cases.append(
        case_existing_dangling_symlink(root)
        if capabilities["dangling_symlink"]["available"]
        else unavailable_record("existing_dangling_symlink_refused", "native_direct", "dangling_symlink", capabilities["dangling_symlink"])
    )
    cases.append(
        case_stable_parent_symlink(root)
        if capabilities["directory_symlink"]["available"]
        else unavailable_record("stable_parent_symlink_success", "native_direct", "directory_symlink", capabilities["directory_symlink"])
    )
    cases.append(
        case_stable_parent_junction(root)
        if capabilities["directory_junction"]["available"]
        else unavailable_record("stable_parent_junction_success", "native_direct", "directory_junction", capabilities["directory_junction"])
    )
    cases.extend([
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
    ])
    cases.append(
        case_parent_symlink_retarget(root)
        if capabilities["directory_symlink"]["available"]
        else unavailable_record(
            "parent_symlink_retarget_can_publish_spoof",
            "scheduler_assisted_native_syscall",
            "directory_symlink",
            capabilities["directory_symlink"],
        )
    )
    cases.append(
        case_parent_junction_retarget(root)
        if capabilities["directory_junction"]["available"]
        else unavailable_record(
            "parent_junction_retarget_can_publish_spoof",
            "scheduler_assisted_native_syscall",
            "directory_junction",
            capabilities["directory_junction"],
        )
    )
    cases.extend([
        terminate_child_at_boundary(root, "before_link"),
        terminate_child_at_boundary(root, "after_link_before_cleanup"),
    ])

    executed = [case for case in cases if case["status"] == "executed"]
    unavailable = [case for case in cases if case["status"] == "unavailable"]
    categories = (
        "native_direct",
        "scheduler_assisted_native_syscall",
        "fault_injection",
        "actual_process_termination",
    )
    category_counts = {
        category: sum(case["category"] == category for case in executed)
        for category in categories
    }
    scope_counts = {
        scope: sum(case["claim_scope"] == scope for case in executed)
        for scope in ("stable_directory_model", "documented_out_of_model_limit")
    }
    unavailable_by_intended_category = {
        category: sum(case.get("intended_category") == category for case in unavailable)
        for category in categories
    }

    source = ROOT / SOURCE_PATH
    generator = ROOT / SCRIPT_PATH
    return {
        "schema": "windows-itunes-itl.windows-filesystem-publication-audit.v1",
        "status": "completed_bounded_windows_ntfs_campaign",
        "repository_baseline_commit": BASE_COMMIT,
        "production_source": {"path": SOURCE_PATH, "sha256": sha256(source.read_bytes())},
        "generator": {"path": SCRIPT_PATH, "sha256": sha256(generator.read_bytes())},
        "environment": environment,
        "capabilities": capabilities,
        "bounds": {
            "case_scenarios": len(cases),
            "executed_case_scenarios": len(executed),
            "unavailable_case_scenarios": len(unavailable),
            "actual_process_termination_scenarios": category_counts["actual_process_termination"],
            "uncontrolled_process_crashes": 0,
            "power_loss_operations": 0,
            "native_itunes_operations": 0,
            "hostile_directory_safety_claims": 0,
            "network_filesystem_operations": 0,
            "scratch_root_policy": "fresh absolute path resolving below tempfile.gettempdir(); removed by CLI",
        },
        "methodology": {
            "case_counts_are_independent_experiments": False,
            "competing_publishers_are_independent_experiments": False,
            "repetitions_and_controls_are_independent_experiments": False,
            "normalization": "no timestamps, absolute paths, random temporary names, PIDs, runner IDs, or volume serials",
            "native_direct": "unmodified production calls on the observed Windows temporary NTFS volume",
            "scheduler_assisted_native_syscall": "Python hooks control interleaving only; reported Windows rename, reparse-point, mkdir, write, and link outcomes use real operations",
            "fault_injection": "Python substitution at one documented I/O boundary; not a native failure-frequency or hostile-directory claim",
            "actual_process_termination": "the parent observed an explicit boundary, called Win32 TerminateProcess with exit code 0x66, and reaped the child; this is neither Linux SIGKILL nor power loss",
            "unavailable": "capability was probed directly and the case is retained as unavailable rather than passed or silently skipped",
        },
        "summary": {
            "category_counts": category_counts,
            "scope_counts": scope_counts,
            "unavailable_by_intended_category": unavailable_by_intended_category,
            "unexpected_anomalies": 0,
            "production_code_changed": False,
            "production_change_warranted": False,
        },
        "observed_guarantees": [
            "On this Windows Server 2025 / CPython 3.12.10 / NTFS runner, stable-parent existing destinations and available hard-link, symlink, dangling-symlink, junction, and lexical aliases were not replaced in the listed direct cases.",
            "A destination created immediately before the real os.link call won with EEXIST, and two synchronized publishers produced one complete winner and one EEXIST refusal.",
            "Injected write, short-write, flush, file-fsync, close, and hard-link failures occurred before publication and left no destination when ordinary cleanup succeeded.",
            "Injected cleanup failures preserved the primary pre-publication error or reported that a complete destination had already been published.",
            "Parent-triggered TerminateProcess before link retained one complete temporary with no destination; termination after the real link but before cleanup retained one complete destination and its temporary hard-link alias.",
        ],
        "observed_limits": [
            "The observed NTFS volume permitted parent rename after stream close. Renaming the parent away before link produced a path-not-found result and left the complete temporary in the displaced directory.",
            "The observed NTFS volume permitted parent directory replacement, directory-symlink retargeting, and junction retargeting at the scheduled boundary; spoofing the temporary basename then allowed spoof bytes to be linked while the requested complete temporary remained in the original directory.",
            "These are bounded real-operation witnesses for the trusted/stable-parent precondition, not hostile-directory safety coverage or universal Windows/NTFS behavior.",
            "The campaign did not cut power, test directory-entry durability, exercise a network filesystem, launch iTunes, use COM/UI/media import, or test native iTunes acceptance.",
            "Explicit TerminateProcess observations are process-termination evidence only; they are not Linux SIGKILL evidence and do not model power loss.",
        ],
        "integration_recommendation": "Retain this Windows-specific corroborating audit without changing production publication code; preserve the trusted/stable-parent disclaimer, keep U-17 open, and do not generalize these observations beyond the exact runner/runtime/NTFS qualification.",
        "cases": cases,
    }


def write_report(path: Path, report: dict[str, object]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch-root", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--child-boundary", choices=("before_link", "after_link_before_cleanup"), help=argparse.SUPPRESS)
    parser.add_argument("--child-parent", type=Path, help=argparse.SUPPRESS)
    parser.add_argument("--child-ready", type=Path, help=argparse.SUPPRESS)
    args = parser.parse_args()

    if args.child_boundary is not None:
        if args.child_parent is None or args.child_ready is None:
            parser.error("child mode requires --child-parent and --child-ready")
        return child_boundary(args.child_boundary, args.child_parent, args.child_ready)

    if args.scratch_root is None:
        parser.error("--scratch-root is required")
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
