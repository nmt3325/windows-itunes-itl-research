"""Lossless, evidence-labelled Windows smart-playlist inspection.

Windows iTunes 12.13.10.3 stores smart rules in ``mhoh`` type 101 and a
112-byte preference candidate in type 102.  The type-101 ``SLst`` framing and
big-endian leaf layout are native-corpus observations.  Most field/operator
*meanings*, string/date/range encodings, and recursive groups are only
cross-format prior art from historical iPod iTunesDB implementations.  This
module therefore parses and validates without evaluating or silently repairing
rules, and it always retains every opaque byte.
"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Any, Literal

from .errors import FormatError

SLST_MAGIC = b"SLst"
SLST_HEADER_SIZE = 136
RULE_HEADER_SIZE = 56
NUMERIC_DATA_SIZE = 68
DATE_IDENTIFIER = 0x2DAE2DAE2DAE2DAE
GROUP_MARKER_PRIOR_ART = 0x01000000
MAX_RULES = 4096
MAX_DEPTH = 16
MAX_DATA_LENGTH = 16 * 1024 * 1024
MAX_PAYLOAD_LENGTH = 64 * 1024 * 1024

EVIDENCE_NATIVE = "native-corpus-observed"
EVIDENCE_PRIOR_ART = "cross-format-prior-art"
EVIDENCE_HYPOTHESIS = "hypothesis"

# Names are intentionally labelled prior-art.  Their numeric identities are
# useful when inspecting Windows payloads, but the names were not established
# by controlled Windows smart-playlist differentials in this repository.
FIELD_NAMES_PRIOR_ART = {
    0x02: "title",
    0x03: "album",
    0x04: "artist",
    0x05: "bit_rate",
    0x06: "sample_rate",
    0x07: "year",
    0x08: "genre",
    0x09: "kind",
    0x0A: "date_modified",
    0x0B: "track_number",
    0x0C: "size",
    0x0D: "duration",
    0x0E: "comment",
    0x10: "date_added",
    0x12: "composer",
    0x16: "play_count",
    0x17: "last_played",
    0x18: "disc_number",
    0x19: "rating",
    0x1F: "compilation",
    0x23: "bpm",
    0x27: "grouping",
    0x28: "playlist_membership",
    0x29: "purchase",
    0x36: "description",
    0x37: "category",
    0x39: "podcast",
    0x3C: "media_or_video_kind",
    0x3E: "tv_show",
    0x3F: "season_number",
    0x44: "skip_count",
    0x45: "last_skipped",
    0x47: "album_artist",
    0x4E: "sort_title",
    0x4F: "sort_album",
    0x50: "sort_artist",
    0x51: "sort_album_artist",
    0x52: "sort_composer",
    0x53: "sort_tv_show",
    0x5A: "album_rating",
}

ACTION_NAMES_PRIOR_ART = {
    0x00000001: "is_integer",
    0x00000010: "greater_than",
    0x00000040: "less_than",
    0x00000100: "in_range",
    0x00000200: "in_last",
    0x00000400: "binary_and",
    0x00000800: "binary_unknown_1",
    0x01000001: "is_string",
    0x01000002: "contains",
    0x01000004: "starts_with",
    0x01000008: "ends_with",
    0x02000001: "is_not_integer",
    0x02000010: "not_greater_than",
    0x02000040: "not_less_than",
    0x02000100: "not_in_range",
    0x02000200: "not_in_last",
    0x02000400: "not_binary_and",
    0x02000800: "binary_unknown_2",
    0x03000001: "is_not_string",
    0x03000002: "does_not_contain",
    0x03000004: "does_not_start_with",
    0x03000008: "does_not_end_with",
}

LIMIT_UNIT_NAMES_PRIOR_ART = {
    1: "minutes",
    2: "megabytes",
    3: "items",
    4: "hours",
    5: "gigabytes",
}

SELECTION_ORDER_NAMES_PRIOR_ART = {
    0x02: "random",
    0x03: "title",
    0x04: "album",
    0x05: "artist",
    0x07: "genre",
    0x10: "most_recently_added",
    0x14: "most_often_played",
    0x15: "most_recently_played",
    0x17: "highest_rating",
}


@dataclass(frozen=True)
class ValidationIssue:
    severity: Literal["error", "warning", "info"]
    code: str
    message: str
    offset: int | None = None
    evidence: str | None = None

    def to_dict(self) -> dict[str, Any]:
        value: dict[str, Any] = {
            "severity": self.severity,
            "code": self.code,
            "message": self.message,
        }
        if self.offset is not None:
            value["offset"] = self.offset
        if self.evidence is not None:
            value["evidence"] = self.evidence
        return value


@dataclass(frozen=True)
class NumericValue:
    """The fixed 68-byte non-string value candidate, retained verbatim."""

    raw: bytes
    from_value: int
    from_date: int
    from_units: int
    to_value: int
    to_date: int
    to_units: int
    trailing_u32: tuple[int, int, int, int, int]

    @classmethod
    def parse(cls, data: bytes) -> NumericValue:
        data = bytes(data)
        if len(data) != NUMERIC_DATA_SIZE:
            raise FormatError(f"numeric value must be {NUMERIC_DATA_SIZE} bytes")
        return cls(
            data,
            int.from_bytes(data[0:8], "big"),
            int.from_bytes(data[8:16], "big", signed=True),
            int.from_bytes(data[16:24], "big"),
            int.from_bytes(data[24:32], "big"),
            int.from_bytes(data[32:40], "big", signed=True),
            int.from_bytes(data[40:48], "big"),
            tuple(int.from_bytes(data[o:o + 4], "big") for o in range(48, 68, 4)),
        )

    def to_bytes(self) -> bytes:
        return self.raw

    def to_dict(self) -> dict[str, Any]:
        return {
            "encoding": "six-big-endian-64-bit-values-plus-five-u32",
            "evidence": EVIDENCE_NATIVE,
            "from_value": self.from_value,
            "from_value_hex": f"0x{self.from_value:016X}",
            "from_date_signed": self.from_date,
            "from_units": self.from_units,
            "to_value": self.to_value,
            "to_value_hex": f"0x{self.to_value:016X}",
            "to_date_signed": self.to_date,
            "to_units": self.to_units,
            "trailing_u32": list(self.trailing_u32),
            "raw_hex": self.raw.hex(),
        }


@dataclass(frozen=True)
class SmartRule:
    field_id: int
    action_id: int
    opaque_header: bytes
    data: bytes
    offset: int
    nested: SmartRuleSet | None = None
    nested_error: str | None = None

    @property
    def marker(self) -> int:
        return int.from_bytes(self.opaque_header[:4], "big")

    @property
    def field_name_prior_art(self) -> str | None:
        return FIELD_NAMES_PRIOR_ART.get(self.field_id)

    @property
    def action_name_prior_art(self) -> str | None:
        return ACTION_NAMES_PRIOR_ART.get(self.action_id)

    @property
    def negated_candidate(self) -> bool:
        return bool(self.action_id & 0x02000000)

    @property
    def string_candidate(self) -> bool:
        return bool(self.action_id & 0x01000000)

    @property
    def numeric_value(self) -> NumericValue | None:
        return NumericValue.parse(self.data) if len(self.data) == NUMERIC_DATA_SIZE else None

    @property
    def string_value(self) -> str | None:
        if not self.string_candidate or len(self.data) % 2:
            return None
        try:
            return self.data.decode("utf-16-be", errors="strict")
        except UnicodeDecodeError:
            return None

    def to_bytes(self) -> bytes:
        if len(self.opaque_header) != 44:
            raise FormatError("smart-rule opaque header must be 44 bytes", self.offset + 8)
        if not 0 <= self.field_id < 2**32 or not 0 <= self.action_id < 2**32:
            raise ValueError("smart-rule IDs must be uint32 values")
        if len(self.data) >= 2**32:
            raise ValueError("smart-rule data exceeds uint32 length")
        return (
            self.field_id.to_bytes(4, "big")
            + self.action_id.to_bytes(4, "big")
            + self.opaque_header
            + len(self.data).to_bytes(4, "big")
            + self.data
        )

    def to_dict(self) -> dict[str, Any]:
        value: dict[str, Any] = {
            "offset": self.offset,
            "field_id": self.field_id,
            "field_id_hex": f"0x{self.field_id:08X}",
            "field_name_prior_art": self.field_name_prior_art,
            "field_name_evidence": EVIDENCE_PRIOR_ART if self.field_name_prior_art else None,
            "action_id": self.action_id,
            "action_id_hex": f"0x{self.action_id:08X}",
            "action_name_prior_art": self.action_name_prior_art,
            "action_name_evidence": EVIDENCE_PRIOR_ART if self.action_name_prior_art else None,
            "negated_candidate": self.negated_candidate,
            "string_candidate": self.string_candidate,
            "candidate_bit_interpretation_evidence": EVIDENCE_PRIOR_ART,
            "marker": self.marker,
            "marker_hex": f"0x{self.marker:08X}",
            "opaque_header_hex": self.opaque_header.hex(),
            "data_length": len(self.data),
            "raw_data_hex": self.data.hex(),
        }
        numeric = self.numeric_value
        if numeric is not None:
            value["numeric_value"] = numeric.to_dict()
        string = self.string_value
        if string is not None:
            value["string_value_candidate"] = string
            value["string_encoding_evidence"] = EVIDENCE_PRIOR_ART
        if self.nested is not None:
            value["nested_group_candidate"] = self.nested.to_dict()
            value["nested_group_evidence"] = EVIDENCE_PRIOR_ART
        if self.nested_error is not None:
            value["nested_group_error"] = self.nested_error
        return value


@dataclass(frozen=True)
class SmartRuleSet:
    version_word: int
    conjunction: int
    opaque_header: bytes
    rules: tuple[SmartRule, ...]
    trailing: bytes = b""
    depth: int = 0

    @property
    def conjunction_name_prior_art(self) -> str | None:
        return {0: "AND", 1: "OR"}.get(self.conjunction)

    def to_bytes(self) -> bytes:
        if len(self.opaque_header) != 120:
            raise FormatError("SLst opaque header must be 120 bytes", 16)
        return (
            SLST_MAGIC
            + self.version_word.to_bytes(4, "big")
            + len(self.rules).to_bytes(4, "big")
            + self.conjunction.to_bytes(4, "big")
            + self.opaque_header
            + b"".join(rule.to_bytes() for rule in self.rules)
            + self.trailing
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "magic": "SLst",
            "header_size": SLST_HEADER_SIZE,
            "version_word": self.version_word,
            "version_word_hex": f"0x{self.version_word:08X}",
            "rule_count": len(self.rules),
            "conjunction_raw": self.conjunction,
            "conjunction_name_prior_art": self.conjunction_name_prior_art,
            "conjunction_semantics_evidence": EVIDENCE_PRIOR_ART,
            "opaque_header_hex": self.opaque_header.hex(),
            "rules": [rule.to_dict() for rule in self.rules],
            "trailing_hex": self.trailing.hex(),
            "depth": self.depth,
        }


@dataclass(frozen=True)
class SmartPreferences:
    """Structural view of a Windows type-102 payload.

    The offsets are native-corpus observations.  Candidate names are reported
    separately and remain cross-format analogies because the Windows body is
    112 bytes and differs from the historical 72-byte iPod body.
    """

    raw: bytes
    byte_00: int
    byte_01: int
    byte_02: int
    byte_03: int
    u32be_04: int
    u32be_08: int
    u32be_0c: int
    u32be_10: int
    tail: bytes

    def to_bytes(self) -> bytes:
        return self.raw

    def to_dict(self) -> dict[str, Any]:
        return {
            "length": len(self.raw),
            "raw_hex": self.raw.hex(),
            "observed_fields": {
                "byte_00": self.byte_00,
                "byte_01": self.byte_01,
                "byte_02": self.byte_02,
                "byte_03": self.byte_03,
                "u32be_04": self.u32be_04,
                "u32be_08": self.u32be_08,
                "u32be_0c": self.u32be_0c,
                "u32be_10": self.u32be_10,
                "tail_hex": self.tail.hex(),
                "evidence": EVIDENCE_NATIVE,
            },
            "candidate_interpretation": {
                "live_update": bool(self.byte_00),
                "match_rules": bool(self.byte_01),
                "limit_enabled": bool(self.byte_02),
                "limit_unit_code": self.byte_03,
                "limit_unit_name": LIMIT_UNIT_NAMES_PRIOR_ART.get(self.byte_03),
                "selection_order_code": self.u32be_04,
                "selection_order_name": SELECTION_ORDER_NAMES_PRIOR_ART.get(self.u32be_04),
                "limit_value": self.u32be_08,
                "evidence": EVIDENCE_PRIOR_ART,
                "warning": "candidate meanings are not controlled Windows differentials",
            },
        }


@dataclass(frozen=True)
class SmartPlaylistDefinition:
    rules: SmartRuleSet | None
    preferences: SmartPreferences | None
    ancillary_type_103: tuple[bytes, ...]
    issues: tuple[ValidationIssue, ...]

    def to_dict(self) -> dict[str, Any]:
        return {
            "rules": self.rules.to_dict() if self.rules is not None else None,
            "preferences": self.preferences.to_dict() if self.preferences is not None else None,
            "ancillary_type_103_hex": [value.hex() for value in self.ancillary_type_103],
            "issues": [issue.to_dict() for issue in self.issues],
        }


def _require_bytes(value: bytes | bytearray | memoryview, label: str) -> bytes:
    if not isinstance(value, (bytes, bytearray, memoryview)):
        raise TypeError(f"{label} must be bytes-like")
    return bytes(value)


def parse_rules(
    payload: bytes | bytearray | memoryview,
    *,
    max_rules: int = MAX_RULES,
    max_depth: int = MAX_DEPTH,
    max_data_length: int = MAX_DATA_LENGTH,
    _depth: int = 0,
) -> SmartRuleSet:
    """Parse one root or nested ``SLst`` without interpreting unknown bytes."""
    data = _require_bytes(payload, "smart-rule payload")
    if len(data) > MAX_PAYLOAD_LENGTH:
        raise FormatError("SLst payload exceeds parser limit")
    if len(data) < SLST_HEADER_SIZE:
        raise FormatError("truncated SLst header", 0)
    if data[:4] != SLST_MAGIC:
        raise FormatError("missing SLst magic", 0)
    if type(max_rules) is not int or max_rules < 0:
        raise ValueError("max_rules must be a non-negative integer")
    if type(max_depth) is not int or max_depth < 0:
        raise ValueError("max_depth must be a non-negative integer")
    if type(max_data_length) is not int or max_data_length < 0:
        raise ValueError("max_data_length must be a non-negative integer")
    count = int.from_bytes(data[8:12], "big")
    if count > max_rules:
        raise FormatError(f"SLst rule count {count} exceeds limit {max_rules}", 8)
    version_word = int.from_bytes(data[4:8], "big")
    conjunction = int.from_bytes(data[12:16], "big")
    opaque_header = data[16:SLST_HEADER_SIZE]
    rules: list[SmartRule] = []
    pos = SLST_HEADER_SIZE
    for index in range(count):
        if pos + RULE_HEADER_SIZE > len(data):
            raise FormatError(f"truncated smart rule {index} header", pos)
        field_id = int.from_bytes(data[pos:pos + 4], "big")
        action_id = int.from_bytes(data[pos + 4:pos + 8], "big")
        opaque = data[pos + 8:pos + 52]
        length = int.from_bytes(data[pos + 52:pos + 56], "big")
        if length > max_data_length:
            raise FormatError(
                f"smart rule {index} data length {length} exceeds limit {max_data_length}",
                pos + 52,
            )
        end = pos + RULE_HEADER_SIZE + length
        if end > len(data):
            raise FormatError(f"truncated smart rule {index} data", pos + RULE_HEADER_SIZE)
        rule_data = data[pos + RULE_HEADER_SIZE:end]
        nested = None
        nested_error = None
        full_group_discriminator = (
            field_id == 0
            and action_id == 1
            and int.from_bytes(opaque[:4], "big") == GROUP_MARKER_PRIOR_ART
            and rule_data.startswith(SLST_MAGIC)
        )
        if full_group_discriminator:
            if _depth >= max_depth:
                nested_error = f"nested SLst exceeds depth limit {max_depth}"
            else:
                try:
                    nested = parse_rules(
                        rule_data,
                        max_rules=max_rules,
                        max_depth=max_depth,
                        max_data_length=max_data_length,
                        _depth=_depth + 1,
                    )
                except FormatError as exc:
                    # A historical group-shaped wrapper is not Windows-native
                    # proof.  Preserve malformed/unknown data rather than
                    # discarding the outer ruleset.
                    nested_error = str(exc)
        rules.append(SmartRule(field_id, action_id, opaque, rule_data, pos, nested, nested_error))
        pos = end
    return SmartRuleSet(version_word, conjunction, opaque_header, tuple(rules), data[pos:], _depth)


def parse_preferences(payload: bytes | bytearray | memoryview) -> SmartPreferences:
    data = _require_bytes(payload, "smart-preference payload")
    if len(data) < 20:
        raise FormatError("truncated type-102 preference candidate", 0)
    return SmartPreferences(
        data,
        data[0],
        data[1],
        data[2],
        data[3],
        int.from_bytes(data[4:8], "big"),
        int.from_bytes(data[8:12], "big"),
        int.from_bytes(data[12:16], "big"),
        int.from_bytes(data[16:20], "big"),
        data[20:],
    )


def _validate_rule_set(rules: SmartRuleSet, issues: list[ValidationIssue], base: int = 0) -> None:
    if rules.version_word != 0x00010001:
        issues.append(ValidationIssue(
            "warning", "unexpected_version_word",
            f"SLst +0x04 is 0x{rules.version_word:08X}; native corpus observed 0x00010001",
            base + 4, EVIDENCE_NATIVE,
        ))
    if rules.conjunction not in (0, 1):
        issues.append(ValidationIssue(
            "warning", "unknown_conjunction",
            f"unrecognised conjunction value {rules.conjunction}; preserved verbatim",
            base + 12, EVIDENCE_PRIOR_ART,
        ))
    if any(rules.opaque_header):
        issues.append(ValidationIssue(
            "info", "nonzero_slst_opaque_header",
            "SLst +0x10..+0x87 contains nonzero opaque bytes",
            base + 16, EVIDENCE_NATIVE,
        ))
    for index, rule in enumerate(rules.rules):
        offset = base + rule.offset
        if rule.field_name_prior_art is None:
            issues.append(ValidationIssue(
                "info", "unknown_field_id",
                f"rule {index} field 0x{rule.field_id:08X} has no prior-art name; preserved",
                offset, EVIDENCE_PRIOR_ART,
            ))
        if rule.action_name_prior_art is None:
            issues.append(ValidationIssue(
                "warning", "unknown_action_id",
                f"rule {index} action 0x{rule.action_id:08X} is unknown; preserved",
                offset + 4, EVIDENCE_PRIOR_ART,
            ))
        if rule.nested_error is not None:
            issues.append(ValidationIssue(
                "error", "invalid_nested_group_candidate",
                f"rule {index} group-shaped payload was not parsed: {rule.nested_error}",
                offset + RULE_HEADER_SIZE, EVIDENCE_PRIOR_ART,
            ))
        if rule.nested is not None:
            _validate_rule_set(rule.nested, issues, offset + RULE_HEADER_SIZE)
            continue
        if rule.string_candidate:
            if len(rule.data) % 2:
                issues.append(ValidationIssue(
                    "error", "odd_utf16be_length",
                    f"rule {index} string-candidate payload has odd length {len(rule.data)}",
                    offset + RULE_HEADER_SIZE, EVIDENCE_PRIOR_ART,
                ))
            elif rule.string_value is None:
                issues.append(ValidationIssue(
                    "warning", "invalid_utf16be_candidate",
                    f"rule {index} string-candidate payload is not strict UTF-16BE",
                    offset + RULE_HEADER_SIZE, EVIDENCE_PRIOR_ART,
                ))
        elif rule.action_name_prior_art is not None and len(rule.data) != NUMERIC_DATA_SIZE:
            issues.append(ValidationIssue(
                "warning", "unexpected_nonstring_length",
                f"rule {index} known non-string prior-art action has {len(rule.data)} bytes, not 68",
                offset + 52, EVIDENCE_PRIOR_ART,
            ))
        if any(rule.opaque_header):
            group_prefix = rule.opaque_header[:4]
            group_tail = rule.opaque_header[4:]
            if rule.nested is None or group_prefix != GROUP_MARKER_PRIOR_ART.to_bytes(4, "big") or any(group_tail):
                issues.append(ValidationIssue(
                    "info", "nonzero_rule_opaque_header",
                    f"rule {index} +0x08..+0x33 contains nonzero opaque bytes",
                    offset + 8, EVIDENCE_NATIVE,
                ))
    if rules.trailing:
        issues.append(ValidationIssue(
            "warning", "trailing_slst_bytes",
            f"{len(rules.trailing)} byte(s) follow the declared rules",
            base + len(rules.to_bytes()) - len(rules.trailing), EVIDENCE_NATIVE,
        ))


def validate_rules(payload: bytes | bytearray | memoryview | SmartRuleSet) -> list[ValidationIssue]:
    issues: list[ValidationIssue] = []
    if isinstance(payload, SmartRuleSet):
        rules = payload
    else:
        try:
            rules = parse_rules(payload)
        except (FormatError, TypeError, ValueError) as exc:
            offset = exc.offset if isinstance(exc, FormatError) else None
            return [ValidationIssue("error", "invalid_slst", str(exc), offset, EVIDENCE_NATIVE)]
    _validate_rule_set(rules, issues)
    return issues


def validate_preferences(payload: bytes | bytearray | memoryview | SmartPreferences) -> list[ValidationIssue]:
    if isinstance(payload, SmartPreferences):
        prefs = payload
    else:
        try:
            prefs = parse_preferences(payload)
        except (FormatError, TypeError) as exc:
            offset = exc.offset if isinstance(exc, FormatError) else None
            return [ValidationIssue("error", "invalid_preferences", str(exc), offset, EVIDENCE_NATIVE)]
    issues: list[ValidationIssue] = []
    if len(prefs.raw) != 112:
        issues.append(ValidationIssue(
            "warning", "unexpected_preferences_length",
            f"type-102 payload has {len(prefs.raw)} bytes; native corpus observed 112",
            0, EVIDENCE_NATIVE,
        ))
    for offset, value in enumerate((prefs.byte_00, prefs.byte_01, prefs.byte_02)):
        if value not in (0, 1):
            issues.append(ValidationIssue(
                "info", "non_boolean_candidate_flag",
                f"type-102 byte +0x{offset:02X} is {value}, not 0/1; preserved",
                offset, EVIDENCE_PRIOR_ART,
            ))
    if prefs.u32be_10 != 7:
        issues.append(ValidationIssue(
            "info", "unseen_u32be_10",
            f"type-102 +0x10 is 0x{prefs.u32be_10:08X}; native corpus observed 7",
            16, EVIDENCE_NATIVE,
        ))
    if any(prefs.tail):
        issues.append(ValidationIssue(
            "info", "nonzero_preferences_tail",
            "type-102 bytes after +0x13 contain nonzero opaque data",
            20, EVIDENCE_NATIVE,
        ))
    return issues


def parse_playlist_smart(node: Any) -> SmartPlaylistDefinition | None:
    """Parse type-101/102 children of an ``miph``-like Node.

    The argument is duck-typed to avoid a circular import.  Duplicate records
    and malformed payloads become explicit issues rather than being selected
    silently.
    """
    children = getattr(node, "children", None)
    if children is None:
        return None
    rules_nodes = [c for c in children if getattr(c, "tag", None) == b"mhoh" and getattr(c, "type_code", None) == 101]
    pref_nodes = [c for c in children if getattr(c, "tag", None) == b"mhoh" and getattr(c, "type_code", None) == 102]
    type103 = tuple(bytes(c.payload) for c in children if getattr(c, "tag", None) == b"mhoh" and getattr(c, "type_code", None) == 103)
    if not rules_nodes and not pref_nodes:
        return None
    issues: list[ValidationIssue] = []
    if len(rules_nodes) != 1:
        issues.append(ValidationIssue(
            "error" if len(rules_nodes) > 1 else "warning",
            "smart_rule_record_count",
            f"playlist contains {len(rules_nodes)} type-101 record(s)",
            evidence=EVIDENCE_NATIVE,
        ))
    if len(pref_nodes) != 1:
        issues.append(ValidationIssue(
            "error" if len(pref_nodes) > 1 else "warning",
            "smart_preference_record_count",
            f"playlist contains {len(pref_nodes)} type-102 record(s)",
            evidence=EVIDENCE_NATIVE,
        ))
    rules = None
    preferences = None
    if len(rules_nodes) == 1:
        try:
            rules = parse_rules(rules_nodes[0].payload)
            issues.extend(validate_rules(rules))
        except FormatError as exc:
            issues.append(ValidationIssue("error", "invalid_slst", str(exc), exc.offset, EVIDENCE_NATIVE))
    if len(pref_nodes) == 1:
        try:
            preferences = parse_preferences(pref_nodes[0].payload)
            issues.extend(validate_preferences(preferences))
        except FormatError as exc:
            issues.append(ValidationIssue("error", "invalid_preferences", str(exc), exc.offset, EVIDENCE_NATIVE))
    return SmartPlaylistDefinition(rules, preferences, type103, tuple(issues))


def dump_rules(payload: bytes | bytearray | memoryview | SmartRuleSet) -> dict[str, Any]:
    rules = payload if isinstance(payload, SmartRuleSet) else parse_rules(payload)
    value = rules.to_dict()
    value["validation_issues"] = [issue.to_dict() for issue in validate_rules(rules)]
    return value


def dump_preferences(payload: bytes | bytearray | memoryview | SmartPreferences) -> dict[str, Any]:
    prefs = payload if isinstance(payload, SmartPreferences) else parse_preferences(payload)
    value = prefs.to_dict()
    value["validation_issues"] = [issue.to_dict() for issue in validate_preferences(prefs)]
    return value


__all__ = [
    "SLST_MAGIC", "SLST_HEADER_SIZE", "RULE_HEADER_SIZE", "NUMERIC_DATA_SIZE",
    "DATE_IDENTIFIER", "GROUP_MARKER_PRIOR_ART", "FIELD_NAMES_PRIOR_ART",
    "ACTION_NAMES_PRIOR_ART", "ValidationIssue", "NumericValue", "SmartRule",
    "SmartRuleSet", "SmartPreferences", "SmartPlaylistDefinition",
    "parse_rules", "parse_preferences", "parse_playlist_smart",
    "validate_rules", "validate_preferences", "dump_rules", "dump_preferences",
]
