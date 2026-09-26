"""Deterministic, public-only preflight for the retained static-analysis surface.

This tool verifies a repository-relative lock and reports whether the historical
Ghidra/Unicorn replay prerequisites are publicly available.  It never locates,
loads, reconstructs, or executes iTunes or any other proprietary binary.
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import re
import sys
from pathlib import Path, PurePosixPath, PureWindowsPath
from typing import Any, Iterable

LOCK_RELATIVE_PATH = "scripts/static/public-replay-lock.json"
REPORT_SCHEMA = "windows-itunes-itl.public-static-replay-report.v1"
LOCK_SCHEMA = "windows-itunes-itl.public-static-replay-lock.v1"
MODULE_SHA256 = "30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d"
SHA256_RE = re.compile(r"[0-9a-f]{64}")
WINDOWS_ABSOLUTE_RE = re.compile(rb"[A-Za-z]:\\")
RESERVED_WINDOWS_NAMES = {"CON", "PRN", "AUX", "NUL"} | {
    f"{prefix}{number}"
    for prefix in ("COM", "LPT")
    for number in range(1, 10)
}
HISTORICAL_SCRIPT_PATHS = (
    "scripts/static/offline_aes_proof.py",
    "scripts/static/pe_probe.py",
    "scripts/static/prepare_targets.py",
    "scripts/static/rebuild_targets.py",
    "scripts/static/run-headless.ps1",
    "scripts/ghidra/ITLSelective.java",
)
CORE_PUBLIC_PATHS = {
    "scripts/static/public_replay_preflight.py",
    *HISTORICAL_SCRIPT_PATHS,
    "evidence/static/reproduce.md",
    "evidence/static/targets-final.txt",
    "evidence/static/decompiled/summary.tsv",
    "evidence/static/function-atlas.json",
    "evidence/static/offline-emulation.json",
    "evidence/static/final-qa.json",
    "evidence/static/final-source-check.json",
}


class PreflightError(ValueError):
    """A deterministic public preflight check failed."""


def _reject_duplicate_keys(pairs: list[tuple[str, Any]]) -> dict[str, Any]:
    result: dict[str, Any] = {}
    for key, value in pairs:
        if key in result:
            raise PreflightError(f"duplicate JSON key: {key}")
        result[key] = value
    return result


def load_json_strict(path: Path) -> Any:
    return json.loads(
        path.read_text(encoding="utf-8-sig"),
        object_pairs_hook=_reject_duplicate_keys,
    )


def load_json_bytes_strict(value: bytes) -> Any:
    return json.loads(value.decode("utf-8-sig"), object_pairs_hook=_reject_duplicate_keys)


def safe_relative(value: str) -> PurePosixPath:
    if (
        not isinstance(value, str)
        or not value
        or "\\" in value
        or ":" in value
        or any(ord(character) < 32 for character in value)
    ):
        raise PreflightError("unsafe repository-relative path")
    path = PurePosixPath(value)
    if path.is_absolute() or PureWindowsPath(value).drive or path.as_posix() != value:
        raise PreflightError(f"non-canonical repository-relative path: {value}")
    for part in path.parts:
        stem = part.split(".", 1)[0].upper()
        if part in ("", ".", "..") or part.rstrip(" .") != part or stem in RESERVED_WINDOWS_NAMES:
            raise PreflightError(f"unsafe path component: {value}")
    return path


def _is_link(path: Path) -> bool:
    return path.is_symlink() or (hasattr(path, "is_junction") and path.is_junction())


def regular_file(root: Path, relative: str) -> Path:
    rel = safe_relative(relative)
    cursor = root
    for part in rel.parts:
        cursor /= part
        if _is_link(cursor):
            raise PreflightError(f"linked public input is not allowed: {relative}")
    if not cursor.is_file():
        raise PreflightError(f"missing public input: {relative}")
    try:
        inside_root = cursor.resolve(strict=True).is_relative_to(root)
    except OSError as exc:
        raise PreflightError(f"unreadable public input: {relative}") from exc
    if not inside_root:
        raise PreflightError(f"public input escapes repository root: {relative}")
    return cursor


def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _exact_keys(value: Any, expected: set[str], label: str) -> dict[str, Any]:
    if not isinstance(value, dict) or set(value) != expected:
        raise PreflightError(f"invalid {label} fields")
    return value


def _validate_lock(root: Path) -> tuple[dict[str, Any], Path, dict[str, dict[str, Any]]]:
    lock_path = regular_file(root, LOCK_RELATIVE_PATH)
    lock = _exact_keys(
        load_json_strict(lock_path),
        {
            "schema",
            "module",
            "toolchain",
            "required_public_files",
            "expected_retained_findings",
            "known_blockers",
        },
        "lock",
    )
    if lock["schema"] != LOCK_SCHEMA:
        raise PreflightError("unsupported lock schema")

    module = _exact_keys(lock["module"], {"name", "version", "sha256", "staged"}, "module")
    if module != {
        "name": "iTunes.exe",
        "version": "12.13.10.3",
        "sha256": MODULE_SHA256,
        "staged": False,
    }:
        raise PreflightError("unexpected historical module identity")

    toolchain = lock["toolchain"]
    if not isinstance(toolchain, dict) or set(toolchain) != {
        "ghidra",
        "jdk",
        "unicorn",
        "capstone",
        "pefile",
        "pycryptodome",
    }:
        raise PreflightError("invalid toolchain lock")
    for name, item in toolchain.items():
        if not isinstance(item, dict) or item.get("staged") is not False:
            raise PreflightError(f"toolchain availability must stay explicit: {name}")
        version = item.get("version")
        if version is not None and not isinstance(version, str):
            raise PreflightError(f"invalid toolchain version: {name}")
    ghidra = toolchain["ghidra"]
    if ghidra.get("version") != "12.1.3" or ghidra.get("archive_sha256") != (
        "93a5d11a9ad510622acaaf908c556a7b9b764d338e78a7567f3689bf5081fd54"
    ) or ghidra.get("archive_bytes") != 569445154:
        raise PreflightError("unexpected Ghidra pin")
    if toolchain["unicorn"].get("version") != "2.1.4":
        raise PreflightError("unexpected Unicorn pin")

    rows = lock["required_public_files"]
    if not isinstance(rows, list) or not rows:
        raise PreflightError("required_public_files must be a nonempty list")
    by_path: dict[str, dict[str, Any]] = {}
    folded: set[str] = set()
    previous = ""
    for row in rows:
        row = _exact_keys(row, {"path", "bytes", "sha256"}, "public file row")
        rel = safe_relative(row["path"]).as_posix()
        if rel <= previous:
            raise PreflightError("public file rows must be strictly path-sorted")
        previous = rel
        if rel.casefold() in folded:
            raise PreflightError(f"duplicate or case-folded public path: {rel}")
        folded.add(rel.casefold())
        if type(row["bytes"]) is not int or row["bytes"] < 0:
            raise PreflightError(f"invalid public file size: {rel}")
        if not isinstance(row["sha256"], str) or SHA256_RE.fullmatch(row["sha256"]) is None:
            raise PreflightError(f"invalid public file SHA-256: {rel}")
        path = regular_file(root, rel)
        if path.stat().st_size != row["bytes"]:
            raise PreflightError(f"public file size mismatch: {rel}")
        if sha256_file(path) != row["sha256"]:
            raise PreflightError(f"public file SHA-256 mismatch: {rel}")
        by_path[rel] = row

    expected = lock["expected_retained_findings"]
    if not isinstance(expected, dict) or any(type(value) is not int or value < 0 for value in expected.values()):
        raise PreflightError("invalid expected retained findings")

    blockers = lock["known_blockers"]
    if not isinstance(blockers, list) or not blockers:
        raise PreflightError("known_blockers must be a nonempty list")
    blocker_ids: set[str] = set()
    for blocker in blockers:
        blocker = _exact_keys(blocker, {"id", "description"}, "known blocker")
        if not isinstance(blocker["id"], str) or not blocker["id"] or blocker["id"] in blocker_ids:
            raise PreflightError("invalid or duplicate known blocker id")
        if not isinstance(blocker["description"], str) or not blocker["description"]:
            raise PreflightError("invalid known blocker description")
        blocker_ids.add(blocker["id"])
    return lock, lock_path, by_path


def _parse_targets(root: Path) -> list[str]:
    values = regular_file(root, "evidence/static/targets-final.txt").read_text(encoding="ascii").splitlines()
    if not values or len(values) != len(set(values)):
        raise PreflightError("target list is empty or duplicated")
    if any(re.fullmatch(r"[0-9a-f]+", value) is None for value in values):
        raise PreflightError("target list contains a non-canonical RVA")
    return ["0x" + value for value in values]


def _parse_summary(root: Path) -> list[dict[str, str]]:
    path = regular_file(root, "evidence/static/decompiled/summary.tsv")
    with path.open("r", encoding="utf-8", newline="") as stream:
        reader = csv.DictReader(stream, delimiter="\t")
        if reader.fieldnames != ["module", "rva", "name", "bytes", "completed", "error"]:
            raise PreflightError("unexpected decompiler summary columns")
        rows = list(reader)
    for row in rows:
        if (
            row["module"] != "iTunes.exe"
            or row["completed"] != "true"
            or row["error"] != ""
            or not row["bytes"].isdigit()
            or int(row["bytes"]) <= 0
        ):
            raise PreflightError("decompiler summary contains a failed or malformed row")
    return rows


def _validate_retained_evidence(
    root: Path,
    lock: dict[str, Any],
    locked_files: dict[str, dict[str, Any]],
) -> dict[str, Any]:
    targets = _parse_targets(root)
    summary = _parse_summary(root)
    atlas = load_json_strict(regular_file(root, "evidence/static/function-atlas.json"))
    if not isinstance(atlas, list):
        raise PreflightError("function atlas must be a list")
    if [row["rva"] for row in summary] != targets:
        raise PreflightError("target list and decompiler summary diverge")
    if [row.get("rva") for row in atlas] != targets:
        raise PreflightError("target list and function atlas diverge")

    atlas_c_matches = 0
    atlas_c_mismatches = 0
    asm_headers_matching = 0
    asm_headers_mismatching = 0
    referenced_paths: set[str] = set(CORE_PUBLIC_PATHS)
    for row in atlas:
        row = _exact_keys(
            row,
            {
                "module",
                "rva",
                "base",
                "module_sha256",
                "function_bytes",
                "instruction_count",
                "decompiled_c",
                "c_sha256",
                "assembly",
                "body_basis",
            },
            "function atlas row",
        )
        if (
            row["module"] != "iTunes.exe"
            or row["base"] != "0x140000000"
            or row["module_sha256"] != MODULE_SHA256
            or type(row["function_bytes"]) is not int
            or row["function_bytes"] <= 0
            or type(row["instruction_count"]) is not int
            or row["instruction_count"] <= 0
            or not isinstance(row["c_sha256"], str)
            or SHA256_RE.fullmatch(row["c_sha256"]) is None
        ):
            raise PreflightError(f"malformed function atlas row: {row.get('rva')}")
        c_rel = "evidence/static/" + safe_relative(row["decompiled_c"]).as_posix()
        asm_rel = "evidence/static/" + safe_relative(row["assembly"]).as_posix()
        referenced_paths.update((c_rel, asm_rel))
        c_path = regular_file(root, c_rel)
        asm_path = regular_file(root, asm_rel)
        if sha256_file(c_path) == row["c_sha256"]:
            atlas_c_matches += 1
        else:
            atlas_c_mismatches += 1
        expected_header = (
            f"; Original iTunes.exe machine code; base={row['base']}; "
            f"RVA={row['rva']}; SHA256={MODULE_SHA256}"
        )
        first_line = asm_path.read_text(encoding="utf-8").splitlines()[0]
        if first_line == expected_header:
            asm_headers_matching += 1
        else:
            asm_headers_mismatching += 1

    if set(locked_files) != referenced_paths:
        missing = sorted(referenced_paths - set(locked_files))[:3]
        extra = sorted(set(locked_files) - referenced_paths)[:3]
        raise PreflightError(f"lock surface mismatch; missing={missing!r}; extra={extra!r}")

    offline = load_json_strict(regular_file(root, "evidence/static/offline-emulation.json"))
    if (
        not isinstance(offline, dict)
        or offline.get("kind") != "offline_unicorn_original_machine_code"
        or offline.get("module") != "iTunes.exe"
        or offline.get("sha256") != MODULE_SHA256
        or offline.get("unicorn") != lock["toolchain"]["unicorn"]["version"]
        or offline.get("native_iTunes_acceptance") is not False
        or offline.get("host_executable_loaded") is not False
        or offline.get("success") is not True
        or not isinstance(offline.get("tests"), list)
    ):
        raise PreflightError("retained offline-emulation metadata is malformed")
    offline_passing = sum(test.get("pass") is True for test in offline["tests"] if isinstance(test, dict))

    final_qa = load_json_strict(regular_file(root, "evidence/static/final-qa.json"))
    if (
        not isinstance(final_qa, dict)
        or final_qa.get("success") is not True
        or final_qa.get("decompiled_functions") != len(atlas)
        or final_qa.get("offline_tests") != len(offline["tests"])
        or final_qa.get("offline_tests_all_pass") is not True
        or final_qa.get("native_application_acceptance") is not False
        or final_qa.get("all_final_c_nonempty_and_hashed") is not True
    ):
        raise PreflightError("retained final QA metadata is malformed")

    source_check = load_json_strict(regular_file(root, "evidence/static/final-source-check.json"))
    if (
        not isinstance(source_check, dict)
        or source_check.get("exe_sha256") != MODULE_SHA256
        or source_check.get("exe_version") != lock["module"]["version"]
        or source_check.get("worktree_status") != []
    ):
        raise PreflightError("retained source-check metadata is malformed")

    absolute_path_scripts: list[str] = []
    timing_field_scripts: list[str] = []
    for relative in HISTORICAL_SCRIPT_PATHS:
        value = regular_file(root, relative).read_bytes()
        if WINDOWS_ABSOLUTE_RE.search(value):
            absolute_path_scripts.append(relative)
        if b"elapsed_s" in value or b"time.time" in value or b"perf_counter" in value:
            timing_field_scripts.append(relative)

    findings = {
        "target_rows": len(targets),
        "summary_rows": len(summary),
        "summary_completed": sum(row["completed"] == "true" for row in summary),
        "atlas_rows": len(atlas),
        "atlas_c_hash_matches": atlas_c_matches,
        "atlas_c_hash_mismatches": atlas_c_mismatches,
        "asm_identity_headers_matching": asm_headers_matching,
        "asm_identity_headers_mismatching": asm_headers_mismatching,
        "offline_test_records": len(offline["tests"]),
        "offline_tests_passing": offline_passing,
        "historical_scripts_with_absolute_paths": len(absolute_path_scripts),
        "historical_scripts_with_timing_fields": len(timing_field_scripts),
    }
    if findings != lock["expected_retained_findings"]:
        raise PreflightError("retained finding set differs from the reviewed lock")
    return {
        "status": "blocked_for_historical_replay",
        "target_summary_atlas_alignment": True,
        "findings": findings,
        "machine_bound_scripts": absolute_path_scripts,
        "timing_dependent_scripts": timing_field_scripts,
        "retained_final_qa_declares_all_c_hashed": True,
        "current_public_atlas_c_hashes_coherent": atlas_c_mismatches == 0,
    }


def _expect_rejected(callable_value: Any, label: str) -> None:
    try:
        callable_value()
    except (PreflightError, json.JSONDecodeError):
        return
    raise PreflightError(f"synthetic negative control was not rejected: {label}")


def run_synthetic_controls() -> dict[str, Any]:
    accepted = safe_relative("evidence/static/example.json").as_posix()
    if accepted != "evidence/static/example.json":
        raise PreflightError("synthetic canonical path control changed")
    _expect_rejected(lambda: safe_relative("../escape"), "parent traversal")
    _expect_rejected(lambda: safe_relative("/absolute"), "POSIX absolute path")
    _expect_rejected(lambda: safe_relative("C:/absolute"), "Windows absolute path")
    _expect_rejected(lambda: safe_relative("mixed\\separator"), "backslash path")
    sample = b"public-static-replay-synthetic-control-v1\n"
    digest = sha256_bytes(sample)
    if digest != "15d5274d2e9beecc8b8a5b6ae7f193f16ffbe5d599aa908927775fb4410afa3d":
        raise PreflightError("synthetic digest positive control changed")
    if sha256_bytes(sample + b"tamper") == digest:
        raise PreflightError("synthetic digest negative control changed")
    _expect_rejected(
        lambda: load_json_bytes_strict(b'{"schema": 1, "schema": 2}'),
        "duplicate JSON key",
    )
    return {
        "status": "passed",
        "case_count": 8,
        "cases_are_independent_experiments": False,
        "positive_cases": 2,
        "negative_cases": 6,
    }


def _surface_tree_sha256(rows: Iterable[dict[str, Any]]) -> str:
    canonical = json.dumps(list(rows), sort_keys=True, separators=(",", ":"), ensure_ascii=True)
    return sha256_bytes((canonical + "\n").encode("ascii"))


def build_report(repo_root: Path | None = None) -> dict[str, Any]:
    root = (repo_root or Path(__file__).resolve().parents[2]).resolve(strict=True)
    if not root.is_dir():
        raise PreflightError("repository root is not a directory")
    synthetic = run_synthetic_controls()
    lock, lock_path, locked_files = _validate_lock(root)
    retained = _validate_retained_evidence(root, lock, locked_files)
    rows = lock["required_public_files"]
    return {
        "schema": REPORT_SCHEMA,
        "status": "preflight_completed_with_expected_blockers",
        "scope": "public_retained_static_surface_only",
        "lock": {
            "path": LOCK_RELATIVE_PATH,
            "sha256": sha256_file(lock_path),
            "schema": lock["schema"],
        },
        "public_surface": {
            "status": "verified_against_lock",
            "file_count": len(rows),
            "bytes": sum(row["bytes"] for row in rows),
            "tree_sha256": _surface_tree_sha256(rows),
        },
        "retained_evidence": retained,
        "synthetic_controls": synthetic,
        "toolchain_pins": lock["toolchain"],
        "historical_replay": {
            "status": "unavailable",
            "available_from_public_clone": False,
            "ghidra_end_to_end_reproduced": False,
            "unicorn_original_machine_code_reproduced": False,
            "blockers": [item["id"] for item in lock["known_blockers"]],
        },
        "operations": {
            "network_operations": 0,
            "proprietary_binary_reads": 0,
            "itunes_launches": 0,
            "ghidra_invocations": 0,
            "unicorn_invocations": 0,
            "native_acceptance_operations": 0,
        },
        "claims": {
            "u18_closed": False,
            "u13_closed": False,
            "u17_closed": False,
            "universal_itl_support": False,
            "percentage_complete": None,
            "independent_reimplementation_passed": False,
            "native_application_acceptance": False,
            "historical_binary_analysis_reproduced": False,
        },
    }


def report_bytes(report: dict[str, Any]) -> bytes:
    return (json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode("utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-root", type=Path, help="repository root; defaults relative to this script")
    destination = parser.add_mutually_exclusive_group()
    destination.add_argument("--output", type=Path, help="write the deterministic report")
    destination.add_argument("--check-report", type=Path, help="require an existing report to match byte-for-byte")
    args = parser.parse_args(argv)
    try:
        payload = report_bytes(build_report(args.repo_root))
        if args.check_report is not None:
            if args.check_report.read_bytes() != payload:
                raise PreflightError("retained report differs from deterministic replay")
        elif args.output is not None:
            args.output.parent.mkdir(parents=True, exist_ok=True)
            if _is_link(args.output):
                raise PreflightError("refusing linked output path")
            args.output.write_bytes(payload)
        else:
            sys.stdout.buffer.write(payload)
            return 0
    except (OSError, TypeError, KeyError, json.JSONDecodeError, PreflightError) as exc:
        print(f"PUBLIC_STATIC_REPLAY_PREFLIGHT_ERROR: {exc}", file=sys.stderr)
        return 1
    print(f"PUBLIC_STATIC_REPLAY_PREFLIGHT_OK sha256={sha256_bytes(payload)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
