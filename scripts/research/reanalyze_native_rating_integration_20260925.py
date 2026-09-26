"""Reanalyze frozen native-rating snapshots with the integrated parser tree.

The native report is immutable execution evidence produced on its source branch.
This script does not replay iTunes.  It verifies every retained snapshot against
the current repository parsers, records source hashes, and makes parser drift
explicit without rewriting the native operation log.
"""
from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "evidence" / "research" / "20260925" / "native-rating-kind"
REPORT = EVIDENCE / "report.json"
PRODUCER_COMMIT = "e1392568c77fbd3a49c72d3e80f802999b7aac6a"
PRODUCER_PARENT = "9dc9be906c30172fc8d0ac9550d28cb137e63e42"
SOURCE_PATHS = (
    "itlkit/library.py",
    "REFERENCE_PARSER/core.py",
    "scripts/windows/native_rating_kind_20260925.py",
)


def _load_rating_module(repo_root: Path):
    path = repo_root / "scripts" / "windows" / "native_rating_kind_20260925.py"
    spec = importlib.util.spec_from_file_location("integrated_native_rating", path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load native rating module: {path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _without_high_level(primary: dict[str, Any]) -> dict[str, Any]:
    result = dict(primary)
    result.pop("high_level_library", None)
    return result


def _without_integrated_validator_additions(validator: dict[str, Any]) -> dict[str, Any]:
    result = json.loads(json.dumps(validator))
    result.get("coverage", {}).pop("compressed_trailer", None)
    return result


def _snapshot_paths(evidence: Path, case: dict[str, Any]) -> dict[str, Path]:
    case_root = evidence / "cases" / case["name"]
    paths = {"baseline": case_root / "baseline.itl"}
    for session in case["sessions"]:
        paths[session["phase"]] = case_root / session["phase"] / "native-saved.itl"
    return paths


def build_reanalysis(repo_root: Path = ROOT) -> dict[str, Any]:
    repo_root = repo_root.resolve()
    evidence = repo_root / EVIDENCE.relative_to(ROOT)
    report_path = evidence / "report.json"
    report = json.loads(report_path.read_text(encoding="utf-8"))
    rating = _load_rating_module(repo_root)

    frozen_outcomes: Counter[str] = Counter()
    integrated_outcomes: Counter[str] = Counter()
    snapshot_hashes: set[str] = set()
    differences: list[dict[str, Any]] = []
    analyzed = 0

    for case in report["cases"]:
        paths = _snapshot_paths(evidence, case)
        expected_labels = set(case["snapshot_analyses"])
        if set(paths) != expected_labels:
            raise RuntimeError(f"snapshot labels differ for {case['name']}")
        for label in sorted(paths):
            expected = case["snapshot_analyses"][label]
            current = rating.analyze_snapshot(paths[label])
            analyzed += 1
            digest = _sha256(paths[label])
            snapshot_hashes.add(digest)
            if digest != expected["file"]["sha256"]:
                raise RuntimeError(f"snapshot hash mismatch: {case['name']}/{label}")
            for key in ("independent", "errors"):
                if current[key] != expected[key]:
                    raise RuntimeError(f"{key} drift: {case['name']}/{label}")
            if _without_integrated_validator_additions(current["validator"]) != expected["validator"]:
                raise RuntimeError(f"validator drift: {case['name']}/{label}")
            trailer_coverage = current["validator"].get("coverage", {}).get("compressed_trailer")
            if trailer_coverage != {"present": False, "bytes": 0, "semantically_validated": False}:
                raise RuntimeError(f"unexpected trailer coverage: {case['name']}/{label}")
            if _without_high_level(current["primary"]) != _without_high_level(expected["primary"]):
                raise RuntimeError(f"targeted primary drift: {case['name']}/{label}")
            if not current["passed"]:
                raise RuntimeError(f"integrated analysis failed: {case['name']}/{label}")

            frozen = expected["primary"]["high_level_library"]["outcome"]
            integrated = current["primary"]["high_level_library"]["outcome"]
            frozen_outcomes[frozen] += 1
            integrated_outcomes[integrated] += 1
            if frozen != integrated:
                differences.append(
                    {
                        "case": case["name"],
                        "snapshot": label,
                        "sha256": digest,
                        "frozen_outcome": frozen,
                        "integrated_outcome": integrated,
                    }
                )

    source_hashes = [
        {"path": path, "sha256": _sha256(repo_root / path)} for path in SOURCE_PATHS
    ]
    mismatch_hashes = sorted({item["sha256"] for item in differences})
    return {
        "schema": "itl.native-rating.integrated-reanalysis.v1",
        "scope": "offline reanalysis of retained native-rating ITL snapshots; no native application launched",
        "frozen_producer": {
            "commit": PRODUCER_COMMIT,
            "parent": PRODUCER_PARENT,
            "branch": "research/20260925-native-rating",
            "report": {
                "path": "evidence/research/20260925/native-rating-kind/report.json",
                "sha256": hashlib.sha256(canonical_json(report).encode("utf-8")).hexdigest(),
                "hash_basis": "UTF-8 JSON; ensure_ascii=false; sorted keys; indent=2; LF terminator",
                "repository_bytes_sha256": _sha256(report_path),
            },
        },
        "integrated_source_hashes": source_hashes,
        "counts": {
            "snapshot_occurrences": analyzed,
            "unique_snapshot_sha256": len(snapshot_hashes),
            "frozen_high_level_library_outcomes": dict(sorted(frozen_outcomes.items())),
            "integrated_high_level_library_outcomes": dict(sorted(integrated_outcomes.items())),
            "high_level_outcome_differences": len(differences),
            "unique_difference_sha256": len(mismatch_hashes),
            "integrated_primary_independent_validator_passed": analyzed,
        },
        "differences": differences,
        "difference_sha256": mismatch_hashes,
        "native_execution_facts_preserved": {
            "report_passed": report["passed"],
            "cases_passed": report["counts"]["cases_passed"],
            "cases_total": report["counts"]["cases_total"],
            "native_sessions_passed": report["counts"]["native_sessions_passed"],
            "native_sessions": report["counts"]["native_sessions"],
            "rating_values": report["counts"]["rating_values"],
        },
        "conclusion": (
            "The seven frozen blocked outcomes were repeated analyses of the same raw baseline hash, "
            "not seven independent native experiments.  The integrated Library now accepts that exact "
            "native-qualified zero-secondary-ID fixture on its read/no-op path, so all 27 retained "
            "snapshot occurrences are observed by the integrated high-level parser.  Targeted fields, "
            "the independent parser, VALIDATOR results, native operations, and bounded U-14 conclusions "
            "are unchanged."
        ),
        "claim_boundary": [
            "This is offline parser reanalysis, not a new native iTunes run.",
            "Snapshot occurrences and repeated baseline copies are not independent experiments.",
            "High-level parser acceptance does not establish universal ITL support or native acceptance.",
            "The frozen report remains the execution-time record; this file records later parser drift.",
        ],
    }


def canonical_json(value: Any) -> str:
    return json.dumps(value, indent=2, ensure_ascii=False, sort_keys=True) + "\n"


def render_markdown(result: dict[str, Any]) -> str:
    counts = result["counts"]
    hashes = "\n".join(
        f"  - `{row['path']}`: `{row['sha256']}`" for row in result["integrated_source_hashes"]
    )
    return f"""# Integrated parser reanalysis\n\nThis addendum reanalyzes the retained native-rating snapshots without launching iTunes. The immutable execution-time report remains `report.json`; this file makes its parser provenance and later integration drift explicit.\n\n## Provenance\n\n- Frozen producer commit: `{result['frozen_producer']['commit']}` (parent `{result['frozen_producer']['parent']}`).\n- Frozen report canonical JSON SHA-256: `{result['frozen_producer']['report']['sha256']}`.\n- Integrated source hashes:\n{hashes}\n\n## Result\n\n- Retained snapshot occurrences: **{counts['snapshot_occurrences']}**; unique snapshot SHA-256 values: **{counts['unique_snapshot_sha256']}**.\n- Frozen high-level outcomes: `{json.dumps(counts['frozen_high_level_library_outcomes'], sort_keys=True)}`.\n- Integrated high-level outcomes: `{json.dumps(counts['integrated_high_level_library_outcomes'], sort_keys=True)}`.\n- Outcome differences: **{counts['high_level_outcome_differences']} occurrences / {counts['unique_difference_sha256']} unique hash**. All seven differences are repeated copies of the pinned raw baseline, not independent native runs.\n- Integrated targeted primary parser, independent parser, and VALIDATOR checks: **{counts['integrated_primary_independent_validator_passed']}/{counts['snapshot_occurrences']} passed**.\n\n## Interpretation\n\n{result['conclusion']}\n\n## Claim boundary\n\n""" + "".join(f"- {item}\n" for item in result["claim_boundary"])


def write_outputs(output_dir: Path, repo_root: Path = ROOT) -> dict[str, Any]:
    result = build_reanalysis(repo_root)
    output_dir.mkdir(parents=True, exist_ok=True)
    (output_dir / "integrated-reanalysis.json").write_text(canonical_json(result), encoding="utf-8")
    (output_dir / "INTEGRATION.md").write_text(render_markdown(result), encoding="utf-8")
    return result


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-root", type=Path, default=ROOT)
    parser.add_argument("--output-dir", type=Path, default=EVIDENCE)
    args = parser.parse_args()
    result = write_outputs(args.output_dir, args.repo_root)
    print(canonical_json(result["counts"]), end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
