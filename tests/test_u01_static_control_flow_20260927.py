"""Regressions for the bounded U-01 static control-flow follow-up."""
from __future__ import annotations

import hashlib
import importlib.util
import json
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/inventory_u01_record_layouts_20260927.py"
EVIDENCE = ROOT / "evidence/research/20260927/u01-static-control-flow"
CENSUS = EVIDENCE / "record-layout-census.json"
GHIDRA = EVIDENCE / "ghidra-localization-flow.json"


def load_module():
    spec = importlib.util.spec_from_file_location("u01_record_layouts", SCRIPT)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_record_layout_census_rebuilds_byte_exactly() -> None:
    module = load_module()
    rebuilt = json.dumps(
        module.build_report(), ensure_ascii=False, indent=2, sort_keys=True
    ).encode() + b"\n"
    assert CENSUS.read_bytes() == rebuilt


def test_record_layout_census_is_bounded_and_fail_closed() -> None:
    report = json.loads(CENSUS.read_text(encoding="utf-8"))
    assert report["status"] == "offline_census_complete_no_native_launch_authorized"
    assert report["counts"] == {
        "apple_executable_reads": 0,
        "manifest_hashes_verified": 431,
        "native_itunes_launches": 0,
        "network_operations": 0,
        "parse_failures": 1,
        "strict_reference_parses": 430,
        "versions": {
            "12.12.10.1": 6,
            "12.13.10.3": 392,
            "12.13.11.1": 20,
            "12.13.9.1": 12,
        },
    }
    assert report["source_set"]["representative_sample"] is False
    assert report["parse_failures"] == [
        {
            "error": "declared file size does not match actual size",
            "error_type": "FormatError",
            "path": (
                "evidence/research/20260927/u01-sampled-version-matrix/inputs/"
                "reference-three-track-zlib-truncated-1-byte.itl"
            ),
        }
    ]
    conclusion = report["bounded_conclusion"]
    assert conclusion["all_four_version_labels_share_section_type_set"] is True
    assert conclusion["all_four_version_labels_share_record_tag_header_layout_set"] is True
    assert conclusion["target_12_13_11_1_has_new_section_type"] is False
    assert conclusion["target_12_13_11_1_has_new_record_tag_or_header_layout"] is False
    assert conclusion["target_12_13_11_1_has_new_mhoh_type"] is False
    assert conclusion["observed_target_only_differences_are_population_counts"] is True
    assert conclusion["concrete_non_label_incompatibility_theory_identified"] is False
    assert conclusion["native_launch_authorized"] is False
    assert conclusion["u01_status"] == "open"
    assert conclusion["universal_itl_support"] is False
    assert conclusion["parser_writer_profile_12_12_10_1_supported"] is False
    assert conclusion["independent_reimplementation_passed"] is False
    assert conclusion["complete_analysis_gate"] is False


def test_record_layout_and_target_comparison_are_exact() -> None:
    report = json.loads(CENSUS.read_text(encoding="utf-8"))
    expected_layouts = [
        {"header_bytes": 144, "tag": "mfdh"},
        {"header_bytes": 280, "tag": "mhgh"},
        {"header_bytes": 24, "tag": "mhoh"},
        {"header_bytes": 88, "tag": "miah"},
        {"header_bytes": 100, "tag": "miih"},
        {"header_bytes": 3500, "tag": "miph"},
        {"header_bytes": 756, "tag": "mith"},
        {"header_bytes": 92, "tag": "mlah"},
        {"header_bytes": 100, "tag": "mlih"},
        {"header_bytes": 92, "tag": "mlph"},
        {"header_bytes": 44, "tag": "mlsh"},
        {"header_bytes": 92, "tag": "mlth"},
        {"header_bytes": 48, "tag": "msph"},
        {"header_bytes": 84, "tag": "mtph"},
    ]
    expected_sections = [1, 2, 4, 9, 11, 12, 13, 14, 16, 21, 23]
    for row in report["by_version"].values():
        assert row["record_layouts"] == expected_layouts
        assert row["section_types"] == expected_sections

    target = report["comparisons_against_12_12_10_1"]["12.13.11.1"]
    assert target["section_types_only_in_later"] == []
    assert target["record_layouts_only_in_later"] == []
    assert target["mhoh_types_only_in_later"] == []
    assert [
        (row["tag"], row["child_count_bucket"], row["file_count"])
        for row in target["child_count_buckets_only_in_later"]
    ] == [
        ("miph", 9, 12),
        ("miph", 10, 12),
        ("mith", 4, 4),
        ("mlah", 3, 4),
        ("mlih", 3, 4),
        ("mlth", 3, 12),
    ]


def test_ghidra_report_locks_registration_path_without_parser_claim() -> None:
    assert hashlib.sha256(GHIDRA.read_bytes()).hexdigest() == (
        "79bb1af0dbe21722e53ec0a8d26831c2f6e88f909a473fb769e5c7858bd2c887"
    )
    report = json.loads(GHIDRA.read_text(encoding="utf-8"))
    assert report["schema"] == "windows-itl.u01-ghidra-localization-flow-20260927.v2"
    assert report["classification"] == "derived static metadata only; no Apple bytes retained"
    assert report["tool"] == {
        "name": "Ghidra",
        "version": "12.1.3",
        "analysis_mode": "full headless static analysis; target executable never launched",
    }
    assert report["executable"] == {
        "name": "iTunes.exe",
        "sha256": "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b",
        "image_base": "0x140000000",
        "function_count": 62218,
        "binary_retained": False,
    }

    wrapper = report["group_0x1f42_wrapper"]
    assert wrapper["entry_rva"] == "0x1fb500"
    assert wrapper["body_address_count"] == 75
    assert len(wrapper["instructions"]) == 19
    assert wrapper["reference_counts"] == {
        "total": 2,
        "call": 0,
        "jump": 0,
        "executable_source": 0,
    }
    assert [
        (row["from_rva"], row["from_memory_block"], row["reference_type"])
        for row in wrapper["references_to"]
    ] == [
        ("0x215f2bc", ".pdata", "DATA"),
        ("0x1949d58", ".rdata", "DATA"),
    ]

    pointer_table = report["wrapper_pointer_table_slot"]
    assert pointer_table["rva"] == "0x1949d58"
    assert pointer_table["stored_target_rva"] == "0x1fb500"
    assert len(pointer_table["neighbors"]) == 17
    assert all(row["target_executable"] for row in pointer_table["neighbors"])
    assert all(row["target_function_entry"] for row in pointer_table["neighbors"])

    assert report["group_descriptor"]["rva"] == "0x19fd810"
    assert report["group_descriptor"]["reference_counts"] == {
        "total": 1,
        "call": 0,
        "jump": 0,
        "executable_source": 1,
    }
    assert report["newer_version_member_entry"]["rva"] == "0x19fd7c0"
    assert report["newer_version_member_entry"]["reference_counts"]["total"] == 0
    assert report["invalid_library_member_entry"]["rva"] == "0x19fd7d0"
    assert report["invalid_library_member_entry"]["reference_counts"]["total"] == 0

    registration = report["registration_dictionary_global"]
    assert registration["rva"] == "0x211aeb8"
    assert registration["symbols"] == ["DAT_14211aeb8"]
    assert registration["reference_counts"]["total"] == 223
    assert Counter(row["reference_type"] for row in registration["references_to"]) == {
        "READ": 112,
        "WRITE": 111,
    }
    create_slot = report["dictionary_create_mutable_indirect_slot"]
    assert create_slot["rva"] == "0x192f340"
    assert create_slot["symbols"] == ["PTR_CFDictionaryCreateMutable_14192f340"]
    assert create_slot["reference_counts"]["total"] == 795
    add_slot = report["dictionary_add_value_indirect_slot"]
    assert add_slot["rva"] == "0x192f5e8"
    assert add_slot["symbols"] == ["PTR_CFDictionaryAddValue_14192f5e8"]
    assert add_slot["reference_counts"]["total"] == 714

    instructions = {row["rva"]: row for row in wrapper["instructions"]}
    assert instructions["0x1fb51a"]["mnemonic"] == "CALL"
    assert instructions["0x1fb51a"]["operands"] == ["qword ptr [0x14192f340]"]
    assert instructions["0x1fb52c"]["operands"] == ["R8", "[0x1419fd810]"]
    assert instructions["0x1fb533"]["operands"] == ["EDX", "0x1f42"]
    assert instructions["0x1fb53f"]["mnemonic"] == "JMP"
    assert instructions["0x1fb53f"]["operands"] == ["qword ptr [0x14192f5e8]"]

    immediate_counts = Counter(row["value"] for row in report["instruction_immediate_uses"])
    assert immediate_counts == {"0x1f42": 10}
    conclusion = report["bounded_conclusion"]
    assert conclusion["wrapper_classification"] == (
        "generated_localization_group_registration_initializer"
    )
    assert conclusion["direct_call_reference_to_wrapper_identified"] is False
    assert conclusion["parser_result_or_status_comparison_identified"] is False
    assert conclusion["member_3_vs_4_selection_branch_identified"] is False
    assert conclusion["semantic_status_code_claimed"] is False
    assert conclusion["concrete_non_label_incompatibility_theory_identified"] is False
    assert conclusion["native_launch_authorized"] is False
    assert conclusion["u01_status"] == "open"
