#!/usr/bin/env python3
"""Audit retained native COM observations of RatingKind and AlbumRatingKind.

The input roots are deliberately frozen historical evidence directories.  Raw
JSON occurrences are counted for reproducibility, but they are not treated as
independent native runs because summaries and worker results embed copies of
some of the same observations.
"""
from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
from typing import Any, Iterable

ROOT = Path(__file__).resolve().parents[2]
INPUT_ROOTS = (
    ROOT / "evidence" / "native" / "field-matrix-20260922",
    ROOT / "evidence" / "native" / "oracles",
    ROOT / "evidence" / "native" / "phase3",
    ROOT / "evidence" / "independent" / "itl-rs-20260922" / "native-accepted",
    ROOT / "evidence" / "static" / "phase3",
)
DEFAULT_OUTPUT = (
    ROOT / "evidence" / "research" / "20260925" / "rating-kind-corpus-audit"
)
STATE_KEYS = ("Rating", "RatingKind", "AlbumRating", "AlbumRatingKind")
IDENTITY_KEYS = ("Name", "PersistentID", "TrackID")
PUBLIC_PRIOR_ART_URL = "https://documentation.help/iTunesCOM/documentation.pdf"


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def relative(path: Path) -> str:
    return path.resolve().relative_to(ROOT).as_posix()


def _pointer_component(value: object) -> str:
    return str(value).replace("~", "~0").replace("/", "~1")


def _collect(
    value: Any, *, source: str, pointer: str, observations: list[dict[str, Any]]
) -> None:
    if isinstance(value, dict):
        if set(STATE_KEYS).issubset(value):
            state = {key: value[key] for key in STATE_KEYS}
            for key, item in state.items():
                if not isinstance(item, int) or isinstance(item, bool):
                    raise ValueError(f"{source}{pointer}: {key} is not an integer: {item!r}")
            observations.append(
                {
                    "source": source,
                    "json_pointer": pointer or "/",
                    "identity": {key: value.get(key) for key in IDENTITY_KEYS},
                    "state": state,
                }
            )
        for key in sorted(value):
            _collect(
                value[key],
                source=source,
                pointer=f"{pointer}/{_pointer_component(key)}",
                observations=observations,
            )
    elif isinstance(value, list):
        for index, item in enumerate(value):
            _collect(
                item,
                source=source,
                pointer=f"{pointer}/{index}",
                observations=observations,
            )


def _input_files() -> tuple[list[Path], dict[str, int]]:
    files: list[Path] = []
    counts: dict[str, int] = {}
    for root in INPUT_ROOTS:
        if not root.is_dir():
            raise FileNotFoundError(relative(root))
        root_files = sorted(root.rglob("*.json"), key=relative)
        counts[relative(root)] = len(root_files)
        files.extend(root_files)
    unique = sorted(set(files), key=relative)
    if len(unique) != len(files):
        raise AssertionError("input roots overlap")
    return unique, counts


def _state_tuple(observation: dict[str, Any]) -> tuple[int, int, int, int]:
    return tuple(observation["state"][key] for key in STATE_KEYS)  # type: ignore[return-value]


def _state_key(state: tuple[int, int, int, int]) -> str:
    return "|".join(f"{key}={value}" for key, value in zip(STATE_KEYS, state, strict=True))


def build_report() -> dict[str, Any]:
    files, root_counts = _input_files()
    file_set_digest = hashlib.sha256()
    observations: list[dict[str, Any]] = []
    for path in files:
        label = relative(path)
        digest = sha256_file(path)
        file_set_digest.update(label.encode("utf-8"))
        file_set_digest.update(b"\0")
        file_set_digest.update(digest.encode("ascii"))
        file_set_digest.update(b"\n")
        document = json.loads(path.read_text(encoding="utf-8-sig"))
        _collect(document, source=label, pointer="", observations=observations)

    observations.sort(key=lambda item: (item["source"], item["json_pointer"]))
    state_counts = Counter(_state_tuple(item) for item in observations)
    witnesses: dict[tuple[int, int, int, int], dict[str, Any]] = {}
    for item in observations:
        witnesses.setdefault(_state_tuple(item), item)

    unique_source_identity_states = {
        json.dumps(
            {
                "source": item["source"],
                "identity": item["identity"],
                "state": item["state"],
            },
            sort_keys=True,
            ensure_ascii=False,
        )
        for item in observations
    }
    states = [
        {
            "key": _state_key(state),
            "values": dict(zip(STATE_KEYS, state, strict=True)),
            "raw_occurrences": state_counts[state],
            "first_witness": witnesses[state],
        }
        for state in sorted(state_counts)
    ]
    track_kind_codes = sorted({state[1] for state in state_counts})
    album_kind_codes = sorted({state[3] for state in state_counts})
    nonzero_track_by_kind = {
        str(kind): sorted({state[0] for state in state_counts if state[0] and state[1] == kind})
        for kind in track_kind_codes
    }
    nonzero_album_by_kind = {
        str(kind): sorted({state[2] for state in state_counts if state[2] and state[3] == kind})
        for kind in album_kind_codes
    }

    return {
        "schema": "windows-itl.rating-kind-corpus-audit.v1",
        "report_date": "2026-09-25",
        "scope": {
            "input_roots": [relative(root) for root in INPUT_ROOTS],
            "json_files_by_root": root_counts,
            "json_files_total": len(files),
            "input_file_set_sha256": file_set_digest.hexdigest(),
            "native_actions_performed": False,
            "repository_writes_to_frozen_evidence": False,
            "raw_occurrences_are_independent_runs": False,
        },
        "summary": {
            "raw_observations": len(observations),
            "unique_source_identity_states": len(unique_source_identity_states),
            "distinct_joint_states": len(states),
            "track_rating_kind_codes": track_kind_codes,
            "album_rating_kind_codes": album_kind_codes,
            "nonzero_track_rating_values_by_kind_code": nonzero_track_by_kind,
            "nonzero_album_rating_values_by_kind_code": nonzero_album_by_kind,
        },
        "states": states,
        "findings": {
            "track_rating_value_alone_determines_kind": False,
            "album_rating_value_alone_determines_kind": False,
            "nonzero_computed_track_witness": witnesses[(60, 1, 60, 0)],
            "nonzero_computed_album_witness": witnesses[(80, 0, 80, 1)],
            "bounded_conclusion": (
                "In this frozen corpus, non-zero values coexist with both raw kind codes. "
                "The exact album-rating-explicit witness has Rating=60/RatingKind=1 and "
                "AlbumRating=60/AlbumRatingKind=0; the rating-explicit witness has "
                "Rating=80/RatingKind=0 and AlbumRating=80/AlbumRatingKind=1. "
                "Therefore neither kind can be inferred from zero/non-zero value alone."
            ),
        },
        "public_prior_art": {
            "url": PUBLIC_PRIOR_ART_URL,
            "classification": "historical COM documentation; not current-native evidence",
            "bounded_use": (
                "The document names raw enum codes 0/1 as user/computed and exposes "
                "RatingKind as read-only. The corpus audit above is derived independently "
                "from retained repository evidence."
            ),
        },
        "limitations": [
            "The JSON occurrence count includes summaries and worker artifacts that duplicate observations.",
            "Only four joint states occur in the fixed retained roots; this is not an exhaustive state matrix.",
            "No Loved or Disliked transition is present in this audit.",
            "No RatingKind or AlbumRatingKind setter was attempted; both remain observe-only here.",
            "The audit does not map these COM values to ITL byte offsets or prove other iTunes versions.",
            "U-14 remains open.",
        ],
    }


def render_markdown(report: dict[str, Any]) -> str:
    lines = [
        "# RatingKind / AlbumRatingKind retained-corpus audit (2026-09-25)",
        "",
        "## Result",
        "",
        report["findings"]["bounded_conclusion"],
        "",
        "This is a deterministic census of frozen JSON evidence. It did not launch iTunes or modify native evidence. Raw occurrences are reproducibility counts, not independent runs.",
        "",
        "| Rating | RatingKind | AlbumRating | AlbumRatingKind | raw occurrences | first witness |",
        "|---:|---:|---:|---:|---:|---|",
    ]
    for state in report["states"]:
        values = state["values"]
        witness = state["first_witness"]
        location = f"`{witness['source']}#{witness['json_pointer']}`"
        lines.append(
            f"| {values['Rating']} | {values['RatingKind']} | {values['AlbumRating']} | "
            f"{values['AlbumRatingKind']} | {state['raw_occurrences']} | {location} |"
        )
    lines.extend(
        [
            "",
            "## Evidence boundary",
            "",
            f"- JSON files: **{report['scope']['json_files_total']}**",
            f"- raw matching objects: **{report['summary']['raw_observations']}**",
            f"- distinct joint states: **{report['summary']['distinct_joint_states']}**",
            f"- input file-set SHA-256: `{report['scope']['input_file_set_sha256']}`",
            "- repeated summary/result copies are explicitly not counted as independent experiments",
            "",
            "The retained `album-rating-explicit` state is the decisive counterexample to a zero/non-zero shortcut: a non-zero track Rating of 60 has raw RatingKind 1 while the explicit AlbumRating 60 has raw AlbumRatingKind 0. Conversely, `rating-explicit` retains AlbumRating 80 with raw AlbumRatingKind 1. Value and kind must therefore remain separate fields.",
            "",
            "Historical iTunes COM documentation at " + PUBLIC_PRIOR_ART_URL + " names codes 0/1 as user/computed and documents `RatingKind` as read-only. That naming is prior art; the state table and witnesses come from repository evidence.",
            "",
            "## What remains open",
            "",
            "This audit does not cover Loved/Disliked transitions, does not attempt kind setters, does not map COM state to an ITL byte, and does not generalize beyond the fixed retained corpus. **U-14 remains open.**",
            "",
            "## Reproduce",
            "",
            "```bash",
            "python scripts/research/audit_rating_kind_corpus_20260925.py",
            "python -m pytest -q -p no:cacheprovider tests/test_rating_kind_corpus_20260925.py",
            "```",
            "",
        ]
    )
    return "\n".join(lines)


def write_outputs(output_dir: Path) -> dict[str, Any]:
    report = build_report()
    output_dir.mkdir(parents=True, exist_ok=True)
    (output_dir / "report.json").write_text(
        json.dumps(report, indent=2, sort_keys=True, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    (output_dir / "README.md").write_text(render_markdown(report), encoding="utf-8")
    return report


def _parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, default=DEFAULT_OUTPUT)
    return parser


def main(argv: Iterable[str] | None = None) -> int:
    args = _parser().parse_args(argv)
    report = write_outputs(args.output_dir)
    print(
        json.dumps(
            {
                "report": relative(args.output_dir / "report.json")
                if (args.output_dir / "report.json").resolve().is_relative_to(ROOT)
                else str(args.output_dir / "report.json"),
                "json_files": report["scope"]["json_files_total"],
                "raw_observations": report["summary"]["raw_observations"],
                "distinct_joint_states": report["summary"]["distinct_joint_states"],
                "u14_closed": False,
            },
            indent=2,
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
