"""Build a deterministic public replay blocker inventory.

This is a public, repository-only U-18 aid.  It inventories the retained
historical replay blockers and claim boundaries from the checked-in public
static surface.  It performs no network access, no proprietary binary reads,
no Ghidra or Unicorn execution, and no native iTunes operation.
"""
from __future__ import annotations

import argparse
import ast
import hashlib
import json
import re
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
SCHEMA = "windows-itunes-itl.public-replay-gap-inventory.v1"
LOCK_REL = Path("scripts/static/public-replay-lock.json")
PREFLIGHT_REPORT_REL = Path("evidence/research/20260925/public-static-replay-bootstrap/report.json")
PREFLIGHT_SCRIPT_REL = Path("scripts/static/public_replay_preflight.py")
PYCRYPTODOME_PIN_SOURCES = [Path("README.md"), Path("scripts/experimental-import/requirements.txt")]
HISTORICAL_SCRIPTS = [
    Path("scripts/static/offline_aes_proof.py"),
    Path("scripts/static/pe_probe.py"),
    Path("scripts/static/prepare_targets.py"),
    Path("scripts/static/rebuild_targets.py"),
    Path("scripts/static/run-headless.ps1"),
    Path("scripts/ghidra/ITLSelective.java"),
]
NON_STDLIB_IMPORT_ROOTS = {"Crypto", "capstone", "pefile", "unicorn"}
TIMING_MARKERS = ("elapsed_s", "time.time", "perf_counter")
PRE_PARAMETERIZATION_BASELINE = {"machine_bound_script_count": 5, "timing_dependent_script_count": 2}
WINDOWS_ABSOLUTE_RE = re.compile(r"[A-Za-z]:\\")
OUTPUT_RE = re.compile(
    r"(?:evidence/static/|evidence\\\\static\\\\|decompiled/|decompiled\\\\)?"
    r"(?:offline-emulation|pe_inventory|pdata|important_xrefs|xrefs|function_groups|"
    r"targets1|targets-final|callgraph1|supplementary-leaf-ranges|function-atlas|summary)"
    r"(?:\\.json|\\.sqlite|\\.tsv|\\.txt|\\.c)?"
)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def load_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def relative_line_hits(lines: list[str], predicate) -> list[dict[str, Any]]:
    hits = []
    for number, text in enumerate(lines, 1):
        if predicate(text):
            hits.append({"line": number, "text": text.rstrip("\n")})
    return hits


def import_roots(path: Path, text: str) -> list[str]:
    if path.suffix != ".py":
        return []
    try:
        tree = ast.parse(text, filename=path.as_posix())
    except SyntaxError:
        return []
    roots: set[str] = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            for alias in node.names:
                root = alias.name.split(".", 1)[0]
                if root in NON_STDLIB_IMPORT_ROOTS:
                    roots.add(root)
        elif isinstance(node, ast.ImportFrom) and node.module:
            root = node.module.split(".", 1)[0]
            if root in NON_STDLIB_IMPORT_ROOTS:
                roots.add(root)
    return sorted(roots)


def output_references(lines: list[str]) -> list[dict[str, Any]]:
    hits: list[dict[str, Any]] = []
    seen: set[tuple[int, str]] = set()
    for number, line in enumerate(lines, 1):
        for match in OUTPUT_RE.finditer(line.replace("\\\\", "/")):
            value = match.group(0)
            if "." not in Path(value).name:
                continue
            key = (number, value)
            if key not in seen:
                seen.add(key)
                hits.append({"line": number, "value": value})
    return hits


def script_inventory(root: Path) -> list[dict[str, Any]]:
    result = []
    for relative in HISTORICAL_SCRIPTS:
        path = root / relative
        text = path.read_text(encoding="utf-8")
        lines = text.splitlines(keepends=True)
        machine_hits = relative_line_hits(lines, lambda line: bool(WINDOWS_ABSOLUTE_RE.search(line)))
        timing_hits = relative_line_hits(lines, lambda line: any(marker in line for marker in TIMING_MARKERS))
        result.append(
            {
                "path": relative.as_posix(),
                "sha256": sha256_file(path),
                "bytes": path.stat().st_size,
                "machine_bound_windows_path_lines": machine_hits,
                "machine_bound_windows_path_line_count": len(machine_hits),
                "has_machine_bound_windows_paths": bool(machine_hits),
                "timing_marker_lines": timing_hits,
                "timing_marker_line_count": len(timing_hits),
                "has_timing_markers": bool(timing_hits),
                "non_stdlib_import_roots": import_roots(relative, text),
                "statically_visible_output_references": output_references(lines),
            }
        )
    return result


def dependency_matrix(lock: dict[str, Any]) -> dict[str, Any]:
    matrix: dict[str, Any] = {
        "module": {
            "name": lock["module"]["name"],
            "version": lock["module"]["version"],
            "sha256": lock["module"]["sha256"],
            "staged": lock["module"]["staged"],
            "exact_version_recorded": True,
            "exact_hash_recorded": True,
        },
        "toolchain": {},
        "missing_exact_version_tools": [],
        "unstaged_items": [],
    }
    if lock["module"].get("staged") is False:
        matrix["unstaged_items"].append("module:iTunes.exe")
    for name in sorted(lock["toolchain"]):
        item = lock["toolchain"][name]
        row = dict(item)
        row["exact_version_recorded"] = item.get("version") is not None
        row["staged"] = item.get("staged")
        if item.get("version") is None:
            matrix["missing_exact_version_tools"].append(name)
        if item.get("staged") is False:
            matrix["unstaged_items"].append(f"toolchain:{name}")
        matrix["toolchain"][name] = row
    return matrix


def build_inventory(root: Path = ROOT) -> dict[str, Any]:
    root = root.resolve()
    lock_path = root / LOCK_REL
    report_path = root / PREFLIGHT_REPORT_REL
    lock = load_json(lock_path)
    preflight_report = load_json(report_path)
    scripts = script_inventory(root)
    machine_bound = [row["path"] for row in scripts if row["has_machine_bound_windows_paths"]]
    timing_dependent = [row["path"] for row in scripts if row["has_timing_markers"]]
    locked_paths = [row["path"] for row in lock["required_public_files"]]
    retained = preflight_report["retained_evidence"]
    return {
        "schema": SCHEMA,
        "status": "completed_public_gap_inventory_u18_open",
        "scope": "public_retained_static_surface_only",
        "sources": {
            "lock": {"path": LOCK_REL.as_posix(), "sha256": sha256_file(lock_path), "schema": lock["schema"]},
            "preflight_report": {
                "path": PREFLIGHT_REPORT_REL.as_posix(),
                "sha256": sha256_file(report_path),
                "schema": preflight_report["schema"],
            },
            "preflight_script": {
                "path": PREFLIGHT_SCRIPT_REL.as_posix(),
                "sha256": sha256_file(root / PREFLIGHT_SCRIPT_REL),
            },
        },
        "historical_scripts": scripts,
        "historical_script_summary": {
            "script_count": len(scripts),
            "machine_bound_script_count": len(machine_bound),
            "machine_bound_scripts": machine_bound,
            "timing_dependent_script_count": len(timing_dependent),
            "timing_dependent_scripts": timing_dependent,
            "pre_parameterization_baseline": PRE_PARAMETERIZATION_BASELINE,
            "portability_improvement": {
                "machine_bound_scripts_removed": PRE_PARAMETERIZATION_BASELINE["machine_bound_script_count"] - len(machine_bound),
                "timing_dependent_scripts_removed": PRE_PARAMETERIZATION_BASELINE["timing_dependent_script_count"] - len(timing_dependent),
                "current_counts_match_regenerated_preflight": {
                    "machine_bound": len(machine_bound) == retained["findings"]["historical_scripts_with_absolute_paths"],
                    "timing_dependent": len(timing_dependent) == retained["findings"]["historical_scripts_with_timing_fields"],
                },
            },
        },
        "dependency_pin_matrix": dependency_matrix(lock),
        "public_input_matrix": {
            "locked_public_file_count": len(locked_paths),
            "locked_public_bytes": preflight_report["public_surface"]["bytes"],
            "locked_tree_sha256": preflight_report["public_surface"]["tree_sha256"],
            "retained_c_rows": retained["findings"]["atlas_rows"],
            "retained_asm_identity_headers_matching": retained["findings"]["asm_identity_headers_matching"],
            "offline_test_records": retained["findings"]["offline_test_records"],
            "offline_tests_passing": retained["findings"]["offline_tests_passing"],
            "synthetic_controls": preflight_report["synthetic_controls"],
        },
        "missing_input_matrix": {
            "proprietary_module_staged": lock["module"]["staged"],
            "ghidra_distribution_staged": lock["toolchain"]["ghidra"]["staged"],
            "ghidra_project_cache_staged": False,
            "exact_python_dependency_versions_recorded": False,
            "missing_exact_python_dependencies": ["capstone", "pefile"],
            "pycryptodome_version_evidence": {
                "version": lock["toolchain"]["pycryptodome"]["version"],
                "basis": lock["toolchain"]["pycryptodome"]["version_evidence"],
                "sources": [
                    {"path": path.as_posix(), "sha256": sha256_file(root / path)}
                    for path in PYCRYPTODOME_PIN_SOURCES
                ],
                "historical_static_execution_linkage_proven": lock["toolchain"]["pycryptodome"]["historical_static_execution_linkage_proven"],
            },
            "historical_static_execution_dependency_set_fully_proven": False,
            "lawful_public_or_synthetic_pe_fixture_present": False,
            "public_synthetic_ghidra_project_fixture_present": False,
            "current_public_atlas_c_hashes_coherent": retained["current_public_atlas_c_hashes_coherent"],
            "atlas_c_hash_matches": retained["findings"]["atlas_c_hash_matches"],
            "atlas_c_hash_mismatches": retained["findings"]["atlas_c_hash_mismatches"],
        },
        "historical_replay": preflight_report["historical_replay"],
        "operations": preflight_report["operations"],
        "claims": preflight_report["claims"],
        "claim_boundaries": {
            "u18_closed": False,
            "historical_binary_analysis_reproduced": False,
            "ghidra_end_to_end_reproduced": False,
            "unicorn_original_machine_code_reproduced": False,
            "native_application_acceptance": False,
            "independent_reimplementation_passed": False,
            "universal_itl_support": False,
            "percentage_complete": None,
            "not_independent_experiments": "This inventory is one deterministic repository-local check and does not replay historical binary analysis.",
        },
        "recommended_next_step": (
            "Use the now-parameterized deterministic scripts only with lawfully supplied inputs; do not claim U-18 "
            "closure until exact historical dependencies, staged/recreated Ghidra state, coherent "
            "provenance, and end-to-end Ghidra/Unicorn receipts exist."
        ),
    }


def report_bytes(report: dict[str, Any]) -> bytes:
    return (json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode("utf-8")


def write_report(output: Path, report: dict[str, Any]) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_bytes(report_bytes(report))


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-root", type=Path, default=ROOT)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--check-report", type=Path)
    args = parser.parse_args()
    report = build_inventory(args.repo_root)
    data = report_bytes(report)
    if args.check_report is not None:
        retained = args.check_report.read_bytes()
        if retained != data:
            raise SystemExit("public replay gap inventory differs from retained report")
    if args.output is not None:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_bytes(data)
    print("PUBLIC_REPLAY_GAP_INVENTORY_OK sha256=" + hashlib.sha256(data).hexdigest())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
