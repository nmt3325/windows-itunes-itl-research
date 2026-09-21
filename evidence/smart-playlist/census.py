#!/usr/bin/env python3
"""Regenerate compact, content-addressed smart-playlist corpus evidence."""
from __future__ import annotations

import argparse
import collections
import hashlib
import json
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

from itlkit import Library  # noqa: E402
from itlkit.binary import uint  # noqa: E402
from itlkit.smart import dump_preferences, dump_rules, parse_rules  # noqa: E402

SCHEMA = "windows-itunes-itl-smart-playlist-census.v1"


def _sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _tracked_itl_files() -> list[Path]:
    output = subprocess.check_output(
        ["git", "-C", str(REPO), "ls-files", "--", "*.itl"], text=True,
    )
    return [REPO / line for line in output.splitlines() if line]


def _special_kind(playlist) -> int | None:
    return uint(playlist.node.header, 0x238) if len(playlist.node.header) >= 0x23C else None


def _group_id(type_code: int, payload: bytes) -> str:
    return f"mhoh-{type_code}-{_sha(payload)[:16]}"


def _walk_rules(rules, stats: dict[str, object]) -> None:
    stats["max_depth"] = max(stats["max_depth"], rules.depth)
    stats["conjunctions"].add(rules.conjunction)
    stats["version_words"].add(rules.version_word)
    stats["slst_lengths"].append(len(rules.to_bytes()))
    stats["nonzero_slst_opaque"] += int(any(rules.opaque_header))
    stats["trailing_slst"] += int(bool(rules.trailing))
    for rule in rules.rules:
        stats["fields"][rule.field_id] += 1
        stats["actions"][rule.action_id] += 1
        stats["data_lengths"][len(rule.data)] += 1
        stats["string_candidates"] += int(rule.string_candidate)
        stats["nonzero_rule_opaque"] += int(any(rule.opaque_header))
        if rule.nested is not None:
            stats["nested_groups"] += 1
            _walk_rules(rule.nested, stats)


def generate() -> dict:
    files = _tracked_itl_files()
    file_rows: list[dict] = []
    occurrences: list[dict] = []
    groups: dict[str, dict] = {}
    errors: list[dict] = []
    versions: collections.Counter[str] = collections.Counter()
    stats = {
        "fields": collections.Counter(),
        "actions": collections.Counter(),
        "data_lengths": collections.Counter(),
        "conjunctions": set(),
        "version_words": set(),
        "slst_lengths": [],
        "string_candidates": 0,
        "nested_groups": 0,
        "nonzero_slst_opaque": 0,
        "nonzero_rule_opaque": 0,
        "trailing_slst": 0,
        "max_depth": 0,
    }

    def intern(type_code: int, payload: bytes) -> str:
        group_id = _group_id(type_code, payload)
        if group_id not in groups:
            group = {
                "type_code": type_code,
                "sha256": _sha(payload),
                "length": len(payload),
                "payload_hex": payload.hex(),
                "occurrence_count": 0,
                "examples": [],
            }
            if type_code == 101:
                group["parsed"] = dump_rules(payload)
            elif type_code == 102:
                group["parsed"] = dump_preferences(payload)
            groups[group_id] = group
        return group_id

    for path in files:
        rel = path.relative_to(REPO).as_posix()
        raw = path.read_bytes()
        row = {"path": rel, "size": len(raw), "sha256": _sha(raw)}
        try:
            library = Library.from_bytes(raw)
            versions[library.container.version] += 1
            row.update({
                "version": library.container.version,
                "track_count": len(library.tracks),
                "playlist_count": len(library.playlists),
            })
            smart_count = 0
            for playlist in library.playlists:
                children = [child for child in playlist.node.children or () if child.tag == b"mhoh"]
                by_type = {
                    type_code: [child for child in children if child.type_code == type_code]
                    for type_code in (101, 102, 103)
                }
                if not by_type[101] and not by_type[102] and not by_type[103]:
                    continue
                smart_count += 1
                for child in by_type[101]:
                    _walk_rules(parse_rules(child.payload), stats)
                references = {
                    str(type_code): [intern(type_code, child.payload) for child in by_type[type_code]]
                    for type_code in (101, 102, 103)
                    if by_type[type_code]
                }
                occurrence = {
                    "path": rel,
                    "playlist_name": playlist.name,
                    "persistent_id": f"{playlist.persistent_id:016X}",
                    "special_kind": _special_kind(playlist),
                    "groups": references,
                }
                occurrences.append(occurrence)
                example = {
                    "path": rel,
                    "playlist_name": playlist.name,
                    "persistent_id": occurrence["persistent_id"],
                }
                for group_ids in references.values():
                    for group_id in group_ids:
                        groups[group_id]["occurrence_count"] += 1
                        if len(groups[group_id]["examples"]) < 3 and example not in groups[group_id]["examples"]:
                            groups[group_id]["examples"].append(example)
            row["smart_playlist_count"] = smart_count
        except Exception as exc:  # Evidence generator must record, not hide, failures.
            row["error"] = f"{type(exc).__name__}: {exc}"
            errors.append({"path": rel, "error": row["error"]})
        file_rows.append(row)

    manifest_lines = [f"{row['sha256']}  {row['path']}" for row in file_rows]
    type_counts = collections.Counter(group["type_code"] for group in groups.values())
    type_occurrences = collections.Counter()
    for group in groups.values():
        type_occurrences[group["type_code"]] += group["occurrence_count"]
    summary = {
        "tracked_itl_files": len(file_rows),
        "successfully_parsed": len(file_rows) - len(errors),
        "parse_errors": len(errors),
        "library_versions": dict(sorted(versions.items())),
        "smart_playlist_instances": len(occurrences),
        "unique_type_101_payloads": type_counts[101],
        "unique_type_102_payloads": type_counts[102],
        "unique_type_103_payloads": type_counts[103],
        "type_101_occurrences": type_occurrences[101],
        "type_102_occurrences": type_occurrences[102],
        "type_103_occurrences": type_occurrences[103],
        "observed_field_ids": [f"0x{value:08X}" for value in sorted(stats["fields"])],
        "observed_action_ids": [f"0x{value:08X}" for value in sorted(stats["actions"])],
        "observed_rule_data_lengths": sorted(stats["data_lengths"]),
        "observed_conjunction_values": sorted(stats["conjunctions"]),
        "observed_version_words": [f"0x{value:08X}" for value in sorted(stats["version_words"])],
        "string_candidate_rules": stats["string_candidates"],
        "nested_group_candidates": stats["nested_groups"],
        "nonzero_slst_opaque_headers": stats["nonzero_slst_opaque"],
        "nonzero_rule_opaque_headers": stats["nonzero_rule_opaque"],
        "slst_with_trailing_bytes": stats["trailing_slst"],
        "maximum_parsed_depth": stats["max_depth"],
        "source_manifest_sha256": _sha(("\n".join(manifest_lines) + "\n").encode()),
    }
    return {
        "schema": SCHEMA,
        "generator": "evidence/smart-playlist/census.py",
        "corpus_commit": subprocess.check_output(
            ["git", "-C", str(REPO), "rev-parse", "HEAD"], text=True,
        ).strip(),
        "evidence_class": "native-corpus-observed",
        "scope_note": (
            "Tracked corpus only. It contains built-in/system definitions and no identified "
            "user-created custom smart playlist. Numeric names and operator meanings are not "
            "promoted to native fact by this census."
        ),
        "summary": summary,
        "field_occurrence_counts": {
            f"0x{key:08X}": value for key, value in sorted(stats["fields"].items())
        },
        "action_occurrence_counts": {
            f"0x{key:08X}": value for key, value in sorted(stats["actions"].items())
        },
        "rule_data_length_counts": {
            str(key): value for key, value in sorted(stats["data_lengths"].items())
        },
        "groups": dict(sorted(groups.items())),
        "occurrences": occurrences,
        "files": file_rows,
        "errors": errors,
    }


def markdown(document: dict) -> str:
    summary = document["summary"]
    lines = [
        "# Smart-playlist corpus census",
        "",
        "> Evidence class: **native corpus observed**. The corpus contains only identified "
        "built-in/system smart definitions; it does not establish custom-rule semantics.",
        "",
        "Regenerate from the repository root:",
        "",
        "```powershell",
        "python evidence/smart-playlist/census.py --write",
        "```",
        "",
        "## Coverage",
        "",
        "| Measure | Value |",
        "|---|---:|",
        f"| Tracked `.itl` files | {summary['tracked_itl_files']} |",
        f"| Successfully parsed | {summary['successfully_parsed']} |",
        f"| Parse errors | {summary['parse_errors']} |",
        f"| Playlist instances with type 101/102/103 | {summary['smart_playlist_instances']} |",
        f"| Unique type-101 payloads | {summary['unique_type_101_payloads']} |",
        f"| Unique type-102 payloads | {summary['unique_type_102_payloads']} |",
        f"| Unique type-103 payloads | {summary['unique_type_103_payloads']} |",
        "",
        "## Observed native invariants",
        "",
        f"- Version words: {', '.join(summary['observed_version_words'])}.",
        f"- Conjunction raw values: {summary['observed_conjunction_values']}.",
        f"- Rule data lengths: {summary['observed_rule_data_lengths']} bytes.",
        f"- Field IDs: {', '.join(summary['observed_field_ids'])}.",
        f"- Action IDs: {', '.join(summary['observed_action_ids'])}.",
        f"- String-action candidates: {summary['string_candidate_rules']}.",
        f"- Nested-group candidates: {summary['nested_group_candidates']}.",
        f"- Nonzero `SLst` opaque headers: {summary['nonzero_slst_opaque_headers']}.",
        f"- Nonzero rule opaque headers: {summary['nonzero_rule_opaque_headers']}.",
        f"- `SLst` payloads with trailing bytes: {summary['slst_with_trailing_bytes']}.",
        "",
        "## Content-addressed payload groups",
        "",
        "| Group | Type | Bytes | Occurrences | Examples |",
        "|---|---:|---:|---:|---|",
    ]
    for group_id, group in document["groups"].items():
        examples = ", ".join(example["playlist_name"] for example in group["examples"])
        lines.append(
            f"| `{group_id}` | {group['type_code']} | {group['length']} | "
            f"{group['occurrence_count']} | {examples} |"
        )
    lines.extend([
        "",
        "Exact payload hex, lossless AST dumps, all occurrences, every source file hash, and "
        "validation results are in `corpus-census.json`.",
        "",
        "## Interpretation boundary",
        "",
        "The byte framing above is native-corpus evidence. Names such as AND/OR, string "
        "operators, dates, ranges, playlist membership, limit unit, selection order, live "
        "update, and nesting remain cross-format prior art or unresolved unless separately "
        "graded in `SMART_PLAYLIST_SPEC.md`.",
        "",
    ])
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--write", action="store_true", help="write canonical JSON and Markdown")
    args = parser.parse_args()
    document = generate()
    encoded = json.dumps(document, indent=2, sort_keys=True, ensure_ascii=False) + "\n"
    if args.write:
        target = Path(__file__).resolve().parent
        (target / "corpus-census.json").write_text(encoded, encoding="utf-8", newline="\n")
        (target / "corpus-census.md").write_text(markdown(document), encoding="utf-8", newline="\n")
    else:
        sys.stdout.write(encoded)
    return 1 if document["errors"] else 0


if __name__ == "__main__":
    raise SystemExit(main())
