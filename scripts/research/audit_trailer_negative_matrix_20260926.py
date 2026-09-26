#!/usr/bin/env python3
"""Deterministic U-13 negative matrix for compressed-trailer boundary claims.

This research-only audit extends the 2026-09-25 trailer coverage work with
repository-local, offline negative controls.  It deliberately does not run
native iTunes and does not close U-13; it makes additional trailer-shaped tails,
outer-length collisions, and AES-cap/unused-data intersections machine-checkable.
"""
from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import zlib
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
SCRIPT_PATH = "scripts/research/audit_trailer_negative_matrix_20260926.py"
LEGACY_SCRIPT_PATH = "scripts/research/audit_trailer_coverage.py"
DEFAULT_REPORT = ROOT / "evidence" / "research" / "20260926" / "trailer-negative-matrix" / "report.json"
BASE_COMMIT = "c9f271d36a7095262c6195c04eb7f09d6cf88dee"
SOURCE = "TEST_CORPUS/generated/reference-one-track-zlib.itl"
SEED_LABEL = "deterministic-literals-20260926"


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def load_legacy_module():
    path = ROOT / LEGACY_SCRIPT_PATH
    spec = importlib.util.spec_from_file_location("trailer_coverage_20260925", path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load {path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


legacy = load_legacy_module()


def patch_u32(data: bytes, offset: int, value: int, endian: str = "big") -> bytes:
    changed = bytearray(data)
    changed[offset : offset + 4] = int(value).to_bytes(4, endian)
    return bytes(changed)


def make_builder():
    builder = legacy.AuditBuilder()
    builder.load_sources()
    return builder


def add_trailer_case(
    cases: list[Any],
    builder: Any,
    *,
    case_id: str,
    family: str,
    recipe: str,
    trailer: bytes,
    mutation: dict[str, Any] | None = None,
    encryption_flag: int | None = None,
    max_crypt_size: int | None = None,
) -> bytes:
    envelope = legacy.decode_envelope_bytes(builder.sources[SOURCE])
    packed = builder.pack_with_trailer(
        SOURCE,
        trailer,
        encryption_flag=encryption_flag if encryption_flag is not None else envelope.encryption_flag,
        max_crypt_size=max_crypt_size if max_crypt_size is not None else envelope.max_crypt_size,
    )
    cases.append(
        legacy.Case(
            case_id,
            family,
            SOURCE,
            recipe,
            packed,
            "trailer_valid",
            {"trailer_bytes": len(trailer), **(mutation or {})},
            expected_trailer=trailer,
            semantic_write_refused=True,
        )
    )
    return packed


def build_cases(builder: Any) -> list[Any]:
    cases: list[Any] = []
    payload = legacy.decode_envelope_bytes(builder.sources[SOURCE]).payload
    compressed_length = len(zlib.compress(payload, 6))

    second_empty = zlib.compress(b"", 6)
    add_trailer_case(
        cases,
        builder,
        case_id="multi-member-empty-second-zlib",
        family="multi_member_zlib",
        recipe="append a complete empty second zlib member after the first payload stream",
        trailer=second_empty,
        mutation={"second_member_plaintext_bytes": 0},
    )
    second_a = zlib.compress(b"u13-second-member-a", 6)
    second_b = zlib.compress(b"u13-second-member-b", 6)
    add_trailer_case(
        cases,
        builder,
        case_id="multi-member-two-extra-zlib-streams",
        family="multi_member_zlib",
        recipe="append two complete extra zlib members; both must remain opaque trailer bytes",
        trailer=second_a + second_b,
        mutation={"extra_members": 2},
    )
    add_trailer_case(
        cases,
        builder,
        case_id="multi-member-reference-looking-zlib-payload",
        family="multi_member_zlib",
        recipe="append a valid zlib member whose plaintext starts with an ITL-like hdfm marker",
        trailer=zlib.compress(b"hdfm\x00\x00\x00\x90reference-looking-second-member", 6),
        mutation={"second_member_plaintext_prefix_hex": "6864666d00000090"},
    )

    reference_tails = [
        ("reference-tail-hdfm-header", b"hdfm\x00\x00\x00\x90\x00\x00\x00\x90tail-not-envelope"),
        ("reference-tail-mhit-atom", b"mhit\x24\x00\x00\x00mith\x40\x00\x00\x00"),
        ("reference-tail-smart-playlist-ish", b"SLst\x00\x00\x00\x01SRSR\x00opaque"),
        ("reference-tail-count-table-ish", b"mhsd\x00\x00\x00\x14mhlf\x00\x00\x00\x01"),
    ]
    for case_id, trailer in reference_tails:
        add_trailer_case(
            cases,
            builder,
            case_id=case_id,
            family="reference_looking_tail",
            recipe="append bytes that resemble known ITL headers/atoms but are outside the first zlib stream",
            trailer=trailer,
            mutation={"tail_sha256": sha256(trailer)},
        )

    collision_specs = [
        ("outer-size-excludes-16-byte-trailer", b"L" * 16),
        ("outer-size-excludes-17-byte-trailer", b"M" * 17),
        ("outer-size-excludes-0x90-byte-trailer", b"N" * 0x90),
    ]
    for case_id, trailer in collision_specs:
        packed = builder.pack_with_trailer(SOURCE, trailer, encryption_flag=0, max_crypt_size=0)
        declared_without_trailer = len(packed) - len(trailer)
        changed = patch_u32(packed, 8, declared_without_trailer, "big")
        cases.append(
            legacy.Case(
                case_id,
                "trailer_outer_size_collision",
                SOURCE,
                "append a trailer but set the outer declared file size to the trailer-free length",
                changed,
                "outer_size_mismatch",
                {
                    "actual_file_bytes": len(changed),
                    "declared_size": declared_without_trailer,
                    "excluded_trailer_bytes": len(trailer),
                },
            )
        )

    aes_specs = [
        ("aes-cap-encrypts-first-trailer-block", b"A" * 16, compressed_length + 16),
        ("aes-cap-encrypts-trailer-plus-one", b"B" * 17, compressed_length + 17),
        ("aes-cap-rounds-across-31-byte-trailer", b"C" * 31, compressed_length + 31),
        ("aes-cap-overshoots-32-byte-trailer", b"D" * 32, compressed_length + 64),
    ]
    for case_id, trailer, cap in aes_specs:
        add_trailer_case(
            cases,
            builder,
            case_id=case_id,
            family="aes_cap_unused_data_intersection",
            recipe="append opaque bytes while AES flag 2 max_crypt_size crosses the zlib unused_data boundary",
            trailer=trailer,
            encryption_flag=2,
            max_crypt_size=cap,
            mutation={"encryption_flag": 2, "max_crypt_size": cap, "compressed_member_bytes": compressed_length},
        )

    prior_art_tails = [
        ("prior-art-requiem-label-tail", b"requiem-itl-trailer\x00aes-ecb-zlib-tail"),
        ("prior-art-mrexodia-note-tail", b"mrexodia-format-note\x00unused-data-boundary"),
        ("prior-art-libitlp-note-tail", b"libitlp-zlib-openssl-byo-key\x00tail"),
    ]
    for case_id, trailer in prior_art_tails:
        add_trailer_case(
            cases,
            builder,
            case_id=case_id,
            family="public_prior_art_analogue_tail",
            recipe="append public-prior-art-themed marker bytes as opaque unused_data, not as executable replay evidence",
            trailer=trailer,
            mutation={"tail_sha256": sha256(trailer), "public_prior_art_execution": False},
        )

    return cases


def evaluate_cases(builder: Any, cases: list[Any]) -> list[dict[str, Any]]:
    evaluated = [builder.evaluate_case(case) for case in cases]
    ids = [case["id"] for case in evaluated]
    if len(ids) != len(set(ids)):
        raise AssertionError("duplicate negative-matrix case id")
    return evaluated


def compact_case_row(case: dict[str, Any]) -> dict[str, Any]:
    validator = case["outcomes"]["validator"]
    primary = case["outcomes"]["primary_container"]
    relaxed = case["outcomes"]["primary_container_relaxed"]
    reference = case["outcomes"]["reference_envelope"]
    return {
        "id": case["id"],
        "family": case["family"],
        "expectation": case["expectation"],
        "primary_container": primary["decision"],
        "primary_container_relaxed": relaxed["decision"],
        "reference_envelope": reference["decision"],
        "validator": validator["decision"],
        "validator_issue_codes": validator.get("issue_codes", []),
        "trailer_bytes": primary.get("trailer_bytes"),
        "semantic_write_refused": case.get("semantic_write_gate", {}).get("decision") == "reject"
        if "semantic_write_gate" in case
        else None,
    }


def build_report() -> dict[str, Any]:
    builder = make_builder()
    cases = build_cases(builder)
    evaluated = evaluate_cases(builder, cases)
    family_counts = Counter(case["family"] for case in evaluated)
    trailer_valid_cases = [case for case in evaluated if case["expectation"] == "trailer_valid"]
    outer_collision_cases = [case for case in evaluated if case["expectation"] == "outer_size_mismatch"]
    semantic_refusals = [
        case for case in trailer_valid_cases if case.get("semantic_write_gate", {}).get("decision") == "reject"
    ]
    if len(semantic_refusals) != len(trailer_valid_cases):
        raise AssertionError("not every trailer-valid case retained the semantic write refusal gate")
    if any("scope.compressed_trailer" not in case["outcomes"]["validator"].get("issue_codes", []) for case in trailer_valid_cases):
        raise AssertionError("a trailer-valid case lacked validator compressed-trailer scope")
    if any(case["outcomes"]["primary_container_relaxed"]["decision"] != "accept" for case in outer_collision_cases):
        raise AssertionError("outer-size collision relaxed container did not demonstrate the hidden trailer boundary")

    script = ROOT / SCRIPT_PATH
    legacy_script = ROOT / LEGACY_SCRIPT_PATH
    report = {
        "schema": "windows-itl.trailer-negative-matrix-20260926.v1",
        "status": "passed_bounded_offline_u13_negative_matrix_u13_open",
        "repository_baseline_commit": BASE_COMMIT,
        "generator": {"path": SCRIPT_PATH, "sha256": sha256(script.read_bytes())},
        "legacy_audit_driver": {"path": LEGACY_SCRIPT_PATH, "sha256": sha256(legacy_script.read_bytes())},
        "source": {"path": SOURCE, "sha256": sha256(builder.sources[SOURCE])},
        "bounds": {
            "case_scenarios": len(evaluated),
            "trailer_valid_cases": len(trailer_valid_cases),
            "outer_size_collision_cases": len(outer_collision_cases),
            "semantic_write_refusal_checks": len(semantic_refusals),
            "multi_member_zlib_cases": family_counts["multi_member_zlib"],
            "reference_looking_tail_cases": family_counts["reference_looking_tail"],
            "trailer_outer_size_collision_cases": family_counts["trailer_outer_size_collision"],
            "aes_cap_unused_data_intersection_cases": family_counts["aes_cap_unused_data_intersection"],
            "public_prior_art_analogue_tail_cases": family_counts["public_prior_art_analogue_tail"],
            "native_itunes_operations": 0,
            "proprietary_binary_reads": 0,
            "network_operations": 0,
            "production_code_changes": 0,
            "power_loss_operations": 0,
        },
        "coverage": {
            "families": dict(sorted(family_counts.items())),
            "case_index": [compact_case_row(case) for case in evaluated],
        },
        "summary": {
            "u13_status": "open",
            "unexpected_anomalies": 0,
            "all_trailer_valid_cases_have_scope_warning": True,
            "all_trailer_valid_cases_refuse_semantic_write": True,
            "outer_size_collision_strict_rejects_relaxed_accepts": True,
            "native_acceptance_operations": 0,
            "production_code_changed": False,
            "independent_reimplementation_passed": False,
            "universal_itl_support": False,
        },
        "claim_limits": [
            "This is an offline deterministic negative/control matrix; it performs zero native iTunes operations and cannot prove native acceptance.",
            "Trailer bytes remain opaque unused_data with no provenance, decoder, or semantic independence proof.",
            "Reference-looking and public-prior-art-themed tails are byte-pattern controls, not evidence that those bytes are meaningful ITL records or historical replay outputs.",
            "Outer-size collision cases demonstrate fail-closed strict-size behavior, not a safe repair or discard policy.",
            "AES cap/unused-data intersections demonstrate exact recovery and scope warnings for selected finite cases only.",
            "U-13 remains open; no production semantic-write allowance or universal support claim is introduced.",
        ],
        "cases": evaluated,
    }
    return report


def write_report(path: Path, report: dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8", newline="\n")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_REPORT)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    write_report(args.output, build_report())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
