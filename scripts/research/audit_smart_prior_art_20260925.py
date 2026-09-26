#!/usr/bin/env python3
"""Reproducible Windows-ITL / Music-XML Smart Criteria boundary audit.

This audit deliberately maintains two parsers over the same bytes.  The
Windows view is the repository's native-observation parser.  The Music XML
view is a small structural parser for the pinned prior-art fixtures.  Byte
identity is reported, but cross-format names and semantics are never promoted
to Windows-native evidence.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import plistlib
import subprocess
from pathlib import Path
import sys
from typing import Any, Iterable

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from itlkit import Library
from itlkit.smart import (
    RULE_HEADER_SIZE,
    SLST_HEADER_SIZE,
    SmartRuleSet,
    parse_rules,
    validate_rules,
)
DEFAULT_OUTPUT = ROOT / "evidence" / "research" / "20260925" / "smart-prior-art"
DEFAULT_NATIVE_ITL = (
    ROOT
    / "evidence"
    / "native"
    / "smart-playlist-default-20260922-v24"
    / "native-created.itl"
)
DEFAULT_CENSUS = ROOT / "evidence" / "smart-playlist" / "corpus-census.json"
DEFAULT_EXTERNAL = ROOT.parent.parent / "external"

SMART_PLAYLIST_IO_URL = "https://github.com/kynoptic/smart-playlist-io"
SMART_PLAYLIST_IO_COMMIT = "31acf7f058278f120b9d054459134416e76d1d8e"
ITUNES_SMARTPLAYLIST_URL = "https://github.com/cvzi/itunes_smartplaylist"
ITUNES_SMARTPLAYLIST_COMMIT = "9a36e82d5bfaad9154b50166fee0489f5d9306e2"
NATIVE_PLAYLIST_PID = "9081AD2B1ABE848F"

MUSIC_ROOT_HEADER_SIZE = 139
MUSIC_SUBEXPR_HEADER_SIZE = 192
MUSIC_SUBEXPR_PREFIX_SIZE = 53
MUSIC_NESTED_SLST_REGION_SIZE = 139
MUSIC_SKIP_OFFSET = 51
MUSIC_SKIP_TO_NEXT_ADJUSTMENT = 56
MUSIC_FIXED_RULE_SIZE = 124
MUSIC_STRING_HEADER_SIZE = 54
MUSIC_STRING_LENGTH_OFFSET = 52
MUSIC_VALUE_A_OFFSET = 57
MUSIC_VALUE_B_OFFSET = 81
SMART_PLAYLIST_IO_BOILERPLATE_SIZE = 579

# Structural classification from the pinned projects.  Names are prior art.
MUSIC_STRING_FIELDS = {
    0x02,
    0x03,
    0x04,
    0x08,
    0x09,
    0x0E,
    0x12,
    0x27,
    0x36,
    0x37,
    0x3E,
    0x47,
    0x4E,
    0x4F,
    0x50,
    0x51,
    0x52,
    0x53,
}
CROSS_FORMAT_FIELD_NAMES = {
    0x9A: "Love",
    0x86: "iCloudStatus",
    0x85: "Location",
    0x3C: "MediaKind",
}

EXPECTED_SOURCE_HASHES = {
    "smart-playlist-io": {
        "LICENSE": "7839b3fbd43277bf8c334d8920940ed8a6ba78dbb0bda29d910418603b74099e",
        "NOTICE": "bdfbd96e0d2dd3fc5bd960ed77a393e25783fb2d69f481a4bfb330e8073125eb",
        "src/smart_playlist_io/constants.py": "a8616b1f6789e05815f4f6ba022b3322a47f8627d3087250bcb732ec0286bb72",
        "src/smart_playlist_io/encode.py": "922dff42b5dc813078cca9f0797dc837649600e9a5639fc6698464396891769f",
        "src/smart_playlist_io/decode.py": "5d408bf2038ce1dddfb16af6c089f7ac574ede3eed0ffb68cadc0b42836d6572",
        "tests/fixtures/golden_criteria.bin": "884ec390daabf84aae0ed19983f1c27b8d244b3b481476b46c36771b3a0f9b1e",
        "tests/fixtures/golden_info.bin": "101dde6edd686b478b3f6c036c413018dd229ca96c18789d971ceda8d6fd252f",
    },
    "itunes_smartplaylist": {
        "LICENSE": "0becf4519f22527da9fd7c3522fe4c088d190dc450b84340cb5b5c11e6508182",
        "itunessmart/parse.py": "a3c52d416ca24a32ac760071f27278fd5a0270d1614104cf9a6090bd9e8df39c",
        "itunessmart/data_structure.py": "189d25bccc949429c1b48f3f20fd9666c02c5f8a102a4c30e5c08a7c0ec77f87",
        "tests/library_minimal.xml": "b66575ed3f15393d7645bf2120b72b5d4e991252bce0acfe5a2071a45cbb7d2f",
        "tests/library_onlysmartplaylists.xml": "4c8c5e5699b313bffcce7bd7e6e6b98d3ae5cd089333b2b233015bad7466bdd0",
    },
}


class MusicCriteriaError(ValueError):
    """A pinned Music XML fixture does not have the bounded audited shape."""


def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def path_label(path: Path) -> str:
    resolved = path.resolve()
    try:
        return resolved.relative_to(ROOT).as_posix()
    except ValueError:
        return path.name


def file_facts(path: Path, *, label: str | None = None) -> dict[str, Any]:
    data = path.read_bytes()
    return {
        "path": label or path_label(path),
        "bytes": len(data),
        "sha256": sha256_bytes(data),
    }


def _require(data: bytes, start: int, size: int, label: str) -> None:
    if start < 0 or size < 0 or start + size > len(data):
        raise MusicCriteriaError(
            f"{label} at {start} needs {size} bytes; input has {len(data)}"
        )


def _u16be(data: bytes, offset: int) -> int:
    _require(data, offset, 2, "u16be")
    return int.from_bytes(data[offset : offset + 2], "big")


def _u32be(data: bytes, offset: int) -> int:
    _require(data, offset, 4, "u32be")
    return int.from_bytes(data[offset : offset + 4], "big")


def find_magic_offsets(data: bytes, magic: bytes = b"SLst") -> list[int]:
    result: list[int] = []
    start = 0
    while True:
        offset = data.find(magic, start)
        if offset < 0:
            return result
        result.append(offset)
        start = offset + 1


def _parse_music_leaf(
    data: bytes, offset: int, *, is_last: bool, path: str
) -> tuple[dict[str, Any], int]:
    _require(data, offset, MUSIC_STRING_HEADER_SIZE, f"Music leaf {path}")
    field_id = data[offset]
    common = {
        "kind": "leaf",
        "path": path,
        "offset": offset,
        "field_id": field_id,
        "field_id_hex": f"0x{field_id:02X}",
        "field_width_bytes": 1,
        "sign_or_modifier_byte": data[offset + 1],
        "operator_byte": data[offset + 4],
    }
    if field_id in MUSIC_STRING_FIELDS:
        byte_length = data[offset + MUSIC_STRING_LENGTH_OFFSET]
        value_offset = offset + MUSIC_STRING_HEADER_SIZE
        declared_end = value_offset + byte_length
        truncated_final_high_byte = False
        if declared_end <= len(data):
            value = data[value_offset:declared_end]
            end = declared_end
        elif is_last and declared_end == len(data) + 1:
            # The pinned itunes_smartplaylist minimal fixture ends after the
            # final ASCII low byte. Its parser samples every other byte and
            # therefore still yields the text, but this is not a complete
            # UTF-16LE code-unit sequence. Keep that boundary explicit.
            value = data[value_offset:]
            end = len(data)
            truncated_final_high_byte = True
        else:
            _require(data, value_offset, byte_length, f"Music string {path}")
            raise AssertionError("unreachable Music string bounds branch")
        terminator_bytes = 0
        if not is_last and data[end : end + 2] == b"\x00\x00":
            end += 2
            terminator_bytes = 2
        if truncated_final_high_byte or len(value) % 2:
            decoded = None
            decode_error = (
                "pinned fixture omits the final UTF-16LE high byte"
                if truncated_final_high_byte
                else "odd UTF-16LE byte length"
            )
        else:
            try:
                decoded = value.decode("utf-16-le")
                decode_error = None
            except UnicodeDecodeError as exc:
                decoded = None
                decode_error = str(exc)
        low_byte_projection = None
        try:
            low_byte_projection = bytes(value[0::2]).decode("latin-1")
        except UnicodeDecodeError:
            pass
        common.update(
            {
                "storage": "string",
                "header_size": MUSIC_STRING_HEADER_SIZE,
                "length_offset": offset + MUSIC_STRING_LENGTH_OFFSET,
                "byte_length": byte_length,
                "available_value_bytes": len(value),
                "value_offset": value_offset,
                "value_hex": value.hex(),
                "utf16le_value": decoded,
                "utf16le_decode_error": decode_error,
                "low_byte_projection": low_byte_projection,
                "truncated_final_high_byte": truncated_final_high_byte,
                "terminator_bytes": terminator_bytes,
                "end_offset": end,
                "total_size": end - offset,
            }
        )
        return common, end

    _require(data, offset, MUSIC_FIXED_RULE_SIZE, f"Music fixed leaf {path}")
    end = offset + MUSIC_FIXED_RULE_SIZE
    common.update(
        {
            "storage": "fixed",
            "size": MUSIC_FIXED_RULE_SIZE,
            "value_a_offset": offset + MUSIC_VALUE_A_OFFSET,
            "value_a_u32be": _u32be(data, offset + MUSIC_VALUE_A_OFFSET),
            "value_b_offset": offset + MUSIC_VALUE_B_OFFSET,
            "value_b_u32be": _u32be(data, offset + MUSIC_VALUE_B_OFFSET),
            "end_offset": end,
            "total_size": MUSIC_FIXED_RULE_SIZE,
        }
    )
    return common, end


def _parse_music_node(
    data: bytes, offset: int, *, is_last: bool, path: str
) -> tuple[dict[str, Any], int]:
    _require(data, offset, MUSIC_STRING_HEADER_SIZE, f"Music node {path}")
    slst_offset = offset + MUSIC_SUBEXPR_PREFIX_SIZE
    if data[slst_offset : slst_offset + 4] != b"SLst":
        return _parse_music_leaf(data, offset, is_last=is_last, path=path)

    _require(data, offset, MUSIC_SUBEXPR_HEADER_SIZE, f"Music subexpression {path}")
    count = _u32be(data, offset + 61)
    if count > 4096:
        raise MusicCriteriaError(f"Music subexpression {path} count {count} is excessive")
    child_offset = offset + MUSIC_SUBEXPR_HEADER_SIZE
    children: list[dict[str, Any]] = []
    position = child_offset
    for index in range(count):
        child, position = _parse_music_node(
            data,
            position,
            is_last=index == count - 1,
            path=f"{path}.{index}",
        )
        children.append(child)
    children_bytes = position - child_offset
    skip_length = _u16be(data, offset + MUSIC_SKIP_OFFSET)
    skip_base = skip_length - children_bytes
    declared_target = offset + skip_length + MUSIC_SKIP_TO_NEXT_ADJUSTMENT
    return (
        {
            "kind": "subexpression",
            "path": path,
            "offset": offset,
            "prefix_size": MUSIC_SUBEXPR_PREFIX_SIZE,
            "embedded_slst_offset": slst_offset,
            "embedded_slst_region_before_children": MUSIC_NESTED_SLST_REGION_SIZE,
            "header_size_to_children": MUSIC_SUBEXPR_HEADER_SIZE,
            "skip_field_offset": offset + MUSIC_SKIP_OFFSET,
            "skip_length_u16be": skip_length,
            "rule_count": count,
            "logic_byte": data[offset + 68],
            "children_offset": child_offset,
            "children_bytes": children_bytes,
            "observed_skip_base": skip_base,
            "parsed_end_offset": position,
            "declared_target_by_skip_plus_56": declared_target,
            "declared_target_minus_parsed_end": declared_target - position,
            "total_size": position - offset,
            "children": children,
        },
        position,
    )


def parse_music_criteria(data: bytes) -> dict[str, Any]:
    """Parse only the pinned XML Smart Criteria structural subset."""
    data = bytes(data)
    _require(data, 0, MUSIC_ROOT_HEADER_SIZE, "Music root")
    if data[:4] != b"SLst":
        raise MusicCriteriaError("Music criteria does not begin with SLst")
    count = _u32be(data, 8)
    if count > 4096:
        raise MusicCriteriaError(f"Music root count {count} is excessive")
    position = MUSIC_ROOT_HEADER_SIZE
    children: list[dict[str, Any]] = []
    for index in range(count):
        child, position = _parse_music_node(
            data,
            position,
            is_last=index == count - 1,
            path=f"root.{index}",
        )
        children.append(child)
    return {
        "magic": "SLst",
        "version_word_u32be": _u32be(data, 4),
        "rule_count": count,
        "logic_byte": data[15],
        "header_size_to_children": MUSIC_ROOT_HEADER_SIZE,
        "children_offset": MUSIC_ROOT_HEADER_SIZE,
        "children": children,
        "parsed_end_offset": position,
        "input_bytes": len(data),
        "trailing_bytes": len(data) - position,
        "magic_offsets": find_magic_offsets(data),
    }


def flatten_music_nodes(tree: dict[str, Any]) -> list[dict[str, Any]]:
    result: list[dict[str, Any]] = []

    def visit(node: dict[str, Any]) -> None:
        result.append(node)
        for child in node.get("children", []):
            visit(child)

    for child in tree["children"]:
        visit(child)
    return result


def _describe_windows_ruleset(
    rules: SmartRuleSet, *, absolute_offset: int = 0, path: str = "root"
) -> dict[str, Any]:
    result: dict[str, Any] = {
        "path": path,
        "slst_offset": absolute_offset,
        "header_size": SLST_HEADER_SIZE,
        "children_offset": absolute_offset + SLST_HEADER_SIZE,
        "version_word": rules.version_word,
        "rule_count": len(rules.rules),
        "conjunction_raw": rules.conjunction,
        "byte_length": len(rules.to_bytes()),
        "trailing_bytes": len(rules.trailing),
        "trailing_hex": rules.trailing.hex(),
        "rules": [],
    }
    for index, rule in enumerate(rules.rules):
        wrapper_offset = absolute_offset + rule.offset
        item: dict[str, Any] = {
            "path": f"{path}.{index}",
            "wrapper_offset": wrapper_offset,
            "wrapper_size": RULE_HEADER_SIZE,
            "field_offset": wrapper_offset,
            "field_width_bytes": 4,
            "field_id_u32be": rule.field_id,
            "field_id_hex": f"0x{rule.field_id:08X}",
            "action_offset": wrapper_offset + 4,
            "action_id_u32be": rule.action_id,
            "action_id_hex": f"0x{rule.action_id:08X}",
            "marker_u32be": rule.marker,
            "marker_hex": f"0x{rule.marker:08X}",
            "data_length_offset": wrapper_offset + 52,
            "data_length_u32be": len(rule.data),
            "data_offset": wrapper_offset + RULE_HEADER_SIZE,
            "total_size": RULE_HEADER_SIZE + len(rule.data),
            "data_sha256": sha256_bytes(rule.data),
        }
        if rule.numeric_value is not None:
            item["numeric"] = {
                "from_value": rule.numeric_value.from_value,
                "to_value": rule.numeric_value.to_value,
                "from_units": rule.numeric_value.from_units,
                "to_units": rule.numeric_value.to_units,
            }
        if rule.string_candidate:
            item["string_candidate"] = {
                "data_hex": rule.data.hex(),
                "byte_length": len(rule.data),
                "utf16be_value_prior_art": rule.string_value,
                "evidence": "cross-format-prior-art",
            }
        if rule.nested is not None:
            item["nested_slst_relative_offset"] = RULE_HEADER_SIZE
            item["nested"] = _describe_windows_ruleset(
                rule.nested,
                absolute_offset=wrapper_offset + RULE_HEADER_SIZE,
                path=f"{path}.{index}",
            )
        if rule.nested_error is not None:
            item["nested_error"] = rule.nested_error
        result["rules"].append(item)
    return result


def flatten_windows_rules(tree: dict[str, Any]) -> list[dict[str, Any]]:
    result: list[dict[str, Any]] = []

    def visit(ruleset: dict[str, Any]) -> None:
        for rule in ruleset["rules"]:
            result.append(rule)
            if "nested" in rule:
                visit(rule["nested"])

    visit(tree)
    return result


def extract_native_type101(path: Path, persistent_id: str = NATIVE_PLAYLIST_PID) -> dict[str, Any]:
    library = Library.read(path)
    matches = [
        playlist
        for playlist in library.playlists
        if f"{playlist.persistent_id:016X}" == persistent_id.upper()
    ]
    if len(matches) != 1:
        raise ValueError(f"expected one playlist {persistent_id}, found {len(matches)}")
    playlist = matches[0]
    nodes = [
        child
        for child in playlist.node.children or ()
        if child.tag == b"mhoh" and child.type_code == 101
    ]
    if len(nodes) != 1:
        raise ValueError(f"expected one type-101 node, found {len(nodes)}")
    payload = bytes(nodes[0].payload)
    rules = parse_rules(payload)
    if rules.to_bytes() != payload:
        raise AssertionError("Windows parser did not round-trip native type-101 bytes")
    return {
        "itl": file_facts(path),
        "playlist": {"name": playlist.name, "persistent_id": persistent_id.upper()},
        "type101": {
            "bytes": len(payload),
            "sha256": sha256_bytes(payload),
            "magic_offsets": find_magic_offsets(payload),
            "round_trip_equal": True,
            "validation_issues": [issue.to_dict() for issue in validate_rules(rules)],
            "tree": _describe_windows_ruleset(rules),
        },
        "_payload": payload,
    }


def compare_bytes(left: bytes, right: bytes) -> dict[str, Any]:
    overlap = min(len(left), len(right))
    prefix = 0
    while prefix < overlap and left[prefix] == right[prefix]:
        prefix += 1
    spans: list[dict[str, Any]] = []
    if overlap:
        start = 0
        equal = left[0] == right[0]
        for offset in range(1, overlap):
            state = left[offset] == right[offset]
            if state != equal:
                spans.append(
                    {
                        "start": start,
                        "end": offset,
                        "bytes": offset - start,
                        "equal": equal,
                    }
                )
                start = offset
                equal = state
        spans.append(
            {"start": start, "end": overlap, "bytes": overlap - start, "equal": equal}
        )
    differing_offsets = [offset for offset in range(overlap) if left[offset] != right[offset]]
    return {
        "left_bytes": len(left),
        "right_bytes": len(right),
        "overlap_bytes": overlap,
        "common_prefix_bytes": prefix,
        "common_prefix_sha256": sha256_bytes(left[:prefix]),
        "first_difference_offset": differing_offsets[0] if differing_offsets else None,
        "difference_count_in_overlap": len(differing_offsets),
        "first_differences": [
            {
                "offset": offset,
                "left_hex": f"{left[offset]:02x}",
                "right_hex": f"{right[offset]:02x}",
            }
            for offset in differing_offsets[:32]
        ],
        "spans": spans,
    }


def _string_overlap_witness(
    golden: bytes, windows_tree: dict[str, Any], music_tree: dict[str, Any]
) -> dict[str, Any]:
    windows = next(
        rule
        for rule in flatten_windows_rules(windows_tree)
        if rule["field_id_u32be"] == 0x04
        and rule.get("string_candidate", {}).get("utf16be_value_prior_art") == "Rock"
    )
    music = next(
        node
        for node in flatten_music_nodes(music_tree)
        if node.get("field_id") == 0x04 and node.get("utf16le_value") == "Rock"
    )
    windows_data = golden[
        windows["data_offset"] : windows["data_offset"]
        + windows["string_candidate"]["byte_length"]
    ]
    music_data = golden[music["value_offset"] : music["end_offset"] - music["terminator_bytes"]]
    return {
        "text": "Rock",
        "windows_view": {
            "rule_offset": windows["wrapper_offset"],
            "data_offset": windows["data_offset"],
            "data_hex": windows_data.hex(),
            "decode": "utf-16-be",
            "decoded": windows_data.decode("utf-16-be"),
            "evidence": "cross-format-prior-art-overlay-only",
        },
        "music_xml_view": {
            "rule_offset": music["offset"],
            "data_offset": music["value_offset"],
            "data_hex": music_data.hex(),
            "decode": "utf-16-le",
            "decoded": music_data.decode("utf-16-le"),
            "evidence": "pinned-Music-XML-prior-art",
        },
        "rule_offset_delta_music_minus_windows": music["offset"]
        - windows["wrapper_offset"],
        "data_offset_delta_music_minus_windows": music["value_offset"]
        - windows["data_offset"],
        "interpretation": (
            "The same ASCII text appears in opposite byte orders because the Music "
            "view starts the rule three bytes later and the value one byte later. "
            "This is not a native Windows string-encoding observation."
        ),
    }


def build_core_audit(
    *,
    native_itl: Path,
    census_path: Path,
    golden_criteria_path: Path,
    golden_info_path: Path,
    minimal_criteria_path: Path,
    minimal_info_path: Path,
) -> dict[str, Any]:
    native = extract_native_type101(native_itl)
    native_payload = native.pop("_payload")
    golden = golden_criteria_path.read_bytes()
    golden_info = golden_info_path.read_bytes()
    minimal = minimal_criteria_path.read_bytes()
    minimal_info = minimal_info_path.read_bytes()

    music_golden = parse_music_criteria(golden)
    music_minimal = parse_music_criteria(minimal)
    windows_golden_rules = parse_rules(golden)
    if windows_golden_rules.to_bytes() != golden:
        raise AssertionError("Windows overlay parser did not round-trip upstream golden")
    windows_golden = _describe_windows_ruleset(windows_golden_rules)

    comparison = compare_bytes(native_payload, golden)
    census = json.loads(census_path.read_text(encoding="utf-8"))
    native_fields = set(census["summary"]["observed_field_ids"])
    v24_nonempty_strings = [
        rule
        for rule in flatten_windows_rules(native["type101"]["tree"])
        if rule.get("string_candidate", {}).get("byte_length", 0) > 0
    ]
    golden_music_nodes = flatten_music_nodes(music_golden)
    music_subexpressions = [node for node in golden_music_nodes if node["kind"] == "subexpression"]

    report: dict[str, Any] = {
        "schema": "windows-itl.smart-prior-art-audit.v1",
        "generated_by": "scripts/research/audit_smart_prior_art_20260925.py",
        "scope": {
            "unresolved": "U-06",
            "policy": (
                "Cross-format source code and Music XML bytes may establish prior-art "
                "correspondence only. Only retained Windows ITL bytes establish native facts."
            ),
            "windows_writes_performed": False,
        },
        "constants": {
            "windows_slst_header_size": SLST_HEADER_SIZE,
            "windows_rule_wrapper_size": RULE_HEADER_SIZE,
            "music_root_header_size": MUSIC_ROOT_HEADER_SIZE,
            "music_subexpression_header_size": MUSIC_SUBEXPR_HEADER_SIZE,
            "music_nested_slst_relative_offset": MUSIC_SUBEXPR_PREFIX_SIZE,
            "music_nested_slst_region_before_children": MUSIC_NESTED_SLST_REGION_SIZE,
            "music_fixed_rule_size": MUSIC_FIXED_RULE_SIZE,
            "music_string_header_size": MUSIC_STRING_HEADER_SIZE,
            "smart_playlist_io_boilerplate_size": SMART_PLAYLIST_IO_BOILERPLATE_SIZE,
        },
        "inputs": {
            "native_itl": native["itl"],
            "native_census": {
                **file_facts(census_path),
                "corpus_commit": census["corpus_commit"],
                "evidence_class": census["evidence_class"],
            },
            "retained_prior_art": {
                "golden_criteria": file_facts(golden_criteria_path),
                "golden_info": file_facts(golden_info_path),
                "minimal_criteria": file_facts(minimal_criteria_path),
                "minimal_info": file_facts(minimal_info_path),
            },
        },
        "windows_native_v24": native,
        "existing_windows_corpus": {
            "file_count": len(census["files"]),
            "occurrence_count": len(census["occurrences"]),
            "observed_field_ids": census["summary"]["observed_field_ids"],
            "field_occurrence_counts": census["field_occurrence_counts"],
            "observed_action_ids": census["summary"]["observed_action_ids"],
            "action_occurrence_counts": census["action_occurrence_counts"],
            "observed_rule_data_lengths": census["summary"]["observed_rule_data_lengths"],
            "string_candidate_rules": census["summary"]["string_candidate_rules"],
        },
        "music_xml_prior_art": {
            "smart_playlist_io_golden": {
                "criteria": file_facts(golden_criteria_path),
                "info": file_facts(golden_info_path),
                "music_view": music_golden,
                "windows_overlay_view": {
                    "round_trip_equal": True,
                    "validation_issues": [
                        issue.to_dict() for issue in validate_rules(windows_golden_rules)
                    ],
                    "tree": windows_golden,
                    "classification": "cross-format-overlay-not-native-evidence",
                },
                "boilerplate": {
                    "bytes": SMART_PLAYLIST_IO_BOILERPLATE_SIZE,
                    "sha256": sha256_bytes(golden[:SMART_PLAYLIST_IO_BOILERPLATE_SIZE]),
                    "outer_rule_count": _u32be(golden, 8),
                    "first_child_offset": music_golden["children"][0]["offset"],
                    "first_child_end": music_golden["children"][0]["parsed_end_offset"],
                    "second_child_offset": music_golden["children"][1]["offset"],
                    "classification": "fixed-Music-XML-prior-art-prefix",
                },
                "observed_subexpression_skip_bases": [
                    {
                        "path": node["path"],
                        "offset": node["offset"],
                        "skip_length": node["skip_length_u16be"],
                        "children_bytes": node["children_bytes"],
                        "observed_skip_base": node["observed_skip_base"],
                        "declared_target_minus_parsed_end": node[
                            "declared_target_minus_parsed_end"
                        ],
                    }
                    for node in music_subexpressions
                ],
            },
            "itunes_smartplaylist_minimal": {
                "criteria": file_facts(minimal_criteria_path),
                "info": file_facts(minimal_info_path),
                "music_view": music_minimal,
                "classification": "pinned-XML-fixture-prior-art",
            },
            "field_name_correspondence": [
                {
                    "field_id": field_id,
                    "field_id_hex": f"0x{field_id:02X}",
                    "prior_art_name": name,
                    "seen_in_existing_windows_corpus": f"0x{field_id:08X}" in native_fields,
                    "classification": "cross-format-correspondence-only",
                }
                for field_id, name in CROSS_FORMAT_FIELD_NAMES.items()
            ],
        },
        "byte_comparison": {
            "native_v24_vs_smart_playlist_io_golden": comparison,
            "native_prefix_579_equals_golden_boilerplate": (
                native_payload[:SMART_PLAYLIST_IO_BOILERPLATE_SIZE]
                == golden[:SMART_PLAYLIST_IO_BOILERPLATE_SIZE]
            ),
            "native_prefix_579_sha256": sha256_bytes(
                native_payload[:SMART_PLAYLIST_IO_BOILERPLATE_SIZE]
            ),
            "shared_slst_offsets_through_632": (
                find_magic_offsets(native_payload)[:3] == find_magic_offsets(golden)[:3]
            ),
            "string_phase_witness": _string_overlap_witness(
                golden, windows_golden, music_golden
            ),
        },
        "findings": [
            {
                "id": "F-01-native-v24-framing",
                "evidence": "Windows-native-v24",
                "result": (
                    "The retained type-101 payload is 824 bytes; Windows children begin "
                    "at 136, group wrappers are 56 bytes, and nested SLst values begin "
                    "at absolute offsets 192 and 632."
                ),
            },
            {
                "id": "F-02-exact-common-prefix",
                "evidence": "byte-comparison",
                "result": (
                    f"Native v24 and the pinned smart-playlist-io golden are identical "
                    f"for bytes [0,{comparison['common_prefix_bytes']}); their first "
                    f"difference is at {comparison['first_difference_offset']}."
                ),
                "limit": "Identity proves shared bytes, not shared provenance or semantics.",
            },
            {
                "id": "F-03-dual-offset-overlay",
                "evidence": "mechanical-two-parser-comparison",
                "result": (
                    "The same nested SLst at 192 is Windows wrapper 136+56 and Music "
                    "subexpression 139+53. The 192-byte totals coincide while the "
                    "component boundaries differ by three bytes."
                ),
            },
            {
                "id": "F-04-mixed-skip-base",
                "evidence": "pinned-smart-playlist-io-golden",
                "result": (
                    "The fixed MediaKind subexpression at 139 has observed skip base "
                    "136, while generated user/nested subexpressions have observed base "
                    "139. Therefore 139 is not a uniform invariant of all subexpressions "
                    "inside the checked-in golden."
                ),
            },
            {
                "id": "F-05-field-width-overlay",
                "evidence": "mechanical-two-parser-comparison",
                "result": (
                    "A Music one-byte field at offset x+3 overlays the low byte of the "
                    "Windows big-endian uint32 field at x; this explains numeric-ID "
                    "agreement without proving semantic equivalence."
                ),
            },
            {
                "id": "F-06-string-byte-phase",
                "evidence": "pinned-Music-XML-golden-overlay",
                "result": (
                    "Rock is UTF-16LE from Music offset 949 and UTF-16BE from the "
                    "Windows-overlay offset 948. The one-byte phase shift produces both "
                    "readings from the same bytes."
                ),
                "limit": (
                    "The retained native v24 Artist rule has zero operand bytes; it "
                    "does not establish either Windows string byte order."
                ),
            },
            {
                "id": "F-07-field-name-boundary",
                "evidence": "pinned-source-plus-native-census",
                "result": (
                    "Pinned sources map 0x9A/0x86/0x85/0x3C to Love/iCloudStatus/"
                    "Location/MediaKind. Native corpus bytes contain 0x3C and 0x85 but "
                    "not 0x9A or 0x86; all names remain cross-format prior art."
                ),
            },
        ],
        "unresolved_boundaries": [
            "No retained Windows-native non-empty string operand establishes UTF-16 byte order.",
            "No controlled Windows differentials establish field/operator meanings for the custom rule.",
            "No semantic oracle establishes membership behavior for nested custom conditions.",
            "No two-cycle Windows persistence run exists for a non-default custom Smart Playlist.",
            "The meaning of the three-byte Music/Windows boundary shift remains structural, not semantic.",
            "smart-playlist-io golden bytes are encoder-generated regression data, not a fresh native export.",
        ],
        "next_native_experiments": [
            {
                "id": "N-01-string-endianness",
                "proposal": (
                    "On an isolated Windows profile, create exactly one Artist-contains "
                    "rule with an asymmetric Unicode sentinel such as A\\u1234éZ; capture "
                    "pre-save, first-save, reopen, and second-save ITLs."
                ),
                "acceptance": (
                    "A non-empty type-101 operand is isolated, its length and exact byte "
                    "window are stable across two saves, and only then is Windows string "
                    "endianness classified."
                ),
            },
            {
                "id": "N-02-group-boundary",
                "proposal": (
                    "Create a nested OR group followed by a non-group sibling so the group "
                    "is not final; vary one child at a time."
                ),
                "acceptance": (
                    "The next-sibling offset resolves whether native length/skip accounting "
                    "contains any three-byte adjustment."
                ),
            },
            {
                "id": "N-03-field-operators",
                "proposal": (
                    "Create isolated one-rule playlists for fields corresponding to 0x9A, "
                    "0x86, 0x85, and 0x3C and toggle one operator/value per save."
                ),
                "acceptance": (
                    "Each claimed field/operator mapping has an isolated byte differential "
                    "and a track-membership oracle; prior-art names are not used as proof."
                ),
            },
            {
                "id": "N-04-two-cycle-persistence",
                "proposal": (
                    "For every candidate above, reopen iTunes and perform a no-op second "
                    "save before declaring persistence."
                ),
                "acceptance": "The semantic AST and exact relevant payload bytes survive two cycles.",
            },
        ],
    }

    if comparison["common_prefix_bytes"] != 630:
        raise AssertionError("unexpected native/golden common-prefix length")
    if music_golden["children"][0]["observed_skip_base"] != 136:
        raise AssertionError("fixed boilerplate no longer has observed skip base 136")
    if music_golden["children"][1]["observed_skip_base"] != 139:
        raise AssertionError("generated user group no longer has observed skip base 139")
    if v24_nonempty_strings:
        raise AssertionError("native v24 unexpectedly contains a non-empty string candidate")
    return report


def _git_head(repo: Path) -> str:
    return subprocess.run(
        ["git", "-C", str(repo), "rev-parse", "HEAD"],
        check=True,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    ).stdout.strip()


def verify_upstream_repo(
    repo: Path, *, name: str, expected_commit: str, expected_hashes: dict[str, str]
) -> dict[str, Any]:
    head = _git_head(repo)
    if head != expected_commit:
        raise ValueError(f"{name} HEAD {head} != pinned {expected_commit}")
    files: list[dict[str, Any]] = []
    for relative, expected_hash in expected_hashes.items():
        path = repo / relative
        actual = sha256_file(path)
        if actual != expected_hash:
            raise ValueError(f"{name}/{relative} hash {actual} != {expected_hash}")
        files.append(
            {
                "path": relative,
                "bytes": path.stat().st_size,
                "sha256": actual,
            }
        )
    return {"commit": head, "files": files}


def _extract_minimal_xml(xml_path: Path) -> tuple[bytes, bytes, str]:
    value = plistlib.loads(xml_path.read_bytes())
    matches = [playlist for playlist in value["Playlists"] if "Smart Criteria" in playlist]
    if len(matches) != 1:
        raise ValueError(f"expected one minimal smart playlist, found {len(matches)}")
    playlist = matches[0]
    return bytes(playlist["Smart Criteria"]), bytes(playlist["Smart Info"]), playlist["Name"]


def _write_json(path: Path, value: Any) -> None:
    path.write_text(
        json.dumps(value, indent=2, sort_keys=True, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )


def _normalised_utf8(path: Path) -> str:
    return path.read_text(encoding="utf-8").replace("\r\n", "\n").rstrip()


def build_third_party_notices(
    *, smart_playlist_io_repo: Path, itunes_smartplaylist_repo: Path
) -> str:
    smart_license = _normalised_utf8(smart_playlist_io_repo / "LICENSE")
    smart_notice = _normalised_utf8(smart_playlist_io_repo / "NOTICE")
    itunes_license = _normalised_utf8(itunes_smartplaylist_repo / "LICENSE")
    return f"""# Third-party notices for retained Smart Playlist prior-art snapshots

This directory retains four small binary snapshots solely for reproducible,
evidence-bounded format comparison. They are cross-format prior art, not
Windows-native proof. The source repositories and exact commits are pinned in
`source-manifest.json`.

## `kynoptic/smart-playlist-io`

Source: {SMART_PLAYLIST_IO_URL}
Pinned commit: `{SMART_PLAYLIST_IO_COMMIT}`

`smart-playlist-io-golden-criteria.bin` and
`smart-playlist-io-golden-info.bin` are exact copies of the pinned upstream
regression fixtures `tests/fixtures/golden_criteria.bin` and
`tests/fixtures/golden_info.bin`.

### MIT license (verbatim; line endings normalized)

```text
{smart_license}
```

### Upstream NOTICE (verbatim; line endings normalized)

```text
{smart_notice}
```

## `cvzi/itunes_smartplaylist`

Source: {ITUNES_SMARTPLAYLIST_URL}
Pinned commit: `{ITUNES_SMARTPLAYLIST_COMMIT}`

`itunes-smartplaylist-minimal-criteria.bin` and
`itunes-smartplaylist-minimal-info.bin` are byte-exact extractions of the
`Smart Criteria` and `Smart Info` plist data in the pinned
`tests/library_minimal.xml` fixture.

### MIT license (verbatim; line endings normalized)

```text
{itunes_license}
```
"""


def generate_audit(
    *,
    native_itl: Path,
    census_path: Path,
    smart_playlist_io_repo: Path,
    itunes_smartplaylist_repo: Path,
    output_dir: Path,
) -> tuple[dict[str, Any], dict[str, Any]]:
    smart_verified = verify_upstream_repo(
        smart_playlist_io_repo,
        name="smart-playlist-io",
        expected_commit=SMART_PLAYLIST_IO_COMMIT,
        expected_hashes=EXPECTED_SOURCE_HASHES["smart-playlist-io"],
    )
    itunes_verified = verify_upstream_repo(
        itunes_smartplaylist_repo,
        name="itunes_smartplaylist",
        expected_commit=ITUNES_SMARTPLAYLIST_COMMIT,
        expected_hashes=EXPECTED_SOURCE_HASHES["itunes_smartplaylist"],
    )

    output_dir.mkdir(parents=True, exist_ok=True)
    golden_criteria = (
        smart_playlist_io_repo / "tests" / "fixtures" / "golden_criteria.bin"
    ).read_bytes()
    golden_info = (
        smart_playlist_io_repo / "tests" / "fixtures" / "golden_info.bin"
    ).read_bytes()
    minimal_criteria, minimal_info, minimal_name = _extract_minimal_xml(
        itunes_smartplaylist_repo / "tests" / "library_minimal.xml"
    )

    retained = {
        "smart-playlist-io-golden-criteria.bin": golden_criteria,
        "smart-playlist-io-golden-info.bin": golden_info,
        "itunes-smartplaylist-minimal-criteria.bin": minimal_criteria,
        "itunes-smartplaylist-minimal-info.bin": minimal_info,
    }
    for name, data in retained.items():
        (output_dir / name).write_bytes(data)

    notices_path = output_dir / "THIRD_PARTY_NOTICES.md"
    notices_path.write_text(
        build_third_party_notices(
            smart_playlist_io_repo=smart_playlist_io_repo,
            itunes_smartplaylist_repo=itunes_smartplaylist_repo,
        ),
        encoding="utf-8",
    )

    manifest = {
        "schema": "windows-itl.smart-prior-art-source-manifest.v1",
        "evidence_class": "cross-format-prior-art",
        "warning": "These sources and snapshots are not Windows-native proof.",
        "repositories": [
            {
                "name": "smart-playlist-io",
                "url": SMART_PLAYLIST_IO_URL,
                "license": {"spdx": "MIT", "path": "LICENSE", "notice_path": "NOTICE"},
                **smart_verified,
            },
            {
                "name": "itunes_smartplaylist",
                "url": ITUNES_SMARTPLAYLIST_URL,
                "license": {"spdx": "MIT", "path": "LICENSE"},
                **itunes_verified,
            },
        ],
        "retained_snapshots": [
            {
                "path": f"evidence/research/20260925/smart-prior-art/{name}",
                "bytes": len(data),
                "sha256": sha256_bytes(data),
            }
            for name, data in sorted(retained.items())
        ],
        "minimal_playlist_name": minimal_name,
        "license_policy": {
            "spdx": "MIT",
            "third_party_notices": {
                "path": "evidence/research/20260925/smart-prior-art/THIRD_PARTY_NOTICES.md",
                "sha256": sha256_file(notices_path),
            },
            "snapshot_origins": [
                {
                    "snapshot": "smart-playlist-io-golden-criteria.bin",
                    "repository": "smart-playlist-io",
                    "source_path": "tests/fixtures/golden_criteria.bin",
                },
                {
                    "snapshot": "smart-playlist-io-golden-info.bin",
                    "repository": "smart-playlist-io",
                    "source_path": "tests/fixtures/golden_info.bin",
                },
                {
                    "snapshot": "itunes-smartplaylist-minimal-criteria.bin",
                    "repository": "itunes_smartplaylist",
                    "source_path": "tests/library_minimal.xml#Smart Criteria",
                },
                {
                    "snapshot": "itunes-smartplaylist-minimal-info.bin",
                    "repository": "itunes_smartplaylist",
                    "source_path": "tests/library_minimal.xml#Smart Info",
                },
            ],
        },
    }
    _write_json(output_dir / "source-manifest.json", manifest)

    report = build_core_audit(
        native_itl=native_itl,
        census_path=census_path,
        golden_criteria_path=output_dir / "smart-playlist-io-golden-criteria.bin",
        golden_info_path=output_dir / "smart-playlist-io-golden-info.bin",
        minimal_criteria_path=output_dir / "itunes-smartplaylist-minimal-criteria.bin",
        minimal_info_path=output_dir / "itunes-smartplaylist-minimal-info.bin",
    )
    report["source_manifest_sha256"] = sha256_file(output_dir / "source-manifest.json")
    _write_json(output_dir / "audit.json", report)
    return report, manifest


def _parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--native-itl", type=Path, default=DEFAULT_NATIVE_ITL)
    parser.add_argument("--census", type=Path, default=DEFAULT_CENSUS)
    parser.add_argument(
        "--smart-playlist-io-repo",
        type=Path,
        default=DEFAULT_EXTERNAL / "smart-playlist-io",
    )
    parser.add_argument(
        "--itunes-smartplaylist-repo",
        type=Path,
        default=DEFAULT_EXTERNAL / "itunes_smartplaylist",
    )
    parser.add_argument("--output-dir", type=Path, default=DEFAULT_OUTPUT)
    return parser


def main(argv: Iterable[str] | None = None) -> int:
    args = _parser().parse_args(argv)
    report, manifest = generate_audit(
        native_itl=args.native_itl,
        census_path=args.census,
        smart_playlist_io_repo=args.smart_playlist_io_repo,
        itunes_smartplaylist_repo=args.itunes_smartplaylist_repo,
        output_dir=args.output_dir,
    )
    summary = {
        "audit": path_label(args.output_dir / "audit.json"),
        "manifest": path_label(args.output_dir / "source-manifest.json"),
        "native_type101_sha256": report["windows_native_v24"]["type101"]["sha256"],
        "common_prefix_bytes": report["byte_comparison"][
            "native_v24_vs_smart_playlist_io_golden"
        ]["common_prefix_bytes"],
        "retained_snapshots": len(manifest["retained_snapshots"]),
    }
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
