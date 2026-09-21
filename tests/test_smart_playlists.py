from __future__ import annotations

import struct
from pathlib import Path

import pytest

from itlkit import FormatError, Library
from itlkit.smart import (
    DATE_IDENTIFIER,
    GROUP_MARKER_PRIOR_ART,
    NumericValue,
    dump_rules,
    parse_preferences,
    parse_rules,
    validate_preferences,
    validate_rules,
)

ROOT = Path(__file__).resolve().parents[1]
EMPTY = ROOT / "evidence" / "native" / "snapshots" / "000-empty.itl"


def _numeric(
    from_value: int = 0,
    from_date: int = 0,
    from_units: int = 1,
    to_value: int = 0,
    to_date: int = 0,
    to_units: int = 1,
    trailing: tuple[int, int, int, int, int] = (0, 0, 0, 0, 0),
) -> bytes:
    return struct.pack(
        ">QqQQqQIIIII",
        from_value,
        from_date,
        from_units,
        to_value,
        to_date,
        to_units,
        *trailing,
    )


def _rule(field: int, action: int, data: bytes, opaque: bytes = bytes(44)) -> bytes:
    assert len(opaque) == 44
    return struct.pack(">II", field, action) + opaque + struct.pack(">I", len(data)) + data


def _slst(
    *rules: bytes,
    conjunction: int = 0,
    version: int = 0x00010001,
    opaque: bytes = bytes(120),
    trailing: bytes = b"",
) -> bytes:
    assert len(opaque) == 120
    return (
        b"SLst"
        + struct.pack(">III", version, len(rules), conjunction)
        + opaque
        + b"".join(rules)
        + trailing
    )


def _group(nested: bytes, *, field: int = 0, action: int = 1,
           marker: int = GROUP_MARKER_PRIOR_ART, tail: bytes = bytes(40)) -> bytes:
    assert len(tail) == 40
    return _rule(field, action, nested, marker.to_bytes(4, "big") + tail)


def _child(playlist, type_code: int):
    matches = [c for c in playlist.node.children or ()
               if c.tag == b"mhoh" and c.type_code == type_code]
    assert len(matches) == 1
    return matches[0]


def test_native_corpus_rules_and_preferences_are_lossless() -> None:
    library = Library.read(EMPTY)
    smart = [playlist for playlist in library.playlists if playlist.smart_definition]

    assert len(smart) == 12
    for playlist in smart:
        definition = playlist.smart_definition
        assert definition is not None
        assert definition.rules is not None
        assert definition.preferences is not None
        assert definition.rules.to_bytes() == _child(playlist, 101).payload
        assert definition.preferences.to_bytes() == _child(playlist, 102).payload
        assert not [issue for issue in definition.issues if issue.severity == "error"]

    music = next(playlist for playlist in smart if playlist.name == "Music")
    rules = music.smart_definition.rules
    assert rules.version_word == 0x00010001
    assert rules.conjunction == 0
    assert [rule.field_id for rule in rules.rules] == [0x3C, 0x3C]
    assert [rule.action_id for rule in rules.rules] == [0x00000400, 0x02000400]
    assert [rule.numeric_value.from_value for rule in rules.rules] == [1057201, 2129924]

    genius = next(playlist for playlist in smart if playlist.name == "Genius")
    assert genius.smart_definition.rules.conjunction == 1
    assert genius.smart_definition.rules.rules == ()


def test_and_or_strings_and_negation_are_explicitly_prior_art() -> None:
    root = _slst(
        _rule(0x04, 0x01000002, "Alpha".encode("utf-16-be")),
        _rule(0x08, 0x03000002, "Holiday".encode("utf-16-be")),
        conjunction=1,
    )

    parsed = parse_rules(root)
    assert parsed.to_bytes() == root
    assert parsed.conjunction_name_prior_art == "OR"
    assert parsed.rules[0].string_value == "Alpha"
    assert parsed.rules[0].action_name_prior_art == "contains"
    assert parsed.rules[1].string_value == "Holiday"
    assert parsed.rules[1].negated_candidate
    assert parsed.rules[1].action_name_prior_art == "does_not_contain"
    dumped = dump_rules(parsed)
    assert dumped["conjunction_semantics_evidence"] == "cross-format-prior-art"
    assert dumped["rules"][1]["candidate_bit_interpretation_evidence"] == "cross-format-prior-art"


def test_numeric_date_range_playlist_membership_and_media_kind_values() -> None:
    root = _slst(
        _rule(0x07, 0x00000001, _numeric(2024, to_value=2024)),
        _rule(0x10, 0x00000200, _numeric(
            DATE_IDENTIFIER, -2, 604800, DATE_IDENTIFIER, 0, 1,
        )),
        _rule(0x16, 0x00000100, _numeric(10, to_value=20)),
        _rule(0x28, 0x00000001, _numeric(0x0123456789ABCDEF,
                                                   to_value=0x0123456789ABCDEF)),
        _rule(0x3C, 0x00000400, _numeric(0x40, to_value=0x40)),
    )

    parsed = parse_rules(root)
    assert parsed.to_bytes() == root
    year, relative, range_rule, membership, media = parsed.rules
    assert year.numeric_value.from_value == 2024
    assert relative.numeric_value.from_value == DATE_IDENTIFIER
    assert relative.numeric_value.from_date == -2
    assert relative.numeric_value.from_units == 604800
    assert range_rule.action_name_prior_art == "in_range"
    assert (range_rule.numeric_value.from_value, range_rule.numeric_value.to_value) == (10, 20)
    assert membership.field_name_prior_art == "playlist_membership"
    assert membership.numeric_value.from_value == 0x0123456789ABCDEF
    assert media.field_name_prior_art == "media_or_video_kind"
    assert media.numeric_value.to_value == 0x40
    assert not [issue for issue in validate_rules(parsed) if issue.severity == "error"]


def test_numeric_value_preserves_signed_dates_and_unknown_tail() -> None:
    raw = _numeric(7, -9, 11, 13, -15, 17, (1, 2, 3, 4, 5))
    value = NumericValue.parse(raw)
    assert value.to_bytes() == raw
    assert value.from_date == -9
    assert value.to_date == -15
    assert value.trailing_u32 == (1, 2, 3, 4, 5)


def test_windows_type_102_offsets_and_candidate_labels() -> None:
    library = Library.read(EMPTY)
    music = next(playlist for playlist in library.playlists if playlist.name == "Music")
    raw = _child(music, 102).payload
    prefs = parse_preferences(raw)

    assert len(raw) == 112
    assert (prefs.byte_00, prefs.byte_01, prefs.byte_02, prefs.byte_03) == (1, 1, 0, 3)
    assert (prefs.u32be_04, prefs.u32be_08, prefs.u32be_0c, prefs.u32be_10) == (2, 25, 0, 7)
    assert prefs.to_bytes() == raw
    assert prefs.to_dict()["candidate_interpretation"] == {
        "live_update": True,
        "match_rules": True,
        "limit_enabled": False,
        "limit_unit_code": 3,
        "limit_unit_name": "items",
        "selection_order_code": 2,
        "selection_order_name": "random",
        "limit_value": 25,
        "evidence": "cross-format-prior-art",
        "warning": "candidate meanings are not controlled Windows differentials",
    }
    assert not validate_preferences(prefs)


def test_nested_group_candidate_requires_full_prior_art_discriminator() -> None:
    nested = _slst(_rule(0x02, 0x01000001, "x".encode("utf-16-be")), conjunction=1)
    exact = parse_rules(_slst(_group(nested)))
    assert exact.rules[0].nested is not None
    assert exact.rules[0].nested.conjunction == 1
    assert exact.to_bytes() == _slst(_group(nested))

    candidates = (
        _group(nested, field=7),
        _group(nested, action=9),
        _group(nested, marker=0),
    )
    assert all(parse_rules(_slst(candidate)).rules[0].nested is None
               for candidate in candidates)


def test_depth_limit_preserves_group_bytes_and_reports_error() -> None:
    nested = _slst(conjunction=1)
    raw = _slst(_group(nested))
    parsed = parse_rules(raw, max_depth=0)

    assert parsed.to_bytes() == raw
    assert parsed.rules[0].nested is None
    assert "depth limit" in parsed.rules[0].nested_error
    assert any(issue.code == "invalid_nested_group_candidate"
               and issue.severity == "error" for issue in validate_rules(parsed))


def test_unknown_operator_and_field_are_preserved_not_relabelled() -> None:
    raw = _slst(_rule(0xFEEDFACE, 0x04008000, b"\xAA\x55"))
    parsed = parse_rules(raw)

    assert parsed.to_bytes() == raw
    assert parsed.rules[0].field_name_prior_art is None
    assert parsed.rules[0].action_name_prior_art is None
    codes = {issue.code for issue in validate_rules(parsed)}
    assert {"unknown_field_id", "unknown_action_id"} <= codes


def test_trailing_and_opaque_bytes_are_lossless_and_flagged() -> None:
    raw = _slst(
        _rule(0x02, 0x01000001, "x".encode("utf-16-be"), b"\x01" + bytes(43)),
        opaque=b"\x02" + bytes(119),
        trailing=b"TAIL",
    )
    parsed = parse_rules(raw)

    assert parsed.to_bytes() == raw
    codes = {issue.code for issue in validate_rules(parsed)}
    assert "nonzero_slst_opaque_header" in codes
    assert "nonzero_rule_opaque_header" in codes
    assert "trailing_slst_bytes" in codes


@pytest.mark.parametrize("payload", [
    b"",
    b"SLst" + bytes(12),
    _slst()[:135],
])
def test_truncated_root_is_rejected(payload: bytes) -> None:
    with pytest.raises(FormatError):
        parse_rules(payload)
    assert validate_rules(payload)[0].code == "invalid_slst"


def test_rule_count_and_data_length_limits_are_bounded() -> None:
    excessive_count = b"SLst" + struct.pack(">III", 0x00010001, 5, 0) + bytes(120)
    with pytest.raises(FormatError, match="rule count"):
        parse_rules(excessive_count, max_rules=4)

    header = struct.pack(">II", 2, 1) + bytes(44) + struct.pack(">I", 100)
    truncated = _slst(header)
    with pytest.raises(FormatError, match="truncated smart rule"):
        parse_rules(truncated)

    bounded = _slst(_rule(2, 1, bytes(9)))
    with pytest.raises(FormatError, match="data length"):
        parse_rules(bounded, max_data_length=8)


def test_playlist_property_returns_none_for_master_and_ast_for_smart() -> None:
    library = Library.read(EMPTY)
    master = next(playlist for playlist in library.playlists if playlist.is_master)
    music = next(playlist for playlist in library.playlists if playlist.name == "Music")

    assert master.smart_definition is None
    assert music.smart_definition is not None
    assert music.smart_definition.rules.to_bytes() == _child(music, 101).payload
