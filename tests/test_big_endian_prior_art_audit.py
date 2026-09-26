from __future__ import annotations

import importlib.util
import json
import os
from pathlib import Path

import pytest


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/audit_big_endian_prior_art_20260925.py"
SPEC = importlib.util.spec_from_file_location("big_endian_prior_art_audit", SCRIPT)
assert SPEC is not None and SPEC.loader is not None
audit = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(audit)


def _tag(tag: str, order: str) -> bytes:
    raw = tag.encode("ascii")
    return raw if order == "big" else raw[::-1]


def _put_u32(buffer: bytearray, offset: int, value: int, order: str) -> None:
    buffer[offset : offset + 4] = value.to_bytes(4, order)


def _fixed_record(
    tag: str,
    size: int,
    order: str,
    fields: dict[int, int] | None = None,
) -> bytes:
    value = bytearray(size)
    value[:4] = _tag(tag, order)
    _put_u32(value, 4, size, order)
    for offset, field_value in (fields or {}).items():
        _put_u32(value, offset, field_value, order)
    return bytes(value)


def _section(section_type: int, order: str) -> bytes:
    return _fixed_record("hdsm", 16, order, {12: section_type})


def _generic_hohm(
    order: str,
    *,
    data: bytes = b"Hi",
    declared_data_length: int | None = None,
) -> bytes:
    total = 40 + len(data)
    value = bytearray(total)
    value[:4] = _tag("hohm", order)
    _put_u32(value, 4, 24, order)
    _put_u32(value, 8, total, order)
    _put_u32(value, 12, 0x02, order)
    value[27] = 0
    _put_u32(
        value,
        28,
        len(data) if declared_data_length is None else declared_data_length,
        order,
    )
    value[40:] = data
    return bytes(value)


def _track_payload(
    order: str,
    *,
    root_count: int = 1,
    child_count: int = 1,
    declared_string_length: int | None = None,
) -> bytes:
    return b"".join(
        (
            _section(1, order),
            _fixed_record("htlm", 12, order, {8: root_count}),
            _fixed_record(
                "htim",
                20,
                order,
                {8: 20, 12: child_count, 16: 7},
            ),
            _generic_hohm(
                order,
                declared_data_length=declared_string_length,
            ),
            _section(4, order),
            b"file://synthetic",
        )
    )


@pytest.mark.parametrize(
    ("order", "physical_tag"),
    (("big", "hdsm"), ("little", "msdh")),
)
def test_walker_accepts_synthetic_byte_orders(order: str, physical_tag: str) -> None:
    result = audit.walk_payload(_track_payload(order), order)

    assert result["status"] == "accepted"
    assert result["logical_first_tag"] == "hdsm"
    assert result["physical_first_tag"] == physical_tag
    assert result["record_census"] == {
        "hdsm": 2,
        "hohm": 1,
        "htim": 1,
        "htlm": 1,
    }
    assert result["root_count_checks"][0]["matches"] is True
    assert result["owner_count_checks"][0]["matches"] is True
    assert result["string_primitives"]["record_count"] == 1
    assert result["string_primitives"]["records"][0]["decode_status"] == "valid"


def test_walker_rejects_record_length_overrun() -> None:
    payload = bytearray(_track_payload("big"))
    hohm_offset = 16 + 12 + 20
    _put_u32(payload, hohm_offset + 8, 10_000, "big")

    with pytest.raises(audit.WalkError) as caught:
        audit.walk_payload(bytes(payload), "big")

    assert caught.value.code == "record_out_of_bounds"
    assert caught.value.offset == hohm_offset + 8


def test_walker_rejects_invalid_header_length() -> None:
    payload = bytearray(_track_payload("big"))
    root_offset = 16
    _put_u32(payload, root_offset + 4, 0, "big")

    with pytest.raises(audit.WalkError) as caught:
        audit.walk_payload(bytes(payload), "big")

    assert caught.value.code == "invalid_header_length"


def test_walker_rejects_root_count_mismatch() -> None:
    with pytest.raises(audit.WalkError) as caught:
        audit.walk_payload(_track_payload("big", root_count=2), "big")

    assert caught.value.code == "root_count_mismatch"


def test_walker_rejects_owner_count_mismatch() -> None:
    with pytest.raises(audit.WalkError) as caught:
        audit.walk_payload(_track_payload("big", child_count=2), "big")

    assert caught.value.code == "owner_count_mismatch"


def test_walker_rejects_string_data_overrun() -> None:
    with pytest.raises(audit.WalkError) as caught:
        audit.walk_payload(
            _track_payload("big", declared_string_length=200),
            "big",
        )

    assert caught.value.code == "string_data_out_of_bounds"


def test_reference_census_matches_observed_track_id() -> None:
    order = "big"
    payload = b"".join(
        (
            _section(1, order),
            _fixed_record("htlm", 12, order, {8: 1}),
            _fixed_record("htim", 20, order, {8: 20, 12: 0, 16: 7}),
            _section(2, order),
            _fixed_record("hplm", 12, order, {8: 1}),
            _fixed_record("hpim", 20, order, {12: 0, 16: 1}),
            _fixed_record("hptm", 28, order, {24: 7}),
            _section(4, order),
            b"file://synthetic",
        )
    )

    result = audit.walk_payload(payload, order)
    references = result["reference_primitives"]

    assert references["observed_track_count"] == 1
    assert references["playlist_reference_count"] == 1
    assert references["references_matching_observed_track_id"] == 1
    assert result["playlist_item_count_checks"][0]["item_count_matches"] is True


def test_first_failure_stage_classification() -> None:
    assert (
        audit.classify_parser_failure(
            "itlkit.Library",
            "big",
            RuntimeError(
                "Library supports little-endian payloads only; "
                "use Container for opaque big-endian preservation"
            ),
        )
        == "payload_byte_order_gate"
    )
    assert (
        audit.classify_parser_failure(
            "itlkit.Library",
            "little",
            RuntimeError("mfdh logical size differs from payload + outer header at 0x60"),
        )
        == "semantic_root_size_invariant"
    )


TITL_REPO = os.environ.get("TITL_REPO")


@pytest.mark.skipif(not TITL_REPO, reason="TITL_REPO is required for pinned-fixture integration")
def test_pinned_fixture_audit_integration() -> None:
    result = audit.build_audit(Path(TITL_REPO))
    summary = result["summary"]

    assert summary["fixture_count"] == 14
    assert summary["big_endian_fixture_count"] == 13
    assert summary["little_endian_fixture_count"] == 1
    assert summary["container_decode_accepted"] == 14
    assert summary["container_no_op_exact"] == 14
    assert summary["container_forced_rebuild_reparse_and_payload_preserved"] == 14
    assert summary["itlkit_library_accepted"] == 0
    assert summary["reference_library_accepted"] == 1
    assert summary["pinned_josephw_titl_accepted"] == 14
    assert summary["independent_structural_walker_accepted"] == 14
    assert summary["big_endian_structural_walker_accepted"] == 13
    assert summary["u02_status"] == "open"
    assert all(item["sha256"] for item in result["fixtures"])
    assert str(Path(TITL_REPO).resolve()) not in json.dumps(result, sort_keys=True)
