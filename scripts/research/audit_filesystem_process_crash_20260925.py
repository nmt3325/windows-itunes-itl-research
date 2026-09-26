#!/usr/bin/env python3
"""Bounded Linux process-termination campaign for ``itlkit.io.write_new``.

The parent starts a real child process for each case, waits for one explicit
pipe event with a timeout, and sends SIGKILL in the four crash cases.  The child
uses the production ``write_new`` function unchanged.  Hooks exist only in the
child to stop execution at named boundaries; the partial-write hook performs a
real prefix write and flush before stopping inside the production stream.write
call.  Every payload and filesystem object is synthetic and below a fresh
caller-supplied /tmp root.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import select
import shutil
import signal
import stat
import subprocess
import sys
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
BASE_COMMIT = "c9f271d36a7095262c6195c04eb7f09d6cf88dee"
SCRIPT_PATH = "scripts/research/audit_filesystem_process_crash_20260925.py"
SOURCE_PATH = "itlkit/io.py"
PAYLOAD = (b"itlkit-u17-linux-process-crash-payload\n" * 2048) + b"end\n"
PARTIAL_BYTES = 4097
EVENT_TIMEOUT_SECONDS = 15.0
REAP_TIMEOUT_SECONDS = 10.0
CRASH_STAGES = (
    "after_temp_create_before_write",
    "after_partial_write_flush_before_publication",
    "after_complete_fsync_close_before_link",
    "after_native_link_before_cleanup",
)
CONTROL_STAGE = "normal_completion_control"
ALL_STAGES = (*CRASH_STAGES, CONTROL_STAGE)

sys.path.insert(0, str(ROOT))
import itlkit.io as output  # noqa: E402


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def regular_file_state(path: Path) -> dict[str, object]:
    data = path.read_bytes()
    metadata = path.stat()
    return {
        "kind": "regular",
        "normalized_path": "destination" if path.name == "out" else "temporary[0]",
        "bytes": len(data),
        "sha256": sha256(data),
        "link_count": metadata.st_nlink,
        "mode": stat.filemode(metadata.st_mode),
    }


def destination_state(path: Path) -> dict[str, object]:
    if not os.path.lexists(path):
        return {"kind": "absent", "normalized_path": "destination"}
    if not path.is_file() or path.is_symlink():
        raise AssertionError("campaign destination was not a regular file")
    return regular_file_state(path)


def temporary_files(directory: Path) -> list[Path]:
    return sorted(directory.glob(".out.itlkit-*.tmp"))


def emit_event(event_fd: int, stage: str, boundary: str, **details: object) -> None:
    event = {"event": "boundary_reached", "stage": stage, "boundary": boundary, **details}
    encoded = (json.dumps(event, sort_keys=True, separators=(",", ":")) + "\n").encode("utf-8")
    if len(encoded) >= 4096:
        raise AssertionError("event must fit in one atomic pipe write")
    if os.write(event_fd, encoded) != len(encoded):
        raise OSError("short event-pipe write")


def pause_after_event(event_fd: int, stage: str, boundary: str, **details: object) -> None:
    emit_event(event_fd, stage, boundary, **details)
    signal.pause()
    raise AssertionError("crash-stage child resumed instead of being killed")


class PartialWritePauseStream:
    """Pause inside the production stream.write call after real prefix I/O."""

    def __init__(self, inner, event_fd: int, stage: str):
        self.inner = inner
        self.event_fd = event_fd
        self.stage = stage

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, traceback):
        return self.inner.__exit__(exc_type, exc, traceback)

    def __getattr__(self, name):
        return getattr(self.inner, name)

    def write(self, data: bytes) -> int:
        if len(data) <= PARTIAL_BYTES:
            raise AssertionError("synthetic payload is too small for a partial write")
        written = self.inner.write(data[:PARTIAL_BYTES])
        if written != PARTIAL_BYTES:
            raise OSError("unexpected short prefix write in scheduling hook")
        self.inner.flush()
        pause_after_event(
            self.event_fd,
            self.stage,
            "inside_stream_write_after_real_prefix_write_and_flush",
            real_prefix_bytes=PARTIAL_BYTES,
            real_flush_completed=True,
            production_payload_helper_entered=True,
        )
        raise AssertionError("unreachable")


def child_case(stage: str, event_fd: int, case_directory: Path) -> int:
    if stage not in ALL_STAGES:
        raise ValueError(f"unknown stage: {stage}")
    if not case_directory.is_absolute() or not case_directory.is_dir():
        raise ValueError("child case directory must be an existing absolute directory")
    destination = case_directory / "out"

    if stage == "after_temp_create_before_write":
        real_fdopen = output.os.fdopen

        def pause_before_fdopen(fd, *args, **kwargs):
            pause_after_event(
                event_fd,
                stage,
                "after_native_mkstemp_before_fdopen_and_payload_write",
                native_temporary_creation_completed=True,
                payload_write_started=False,
            )
            return real_fdopen(fd, *args, **kwargs)

        with patch.object(output.os, "fdopen", pause_before_fdopen):
            output.write_new(destination, PAYLOAD)

    elif stage == "after_partial_write_flush_before_publication":
        real_fdopen = output.os.fdopen

        def wrap_fdopen(fd, *args, **kwargs):
            return PartialWritePauseStream(real_fdopen(fd, *args, **kwargs), event_fd, stage)

        with patch.object(output.os, "fdopen", wrap_fdopen):
            output.write_new(destination, PAYLOAD)

    elif stage == "after_complete_fsync_close_before_link":
        real_link = output.os.link

        def pause_before_link(source, target, *args, **kwargs):
            pause_after_event(
                event_fd,
                stage,
                "after_complete_write_flush_fsync_close_before_native_link",
                native_link_completed=False,
                production_payload_helper_returned=True,
            )
            return real_link(source, target, *args, **kwargs)

        with patch.object(output.os, "link", pause_before_link):
            output.write_new(destination, PAYLOAD)

    elif stage == "after_native_link_before_cleanup":
        real_link = output.os.link

        def pause_after_link(source, target, *args, **kwargs):
            result = real_link(source, target, *args, **kwargs)
            pause_after_event(
                event_fd,
                stage,
                "after_native_hard_link_commit_before_return_and_cleanup",
                native_link_completed=True,
                production_cleanup_started=False,
            )
            return result

        with patch.object(output.os, "link", pause_after_link):
            output.write_new(destination, PAYLOAD)

    else:
        output.write_new(destination, PAYLOAD)
        emit_event(
            event_fd,
            stage,
            "after_unmodified_write_new_returned",
            native_link_completed=True,
            production_cleanup_completed=True,
        )
    return 0


def read_event(read_fd: int, timeout_seconds: float) -> dict[str, object]:
    ready, _, _ = select.select([read_fd], [], [], timeout_seconds)
    if not ready:
        raise TimeoutError(f"child did not reach boundary within {timeout_seconds:g} seconds")
    data = os.read(read_fd, 4096)
    if not data:
        raise RuntimeError("child event pipe closed before a boundary event")
    if not data.endswith(b"\n") or data.count(b"\n") != 1:
        raise RuntimeError("child emitted a malformed or non-atomic event")
    event = json.loads(data.decode("utf-8"))
    if not isinstance(event, dict):
        raise RuntimeError("child event was not an object")
    return event


def count_child_fds_for_file(pid: int, path: Path) -> int:
    target = path.stat()
    matches = 0
    for descriptor in (Path("/proc") / str(pid) / "fd").iterdir():
        try:
            descriptor_state = descriptor.stat()
        except FileNotFoundError:
            continue
        if (descriptor_state.st_dev, descriptor_state.st_ino) == (target.st_dev, target.st_ino):
            matches += 1
    return matches


def reap_process(process: subprocess.Popen[bytes]) -> tuple[int, bytes, bytes]:
    try:
        stdout, stderr = process.communicate(timeout=REAP_TIMEOUT_SECONDS)
    except subprocess.TimeoutExpired:
        process.kill()
        stdout, stderr = process.communicate(timeout=REAP_TIMEOUT_SECONDS)
        raise TimeoutError("child did not exit and reap within the deadline")
    if process.returncode is None:
        raise AssertionError("communicate returned without reaping the child")
    return process.returncode, stdout, stderr


def terminate_after_boundary(process: subprocess.Popen[bytes]) -> dict[str, object]:
    if process.poll() is not None:
        _returncode, stdout, stderr = reap_process(process)
        raise AssertionError(
            f"crash-stage child exited before SIGKILL: stdout={stdout!r} stderr={stderr!r}"
        )
    os.kill(process.pid, signal.SIGKILL)
    returncode, stdout, stderr = reap_process(process)
    if stdout or stderr:
        raise AssertionError(f"crash-stage child emitted output: stdout={stdout!r} stderr={stderr!r}")
    if returncode != -signal.SIGKILL:
        raise AssertionError(f"child return code {returncode} did not prove SIGKILL termination")
    return {
        "parent_sent_signal": "SIGKILL",
        "signal_number": signal.SIGKILL,
        "child_returncode": returncode,
        "child_died_by_signal": True,
        "child_exited_normally": False,
        "parent_reaped_child": True,
    }


def process_command(stage: str, event_fd: int, case_directory: Path) -> list[str]:
    return [
        sys.executable,
        "-B",
        str(Path(__file__).resolve()),
        "--_child-stage",
        stage,
        "--_event-fd",
        str(event_fd),
        "--_case-directory",
        str(case_directory),
    ]


def case_metadata(stage: str) -> tuple[str, str]:
    if stage == "after_temp_create_before_write":
        return (
            "actual_process_crash",
            "os.fdopen wrapper pauses after native temporary creation and before any payload write",
        )
    if stage == "after_partial_write_flush_before_publication":
        return (
            "actual_process_crash",
            "stream wrapper performs one real prefix write and flush, then pauses inside production stream.write",
        )
    if stage == "after_complete_fsync_close_before_link":
        return (
            "actual_process_crash",
            "os.link wrapper pauses before the native link after production write, flush, fsync, and close",
        )
    if stage == "after_native_link_before_cleanup":
        return (
            "actual_process_crash",
            "os.link wrapper performs the real hard-link commit, then pauses before returning to production cleanup",
        )
    return ("normal_completion_control", "no scheduling hook")


def run_process_case(root: Path, stage: str) -> dict[str, object]:
    category, hook_mechanics = case_metadata(stage)
    case_directory = root / stage
    case_directory.mkdir()
    destination = case_directory / "out"
    read_fd, write_fd = os.pipe()
    process: subprocess.Popen[bytes] | None = None
    try:
        environment = dict(os.environ)
        environment.update({"PYTHONDONTWRITEBYTECODE": "1", "PYTHONIOENCODING": "utf-8"})
        process = subprocess.Popen(
            process_command(stage, write_fd, case_directory),
            cwd=ROOT,
            env=environment,
            stdin=subprocess.DEVNULL,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            pass_fds=(write_fd,),
        )
        os.close(write_fd)
        write_fd = -1
        try:
            event = read_event(read_fd, EVENT_TIMEOUT_SECONDS)
        except BaseException:
            if process.poll() is None:
                process.kill()
            returncode, stdout, stderr = reap_process(process)
            raise RuntimeError(
                f"failed waiting for {stage}: returncode={returncode} stdout={stdout!r} stderr={stderr!r}"
            )
        if event.get("event") != "boundary_reached" or event.get("stage") != stage:
            raise AssertionError(f"unexpected child event: {event!r}")

        if stage in CRASH_STAGES:
            if process.poll() is not None:
                returncode, stdout, stderr = reap_process(process)
                raise AssertionError(
                    f"child did not remain paused: returncode={returncode} stdout={stdout!r} stderr={stderr!r}"
                )
            temporaries = temporary_files(case_directory)
            if len(temporaries) != 1:
                raise AssertionError(f"expected one temporary at boundary, found {len(temporaries)}")
            temporary = temporaries[0]
            boundary_observation = {
                "child_alive_and_paused": True,
                "destination": destination_state(destination),
                "temporary": regular_file_state(temporary),
                "child_open_fd_count_for_temporary": count_child_fds_for_file(process.pid, temporary),
            }
            termination = terminate_after_boundary(process)
            retained_temporaries = temporary_files(case_directory)
            if len(retained_temporaries) != 1:
                raise AssertionError(
                    f"expected one retained temporary after process crash, found {len(retained_temporaries)}"
                )
            retained_temporary = retained_temporaries[0]
            retained = {
                "destination": destination_state(destination),
                "temporary_count": 1,
                "temporary": regular_file_state(retained_temporary),
                "temporary_retained_because_child_finally_did_not_run": True,
            }
            if os.path.lexists(destination):
                retained["destination_and_temporary_same_inode"] = os.path.samefile(
                    destination, retained_temporary
                )
        else:
            returncode, stdout, stderr = reap_process(process)
            if stdout or stderr:
                raise AssertionError(f"control child emitted output: stdout={stdout!r} stderr={stderr!r}")
            if returncode != 0:
                raise AssertionError(f"normal control child returned {returncode}")
            boundary_observation = {
                "event_after_write_new_returned": True,
                "destination": destination_state(destination),
                "temporary_count": len(temporary_files(case_directory)),
            }
            termination = {
                "parent_sent_signal": None,
                "signal_number": None,
                "child_returncode": returncode,
                "child_died_by_signal": False,
                "child_exited_normally": True,
                "parent_reaped_child": True,
            }
            retained = {
                "destination": destination_state(destination),
                "temporary_count": len(temporary_files(case_directory)),
                "production_cleanup_removed_temporary": temporary_files(case_directory) == [],
            }

        return {
            "id": stage,
            "category": category,
            "hook": {
                "used": stage in CRASH_STAGES,
                "mechanics": hook_mechanics,
                "production_write_new_source_changed": False,
                "production_write_new_invoked": True,
            },
            "boundary_event": event,
            "boundary_observation": boundary_observation,
            "termination": termination,
            "retained_after_reap": retained,
        }
    finally:
        if write_fd >= 0:
            os.close(write_fd)
        os.close(read_fd)
        if process is not None and process.poll() is None:
            process.kill()
            process.communicate(timeout=REAP_TIMEOUT_SECONDS)


def filesystem_facts(root: Path) -> dict[str, object]:
    def stat_field(format_string: str) -> str:
        completed = subprocess.run(
            ["stat", "-f", "-c", format_string, str(root)],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding="utf-8",
        )
        return completed.stdout.strip()

    mount_query = subprocess.run(
        ["findmnt", "-T", str(root), "-J", "-o", "FSTYPE,OPTIONS"],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
    )
    mount_rows = json.loads(mount_query.stdout).get("filesystems", [])
    if len(mount_rows) != 1:
        raise RuntimeError("findmnt did not identify exactly one backing filesystem")
    mount = mount_rows[0]
    statvfs = os.statvfs(root)
    libc_name, libc_version = platform.libc_ver()
    return {
        "operating_system": platform.system(),
        "kernel_release": platform.release(),
        "machine": platform.machine(),
        "python_implementation": platform.python_implementation(),
        "python_version": platform.python_version(),
        "python_optimization": sys.flags.optimize,
        "libc": f"{libc_name} {libc_version}".strip(),
        "mount_filesystem_type": mount["fstype"],
        "mount_options": sorted(mount["options"].split(",")),
        "filesystem_stat_type": stat_field("%T"),
        "filesystem_magic_hex": stat_field("%t"),
        "filesystem_block_size": statvfs.f_bsize,
        "filesystem_fragment_size": statvfs.f_frsize,
        "scope": "the one local filesystem backing the fresh /tmp campaign root",
    }


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
        raise FileExistsError("scratch root must be fresh")
    resolved_parent = path.parent.resolve(strict=True)
    tmp = Path("/tmp").resolve(strict=True)
    candidate = resolved_parent / path.name
    if candidate == tmp or tmp not in candidate.parents:
        raise ValueError("scratch root must resolve below /tmp")
    path.mkdir(mode=0o700)
    return validate_existing_scratch_root(path)


def build_report(scratch_root: Path) -> dict[str, object]:
    if not sys.platform.startswith("linux") or os.name != "posix":
        raise RuntimeError("this retained campaign is Linux/POSIX-specific")
    root = validate_existing_scratch_root(Path(scratch_root))
    environment = filesystem_facts(root)
    cases = [run_process_case(root, stage) for stage in ALL_STAGES]
    crash_cases = [case for case in cases if case["category"] == "actual_process_crash"]
    control_cases = [case for case in cases if case["category"] == "normal_completion_control"]
    if len(crash_cases) != 4 or len(control_cases) != 1:
        raise AssertionError("unexpected crash/control case arithmetic")
    if not all(case["termination"]["child_died_by_signal"] for case in crash_cases):
        raise AssertionError("a crash case did not prove signal termination")
    if not all(case["termination"]["signal_number"] == signal.SIGKILL for case in crash_cases):
        raise AssertionError("a crash case did not prove SIGKILL")

    stage1, stage2, stage3, stage4, control = cases
    full_hash = sha256(PAYLOAD)
    partial_hash = sha256(PAYLOAD[:PARTIAL_BYTES])
    empty_hash = sha256(b"")
    assert stage1["retained_after_reap"]["destination"]["kind"] == "absent"
    assert stage1["retained_after_reap"]["temporary"]["sha256"] == empty_hash
    assert stage1["boundary_observation"]["child_open_fd_count_for_temporary"] == 1
    assert stage2["retained_after_reap"]["destination"]["kind"] == "absent"
    assert stage2["retained_after_reap"]["temporary"]["bytes"] == PARTIAL_BYTES
    assert stage2["retained_after_reap"]["temporary"]["sha256"] == partial_hash
    assert stage2["boundary_observation"]["child_open_fd_count_for_temporary"] == 1
    assert stage3["retained_after_reap"]["destination"]["kind"] == "absent"
    assert stage3["retained_after_reap"]["temporary"]["sha256"] == full_hash
    assert stage3["boundary_observation"]["child_open_fd_count_for_temporary"] == 0
    assert stage4["retained_after_reap"]["destination"]["sha256"] == full_hash
    assert stage4["retained_after_reap"]["temporary"]["sha256"] == full_hash
    assert stage4["retained_after_reap"]["destination_and_temporary_same_inode"] is True
    assert stage4["retained_after_reap"]["destination"]["link_count"] == 2
    assert stage4["retained_after_reap"]["temporary"]["link_count"] == 2
    assert stage4["boundary_observation"]["child_open_fd_count_for_temporary"] == 0
    assert control["retained_after_reap"]["destination"]["sha256"] == full_hash
    assert control["retained_after_reap"]["destination"]["link_count"] == 1
    assert control["retained_after_reap"]["temporary_count"] == 0

    source = ROOT / SOURCE_PATH
    generator = ROOT / SCRIPT_PATH
    return {
        "schema": "windows-itunes-itl.filesystem-process-crash.v1",
        "status": "completed_bounded_linux_process_termination_campaign",
        "repository_baseline_commit": BASE_COMMIT,
        "production_source": {"path": SOURCE_PATH, "sha256": sha256(source.read_bytes())},
        "generator": {"path": SCRIPT_PATH, "sha256": sha256(generator.read_bytes())},
        "environment": environment,
        "synthetic_inputs": {
            "complete_payload": {"bytes": len(PAYLOAD), "sha256": full_hash},
            "partial_prefix": {"bytes": PARTIAL_BYTES, "sha256": partial_hash},
            "empty_temporary_sha256": empty_hash,
            "user_data_operations": 0,
        },
        "bounds": {
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
            "power_loss_operations": 0,
            "native_itunes_operations": 0,
            "network_filesystem_operations": 0,
            "production_code_changes": 0,
            "scratch_root_policy": "fresh absolute path resolving below /tmp; removed after measurement",
        },
        "methodology": {
            "case_counts_are_independent_experiments": False,
            "repetitions_controls_and_retained_artifacts_are_independent_experiments": False,
            "process_crash": "parent receives one atomic pipe event, confirms the child is alive, sends SIGKILL, and reaps return code -9",
            "scheduling_hooks": "child-local wrappers pause at explicit boundaries; retained outcomes use real Linux file, flush, fsync, close, and link operations as stated per case",
            "normal_control": "a separate child invokes unmodified production write_new without scheduling hooks and exits zero",
            "normalization": "no timestamps, PIDs, host paths, random temporary basenames, inode numbers, or device numbers",
            "timeouts_seconds": {"event": EVENT_TIMEOUT_SECONDS, "reap": REAP_TIMEOUT_SECONDS},
        },
        "summary": {
            "actual_process_crash_cases": len(crash_cases),
            "normal_control_cases": len(control_cases),
            "unexpected_anomalies": 0,
            "production_code_changed": False,
            "production_change_warranted": False,
            "u17_status": "open",
        },
        "observations": [
            "SIGKILL after temporary creation but before payload write retained one empty temporary and no destination.",
            "SIGKILL after one real partial write and flush retained exactly the synthetic prefix and no destination.",
            "SIGKILL after the complete payload was written, flushed, fsynced, and closed but before link retained one complete temporary and no destination.",
            "SIGKILL immediately after the native hard-link commit retained a complete destination and complete temporary as two names for one inode with link count two.",
            "The normal child completed with a complete destination, no temporary, link count one, and exit code zero.",
        ],
        "claim_limits": [
            "These cases characterize only the selected Linux process-termination schedules on the recorded runtime and local /tmp filesystem.",
            "Scheduling hooks position the child; they are not additional crash experiments or evidence for arbitrary schedules.",
            "No power loss was performed, so directory-entry durability and post-power-loss content are untested.",
            "The campaign does not establish hostile-directory safety, network-filesystem behavior, Windows parity, universal atomicity, or native iTunes acceptance.",
            "Retained temporaries are expected after SIGKILL because the child cannot execute production finally cleanup; the campaign removes the entire synthetic scratch root after measurement.",
        ],
        "integration_recommendation": "Integrate as research-only evidence, make no production itlkit change, and keep U-17 open for power-loss and broader filesystem/runtime work.",
        "cases": cases,
    }


def run_campaign_and_cleanup(scratch_path: Path) -> dict[str, object]:
    scratch = prepare_new_scratch_root(scratch_path)
    report: dict[str, object] | None = None
    try:
        report = build_report(scratch)
    finally:
        shutil.rmtree(scratch, ignore_errors=False)
    if os.path.lexists(scratch):
        raise AssertionError("campaign scratch root survived cleanup")
    if report is None:
        raise AssertionError("campaign did not produce a report")
    report["scratch_cleanup"] = {
        "root_removed_after_measurement": True,
        "retained_report_contains_random_temporary_names": False,
    }
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
    parser.add_argument("--scratch-root", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--_child-stage", choices=ALL_STAGES, help=argparse.SUPPRESS)
    parser.add_argument("--_event-fd", type=int, help=argparse.SUPPRESS)
    parser.add_argument("--_case-directory", type=Path, help=argparse.SUPPRESS)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    if args._child_stage is not None:
        if args._event_fd is None or args._case_directory is None:
            raise SystemExit("child mode requires event fd and case directory")
        try:
            return child_case(args._child_stage, args._event_fd, args._case_directory)
        finally:
            os.close(args._event_fd)

    if args.scratch_root is None:
        raise SystemExit("--scratch-root is required")
    if args.output is not None:
        scratch_candidate = args.scratch_root.parent.resolve(strict=True) / args.scratch_root.name
        output_candidate = args.output.resolve(strict=False)
        if output_candidate == scratch_candidate or scratch_candidate in output_candidate.parents:
            raise SystemExit("--output must be outside the disposable scratch root")
    report = run_campaign_and_cleanup(args.scratch_root)
    if args.output is None:
        sys.stdout.write(json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n")
    else:
        write_report(args.output, report)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
