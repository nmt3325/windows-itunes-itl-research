"""Rebuild the aggregate corpus and exact delivery manifests deterministically."""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def digest(path: Path) -> str:
    value = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            value.update(chunk)
    return value.hexdigest()


def file_row(path: Path) -> dict:
    return {
        "path": path.relative_to(ROOT).as_posix(),
        "bytes": path.stat().st_size,
        "sha256": digest(path),
    }


def classify_itl(path: Path) -> tuple[str, dict]:
    rel = path.relative_to(ROOT).as_posix()
    if rel.startswith("TEST_CORPUS/generated/"):
        sidecar = Path(str(path) + ".provenance.json")
        acceptance = "unverified"
        evidence = None
        if sidecar.is_file():
            provenance = json.loads(sidecar.read_text(encoding="utf-8"))
            native = provenance.get("native_acceptance", {})
            acceptance = native.get("status", "unverified")
            evidence = native.get("evidence")
        extra = {
            "template_reused": False,
            "native_acceptance": acceptance,
        }
        if evidence is not None:
            extra["native_acceptance_evidence"] = evidence
        return "independent_from_scratch_generated", extra
    if rel.startswith("evidence/independent/itl-rs-20260922/"):
        return "external_independent_interop_candidate", {
            "qualification": "see conformance summary; structural preservation is not semantic interoperability",
        }
    if rel.startswith("evidence/native/fresh-20260921/snapshots/"):
        return "native_itunes_fresh_library", {
            "producer": "iTunes 12.13.10.3",
            "reference_writer_acceptance": "not_applicable",
        }
    if rel.startswith("evidence/path-time/native/snapshots/"):
        return "native_itunes_path_time_sequence", {
            "producer": "iTunes 12.13.10.3",
            "reference_writer_acceptance": "not_applicable",
        }
    if rel.startswith("evidence/native/"):
        return "archived_native_or_exact_candidate", {
            "qualification": "see per-case evidence; presence is not acceptance",
        }
    return "other_itl_fixture", {"qualification": "see source evidence"}


def build_corpus() -> dict:
    rows = []
    counts: dict[str, int] = {}
    for path in sorted(ROOT.rglob("*.itl"), key=lambda p: p.relative_to(ROOT).as_posix()):
        if ".git" in path.parts:
            continue
        corpus_class, extra = classify_itl(path)
        row = file_row(path)
        row["corpus_class"] = corpus_class
        row.update(extra)
        rows.append(row)
        counts[corpus_class] = counts.get(corpus_class, 0) + 1
    references = []
    for name in (
        "TEST_CORPUS/corpus-manifest.json",
        "evidence/native/fresh-20260921/manifest.json",
        "evidence/path-time/manifest.json",
        "evidence/smart-playlist/corpus-census.json",
        "evidence/smart-playlist/prior-art-manifest.json",
        "evidence/native/reference-generated-20260922-passed/qualification-summary.json",
        "evidence/native/reference-multi-track-20260922-v2/qualification-summary.json",
        "evidence/native/reference-multi-track-20260922/summary.json",
        "evidence/native/field-matrix-20260922/summary.json",
        "evidence/independent/itl-rs-20260922/conformance-summary.json",
        "evidence/native/smart-playlist-default-20260922/probe-series-summary.json",
    ):
        path = ROOT / name
        if path.is_file():
            references.append(file_row(path))
    return {
        "schema": "windows-itunes-itl.aggregate-corpus-manifest.v1",
        "hash_algorithm": "sha256",
        "manifest_self_included": False,
        "target": "Windows Apple desktop x64 iTunes 12.13.10.3; secondary observed 12.13.9.1",
        "qualification": {
            "complete_analysis_claim": False,
            "reference_writer_from_scratch_native_acceptance": "verified_for_four_exact_hashes",
            "reference_writer_acceptance_boundary": "No arbitrary values, counts, media kinds, versions, or unknown fields are implied.",
            "fresh_native_library_note": "created by iTunes itself; not evidence that the reference writer is accepted",
            "path_time_note": "native iTunes saves for a bounded matrix; not arbitrary writer acceptance",
            "field_matrix_note": "27 exact passes and two retained failures; not complete field support",
            "external_interop_note": "one exact structural no-op passed native cycles; semantic reimplementation remains false",
            "smart_playlist_note": "native nested framing observed; operand and membership gates failed",
        },
        "summary": {"itl_file_count": len(rows), "by_class": counts},
        "referenced_manifests_and_analyses": references,
        "itl_files": rows,
    }


def build_delivery() -> list[dict]:
    rows = []
    for base, dirs, files in os.walk(ROOT, followlinks=False):
        base_path = Path(base)
        if base_path == ROOT:
            dirs[:] = sorted(d for d in dirs if d != ".git")
        else:
            dirs.sort()
        for name in sorted(files):
            path = base_path / name
            rel = path.relative_to(ROOT).as_posix()
            if rel == "DELIVERY-MANIFEST.json":
                continue
            if path.is_symlink() or not path.is_file():
                raise RuntimeError(f"refusing non-regular delivery path: {rel}")
            rows.append(file_row(path))
    rows.sort(key=lambda row: row["path"])
    return rows


def write_json(path: Path, value: object) -> None:
    path.write_text(
        json.dumps(value, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
        newline="\n",
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--corpus", action="store_true")
    parser.add_argument("--delivery", action="store_true")
    args = parser.parse_args()
    if not args.corpus and not args.delivery:
        args.corpus = args.delivery = True
    if args.corpus:
        write_json(ROOT / "corpus-manifest.json", build_corpus())
    if args.delivery:
        write_json(ROOT / "DELIVERY-MANIFEST.json", build_delivery())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
