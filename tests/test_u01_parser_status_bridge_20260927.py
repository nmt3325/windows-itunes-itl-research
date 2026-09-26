"""Regressions for the bounded U-01 exact-parser status/resource bridge."""
from __future__ import annotations

import hashlib
import json
import struct
from pathlib import Path

import pytest

from REFERENCE_PARSER.core import UnsupportedError, decode_envelope_bytes

ROOT = Path(__file__).resolve().parents[1]
EVIDENCE = ROOT / "evidence/research/20260927/u01-parser-status-bridge"
REPORT = EVIDENCE / "ghidra-parser-status-flow.json"
SCRIPT = ROOT / "scripts/ghidra/U01ParserStatusFlow.java"


def load_report() -> dict:
    return json.loads(REPORT.read_text(encoding="utf-8"))


def instruction_map(report: dict, window: str) -> dict[str, dict]:
    return {row["rva"]: row for row in report["instruction_windows"][window]}


def test_report_and_script_hashes_are_exact() -> None:
    assert hashlib.sha256(REPORT.read_bytes()).hexdigest() == (
        "40dd9a15a6b8a5b5e4974952b73085bd75a5ab2e3b9006c1a9cfd5293e613e35"
    )
    assert hashlib.sha256(SCRIPT.read_bytes()).hexdigest() == (
        "2f4293b5e17aea31f93cbd8f7499ba5855f77c28b3e0972beb2417dd110f7cd0"
    )


def test_report_locks_provenance_and_functions() -> None:
    report = load_report()
    assert report["schema"] == "windows-itl.u01-ghidra-parser-status-flow-20260927.v1"
    assert report["classification"] == (
        "bounded derived static metadata only; no Apple bytes retained"
    )
    assert report["tool"] == {
        "name": "Ghidra",
        "version": "12.1.3",
        "analysis_mode": (
            "saved full headless static analysis; target executable never launched"
        ),
    }
    assert report["executable"] == {
        "name": "iTunes.exe",
        "sha256": "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b",
        "image_base": "0x140000000",
        "function_count": 62218,
        "binary_retained": False,
    }

    expected = {
        "parser": ("0x10ad0b0", "FUN_1410ad0b0", 4920),
        "direct_caller": ("0x53d500", "FUN_14053d500", 6694),
        "upstream_wrapper": ("0x53f4e0", "FUN_14053f4e0", 490),
        "alternate_parser": ("0x10f4b90", "FUN_1410f4b90", 2094),
        "status_formatter": ("0xebbf20", "FUN_140ebbf20", 313),
        "descriptor_mapper": ("0xbfac90", "FUN_140bfac90", 2096),
        "group_0x1f43_registration_wrapper": (
            "0x1fb550",
            "FUN_1401fb550",
            75,
        ),
    }
    for key, (rva, name, body_count) in expected.items():
        function = report["functions"][key]
        assert (function["entry_rva"], function["name"], function["body_address_count"]) == (
            rva,
            name,
            body_count,
        )

    parser_call = report["functions"]["parser"]["direct_call_references"]
    assert [(row["from_rva"], row["from_function_entry_rva"]) for row in parser_call] == [
        ("0x53db44", "0x53d500")
    ]
    caller_call = report["functions"]["direct_caller"]["direct_call_references"]
    assert [(row["from_rva"], row["from_function_entry_rva"]) for row in caller_call] == [
        ("0x53f62c", "0x53f4e0")
    ]


def test_parser_feature_gate_and_status_flow_are_exact() -> None:
    report = load_report()
    header = instruction_map(report, "parser_header_word_ceiling")
    assert header["0x10ad257"]["operands"] == ["EAX", "word ptr [R14 + 0xc]"]
    assert header["0x10ad25c"] == {
        "rva": "0x10ad25c",
        "mnemonic": "CMP",
        "operands": ["AX", "0x43"],
        "references_from": [],
    }
    assert header["0x10ad262"]["operands"] == ["ESI", "0xfffffc94"]

    gate = instruction_map(report, "parser_encryption_mode_gate")
    assert gate["0x10ad2b2"]["operands"] == ["byte ptr [R14 + 0x41]", "0x3"]
    assert gate["0x10ad2b7"]["mnemonic"] == "JC"
    assert gate["0x10ad2b9"]["operands"] == ["ESI", "0xfffffc94"]
    assert gate["0x10ad2c1"]["references_from"][0]["to_rva"] == "0x10ae058"

    alternate = instruction_map(report, "alternate_parser_encryption_mode_gate")
    assert alternate["0x10f4d42"]["operands"] == ["byte ptr [RBX + 0x41]", "0x3"]
    assert alternate["0x10f4d48"]["operands"] == ["EDI", "0xfffffc94"]

    returned = instruction_map(report, "direct_caller_parse_return")
    assert returned["0x53db44"]["references_from"][0]["to_rva"] == "0x10ad0b0"
    assert returned["0x53db49"]["operands"] == ["R14D", "EAX"]
    assert returned["0x53db57"]["operands"] == ["EAX", "EAX"]
    assert returned["0x53db59"]["references_from"][0]["to_rva"] == "0x53e3f4"

    compared = instruction_map(report, "direct_caller_status_comparison")
    assert compared["0x53db8d"]["operands"] == ["R14D", "0xfffffc94"]
    assert compared["0x53db94"]["references_from"][0]["to_rva"] == "0x53e30f"

    error_path = instruction_map(report, "status_error_path_to_group_0x1f43")
    assert error_path["0x53e387"]["operands"] == ["ECX", "0x1f43"]
    assert error_path["0x53e38c"]["operands"] == ["R8D", "R14D"]
    assert error_path["0x53e394"]["references_from"][0]["to_rva"] == "0xebbf20"

    upstream = instruction_map(report, "upstream_zero_success_gate")
    assert upstream["0x53f62c"]["references_from"][0]["to_rva"] == "0x53d500"
    assert upstream["0x53f631"]["operands"] == ["ESI", "EAX"]
    assert upstream["0x53f633"]["operands"] == ["EAX", "EAX"]
    assert upstream["0x53f637"]["operands"] == ["byte ptr [RBX + 0x47a]", "0x1"]

    feature = report["concrete_non_label_feature_gate"]
    assert feature == {
        "outer_header_byte_offset": "0x41",
        "single_gate_condition": "unsigned byte >= 3",
        "values_passing_this_single_native_parser_gate": [0, 1, 2],
        "status_returned_when_gate_fails": -876,
        "status_u32": "0xfffffc94",
        "mapped_primary_resource_id": "0x1f420003",
        "mapped_resource_role_from_prior_exact_build_evidence": "newer_version_message",
        "version_label_field_used_by_this_gate": False,
    }


def test_error_descriptor_maps_minus_876_to_newer_version_resource() -> None:
    report = load_report()
    forwarding = instruction_map(report, "status_formatter_forwarding")
    assert forwarding["0xebbfd4"]["operands"] == ["R8D", "ESI"]
    assert forwarding["0xebbfdf"]["references_from"][0]["to_rva"] == "0xebbc00"

    lookup = instruction_map(report, "descriptor_dictionary_lookup")
    assert lookup["0xbfad0b"]["references_from"][0]["to_rva"] == "0x211aeb8"
    assert "COREFOUNDATION.DLL::CFDictionaryGetValue" in (
        lookup["0xbfad23"]["references_from"][0]["target_symbols"]
    )
    iteration = instruction_map(report, "descriptor_entry_iteration_and_status_compare")
    assert iteration["0xbfad55"]["operands"] == ["RAX", "0x4"]
    assert iteration["0xbfad63"]["operands"] == ["ESI", "dword ptr [RAX]"]
    assert iteration["0xbfad71"]["operands"] == ["ECX", "dword ptr [RAX + 0x4]"]
    assert iteration["0xbfad78"]["operands"] == ["R14D", "dword ptr [RAX + 0x8]"]
    assert iteration["0xbfad7c"]["operands"] == ["R15D", "dword ptr [RAX + 0xc]"]
    assert iteration["0xbfad8b"]["operands"] == ["ESI", "EDI"]

    registration = instruction_map(report, "group_0x1f43_registration")
    assert registration["0x1fb57c"]["operands"] == ["R8", "[0x1419fd7e8]"]
    assert registration["0x1fb583"]["operands"] == ["EDX", "0x1f43"]

    descriptor = report["group_0x1f43_error_descriptor"]
    assert descriptor["rva"] == "0x19fd7e8"
    assert descriptor["group_id"] == "0x00001f43"
    assert descriptor["linked_message_group_id"] == "0x00001f42"
    assert descriptor["entry_count"] == 3
    assert descriptor["entries_pointer_va"] == "0x1419fd7b8"
    assert descriptor["entries_pointer_rva"] == "0x19fd7b8"
    assert [
        (
            row["index"],
            row["rva"],
            row["status_u32"],
            row["status_signed"],
            row["metadata_u32"],
            row["primary_resource_id"],
            row["secondary_resource_id"],
        )
        for row in descriptor["entries"]
    ] == [
        (0, "0x19fd7b8", "0xfffffc94", -876, "0x2af80002", "0x1f420003", "0x00000000"),
        (1, "0x19fd7c8", "0xffffff30", -208, "0x2af80002", "0x1f420004", "0x00000000"),
        (2, "0x19fd7d8", "0xfffffff7", -9, "0x00000000", "0x1f420002", "0x00000000"),
    ]
    assert descriptor["entries"][0]["resource_role_from_prior_exact_build_evidence"] == (
        "newer_version_message"
    )


def test_immediate_inventories_and_fail_closed_boundary_are_exact() -> None:
    report = load_report()
    assert [
        row["instruction"]["rva"]
        for row in report["status_0xfffffc94_immediate_uses"]
    ] == [
        "0x53db8d",
        "0x5aef49",
        "0x108a422",
        "0x10ad262",
        "0x10ad2b9",
        "0x10f4d17",
        "0x10f4d28",
        "0x10f4d48",
    ]
    assert [
        row["instruction"]["rva"] for row in report["group_0x1f43_immediate_uses"]
    ] == ["0x1fb583", "0x53e387", "0x7e48df"]

    assert report["independent_preflight_boundary"] == {
        "reference_parser_source": "REFERENCE_PARSER/core.py",
        "reference_parser_encryption_byte_offset": "0x41",
        "reference_parser_supported_values": [0, 1, 2],
        "mode_3_or_greater_passes_independent_preflight": False,
        "exact_native_candidate_locked": False,
        "native_launch_authorized": False,
    }
    conclusion = report["bounded_conclusion"]
    assert conclusion["parser_result_or_status_comparison_identified"] is True
    assert conclusion["status_minus_876_producer_identified_in_exact_parser"] is True
    assert conclusion["status_minus_876_to_newer_version_resource_mapping_identified"] is True
    assert conclusion["concrete_non_version_label_feature_gate_identified"] is True
    assert conclusion["exact_product_modal_observed"] is False
    assert conclusion["candidate_passes_independent_structural_semantic_preflight"] is False
    assert conclusion["native_launch_authorized"] is False
    assert conclusion["native_itunes_launches"] == 0
    assert conclusion["product_facing_native_negative_established"] is False
    assert conclusion["parser_writer_profile_12_12_10_1_supported"] is False
    assert conclusion["universal_itl_support"] is False
    assert conclusion["independent_semantic_reproduction_passed"] is False
    assert conclusion["complete_analysis_gate"] is False
    assert conclusion["u01_status"] == "open"


def test_independent_reference_parser_refuses_mode_three_preflight() -> None:
    header = bytearray(144)
    header[:4] = b"hdfm"
    struct.pack_into(">II", header, 4, len(header), len(header))
    header[0x10] = len(b"12.12.10.1")
    header[0x11 : 0x11 + header[0x10]] = b"12.12.10.1"
    header[0x41] = 3
    with pytest.raises(UnsupportedError, match=r"unsupported encryption flag 3"):
        decode_envelope_bytes(bytes(header))
