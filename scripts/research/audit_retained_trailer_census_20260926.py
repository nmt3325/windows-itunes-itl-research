"""Census compressed trailers across every ITL in the delivery manifest.

This is a repository-corpus census, not a prevalence sample and not native evidence.
"""
from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "evidence/research/20260926/retained-trailer-census/report.json"
MANIFEST = ROOT / "DELIVERY-MANIFEST.json"
KNOWN_WITNESS = "evidence/research/20260925/native-trailer-u13/candidates/opaque-trailer-17-reference-one-track-zlib.itl"


def canonical(value: Any) -> bytes:
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")) + "\n").encode()


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def build_report() -> dict[str, Any]:
    # Import after ROOT is known so the script also works outside the repository cwd.
    import sys
    if str(ROOT) not in sys.path:
        sys.path.insert(0, str(ROOT))
    from itlkit import Container

    entries = json.loads(MANIFEST.read_text(encoding="utf-8"))
    itl_entries = sorted(
        (e for e in entries if e["path"].endswith(".itl")), key=lambda e: e["path"]
    )
    versions: Counter[str] = Counter()
    compression: Counter[str] = Counter()
    encryption: Counter[str] = Counter()
    trailer_lengths: Counter[str] = Counter()
    witnesses: list[dict[str, Any]] = []
    verified = 0
    parsed = 0
    no_op_exact = 0
    parse_failures: list[dict[str, str]] = []

    for entry in itl_entries:
        path = ROOT / entry["path"]
        data = path.read_bytes()
        if len(data) != entry["bytes"] or sha256(data) != entry["sha256"]:
            raise ValueError(f"delivery manifest mismatch for {entry['path']}")
        verified += 1
        try:
            container = Container.from_bytes(
                data, strict_size=True, max_plain_bytes=512 * 1024 * 1024
            )
        except Exception as exc:
            parse_failures.append(
                {"path": entry["path"], "error_type": type(exc).__name__}
            )
            continue
        parsed += 1
        no_op_exact += container.to_bytes() == data
        versions[container.version] += 1
        compression[str(container.compression_flag)] += 1
        encryption[str(container.encryption_flag)] += 1
        if container.trailer:
            trailer_lengths[str(len(container.trailer))] += 1
            witnesses.append(
                {
                    "path": entry["path"],
                    "file_sha256": entry["sha256"],
                    "trailer_bytes": len(container.trailer),
                    "trailer_sha256": sha256(container.trailer),
                    "known_intentional_u13_witness": entry["path"] == KNOWN_WITNESS,
                }
            )

    source_rows = [
        {"path": e["path"], "bytes": e["bytes"], "sha256": e["sha256"]}
        for e in itl_entries
    ]
    return {
        "schema": "windows-itl.retained-trailer-census-20260926.v1",
        "status": "completed_retained_corpus_census_u13_open",
        "generator": {
            "path": "scripts/research/audit_retained_trailer_census_20260926.py",
            "sha256": sha256(Path(__file__).read_bytes()),
        },
        "source_set": {
            "kind": "all .itl entries in DELIVERY-MANIFEST.json",
            "entries": len(source_rows),
            "canonical_path_size_hash_digest": sha256(canonical(source_rows)),
            "representative_sample": False,
        },
        "counts": {
            "manifest_hashes_verified": verified,
            "strict_container_parses": parsed,
            "parse_failures": len(parse_failures),
            "byte_exact_no_op_roundtrips": no_op_exact,
            "files_with_compressed_trailer": len(witnesses),
            "files_without_compressed_trailer": parsed - len(witnesses),
            "non_known_witness_files_with_trailer": sum(
                not row["known_intentional_u13_witness"] for row in witnesses
            ),
            "native_itunes_operations": 0,
            "network_operations": 0,
            "proprietary_binary_reads": 0,
            "production_code_changes": 0,
        },
        "distributions": {
            "versions": dict(sorted(versions.items())),
            "compression_flags": dict(sorted(compression.items())),
            "encryption_flags": dict(sorted(encryption.items())),
            "trailer_lengths": dict(sorted(trailer_lengths.items(), key=lambda x: int(x[0]))),
        },
        "trailer_witnesses": witnesses,
        "parse_failures": parse_failures,
        "claim_limits": [
            "The delivery corpus is curated and contains related snapshots, controls, generated files, and research candidates; it is not a representative sample of ITL files.",
            "The absence of additional trailers in this retained corpus does not establish trailer rarity, meaning, provenance, or semantic independence.",
            "The sole retained trailer witness is an intentional U-13 candidate and cannot establish naturally occurring trailer behavior.",
            "Container parse and byte-exact no-op round-trip are structural observations, not native iTunes acceptance or safe semantic editability.",
            "No Apple iTunes binary was read or launched; U-13 remains open and universal ITL support remains false.",
        ],
        "summary": {
            "only_trailer_witness_is_known_intentional_u13_candidate": len(witnesses) == 1
            and witnesses[0]["known_intentional_u13_witness"],
            "retained_corpus_prevalence_claim_supported": False,
            "trailer_semantics_recovered": False,
            "native_acceptance_established": False,
            "u13_status": "open",
            "universal_itl_support": False,
            "independent_reimplementation_passed": False,
        },
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    report = build_report()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
