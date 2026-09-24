"""Rebuild the aggregate corpus and exact delivery manifests deterministically."""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
GENERATED_METADATA_DIR = "windows_itl_research.egg-info"
DELIVERY_EXCLUDED_ROOT_DIRS = {".git", GENERATED_METADATA_DIR}
DELIVERY_EXCLUDED_ROOT_DIRS_FOLDED = {name.casefold() for name in DELIVERY_EXCLUDED_ROOT_DIRS}


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
    if rel.startswith("evidence/research/20260925/native-trailer-u13/"):
        return "native_trailer_u13_bounded_matrix", {
            "qualification": (
                "two exact candidate inputs and four native saves from one control/candidate pair; "
                "six retained occurrences are not six independent experiments"
            ),
        }
    if rel.startswith("evidence/research/20260925/native-rating-kind/"):
        return "native_rating_bounded_matrix", {
            "qualification": (
                "20 native-saved snapshots plus eight repeated baseline copies; "
                "see native-rating-kind report and integration addendum; occurrences are not independent runs"
            ),
        }
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
        "evidence/native/media-field-followup-20260922/summary.json",
        "evidence/native/media-field-followup-20260922-v2/summary.json",
        "evidence/native/media-lyrics-ascii-20260922/summary.json",
        "evidence/native/media-field-followup-20260922-mp3-ascii-v3/summary.json",
        "evidence/native/media-field-followup-20260922-mp3-ascii-v3/id3-rewrite-analysis.json",
        "evidence/native/lyrics-authority-20260922/summary.json",
        "evidence/native/media-lyrics-boundary-20260922/summary.json",
        "evidence/native/media-lyrics-boundary-20260922/unicode-id3-rewrite-analysis.json",
        "evidence/native/media-lyrics-extended-boundary-20260922/summary.json",
        "evidence/native/media-lyrics-extended-boundary-20260922/ascii-065536-id3-rewrite-analysis.json",
        "evidence/native/media-lyrics-ceiling-20260922/summary.json",
        "evidence/native/media-lyrics-ceiling-20260922/lyrics-016777209-frame-analysis.json",
        "evidence/native/media-lyrics-ceiling-20260922/lyrics-016777210-frame-analysis.json",
        "evidence/independent/itl-rs-20260922/conformance-summary.json",
        "evidence/native/smart-playlist-default-20260922/probe-series-summary.json",
        "evidence/research/20260925/trailer-coverage-audit/report.json",
        "evidence/research/20260925/native-trailer-u13/generation.json",
        "evidence/research/20260925/native-trailer-u13/analysis.json",
        "evidence/research/20260925/native-trailer-u13/native-run/summary.json",
        "evidence/research/20260925/coverage-guided-fuzz/report.json",
        "evidence/research/20260925/filesystem-threat-model/report.json",
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
            "media_field_followup_note": "first run failed a harness identity gate before mutation; corrected WAV cases retain three exact mutation failures; 17 exact MP3 Lyrics cases passed mutation/restart, and nine additional ceiling cases are qualified native non-exact immediate readbacks rather than harness failures",
            "lyrics_ceiling_note": "one deterministic MP3/ID3v2.2/ULT/COM/build path has an exact 16,777,209-character result adjacent to a native non-exact 16,777,210-character result; retained reports prove unsigned-24-bit frame-size wrap, not a universal Lyrics limit",
            "lyrics_authority_note": "three exact reset-ITL probes followed the supplied MP3 ID3v2.2 ULT input; one track/build only, with hidden caches and general authority unresolved",
            "external_interop_note": "one exact structural no-op passed native cycles; semantic reimplementation remains false",
            "smart_playlist_note": "native nested framing observed; operand and membership gates failed",
            "native_rating_note": "20 native-saved snapshots and eight repeated baseline copies narrow Rating/RatingKind behavior for one exact build/profile; snapshot occurrences are not independent experiments",
            "native_trailer_note": "one exact 17-byte opaque-trailer candidate and its trailer-free control each passed two native cycles; the candidate trailer was stripped on first save; retained copies and repeated saves are not independent experiments",
            "coverage_guided_note": "20,000 deterministic offline mutations completed without a retained anomaly; coarse line-transition guidance is not proof of parser safety or native acceptance",
            "filesystem_publication_note": "21 deterministic Linux case scenarios bound stable-parent guarantees and demonstrate the existing hostile-parent exclusion; scenarios are not independent experiments, no power loss was simulated, production code was unchanged, and U-17 remains open",
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
            dirs[:] = sorted(
                d for d in dirs if d.casefold() not in DELIVERY_EXCLUDED_ROOT_DIRS_FOLDED
            )
        else:
            dirs.sort()
        for name in sorted(files):
            if base_path == ROOT and name.casefold() == ".git":
                continue
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
