#!/usr/bin/env python3
"""Re-audit the retained native PlayedDate matrix with the reference parser.

This script performs no native actions.  It hashes the frozen aggregate report,
parses the retained case-030 through case-038 ITL snapshots with
``REFERENCE_PARSER`` (which deliberately does not import ``itlkit``), compares
selected track fields against the historical aggregate, and derives only
bounded transition facts from those retained bytes.
"""
from __future__ import annotations

import argparse
from collections import Counter
from datetime import datetime
import hashlib
import json
from pathlib import Path
from typing import Any, Iterable

from REFERENCE_PARSER import ReferenceLibrary

ROOT = Path(__file__).resolve().parents[2]
SOURCE_SUMMARY = ROOT / "evidence" / "path-time" / "native" / "native-summary.json"
SNAPSHOT_ROOT = ROOT / "evidence" / "path-time" / "native" / "snapshots"
REFERENCE_CORE = ROOT / "REFERENCE_PARSER" / "core.py"
DEFAULT_OUTPUT = (
    ROOT / "evidence" / "research" / "20260925" / "path-time-retained-audit"
)
SELECTED_TRACK_FIELDS = (
    "track_id",
    "name",
    "date_added",
    "date_modified",
    "play_date",
    "skip_date",
)
DATE_FIELDS = ("date_added", "date_modified", "play_date", "skip_date")
PUBLIC_PRIOR_ART_URL = (
    "https://www.joabj.com/Writing/Tech/Tuts/Apps-APIs/iTunes-PlayDate.html"
)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def relative(path: Path) -> str:
    return path.resolve().relative_to(ROOT).as_posix()


def _snapshot_index(case: dict[str, Any]) -> int:
    prefix = case["name"].split("-", 1)[0]
    if not prefix.isdigit():
        raise ValueError(f"invalid case name: {case['name']!r}")
    return int(prefix)


def _snapshot_path(index: int, case_name: str | None = None) -> Path:
    if case_name is not None:
        path = SNAPSHOT_ROOT / f"{index:03d}-{case_name}.itl"
        if not path.is_file():
            raise FileNotFoundError(relative(path))
        return path
    matches = sorted(SNAPSHOT_ROOT.glob(f"{index:03d}-*.itl"))
    if len(matches) != 1:
        raise RuntimeError(
            f"expected one retained snapshot for index {index:03d}, got {len(matches)}"
        )
    return matches[0]


def _file_set_digest(paths: Iterable[Path]) -> str:
    digest = hashlib.sha256()
    for path in sorted(set(paths), key=relative):
        digest.update(relative(path).encode("utf-8"))
        digest.update(b"\0")
        digest.update(sha256_file(path).encode("ascii"))
        digest.update(b"\n")
    return digest.hexdigest()


def _track_map(summary: dict[str, Any]) -> dict[str, dict[str, Any]]:
    result: dict[str, dict[str, Any]] = {}
    for track in summary["tracks"]:
        persistent_id = track["persistent_id"]
        if not isinstance(persistent_id, str) or len(persistent_id) != 16:
            raise ValueError(f"invalid persistent ID: {persistent_id!r}")
        if persistent_id in result:
            raise ValueError(f"duplicate persistent ID: {persistent_id}")
        result[persistent_id] = track
    return result


def _selected(track: dict[str, Any]) -> dict[str, Any]:
    return {field: track.get(field) for field in SELECTED_TRACK_FIELDS}


def _wall_scalar(readback: str) -> int:
    value = datetime.fromisoformat(readback)
    wall = value.replace(tzinfo=None)
    delta = wall - datetime(1904, 1, 1)
    return delta.days * 86400 + delta.seconds


def _transition(
    before: dict[str, dict[str, Any]], after: dict[str, dict[str, Any]]
) -> dict[str, Any]:
    if set(before) != set(after):
        raise AssertionError("track persistent-ID set changed inside date transition cohort")
    field_counts: Counter[str] = Counter()
    changed_tracks = 0
    modified_deltas: set[int] = set()
    for persistent_id in sorted(before):
        changed = False
        for field in DATE_FIELDS:
            old = before[persistent_id].get(field)
            new = after[persistent_id].get(field)
            if old == new:
                continue
            changed = True
            field_counts[field] += 1
            if field == "date_modified":
                if not isinstance(old, int) or not isinstance(new, int):
                    raise AssertionError("date_modified transition is not integer-valued")
                modified_deltas.add(new - old)
        changed_tracks += int(changed)
    return {
        "changed_track_count": changed_tracks,
        "field_change_counts": dict(sorted(field_counts.items())),
        "date_modified_deltas_seconds": sorted(modified_deltas),
    }


def build_report() -> dict[str, Any]:
    source = json.loads(SOURCE_SUMMARY.read_text(encoding="utf-8-sig"))
    date_cases = source.get("date_cases")
    if not isinstance(date_cases, list) or not date_cases:
        raise ValueError("retained aggregate has no date_cases list")

    cache: dict[Path, dict[str, Any]] = {}

    def parse(path: Path) -> dict[str, Any]:
        if path not in cache:
            cache[path] = ReferenceLibrary.read(path).semantic_summary()
        return cache[path]

    rows: list[dict[str, Any]] = []
    compared_values = 0
    for case in date_cases:
        index = _snapshot_index(case)
        path = _snapshot_path(index, case["name"])
        previous_path = _snapshot_path(index - 1)
        independent = parse(path)
        previous = parse(previous_path)
        reported = case["decoded_after"]

        if independent["sha256"] != reported["sha256"]:
            raise AssertionError(f"snapshot hash mismatch for {case['name']}")
        if independent["version"] != reported["version"]:
            raise AssertionError(f"version mismatch for {case['name']}")
        if len(independent["tracks"]) != reported["track_count"]:
            raise AssertionError(f"track count mismatch for {case['name']}")

        independent_tracks = _track_map(independent)
        reported_tracks = _track_map({"tracks": reported["tracks"]})
        if set(independent_tracks) != set(reported_tracks):
            raise AssertionError(f"track identity mismatch for {case['name']}")
        for persistent_id in sorted(independent_tracks):
            left = _selected(independent_tracks[persistent_id])
            right = _selected(reported_tracks[persistent_id])
            if left != right:
                raise AssertionError(
                    f"selected track-field mismatch for {case['name']} {persistent_id}: "
                    f"{left!r} != {right!r}"
                )
            compared_values += len(SELECTED_TRACK_FIELDS)

        target_name = case["name"].split("-set-", 1)[1]
        targets = [track for track in independent["tracks"] if track.get("name") == target_name]
        if len(targets) != 1:
            raise AssertionError(
                f"expected one target named {target_name!r}, found {len(targets)}"
            )
        target = targets[0]
        before_tracks = _track_map(previous)
        before_target = before_tracks[target["persistent_id"]]
        action = case["action_result"]
        outcome = action["outcome"]
        expected_wall_scalar = None
        if outcome == "accepted":
            expected_wall_scalar = _wall_scalar(action["com_readback"])
            if target["play_date"] != expected_wall_scalar:
                raise AssertionError(
                    f"wall scalar mismatch for {case['name']}: "
                    f"{target['play_date']} != {expected_wall_scalar}"
                )
        elif outcome != "rejected_or_failed":
            raise ValueError(f"unknown date-case outcome: {outcome!r}")

        row = {
            "name": case["name"],
            "timezone": case["timezone"],
            "input": case["input"],
            "action": {
                "outcome": outcome,
                "com_readback": action.get("com_readback"),
                "error": action.get("error"),
            },
            "snapshot": {
                "path": relative(path),
                "sha256": independent["sha256"],
                "version": independent["version"],
                "track_count": len(independent["tracks"]),
            },
            "target": {
                "name": target_name,
                "persistent_id": target["persistent_id"],
                "play_date_before": before_target["play_date"],
                "play_date_after": target["play_date"],
                "expected_wall_scalar_from_com_readback": expected_wall_scalar,
            },
            "reference_parser_selected_date_transition": _transition(
                before_tracks, independent_tracks
            ),
        }
        rows.append(row)

    by_name = {row["name"]: row for row in rows}
    common_names = (
        "031-set-date-naive-utc",
        "032-set-date-aware-utc",
        "033-set-date-naive-eastern",
        "034-set-date-aware-instant",
    )
    common_scalars = sorted({by_name[name]["target"]["play_date_after"] for name in common_names})
    if common_scalars != [3851325296]:
        raise AssertionError(f"unexpected common wall scalar cohort: {common_scalars}")
    timezone_transition = by_name["033-set-date-naive-eastern"][
        "reference_parser_selected_date_transition"
    ]
    if timezone_transition != {
        "changed_track_count": 23,
        "field_change_counts": {"date_modified": 23, "play_date": 1},
        "date_modified_deltas_seconds": [-14400],
    }:
        raise AssertionError(f"unexpected timezone transition: {timezone_transition!r}")

    accepted = [row for row in rows if row["action"]["outcome"] == "accepted"]
    rejected = [row for row in rows if row["action"]["outcome"] == "rejected_or_failed"]
    parsed_snapshots = sorted(cache, key=relative)
    return {
        "schema": "windows-itl.path-time-retained-audit.v1",
        "report_date": "2026-09-25",
        "scope": {
            "source_summary": relative(SOURCE_SUMMARY),
            "source_summary_sha256": sha256_file(SOURCE_SUMMARY),
            "reference_parser_core": relative(REFERENCE_CORE),
            "reference_parser_core_sha256": sha256_file(REFERENCE_CORE),
            "retained_snapshots_parsed": len(parsed_snapshots),
            "retained_snapshot_paths": [relative(path) for path in parsed_snapshots],
            "retained_snapshot_file_set_sha256": _file_set_digest(parsed_snapshots),
            "native_actions_performed": False,
            "frozen_evidence_modified": False,
            "parser_boundary": (
                "REFERENCE_PARSER is a second checked-in parser that deliberately does not "
                "import itlkit; it is not a new native experiment or an external oracle."
            ),
        },
        "summary": {
            "date_cases": len(rows),
            "accepted": len(accepted),
            "rejected_or_failed": len(rejected),
            "case_snapshots_cross_checked": len(rows),
            "selected_track_field_values_cross_checked": compared_values,
            "tracks_per_case_snapshot": sorted(
                {row["snapshot"]["track_count"] for row in rows}
            ),
            "versions": sorted({row["snapshot"]["version"] for row in rows}),
        },
        "cases": rows,
        "findings": {
            "four_equal_wall_tuple_scalars": {
                "case_names": list(common_names),
                "scalar": common_scalars[0],
                "bounded_meaning": (
                    "These four retained cases serialize the displayed 2026-01-15 "
                    "12:34:56 wall tuple as the same uint32 despite UTC/Eastern and "
                    "naive/aware COM inputs."
                ),
            },
            "aware_utc_input_converted_before_storage": {
                "case_name": "034-set-date-aware-instant",
                "input": by_name["034-set-date-aware-instant"]["input"],
                "com_readback": by_name["034-set-date-aware-instant"]["action"]["com_readback"],
                "stored_scalar": by_name["034-set-date-aware-instant"]["target"]["play_date_after"],
            },
            "gap_normalization": {
                "case_name": "036-set-date-gap",
                "input": by_name["036-set-date-gap"]["input"],
                "com_readback": by_name["036-set-date-gap"]["action"]["com_readback"],
                "stored_scalar": by_name["036-set-date-gap"]["target"]["play_date_after"],
            },
            "timezone_transition": {
                "case_name": "033-set-date-naive-eastern",
                **timezone_transition,
                "date_added_change_count": 0,
                "skip_date_change_count": 0,
                "bounded_meaning": (
                    "Across the retained 032->033 transition, all 23 separately parsed "
                    "date_modified values moved by -14,400 seconds, while date_added and "
                    "skip_date did not change; one target play_date was also set. Cause is "
                    "not established."
                ),
            },
            "epoch_boundary_failures": {
                "case_names": [row["name"] for row in rejected],
                "errors": [row["action"]["error"] for row in rejected],
                "reference_parser_date_field_changes": [
                    row["reference_parser_selected_date_transition"] for row in rejected
                ],
                "bounded_meaning": (
                    "Both retained assignments failed at the Python/COM boundary and made "
                    "no separately parsed date-field transition. This does not prove raw "
                    "ITL scalar 0 or 1 rejection."
                ),
            },
            "u11_closed": False,
        },
        "public_prior_art": {
            "url": PUBLIC_PRIOR_ART_URL,
            "classification": "historical iTunes XML observation; not binary-ITL native evidence",
            "bounded_use": (
                "The article independently associates XML Play Date integers with seconds "
                "since 1904-01-01. It does not establish the retained binary ITL wall-time, "
                "DST, COM marshalling, or cross-version behavior audited here."
            ),
        },
        "limitations": [
            "This is a deterministic re-audit of one already-retained native run, not an independent native reproduction.",
            "Only PlayedDate on standalone Windows iTunes 12.13.10.3 is represented by these eight actions.",
            "The 23-track -14,400-second date_modified shift is observed, but its cause is not isolated.",
            "The fold case does not retain a second fold choice, and no offset/fold metadata is established.",
            "The epoch cases failed before successful COM assignment; raw-writer acceptance remains untested.",
            "Other date fields, zones, locales, versions, file timestamps, and epoch boundaries remain unresolved.",
            "U-11 remains open.",
        ],
    }


def render_markdown(report: dict[str, Any]) -> str:
    findings = report["findings"]
    lines = [
        "# Retained PlayedDate / timezone audit (2026-09-25)",
        "",
        "## Result",
        "",
        "A second checked-in parser reproduced the selected date fields in all eight retained case snapshots. Cases 031–034 share raw `play_date=3851325296`; the Eastern aware-input case converted `2026-01-15T17:34:56+00:00` to displayed `12:34:56` before that same wall-tuple scalar was stored. The retained DST-gap input `02:30` read back and serialized as `03:30` (`3855785400`).",
        "",
        "The second-parser 032→033 snapshot comparison also finds all 23 `date_modified` values shifted by exactly -14,400 seconds, no `date_added` or `skip_date` changes, and one target `play_date` set. This is a bounded observation; it does not establish the cause.",
        "",
        "| case | zone | input | outcome | COM readback | stored play_date | selected date-field transition |",
        "|---|---|---|---|---|---:|---|",
    ]
    for row in report["cases"]:
        action = row["action"]
        transition = row["reference_parser_selected_date_transition"]
        readback = action["com_readback"] or action["error"]
        lines.append(
            f"| `{row['name']}` | {row['timezone']} | `{row['input']}` | "
            f"{action['outcome']} | `{readback}` | {row['target']['play_date_after']} | "
            f"{transition['field_change_counts']} |"
        )
    lines.extend(
        [
            "",
            "## Evidence boundary",
            "",
            f"- source aggregate SHA-256: `{report['scope']['source_summary_sha256']}`",
            f"- retained snapshots parsed: **{report['scope']['retained_snapshots_parsed']}** (case 030 baseline plus cases 031–038)",
            f"- case snapshots cross-checked against the aggregate: **{report['summary']['case_snapshots_cross_checked']}**",
            f"- selected track-field values cross-checked: **{report['summary']['selected_track_field_values_cross_checked']}**",
            f"- snapshot file-set SHA-256: `{report['scope']['retained_snapshot_file_set_sha256']}`",
            "- the comparison count is a parser-consistency count, not a count of native experiments",
            "- no native action was performed and no frozen evidence was modified",
            "",
            "`REFERENCE_PARSER` deliberately does not import `itlkit`, but it is still a repository-local implementation rather than an external oracle. The native observations remain limited to the exact retained installer, environment, files, actions, and save sequence.",
            "",
            "## Epoch boundary and public prior art",
            "",
            findings["epoch_boundary_failures"]["bounded_meaning"],
            "",
            f"Historical XML prior art at {PUBLIC_PRIOR_ART_URL} also associates Play Date integers with seconds since 1904-01-01. It is not binary-ITL or current-native evidence and does not prove the wall-time/DST behavior above.",
            "",
            "## What remains open",
            "",
            "No other date field, second fold choice, raw scalar 0/1 writer candidate, additional zone/locale, filesystem-timestamp cause, or iTunes version is qualified here. **U-11 remains open.**",
            "",
            "## Reproduce",
            "",
            "```bash",
            "python scripts/research/audit_path_time_retained_20260925.py",
            "python -m pytest -q -p no:cacheprovider tests/test_path_time_retained_20260925.py",
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
                "date_cases": report["summary"]["date_cases"],
                "accepted": report["summary"]["accepted"],
                "rejected_or_failed": report["summary"]["rejected_or_failed"],
                "snapshot_file_set_sha256": report["scope"][
                    "retained_snapshot_file_set_sha256"
                ],
                "u11_closed": False,
            },
            indent=2,
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
