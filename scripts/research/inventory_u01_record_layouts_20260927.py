"""Compare retained ITL record layouts across labelled iTunes versions for U-01.

This is an offline census of files already listed in DELIVERY-MANIFEST.json.  It
never reads or launches an Apple executable and does not authorize a native run.
"""
from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
MANIFEST = ROOT / "DELIVERY-MANIFEST.json"
DEFAULT_OUTPUT = (
    ROOT
    / "evidence/research/20260927/u01-static-control-flow/record-layout-census.json"
)
EXPECTED_PARSE_FAILURE = (
    "evidence/research/20260927/u01-sampled-version-matrix/inputs/"
    "reference-three-track-zlib-truncated-1-byte.itl"
)
BASE_VERSION = "12.12.10.1"
TARGET_VERSION = "12.13.11.1"


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def canonical(value: Any) -> bytes:
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")) + "\n").encode()


def rendered(value: Any) -> bytes:
    return (json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode()


def build_report() -> dict[str, Any]:
    if str(ROOT) not in sys.path:
        sys.path.insert(0, str(ROOT))
    from REFERENCE_PARSER.core import ReferenceLibrary, u32le

    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    entries = sorted(
        (entry for entry in manifest if entry["path"].endswith(".itl")),
        key=lambda entry: entry["path"],
    )
    source_rows = [
        {"path": entry["path"], "bytes": entry["bytes"], "sha256": entry["sha256"]}
        for entry in entries
    ]

    files: list[dict[str, Any]] = []
    failures: list[dict[str, str]] = []
    for entry in entries:
        path = ROOT / entry["path"]
        data = path.read_bytes()
        if len(data) != entry["bytes"] or sha256(data) != entry["sha256"]:
            raise ValueError(f"delivery manifest mismatch for {entry['path']}")
        try:
            library = ReferenceLibrary.read(path)
        except Exception as exc:
            failures.append(
                {
                    "path": entry["path"],
                    "error_type": type(exc).__name__,
                    "error": str(exc),
                }
            )
            continue

        layouts: set[tuple[str, int]] = set()
        mhoh_types: set[int] = set()
        child_buckets: set[tuple[str, int]] = set()
        record_counts: Counter[str] = Counter()
        section_types: set[int] = set()
        for section in library.sections:
            section_types.add(section.section_type)
            if section.root is None:
                continue
            for record in section.root.walk():
                tag = record.tag.decode("ascii", "replace")
                layouts.add((tag, len(record.header)))
                record_counts[tag] += 1
                child_buckets.add((tag, min(len(record.children), 10)))
                if record.tag == b"mhoh" and len(record.header) >= 16:
                    mhoh_types.add(u32le(record.header, 12))

        files.append(
            {
                "path": entry["path"],
                "sha256": entry["sha256"],
                "bytes": entry["bytes"],
                "version": library.envelope.version,
                "section_types": section_types,
                "record_layouts": layouts,
                "mhoh_types": mhoh_types,
                "child_buckets": child_buckets,
                "record_counts": record_counts,
            }
        )

    if [row["path"] for row in failures] != [EXPECTED_PARSE_FAILURE]:
        raise ValueError(f"unexpected parse-failure set: {failures!r}")

    versions = sorted({row["version"] for row in files})
    grouped = {version: [row for row in files if row["version"] == version] for version in versions}

    def union(version: str, field: str) -> set[Any]:
        result: set[Any] = set()
        for row in grouped[version]:
            result.update(row[field])
        return result

    by_version: dict[str, Any] = {}
    for version in versions:
        rows = grouped[version]
        record_totals: Counter[str] = Counter()
        for row in rows:
            record_totals.update(row["record_counts"])
        by_version[version] = {
            "file_count": len(rows),
            "section_types": sorted(union(version, "section_types")),
            "record_layouts": [
                {"tag": tag, "header_bytes": header_bytes}
                for tag, header_bytes in sorted(union(version, "record_layouts"))
            ],
            "mhoh_types": sorted(union(version, "mhoh_types")),
            "record_occurrences": dict(sorted(record_totals.items())),
        }

    base_sections = union(BASE_VERSION, "section_types")
    base_layouts = union(BASE_VERSION, "record_layouts")
    base_mhoh = union(BASE_VERSION, "mhoh_types")
    base_children = union(BASE_VERSION, "child_buckets")

    comparisons: dict[str, Any] = {}
    for version in versions:
        if version == BASE_VERSION:
            continue
        later_mhoh = sorted(union(version, "mhoh_types") - base_mhoh)
        mhoh_witnesses = []
        for value in later_mhoh:
            witness_rows = [row for row in grouped[version] if value in row["mhoh_types"]]
            mhoh_witnesses.append(
                {
                    "type": value,
                    "file_count": len(witness_rows),
                    "examples": [row["path"] for row in witness_rows[:3]],
                }
            )
        child_only = sorted(union(version, "child_buckets") - base_children)
        child_witnesses = []
        for tag, bucket in child_only:
            witness_rows = [
                row for row in grouped[version] if (tag, bucket) in row["child_buckets"]
            ]
            child_witnesses.append(
                {
                    "tag": tag,
                    "child_count_bucket": bucket,
                    "file_count": len(witness_rows),
                    "examples": [row["path"] for row in witness_rows[:3]],
                    "classification": "population_or_metadata_count_difference_not_a_record_layout",
                }
            )
        comparisons[version] = {
            "section_types_only_in_later": sorted(
                union(version, "section_types") - base_sections
            ),
            "record_layouts_only_in_later": [
                {"tag": tag, "header_bytes": header_bytes}
                for tag, header_bytes in sorted(
                    union(version, "record_layouts") - base_layouts
                )
            ],
            "mhoh_types_only_in_later": mhoh_witnesses,
            "child_count_buckets_only_in_later": child_witnesses,
        }

    target_comparison = comparisons[TARGET_VERSION]
    structural_layouts_equal = all(
        union(version, "record_layouts") == base_layouts for version in versions
    )
    section_sets_equal = all(
        union(version, "section_types") == base_sections for version in versions
    )

    return {
        "schema": "windows-itl.u01-record-layout-census-20260927.v1",
        "status": "offline_census_complete_no_native_launch_authorized",
        "generator": {
            "path": "scripts/research/inventory_u01_record_layouts_20260927.py",
            "sha256": sha256(Path(__file__).read_bytes()),
        },
        "source_set": {
            "kind": "all .itl entries in DELIVERY-MANIFEST.json",
            "entries": len(source_rows),
            "canonical_path_size_hash_digest": sha256(canonical(source_rows)),
            "representative_sample": False,
        },
        "counts": {
            "manifest_hashes_verified": len(entries),
            "strict_reference_parses": len(files),
            "parse_failures": len(failures),
            "versions": dict(sorted(Counter(row["version"] for row in files).items())),
            "native_itunes_launches": 0,
            "apple_executable_reads": 0,
            "network_operations": 0,
        },
        "parse_failures": failures,
        "by_version": by_version,
        "comparisons_against_12_12_10_1": comparisons,
        "bounded_conclusion": {
            "all_four_version_labels_share_section_type_set": section_sets_equal,
            "all_four_version_labels_share_record_tag_header_layout_set": structural_layouts_equal,
            "target_12_13_11_1_has_new_section_type": bool(
                target_comparison["section_types_only_in_later"]
            ),
            "target_12_13_11_1_has_new_record_tag_or_header_layout": bool(
                target_comparison["record_layouts_only_in_later"]
            ),
            "target_12_13_11_1_has_new_mhoh_type": bool(
                target_comparison["mhoh_types_only_in_later"]
            ),
            "observed_target_only_differences_are_population_counts": bool(
                target_comparison["child_count_buckets_only_in_later"]
            ),
            "concrete_non_label_incompatibility_theory_identified": False,
            "native_launch_authorized": False,
            "u01_status": "open",
            "universal_itl_support": False,
            "parser_writer_profile_12_12_10_1_supported": False,
            "independent_reimplementation_passed": False,
            "complete_analysis_gate": False,
        },
        "claim_limits": [
            "The delivery corpus is curated and contains related snapshots, controls, generated files, and research candidates; it is not a representative or independent version sample.",
            "A record tag/header layout census cannot prove semantic compatibility, parser reachability, or native acceptance.",
            "Later-only child-count buckets reflect retained population and metadata counts, not a new record layout.",
            "The later-only 12.13.10.3 mhoh values occur in ordinary Genre, Composer, Grouping, sort-field, and related field-matrix witnesses; absence from six 12.12.10.1-labelled files does not make them version-incompatible.",
            "The six 12.12.10.1-labelled files include related native observations and one never-launched normalized derivative, not six independent accepted experiments.",
            "No Apple executable was read or launched by this generator; this census cannot authorize a native negative.",
        ],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    payload = rendered(build_report())
    if args.check:
        if not args.output.is_file() or args.output.read_bytes() != payload:
            print(f"stale or missing generated report: {args.output}", file=sys.stderr)
            return 1
        print(f"verified {args.output.relative_to(ROOT)} sha256={sha256(payload)}")
        return 0
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(payload)
    print(f"wrote {args.output.relative_to(ROOT)} sha256={sha256(payload)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
