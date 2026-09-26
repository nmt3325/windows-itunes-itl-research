"""Regressions for the offline U-01 structural candidate inventory."""
from __future__ import annotations

import importlib.util
import json
from pathlib import Path

from scripts.windows import u01_distinct_build_20260927 as distinct

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/inventory_u01_structural_candidates_20260927.py"
EVIDENCE = ROOT / "evidence/research/20260927/u01-structural-candidate-inventory"
REPORT = EVIDENCE / "native-structure-inventory.json"
PLAN = EVIDENCE / "predeclared-no-launch-plan.json"
STATIC = EVIDENCE / "static-localization-evidence.json"


def load_module():
    spec = importlib.util.spec_from_file_location("u01_structural_inventory", SCRIPT)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_candidate_and_report_rebuild_byte_exactly() -> None:
    module = load_module()
    assert module.CANDIDATE.read_bytes() == module.build_candidate_bytes()
    rebuilt = json.dumps(module.build_report(), ensure_ascii=False, indent=2, sort_keys=True).encode() + b"\n"
    assert REPORT.read_bytes() == rebuilt


def test_corrected_structural_findings_are_fail_closed() -> None:
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    assert report["status"] == "offline_inventory_complete_no_structural_candidate_eligible_no_native_launch"
    assert report["scope"]["native_launches_performed_by_this_inventory"] == 0
    assert report["scope"]["u01_closed"] is False
    findings = report["corrected_findings"]
    assert findings["mhgh_offset_0xe5_value_4_is_newer_only"] is False
    assert findings["mhgh_offset_0xe5_value_4_observed_on_clean_12_12"] is True
    assert findings["type_109_is_unknown_binary_capability_object"] is False
    assert findings["type_109_is_xml_plist_playlist_view_state"] is True
    assert findings["two_type_109_objects_establish_version_incompatibility"] is False
    assert findings["force_terminated_timeout_survivors_are_clean_native_cycles"] is False

    inventory = report["inventory"]
    clean = [inventory["native_12_12_positive_cycle_1"], inventory["native_12_12_positive_cycle_2"]]
    newer = [
        inventory["native_12_13_9_matched_cycle_2"],
        inventory["native_12_13_11_matched_cycle_2"],
        inventory["native_12_13_11_independent_cycle_2"],
    ]
    assert all(row["mhgh_offset_0xe5"] == 4 for row in clean + newer)
    assert all(row["type_109_objects"] for row in clean + newer)
    assert all(
        obj["payload_format"] == "xml_plist"
        for row in clean + newer
        for obj in row["type_109_objects"]
    )
    assert clean[1]["type_109_objects"][0]["plist"] == {
        "lastViewedPlaylist": 81,
        "lastViewedPlaylistViewMode": 7,
        "tabViewMode": 4,
    }


def test_offline_derivative_is_locked_but_not_launch_eligible() -> None:
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    plan = json.loads(PLAN.read_text(encoding="utf-8"))
    candidate = report["offline_derivative"]
    source = report["inventory"]["native_12_13_11_matched_cycle_2"]
    decision = report["candidate_decision"]
    assert candidate["sha256"] == "e9ea49521b72e8d166ec852531927069ca6fb8dc6a37ea9e59ae3bbda8916f47"
    assert candidate["outer_version"] == candidate["inner_mfdh_version"] == "12.12.10.1"
    assert candidate["file_persistent_id"] == source["file_persistent_id"]
    assert candidate["track_semantics"] == source["track_semantics"]
    assert candidate["section_types"] == source["section_types"]
    assert candidate["mhoh_type_census"] == source["mhoh_type_census"]
    assert candidate["type_109_objects"] == source["type_109_objects"]
    assert decision["eligible_for_12_12_native_negative_launch"] is False
    assert decision["launch_authorized"] is False
    assert plan["locked_inputs"]["offline_derivative"]["sha256"] == candidate["sha256"]
    assert plan["theory_gate"]["passed"] is False
    assert plan["decision"]["attempts_authorized"] == 0
    assert plan["decision"]["launch_authorized"] is False


def test_static_localization_evidence_does_not_invent_parser_status() -> None:
    value = json.loads(STATIC.read_text(encoding="utf-8"))
    entries = {row["role"]: row for row in value["numeric_resource_family"]["members"]}
    assert entries["newer_version_message"]["id"] == "0x1f420003"
    assert entries["newer_version_message"]["file_offset"] == "0x19fc1c0"
    assert entries["invalid_library_message"]["id"] == "0x1f420004"
    assert entries["invalid_library_message"]["file_offset"] == "0x19fc1d0"
    conclusion = value["bounded_conclusion"]
    assert conclusion["resource_family_localized"] is True
    assert conclusion["parser_result_or_status_comparison_identified"] is False
    assert conclusion["call_site_selecting_member_3_versus_4_identified"] is False
    assert conclusion["semantic_status_code_claimed"] is False


def test_library_modal_classifier_distinguishes_newer_invalid_and_title_only() -> None:
    newer = {
        "title": "iTunes",
        "children": [{"text": "The file “iTunes Library.itl” cannot be read because it was created by a newer version of iTunes."}],
    }
    invalid = {
        "title": "iTunes",
        "children": [{"text": "The file “iTunes Library.itl” cannot be read because it does not appear to be a valid library file."}],
    }
    ambiguous = {
        "title": "iTunes",
        "children": [{"text": (
            "The file cannot be read because it was created by a newer version of iTunes; "
            "it also does not appear to be a valid library file."
        )}],
    }
    title_only = {"title": "iTunes", "children": [{"text": "iTunes Library.itl"}]}
    assert distinct.classify_library_modal(newer) == "newer_version"
    assert distinct.classify_library_modal(invalid) == "invalid_library"
    assert distinct.classify_library_modal(ambiguous) == "ambiguous_library_error"
    assert distinct.classify_library_modal(title_only) is None
    assert distinct.product_modal_matches(newer)
    assert not distinct.product_modal_matches(invalid)
