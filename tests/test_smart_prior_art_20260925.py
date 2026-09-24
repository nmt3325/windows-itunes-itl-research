from __future__ import annotations

import importlib.util
import json
from pathlib import Path
import sys

from itlkit.smart import parse_rules

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "audit_smart_prior_art_20260925.py"
EVIDENCE = ROOT / "evidence" / "research" / "20260925" / "smart-prior-art"
NATIVE = (
    ROOT
    / "evidence"
    / "native"
    / "smart-playlist-default-20260922-v24"
    / "native-created.itl"
)
CENSUS = ROOT / "evidence" / "smart-playlist" / "corpus-census.json"

spec = importlib.util.spec_from_file_location("audit_smart_prior_art_20260925", SCRIPT)
assert spec is not None and spec.loader is not None
audit = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = audit
spec.loader.exec_module(audit)


def _golden() -> bytes:
    return (EVIDENCE / "smart-playlist-io-golden-criteria.bin").read_bytes()


def _core_report() -> dict:
    return audit.build_core_audit(
        native_itl=NATIVE,
        census_path=CENSUS,
        golden_criteria_path=EVIDENCE / "smart-playlist-io-golden-criteria.bin",
        golden_info_path=EVIDENCE / "smart-playlist-io-golden-info.bin",
        minimal_criteria_path=EVIDENCE / "itunes-smartplaylist-minimal-criteria.bin",
        minimal_info_path=EVIDENCE / "itunes-smartplaylist-minimal-info.bin",
    )


def test_native_v24_uses_136_byte_slst_and_56_byte_group_wrapper() -> None:
    native = audit.extract_native_type101(NATIVE)
    payload = native.pop("_payload")
    tree = native["type101"]["tree"]

    assert len(payload) == 824
    assert native["type101"]["sha256"] == (
        "cd1fb6489e3ba11c1022512b0ecd99a7e3d45477fe6301f4de6d095b6f769862"
    )
    assert tree["children_offset"] == 136
    assert [rule["wrapper_offset"] for rule in tree["rules"]] == [136, 576]
    assert [rule["data_offset"] for rule in tree["rules"]] == [192, 632]
    assert all(rule["nested_slst_relative_offset"] == 56 for rule in tree["rules"])
    assert native["type101"]["magic_offsets"] == [0, 192, 632]


def test_music_xml_uses_139_root_and_53_byte_nested_slst_prefix() -> None:
    tree = audit.parse_music_criteria(_golden())
    first, second = tree["children"]

    assert tree["children_offset"] == 139
    assert [first["offset"], second["offset"]] == [139, 579]
    assert first["embedded_slst_offset"] - first["offset"] == 53
    assert first["children_offset"] - first["offset"] == 192
    assert first["embedded_slst_offset"] == 192
    assert second["embedded_slst_offset"] == 632


def test_same_192_total_does_not_erase_component_boundary_mismatch() -> None:
    golden = _golden()
    music = audit.parse_music_criteria(golden)
    windows = parse_rules(golden)

    assert windows.to_bytes() == golden
    assert windows.rules[0].offset == 136
    assert windows.rules[0].nested is not None
    assert windows.rules[0].offset + 56 == 192
    assert music["children"][0]["offset"] == 139
    assert music["children"][0]["offset"] + 53 == 192
    assert (136, 56) != (139, 53)


def test_579_byte_boilerplate_has_mixed_skip_base_not_uniform_139() -> None:
    golden = _golden()
    tree = audit.parse_music_criteria(golden)
    fixed_media, generated_user = tree["children"]

    assert generated_user["offset"] == audit.SMART_PLAYLIST_IO_BOILERPLATE_SIZE
    assert fixed_media["parsed_end_offset"] == 579
    assert fixed_media["children_bytes"] == 248
    assert fixed_media["skip_length_u16be"] == 384
    assert fixed_media["observed_skip_base"] == 136
    assert fixed_media["declared_target_minus_parsed_end"] == 0
    assert generated_user["observed_skip_base"] == 139
    assert generated_user["declared_target_minus_parsed_end"] == 3


def test_native_and_golden_share_exact_630_byte_prefix_but_then_diverge() -> None:
    native = audit.extract_native_type101(NATIVE).pop("_payload")
    golden = _golden()
    result = audit.compare_bytes(native, golden)

    assert native[:579] == golden[:579]
    assert result["common_prefix_bytes"] == 630
    assert result["first_difference_offset"] == 630
    assert result["difference_count_in_overlap"] == 7
    assert result["first_differences"][:2] == [
        {"offset": 630, "left_hex": "00", "right_hex": "03"},
        {"offset": 631, "left_hex": "c0", "right_hex": "3f"},
    ]


def test_one_byte_music_field_overlays_low_byte_of_windows_u32be_field() -> None:
    golden = _golden()
    music = audit.parse_music_criteria(golden)
    windows = audit._describe_windows_ruleset(parse_rules(golden))

    windows_media = windows["rules"][0]["nested"]["rules"][0]
    music_media = music["children"][0]["children"][0]
    assert windows_media["wrapper_offset"] == 328
    assert music_media["offset"] == 331
    assert golden[328:332] == b"\x00\x00\x00\x3c"
    assert golden[331] == 0x3C
    assert windows_media["field_width_bytes"] == 4
    assert music_media["field_width_bytes"] == 1


def test_music_utf16le_and_windows_overlay_utf16be_are_one_byte_phased() -> None:
    golden = _golden()
    music = audit.parse_music_criteria(golden)
    windows = audit._describe_windows_ruleset(parse_rules(golden))
    witness = audit._string_overlap_witness(golden, windows, music)

    assert witness["windows_view"]["data_offset"] == 948
    assert witness["windows_view"]["data_hex"] == "0052006f0063006b"
    assert witness["windows_view"]["decoded"] == "Rock"
    assert witness["music_xml_view"]["data_offset"] == 949
    assert witness["music_xml_view"]["data_hex"] == "52006f0063006b00"
    assert witness["music_xml_view"]["decoded"] == "Rock"
    assert witness["rule_offset_delta_music_minus_windows"] == 3
    assert witness["data_offset_delta_music_minus_windows"] == 1

    native = audit.extract_native_type101(NATIVE)
    native.pop("_payload")
    candidates = [
        rule
        for rule in audit.flatten_windows_rules(native["type101"]["tree"])
        if "string_candidate" in rule
    ]
    assert len(candidates) == 1
    assert candidates[0]["string_candidate"]["byte_length"] == 0


def test_cross_format_field_names_are_not_promoted_to_native_semantics() -> None:
    census = json.loads(CENSUS.read_text(encoding="utf-8"))
    assert audit.CROSS_FORMAT_FIELD_NAMES == {
        0x9A: "Love",
        0x86: "iCloudStatus",
        0x85: "Location",
        0x3C: "MediaKind",
    }
    assert census["summary"]["observed_field_ids"] == [
        "0x0000003C",
        "0x00000085",
        "0x000000A4",
    ]
    assert "0x0000009A" not in census["summary"]["observed_field_ids"]
    assert "0x00000086" not in census["summary"]["observed_field_ids"]


def test_retained_prior_art_snapshots_include_verified_mit_notices() -> None:
    manifest = json.loads((EVIDENCE / "source-manifest.json").read_text(encoding="utf-8"))
    policy = manifest["license_policy"]
    notices_path = EVIDENCE / "THIRD_PARTY_NOTICES.md"
    notices = notices_path.read_text(encoding="utf-8")

    assert policy["spdx"] == "MIT"
    assert policy["third_party_notices"]["sha256"] == audit.sha256_file(notices_path)
    assert {entry["snapshot"] for entry in policy["snapshot_origins"]} == {
        path.name for path in EVIDENCE.glob("*.bin")
    }
    assert "Copyright (c) 2026 kynoptic" in notices
    assert "Copyright (c) cuzi 2018" in notices
    assert "banshee-itunes-import-plugin" in notices

    repositories = {entry["name"]: entry for entry in manifest["repositories"]}
    assert repositories["smart-playlist-io"]["license"] == {
        "spdx": "MIT",
        "path": "LICENSE",
        "notice_path": "NOTICE",
    }
    assert repositories["itunes_smartplaylist"]["license"] == {
        "spdx": "MIT",
        "path": "LICENSE",
    }
    verified_paths = {
        name: {item["path"] for item in entry["files"]}
        for name, entry in repositories.items()
    }
    assert {"LICENSE", "NOTICE"} <= verified_paths["smart-playlist-io"]
    assert "LICENSE" in verified_paths["itunes_smartplaylist"]


def test_generated_report_is_deterministic_and_matches_committed_audit() -> None:
    first = _core_report()
    second = _core_report()
    assert first == second

    committed = json.loads((EVIDENCE / "audit.json").read_text(encoding="utf-8"))
    committed_without_manifest_hash = dict(committed)
    committed_without_manifest_hash.pop("source_manifest_sha256")
    assert first == committed_without_manifest_hash
    assert committed["scope"]["windows_writes_performed"] is False
    assert committed["unresolved_boundaries"]
    assert committed["next_native_experiments"]
