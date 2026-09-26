#!/usr/bin/env python3
"""Deterministically audit retained sort/rank/cache evidence without native execution.

The audit uses the independent bounded parser in REFERENCE_PARSER.  It never
imports ``itlkit`` or Windows automation modules, and it never treats repeated
records, COM projections, or summary JSON as additional native runs.
"""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
from dataclasses import dataclass
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import unicodedata
from typing import Any, Iterable

BASELINE_REL = "TEST_CORPUS/generated/reference-one-track-raw.itl"
BASELINE_SHA256 = "c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74"
RANK_OFFSETS = (0x290, 0x294, 0x298, 0x29C, 0x2A0, 0x2A4, 0x2A8)
COMMON_TRACK_OFFSETS = (0xE0, 0xE4, 0xE8, 0xEC, 0xF0, 0xF4, 0xF8)
TEXT_TYPES = {
    2: "name",
    3: "album",
    4: "artist",
    12: "composer",
    27: "album_artist",
    30: "sort_name",
    31: "sort_album",
    32: "sort_artist",
    33: "sort_album_artist",
}
FIELD_CASES = (
    ("name-unicode", "Name", 2),
    ("sort-name", "SortName", 30),
    ("sort-artist", "SortArtist", 32),
    ("sort-album", "SortAlbum", 31),
    ("sort-album-artist", "SortAlbumArtist", 33),
    ("artist-unicode", "Artist", 4),
    ("album-unicode", "Album", 3),
    ("album-artist-unicode", "AlbumArtist", 27),
    ("composer-unicode", "Composer", 12),
)
STATIC_INPUTS = (
    "evidence/static/phase2/findings.md",
    "evidence/static/phase3/findings.md",
    "evidence/static/phase3/name-origin-invalidation-and-sort-calls.txt",
    "evidence/static/phase3/sort-descriptor-jumptable.json",
    "evidence/static/phase3/native-name-diff.json",
    "ITL_FORMAT_SPEC.md",
    "docs/dynamic.md",
    "UNRESOLVED.md",
)
OUTPUT_NAMES = ("input-manifest.json", "census.json", "audit.json", "README.md")


@dataclass(frozen=True)
class InputSpec:
    path: str
    role: str
    provenance: str
    native_case: str | None = None
    stage: str | None = None
    native_case_count_contribution: int = 0


def require(value: Any, message: str) -> None:
    if not value:
        raise ValueError(message)


def json_bytes(value: Any) -> bytes:
    return (json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode("utf-8")


def read_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8-sig"))


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def load_reference_parser(repo_root: Path):
    path = repo_root / "REFERENCE_PARSER/core.py"
    name = "_sort_rank_reference_parser"
    spec = importlib.util.spec_from_file_location(name, path)
    require(spec is not None and spec.loader is not None, "cannot load independent reference parser")
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


def input_specs(repo_root: Path) -> list[InputSpec]:
    specs: list[InputSpec] = [
        InputSpec("scripts/research/audit_sort_rank_20260925.py", "audit implementation", "source_code"),
        InputSpec("REFERENCE_PARSER/core.py", "bounded structural parser", "source_code"),
        InputSpec(BASELINE_REL, "field-matrix pre-native baseline", "synthetic_candidate"),
        InputSpec("evidence/native/field-matrix-20260922/README.md", "field-matrix scope", "derived_summary"),
        InputSpec("evidence/native/field-matrix-20260922/case-matrix.json", "field-matrix case declarations", "derived_summary"),
        InputSpec("evidence/native/field-matrix-20260922/summary.json", "field-matrix aggregate", "derived_summary"),
    ]
    field_root = "evidence/native/field-matrix-20260922/cases"
    for case, _, _ in FIELD_CASES:
        specs.append(InputSpec(f"{field_root}/{case}/result.json", "native case hash chain and status", "derived_summary", case))
        for stage in ("mutation", "verification"):
            specs.append(
                InputSpec(
                    f"{field_root}/{case}/{stage}/native-saved.itl",
                    "archived native-saved ITL stage",
                    "native_saved_stage",
                    case,
                    stage,
                    1 if stage == "mutation" else 0,
                )
            )
    specs.append(
        InputSpec(
            "evidence/native/phase3/parent-independent-audit.json",
            "phase3 archived-run hash chain",
            "derived_summary",
        )
    )
    phase_root = repo_root / "evidence/native/phase3"
    for path in sorted((phase_root / "candidates").glob("*.itl")):
        case = path.stem
        specs.append(
            InputSpec(
                path.relative_to(repo_root).as_posix(),
                "phase3 pre-native candidate",
                "synthetic_candidate",
                case,
                "candidate",
            )
        )
    for path in sorted((phase_root / "snapshots").glob("*.itl")):
        stem = path.stem
        case, stage = stem.rsplit("-reload", 1)
        specs.append(
            InputSpec(
                path.relative_to(repo_root).as_posix(),
                "phase3 archived native-saved ITL stage",
                "native_saved_stage",
                case,
                f"reload{stage}",
                1 if stage == "1" else 0,
            )
        )
    specs.extend(InputSpec(path, "claim-boundary source", "static_or_scope_source") for path in STATIC_INPUTS)
    seen: set[str] = set()
    for item in specs:
        require(item.path not in seen, f"duplicate input declaration: {item.path}")
        seen.add(item.path)
    return specs


def build_manifest(repo_root: Path, specs: Iterable[InputSpec]) -> dict[str, Any]:
    root = repo_root.resolve()
    rows = []
    for spec in specs:
        path = (root / spec.path).resolve()
        require(path.is_relative_to(root), f"input escapes repository: {spec.path}")
        require(path.is_file(), f"missing input: {spec.path}")
        data = path.read_bytes()
        rows.append(
            {
                "path": spec.path,
                "bytes": len(data),
                "sha256": sha256(data),
                "role": spec.role,
                "provenance": spec.provenance,
                "native_case": spec.native_case,
                "stage": spec.stage,
                "native_case_count_contribution": spec.native_case_count_contribution,
            }
        )
    baseline = next(row for row in rows if row["path"] == BASELINE_REL)
    require(baseline["sha256"] == BASELINE_SHA256, "baseline hash does not match the retained case declarations")
    return {
        "schema": "itl.sort-rank.input-manifest.v1",
        "audit_date": "2026-09-25",
        "input_roots": [
            "TEST_CORPUS/generated/reference-one-track-raw.itl",
            "evidence/native/field-matrix-20260922",
            "evidence/native/phase3",
            "evidence/static/phase2",
            "evidence/static/phase3",
            "REFERENCE_PARSER/core.py",
        ],
        "reproduction": "python3 scripts/research/audit_sort_rank_20260925.py --repo-root . --output-dir evidence/research/20260925/sort-rank-audit",
        "files": sorted(rows, key=lambda row: row["path"]),
        "counting_rule": {
            "field_matrix": "Each named case contributes once; mutation and verification ITLs are stages of that case.",
            "phase3": "Each named acceptance case contributes once; candidate/reload snapshots and repeated tracks are not additional native cases.",
            "derived_material": "Summary JSON and COM projections are hash-chain/context sources, not independent native executions.",
        },
    }


def normalization_flags(text: str) -> dict[str, bool]:
    return {form: unicodedata.normalize(form, text) == text for form in ("NFC", "NFD", "NFKC", "NFKD")}


def atom_detail(record: Any, ref: Any) -> dict[str, Any]:
    type_code = ref.u32le(record.header, 12)
    external_id = ref.u32le(record.header, 16) if len(record.header) >= 20 else None
    encoding = ref.u32le(record.payload, 0) if len(record.payload) >= 8 else None
    byte_length = ref.u32le(record.payload, 4) if len(record.payload) >= 8 else None
    in_bounds = byte_length is not None and 16 + byte_length <= len(record.payload)
    raw = record.payload[16 : 16 + byte_length] if in_bounds else b""
    text, metadata = ref.decode_text_object(record)
    state = "undecodable" if text is None else "empty" if text == "" else "nonempty"
    result: dict[str, Any] = {
        "state": state,
        "type_code": type_code,
        "field": TEXT_TYPES.get(type_code, f"type_{type_code}"),
        "record_path": record.path,
        "payload_offset": record.offset,
        "external_id_raw": external_id,
        "encoding_raw": encoding,
        "declared_text_bytes": byte_length,
        "raw_text_hex": raw.hex(),
        "raw_text_sha256": sha256(raw),
        "header_sha256": sha256(record.header),
        "record_sha256": sha256(record.raw),
        "text": text,
        "decode_metadata": metadata,
    }
    if text is not None:
        result["codepoints"] = [f"U+{ord(char):04X}" for char in text]
        result["normalization"] = normalization_flags(text)
    return result


def rank_vector(record: Any) -> list[int]:
    require(len(record.header) >= RANK_OFFSETS[-1] + 4, "track header too short for rank-like vector")
    return [int.from_bytes(record.header[offset : offset + 4], "little") for offset in RANK_OFFSETS]


def track_detail(record: Any, semantics: dict[str, Any], ref: Any) -> dict[str, Any]:
    grouped: dict[int, list[Any]] = defaultdict(list)
    for child in record.children:
        if child.tag == b"mhoh" and len(child.header) >= 16:
            type_code = ref.u32le(child.header, 12)
            if type_code in TEXT_TYPES:
                grouped[type_code].append(child)
    fields: dict[str, Any] = {}
    for type_code, field in TEXT_TYPES.items():
        atoms = grouped[type_code]
        if not atoms:
            fields[field] = {"state": "missing", "type_code": type_code}
        elif len(atoms) == 1:
            fields[field] = atom_detail(atoms[0], ref)
        else:
            fields[field] = {
                "state": "duplicate",
                "type_code": type_code,
                "count": len(atoms),
                "records": [atom_detail(atom, ref) for atom in atoms],
            }
    return {
        "record_path": record.path,
        "payload_offset": record.offset,
        "persistent_id": semantics["persistent_id"],
        "track_id_raw": semantics["track_id"],
        "header_length": len(record.header),
        "header_sha256": sha256(record.header),
        "record_sha256": sha256(record.raw),
        "name_refresh_flag_raw": semantics["name_refresh_flag_raw"],
        "rank_like_words": [
            {"mith_offset": f"0x{wire:x}", "common_track_offset": f"0x{common:x}", "value": value}
            for wire, common, value in zip(RANK_OFFSETS, COMMON_TRACK_OFFSETS, rank_vector(record))
        ],
        "rank_vector": rank_vector(record),
        "text_fields": fields,
    }


def file_detail(path: Path, repo_root: Path, ref: Any, provenance: str, native_case: str | None, stage: str | None) -> dict[str, Any]:
    library = ref.ReferenceLibrary.read(path)
    semantics = library.track_semantics()
    require(len(semantics) == len(library.track_records), "independent parser track enumeration mismatch")
    tracks = [track_detail(record, semantic, ref) for record, semantic in zip(library.track_records, semantics)]
    playlists = []
    playlist_semantics = library.playlist_semantics()
    require(len(playlist_semantics) == len(library.playlist_records), "independent parser playlist enumeration mismatch")
    for record, semantic in zip(library.playlist_records, playlist_semantics):
        playlists.append(
            {
                "record_path": record.path,
                "payload_offset": record.offset,
                "persistent_id": semantic["persistent_id"],
                "playlist_id_raw": semantic["playlist_id"],
                "name": semantic["name"],
                "header_length": len(record.header),
                "header_sha256": sha256(record.header),
                "record_sha256": sha256(record.raw),
                "member_track_persistent_ids": [member["track_persistent_id"] for member in semantic["members"]],
                "smart_rule_objects": semantic["smart_rule_objects"],
                "special_object": semantic["special_object"],
            }
        )
    raw = path.read_bytes()
    return {
        "path": path.relative_to(repo_root).as_posix(),
        "bytes": len(raw),
        "sha256": sha256(raw),
        "provenance": provenance,
        "native_case": native_case,
        "stage": stage,
        "version": library.envelope.version,
        "expanded_payload_bytes": len(library.envelope.payload),
        "expanded_payload_sha256": sha256(library.envelope.payload),
        "section_types": [section.section_type for section in library.sections],
        "track_count": len(tracks),
        "playlist_count": len(playlists),
        "tracks": tracks,
        "playlists": playlists,
    }


def changed_rank_offsets(before: list[int], after: list[int]) -> list[dict[str, Any]]:
    require(len(before) == len(after) == len(RANK_OFFSETS), "rank vector width mismatch")
    return [
        {"offset": f"0x{offset:x}", "before": old, "after": new}
        for offset, old, new in zip(RANK_OFFSETS, before, after)
        if old != new
    ]


def changed_header_bytes(before: bytes, after: bytes) -> list[dict[str, Any]]:
    require(len(before) == len(after), "header width changed")
    return [
        {"offset": f"0x{offset:x}", "before": old, "after": new}
        for offset, (old, new) in enumerate(zip(before, after))
        if old != new
    ]


def stage_track(file_row: dict[str, Any]) -> dict[str, Any]:
    require(file_row["track_count"] == 1, f"expected one-track field case: {file_row['path']}")
    return file_row["tracks"][0]


def build_field_matrix_audit(repo_root: Path, files: dict[str, dict[str, Any]], ref: Any) -> list[dict[str, Any]]:
    baseline = stage_track(files[BASELINE_REL])
    rows = []
    root = repo_root / "evidence/native/field-matrix-20260922/cases"
    for case, com_field, type_code in FIELD_CASES:
        result_path = root / case / "result.json"
        report = read_json(result_path)
        require(report["name"] == case and report["case"]["field"] == com_field, f"case declaration mismatch: {case}")
        require(report["passed"] is True and report["status"] == "passed", f"field case not passed: {case}")
        require(report["candidate"]["sha256"] == BASELINE_SHA256, f"field case baseline mismatch: {case}")
        sessions = {session["phase"]: session for session in report["sessions"]}
        require(set(sessions) == {"mutation", "verification"}, f"field case stage set mismatch: {case}")
        rels = {
            stage: f"evidence/native/field-matrix-20260922/cases/{case}/{stage}/native-saved.itl"
            for stage in ("mutation", "verification")
        }
        for stage, rel in rels.items():
            session = sessions[stage]
            actual = files[rel]
            require(session["saved"]["sha256"] == actual["sha256"], f"saved hash mismatch: {case}/{stage}")
            require(session["saved"]["bytes"] == actual["bytes"], f"saved size mismatch: {case}/{stage}")
            require(session["status"] == "passed" and session["worker_exit_code"] == session["itunes_exit_code"] == 0, f"incomplete native stage: {case}/{stage}")
        require(sessions["mutation"]["prelaunch"]["sha256"] == BASELINE_SHA256, f"mutation chain mismatch: {case}")
        require(sessions["verification"]["prelaunch"]["sha256"] == files[rels["mutation"]]["sha256"], f"verification chain mismatch: {case}")
        mutation = stage_track(files[rels["mutation"]])
        verification = stage_track(files[rels["verification"]])
        require(mutation["persistent_id"] == verification["persistent_id"], f"track identity drift: {case}")
        field_name = TEXT_TYPES[type_code]
        ma, va = mutation["text_fields"][field_name], verification["text_fields"][field_name]
        require(ma["state"] == va["state"] == "nonempty", f"requested text is not serialized: {case}")
        require(ma["text"] == va["text"] == report["case"]["value"], f"requested text mismatch: {case}")
        # Header bytes are read again only for exact byte-offset differencing; the
        # census already carries the corresponding hashes and rank values.
        mut_record = ref.ReferenceLibrary.read(repo_root / rels["mutation"]).track_records[0]
        ver_record = ref.ReferenceLibrary.read(repo_root / rels["verification"]).track_records[0]
        rows.append(
            {
                "case": case,
                "field": com_field,
                "text_type_code": type_code,
                "requested_value": report["case"]["value"],
                "native_case_count_contribution": 1,
                "stage_count": 2,
                "raw_track_occurrence_count": 2,
                "counting_note": "Mutation and verification are save stages of one archived native case, not two independent runs.",
                "source_baseline": {
                    "path": BASELINE_REL,
                    "sha256": files[BASELINE_REL]["sha256"],
                    "rank_vector": baseline["rank_vector"],
                },
                "mutation": {
                    "path": rels["mutation"],
                    "sha256": files[rels["mutation"]]["sha256"],
                    "rank_vector": mutation["rank_vector"],
                    "requested_text_atom": ma,
                },
                "verification": {
                    "path": rels["verification"],
                    "sha256": files[rels["verification"]]["sha256"],
                    "rank_vector": verification["rank_vector"],
                    "requested_text_atom": va,
                },
                "source_to_mutation_rank_changes": changed_rank_offsets(baseline["rank_vector"], mutation["rank_vector"]),
                "mutation_to_verification_rank_changes": changed_rank_offsets(mutation["rank_vector"], verification["rank_vector"]),
                "mutation_to_verification_header_byte_changes": changed_header_bytes(mut_record.header, ver_record.header),
                "requested_text_raw_bytes_stable_between_saves": ma["raw_text_hex"] == va["raw_text_hex"],
                "requested_text_record_stable_between_saves": ma["record_sha256"] == va["record_sha256"],
                "serialized_identity_stability_reported": report["serialized_identity_stability"]["passed"] is True,
            }
        )
    return rows


def build_phase3_audit(repo_root: Path, files: dict[str, dict[str, Any]]) -> list[dict[str, Any]]:
    parent = read_json(repo_root / "evidence/native/phase3/parent-independent-audit.json")
    require(parent["status"] == "passed" and parent["native_actions_by_parent"] is False, "phase3 parent audit boundary changed")
    rows = []
    for case_report in parent["cases"]:
        case = case_report["case"]
        candidate_rel = f"evidence/native/phase3/candidates/{case}.itl"
        reload1_rel = f"evidence/native/phase3/snapshots/{case}-reload1.itl"
        reload2_rel = f"evidence/native/phase3/snapshots/{case}-reload2.itl"
        require(candidate_rel in files and reload1_rel in files and reload2_rel in files, f"phase3 file set incomplete: {case}")
        require(files[candidate_rel]["sha256"] == case_report["candidate"]["sha256"], f"phase3 candidate hash mismatch: {case}")
        for index, rel in enumerate((reload1_rel, reload2_rel)):
            require(files[rel]["sha256"] == case_report["cycles"][index]["saved"]["sha256"], f"phase3 saved hash mismatch: {case}/reload{index + 1}")
        stage_rows = [files[candidate_rel], files[reload1_rel], files[reload2_rel]]
        by_stage = [{track["persistent_id"]: track for track in row["tracks"]} for row in stage_rows]
        require(set(by_stage[0]) == set(by_stage[1]) == set(by_stage[2]), f"phase3 track PID set drift: {case}")
        tracks = []
        for pid in sorted(by_stage[0]):
            candidate, first, second = (stage[pid] for stage in by_stage)
            tracks.append(
                {
                    "persistent_id": pid,
                    "candidate_rank_vector": candidate["rank_vector"],
                    "reload1_rank_vector": first["rank_vector"],
                    "reload2_rank_vector": second["rank_vector"],
                    "candidate_to_reload1_rank_changes": changed_rank_offsets(candidate["rank_vector"], first["rank_vector"]),
                    "reload1_to_reload2_rank_changes": changed_rank_offsets(first["rank_vector"], second["rank_vector"]),
                    "reload1_to_reload2_stable": first["rank_vector"] == second["rank_vector"],
                }
            )
        rows.append(
            {
                "case": case,
                "native_case_count_contribution": 1,
                "stage_count": 2,
                "candidate_counted_as_native_run": False,
                "counting_note": "The candidate is a synthetic pre-native input; reload1/reload2 are stages of one archived native acceptance case.",
                "candidate": {"path": candidate_rel, "sha256": files[candidate_rel]["sha256"]},
                "reload1": {"path": reload1_rel, "sha256": files[reload1_rel]["sha256"]},
                "reload2": {"path": reload2_rel, "sha256": files[reload2_rel]["sha256"]},
                "tracks": tracks,
                "any_candidate_to_reload1_rank_change": any(track["candidate_to_reload1_rank_changes"] for track in tracks),
                "all_reload1_to_reload2_rank_vectors_stable": all(track["reload1_to_reload2_stable"] for track in tracks),
            }
        )
    return rows


def build_state_census(file_rows: list[dict[str, Any]]) -> dict[str, Any]:
    counts = {field: Counter() for field in TEXT_TYPES.values()}
    encoding_counts = {field: Counter() for field in TEXT_TYPES.values()}
    normalization_counts = {field: Counter() for field in TEXT_TYPES.values()}
    examples: dict[tuple[str, str], list[str]] = defaultdict(list)
    raw_track_occurrences = 0
    for file_row in file_rows:
        for index, track in enumerate(file_row["tracks"]):
            raw_track_occurrences += 1
            witness = f"{file_row['path']}#track[{index}]"
            for field, atom in track["text_fields"].items():
                state = atom["state"]
                counts[field][state] += 1
                if len(examples[(field, state)]) < 5:
                    examples[(field, state)].append(witness)
                if state in {"empty", "nonempty"}:
                    encoding_counts[field][str(atom["encoding_raw"])] += 1
                    flags = atom["normalization"]
                    key = "+".join(form for form in ("NFC", "NFD", "NFKC", "NFKD") if flags[form]) or "none"
                    normalization_counts[field][key] += 1
    fields = {}
    for field in TEXT_TYPES.values():
        fields[field] = {
            "state_occurrences": dict(sorted(counts[field].items())),
            "encoding_raw_occurrences": dict(sorted(encoding_counts[field].items())),
            "normalization_occurrences": dict(sorted(normalization_counts[field].items())),
            "examples": {state: examples[(field, state)] for state in sorted(counts[field])},
        }
    return {
        "file_count": len(file_rows),
        "raw_track_occurrence_count": raw_track_occurrences,
        "independent_native_case_count": 15,
        "counting_warning": "Track/text occurrences are repeated serialized observations and must not be counted as independent native runs.",
        "fields": fields,
        "empty_target_text_occurrence_count": sum(counts[field]["empty"] for field in counts),
    }


def make_readme(audit: dict[str, Any], census: dict[str, Any], manifest: dict[str, Any]) -> str:
    field_rows = {row["case"]: row for row in audit["field_matrix_cases"]}
    lines = [
        "# Sort/rank/cache regeneration audit (2026-09-25)",
        "",
        "## Scope and reproduction",
        "",
        "This is a deterministic offline audit of retained evidence. It launched no native application and imported no Windows automation or production `itlkit` code. The structural path is `REFERENCE_PARSER/core.py`; every consumed file, byte length, and SHA-256 is in `input-manifest.json`.",
        "",
        "```bash",
        manifest["reproduction"],
        "```",
        "",
        "Outputs are deterministic: `input-manifest.json`, `census.json`, `audit.json`, and this README. Re-running the command in a second output directory must produce byte-identical files.",
        "",
        "## Counting boundary",
        "",
        "- The 9 selected field-matrix cases are 9 archived native cases. Each mutation/verification pair is two save stages of one case, not two independent native runs.",
        "- The 6 phase3 chains are 6 archived native acceptance cases. A candidate is a synthetic pre-native input; reload1/reload2 are stages of the same case.",
        "- Summary JSON, COM projections, copied snapshots, and repeated track/text records are derived or repeated occurrences, not additional native runs.",
        f"- The census contains {census['state_census']['raw_track_occurrence_count']} raw track occurrences across {census['state_census']['file_count']} ITLs; this number is not a native-run count.",
        "",
        "## Direct wire observations",
        "",
        "The bounded 756-byte `mith` profile contains seven observed little-endian DWORDs at `+0x290/+0x294/+0x298/+0x29c/+0x2a0/+0x2a4/+0x2a8`. Static reader/writer evidence maps those bytes to common-track `+0xe0/+0xe4/+0xe8/+0xec/+0xf0/+0xf4/+0xf8`. Calling them rank/cache-like is bounded terminology; consumer meaning and a universal collation algorithm remain unproved.",
        "",
        "| Archived case | mutation vector | verification vector | exact 0→1000 offsets |",
        "|---|---|---|---|",
    ]
    for case, _, _ in FIELD_CASES:
        row = field_rows[case]
        changed = ", ".join(change["offset"] for change in row["mutation_to_verification_rank_changes"]) or "none"
        lines.append(f"| `{case}` | `{row['mutation']['rank_vector']}` | `{row['verification']['rank_vector']}` | {changed} |")
    lines += [
        "",
        "Observed pairings on the first save are: Name/SortName→`+0x290`; Album/SortAlbum→`+0x294`; Artist/SortArtist→`+0x298` and `+0x2a8`; AlbumArtist→`+0x2a4` and `+0x2a8`; Composer→`+0x2a0`. The verification save restored each observed zero to 1000. `SortAlbumArtist` is the decisive counterexample: its text atom was present and accepted while the vector stayed all-1000 in both saves.",
        "",
        "Phase3 independently supplies pre-native→first-save regeneration witnesses and first-save→second-save stability witnesses. It also shows nontrivial values (for example 125/250/500/750 and reordered 1000-step values), so neither global zeroing nor copying text atom IDs is justified.",
        "",
        "## Text presence and Unicode",
        "",
        "Within the exact audited cohort, target text fields have missing and nonempty serialized states but no empty text atom. Therefore empty-string behavior is a negative result/gap, not something this audit generalizes from missing atoms. The Name witness `Field Matrix 名称 🎵 é` remains decomposed for the final `é` (NFD and not NFC) across both saves, with byte-identical UTF-16LE text payload. Other retained Unicode witnesses include NFC Japanese and supplementary-plane emoji. Encoding choice is observed per atom, not inferred as a normalization rule.",
        "",
        "## Result and limits",
        "",
        "- **No production edit rule was added.** The evidence establishes exact transitions for this cohort but not a safe universal regeneration algorithm.",
        "- **U-10 remains open.** Missing factorials include serialized empty atoms, missing Name, script/case/compatibility and normalization variants, SortComposer/native-sort-index candidates, multi-track ties/collation, and consumer/system-view mapping.",
        "- Structure, correlation, and archived acceptance do not prove universal semantics or native acceptance for a newly generated rule.",
        "- Existing retained evidence was read and hashed only; it was not overwritten.",
        "",
        "See `audit.json` for witnesses/counterexamples and `census.json` for every parsed track, atom state/raw hash, vector, and playlist/system-view record hash.",
        "",
    ]
    return "\n".join(lines)


def generate(repo_root: Path, output_dir: Path) -> dict[str, Any]:
    repo_root = repo_root.resolve()
    output_dir = output_dir.resolve()
    require((repo_root / ".git").exists() or (repo_root / ".git").is_file(), "repo root does not look like a Git worktree")
    specs = input_specs(repo_root)
    manifest = build_manifest(repo_root, specs)
    ref = load_reference_parser(repo_root)
    itl_specs = [spec for spec in specs if spec.path.endswith(".itl")]
    file_rows = [
        file_detail(repo_root / spec.path, repo_root, ref, spec.provenance, spec.native_case, spec.stage)
        for spec in itl_specs
    ]
    file_index = {row["path"]: row for row in file_rows}
    require(len(file_index) == len(file_rows), "duplicate ITL input")
    field_cases = build_field_matrix_audit(repo_root, file_index, ref)
    phase3_cases = build_phase3_audit(repo_root, file_index)
    state_census = build_state_census(file_rows)
    census = {
        "schema": "itl.sort-rank.census.v1",
        "parser": {
            "path": "REFERENCE_PARSER/core.py",
            "imports_itlkit": False,
            "record_discovery": "explicit envelope/section/record lengths and counts; no raw tag scan",
        },
        "rank_word_offsets": [f"0x{offset:x}" for offset in RANK_OFFSETS],
        "files": file_rows,
        "state_census": state_census,
    }
    field_map = {row["case"]: row for row in field_cases}
    phase_map = {row["case"]: row for row in phase3_cases}
    audit = {
        "schema": "itl.sort-rank.audit.v1",
        "status": "passed_with_negative_result",
        "native_execution_performed": False,
        "production_change": {
            "made": False,
            "reason": "Observed invalidation/regeneration correlations do not identify a safe universal consumer algorithm.",
        },
        "rank_word_layout": [
            {
                "mith_offset": f"0x{wire:x}",
                "common_track_offset": f"0x{common:x}",
                "wire_fact": "observed 32-bit little-endian value in the retained 756-byte profile",
                "semantic_status": "rank/cache-like; exact consumer meaning unproved",
            }
            for wire, common in zip(RANK_OFFSETS, COMMON_TRACK_OFFSETS)
        ],
        "evidence_identity": {
            "selected_field_matrix_native_cases": len(field_cases),
            "phase3_native_cases": len(phase3_cases),
            "total_archived_native_cases": len(field_cases) + len(phase3_cases),
            "raw_track_occurrences": state_census["raw_track_occurrence_count"],
            "raw_occurrences_are_independent_runs": False,
            "derived_summaries_are_independent_runs": False,
        },
        "field_matrix_cases": field_cases,
        "phase3_cases": phase3_cases,
        "decisive_witnesses": [
            {
                "claim": "Name and SortName share the observed +0x290 zero-on-mutation then 1000-on-verification pattern while remaining distinct mhoh type 2 and type 30 atoms.",
                "cases": ["name-unicode", "sort-name"],
                "observed_vectors": [field_map["name-unicode"]["mutation"]["rank_vector"], field_map["sort-name"]["mutation"]["rank_vector"]],
            },
            {
                "claim": "Album/SortAlbum and Artist/SortArtist have paired first-save zero patterns; the following verification save restores the observed slots to 1000.",
                "cases": ["album-unicode", "sort-album", "artist-unicode", "sort-artist"],
            },
            {
                "claim": "Phase3 first native saves changed candidate vectors and every audited second save retained the first-save vector per persistent track ID.",
                "cases": [row["case"] for row in phase3_cases],
                "all_second_save_stable": all(row["all_reload1_to_reload2_rank_vectors_stable"] for row in phase3_cases),
                "cases_with_first_save_change": [row["case"] for row in phase3_cases if row["any_candidate_to_reload1_rank_change"]],
            },
            {
                "claim": "The decomposed Name text payload survives both native saves byte-for-byte without forced NFC normalization.",
                "case": "name-unicode",
                "raw_bytes_stable": field_map["name-unicode"]["requested_text_raw_bytes_stable_between_saves"],
                "normalization": field_map["name-unicode"]["mutation"]["requested_text_atom"]["normalization"],
            },
        ],
        "counterexamples": [
            {
                "claim_refuted": "Every Sort* update zeros a rank/cache-like word on the first save.",
                "case": "sort-album-artist",
                "fact": "The type-33 text atom is nonempty and stable while both vectors are [1000,1000,1000,1000,1000,1000,1000].",
            },
            {
                "claim_refuted": "The seven words can be regenerated by setting all of them to zero or 1000.",
                "case": "crud3-cross-shared-COW-037",
                "fact": "The first native save contains per-track 125/250/500/750 values and these persist on the second save.",
            },
            {
                "claim_refuted": "Missing and empty serialized text are interchangeable in this audit.",
                "fact": f"The cohort contains {state_census['empty_target_text_occurrence_count']} empty target atoms; missing is separately represented by absence of an mhoh child.",
            },
        ],
        "observed_facts": [
            "All parsed tracks use the retained 756-byte mith profile and the seven values are read at exact offsets, not found by raw occurrence scanning.",
            "The field-matrix mutation and verification artifacts form one hash-chained case each.",
            "Only the rank-like offsets listed in each transition are claimed as regenerated; unrelated header differences in object references are recorded but not assigned rank semantics.",
            "Name/Sort* atoms retain distinct type codes and raw payload hashes; rank-vector correlation does not merge their string namespaces.",
        ],
        "unproven_semantics": [
            "The consumer-visible meaning/order of all seven words and the complete collation/tie algorithm.",
            "A universal one-to-one mapping from each Name/Sort* field to a single word.",
            "Native behavior for empty text atoms, missing Name, normalization variants, scripts/case/compatibility forms, and duplicate/tie groups.",
            "SortComposer (static descriptor type 34), native sort-index/type 35, and system-view cache consumers.",
            "Native acceptance of any newly synthesized regeneration algorithm outside the exact archived cases.",
        ],
        "u10": {
            "closed": False,
            "reason": "The audit adds reproducible witnesses and counterexamples but leaves consumer mapping and required factorials incomplete.",
            "remaining_gaps": [
                "missing/empty/nonempty native factorials, including missing Name and a serialized empty atom",
                "Unicode script, case, compatibility-normalization, and canonical-equivalence factorials",
                "multi-track ordering, ties, duplicate values, and system-view consumer mapping",
                "SortComposer/native-sort-index and complete Name versus Sort* candidate coverage",
                "a native acceptance campaign for any proposed production regeneration rule",
            ],
        },
    }
    require(field_map["sort-album-artist"]["mutation_to_verification_rank_changes"] == [], "decisive SortAlbumArtist counterexample changed")
    require(state_census["empty_target_text_occurrence_count"] == 0, "new empty witness requires claim review")
    require(all(row["all_reload1_to_reload2_rank_vectors_stable"] for row in phase3_cases), "phase3 second-save stability changed")
    require(any(row["any_candidate_to_reload1_rank_change"] for row in phase3_cases), "phase3 has no regeneration witness")
    require(phase_map["crud3-cross-shared-COW-037"]["all_reload1_to_reload2_rank_vectors_stable"], "COW rank witness changed")
    readme = make_readme(audit, census, manifest)
    output_dir.mkdir(parents=True, exist_ok=True)
    outputs = {
        "input-manifest.json": json_bytes(manifest),
        "census.json": json_bytes(census),
        "audit.json": json_bytes(audit),
        "README.md": readme.encode("utf-8"),
    }
    for name in OUTPUT_NAMES:
        (output_dir / name).write_bytes(outputs[name])
    # Final preservation gate: every input still has the digest placed in the manifest.
    for pin in manifest["files"]:
        require(sha256((repo_root / pin["path"]).read_bytes()) == pin["sha256"], f"input changed during audit: {pin['path']}")
    return {"manifest": manifest, "census": census, "audit": audit, "outputs": outputs}


def main(argv: list[str] | None = None) -> int:
    default_root = Path(__file__).resolve().parents[2]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-root", type=Path, default=default_root)
    parser.add_argument("--output-dir", type=Path, default=None)
    args = parser.parse_args(argv)
    repo_root = args.repo_root.resolve()
    output_dir = args.output_dir or repo_root / "evidence/research/20260925/sort-rank-audit"
    result = generate(repo_root, output_dir)
    print(
        json.dumps(
            {
                "status": result["audit"]["status"],
                "output_dir": str(Path(output_dir).resolve()),
                "input_files": len(result["manifest"]["files"]),
                "itl_files": len(result["census"]["files"]),
                "raw_track_occurrences": result["census"]["state_census"]["raw_track_occurrence_count"],
                "native_cases": result["audit"]["evidence_identity"]["total_archived_native_cases"],
                "u10_closed": result["audit"]["u10"]["closed"],
            },
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
