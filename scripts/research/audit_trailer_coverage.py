"""Deterministic differential audit for ITL trailer, length, offset, and coverage boundaries.

The audit mutates checked-in inputs in memory only.  It compares the primary
``itlkit`` stack with the independent reference parser, writer, and validator.
Structural success is never reported as native acceptance.
"""
from __future__ import annotations

import argparse
from collections import Counter
from dataclasses import dataclass, field
import hashlib
import json
from pathlib import Path
import random
import sys
from typing import Any, Callable
import zlib

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from Crypto.Cipher import AES

from itlkit import Container, Library
from REFERENCE_PARSER.core import (
    AES_KEY,
    ReferenceLibrary,
    decode_envelope_bytes,
    detect_bytes,
)
from REFERENCE_WRITER.writer import encode_envelope
from VALIDATOR.validator import validate_bytes


DEFAULT_REPORT = ROOT / "evidence" / "research" / "20260925" / "report.json"
SEED = 0x20260925
MAX_PLAIN_BYTES = 16 * 1024 * 1024
GENERATED_HASHES = {
    "TEST_CORPUS/generated/reference-one-track-raw.itl": "c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74",
    "TEST_CORPUS/generated/reference-one-track-zlib.itl": "25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad",
    "TEST_CORPUS/generated/reference-three-track-raw.itl": "7d9b274765471d2d77440049273b210138e36b998d39d4790fe750d60c32406b",
    "TEST_CORPUS/generated/reference-three-track-zlib.itl": "73dbb405fbd2b68b62d29913b697a72100f8606cdb2ee704c55908e4de389e17",
}
NATIVE_SNAPSHOT = "evidence/native/snapshots/001-one-track.itl"


@dataclass(frozen=True)
class Case:
    case_id: str
    family: str
    source: str
    recipe: str
    data: bytes
    expectation: str
    mutation: dict[str, Any] = field(default_factory=dict)
    validator_issue: str | None = None
    expected_trailer: bytes | None = None
    semantic_write_refused: bool | None = None


EXPECTED_DECISIONS = {
    "valid": {
        "primary_container": "accept",
        "primary_container_relaxed": "accept",
        "primary_library": "accept",
        "reference_envelope": "accept",
        "reference_library": "accept",
        "detection": "accept",
        "validator": "accept",
    },
    "trailer_valid": {
        "primary_container": "accept",
        "primary_container_relaxed": "accept",
        "primary_library": "accept",
        "reference_envelope": "accept",
        "reference_library": "accept",
        "detection": "accept",
        "validator": "accept",
    },
    "envelope_invalid": {
        "primary_container": "reject",
        "primary_container_relaxed": "reject",
        "primary_library": "reject",
        "reference_envelope": "reject",
        "reference_library": "reject",
        "detection": "reject",
        "validator": "reject",
    },
    "outer_size_mismatch": {
        "primary_container": "reject",
        "primary_container_relaxed": "accept",
        "primary_library": "reject",
        "reference_envelope": "reject",
        "reference_library": "reject",
        "detection": "reject",
        "validator": "reject",
    },
    "semantic_boundary_invalid": {
        "primary_container": "accept",
        "primary_container_relaxed": "accept",
        "primary_library": "reject",
        "reference_envelope": "accept",
        "reference_library": "reject",
        "detection": "reject",
        "validator": "reject",
    },
    "semantic_count_invalid": {
        "primary_container": "accept",
        "primary_container_relaxed": "accept",
        "primary_library": "reject",
        "reference_envelope": "accept",
        "reference_library": "accept",
        "detection": "accept",
        "validator": "reject",
    },
    "logical_size_invalid": {
        "primary_container": "accept",
        "primary_container_relaxed": "accept",
        "primary_library": "reject",
        "reference_envelope": "accept",
        "reference_library": "accept",
        "detection": "accept",
        "validator": "reject",
    },
}


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def u32be(data: bytes, offset: int) -> int:
    return int.from_bytes(data[offset : offset + 4], "big")


def u32le(data: bytes, offset: int) -> int:
    return int.from_bytes(data[offset : offset + 4], "little")


def patch_u32(data: bytes, offset: int, value: int, endian: str) -> bytes:
    changed = bytearray(data)
    changed[offset : offset + 4] = value.to_bytes(4, endian)
    return bytes(changed)


def patch_outer_size(data: bytes) -> bytes:
    if len(data) < 12:
        return data
    return patch_u32(data, 8, len(data), "big")


def crypt_length(body_length: int, cap: int, flag: int) -> int:
    if flag == 0:
        interval = 0
    elif flag == 1:
        interval = body_length
    elif flag == 2:
        interval = min(body_length, cap)
    else:
        raise ValueError(f"unsupported audit encryption flag {flag}")
    return interval // 16 * 16


def normalized_error(exc: BaseException) -> str:
    message = str(exc).lower()
    checks = (
        ("opaque_trailer", ("unknown compression trailer",)),
        ("outer_size", ("declared outer file size", "declared file size")),
        ("plain_limit", ("exceeds configured limit", "payload exceeds")),
        ("zlib_truncated", ("truncated zlib",)),
        ("zlib_invalid", ("zlib",)),
        ("outer_header", ("outer header", "hdfm envelope")),
        ("logical_size", ("logical size",)),
        ("secondary_identity", ("secondary track id",)),
        ("identity", ("identity", "persistent id")),
        ("count", ("count",)),
        ("section_boundary", ("section boundary", "section ", "msdh")),
        ("record_boundary", ("record", "header length", "total length", "prefix")),
        ("unsupported", ("unsupported",)),
    )
    for code, needles in checks:
        if any(needle in message for needle in needles):
            return code
    return "other"


def capture(call: Callable[[], dict[str, Any]]) -> dict[str, Any]:
    try:
        result = call()
        return {"decision": "accept", **result}
    except Exception as exc:  # deterministic classification is the audit output
        return {
            "decision": "reject",
            "error_type": type(exc).__name__,
            "error_class": normalized_error(exc),
        }


def container_result(data: bytes, *, strict_size: bool) -> dict[str, Any]:
    container = Container.from_bytes(
        data, strict_size=strict_size, max_plain_bytes=MAX_PLAIN_BYTES
    )
    return {
        "payload_bytes": len(container.payload),
        "payload_sha256": sha256(container.payload),
        "trailer_bytes": len(container.trailer),
        "trailer_sha256": sha256(container.trailer),
        "no_op_exact": container.to_bytes() == data,
    }


def library_result(data: bytes) -> dict[str, Any]:
    library = Library.from_bytes(data, max_plain_bytes=MAX_PLAIN_BYTES)
    return {
        "tracks": len(library.tracks),
        "playlists": len(library.playlists),
        "sections": len(library.sections),
        "trailer_bytes": len(library.container.trailer),
        "no_op_exact": library.to_bytes() == data,
    }


def reference_envelope_result(data: bytes) -> dict[str, Any]:
    envelope = decode_envelope_bytes(data, max_plain_bytes=MAX_PLAIN_BYTES)
    return {
        "payload_bytes": len(envelope.payload),
        "payload_sha256": sha256(envelope.payload),
        "trailer_bytes": len(envelope.trailer),
        "trailer_sha256": sha256(envelope.trailer),
    }


def reference_library_result(data: bytes) -> dict[str, Any]:
    library = ReferenceLibrary.from_bytes(data)
    return {
        "tracks": len(library.track_records),
        "playlists": len(library.playlist_records),
        "sections": len(library.sections),
        "trailer_bytes": len(library.envelope.trailer),
    }


def detection_result(data: bytes) -> dict[str, Any]:
    result = detect_bytes(data)
    if result["status"] != "recognized":
        raise ValueError(result["status"])
    return {"status": result["status"], "version": result["version"]}


def outcomes(data: bytes) -> dict[str, dict[str, Any]]:
    result = {
        "primary_container": capture(lambda: container_result(data, strict_size=True)),
        "primary_container_relaxed": capture(
            lambda: container_result(data, strict_size=False)
        ),
        "primary_library": capture(lambda: library_result(data)),
        "reference_envelope": capture(lambda: reference_envelope_result(data)),
        "reference_library": capture(lambda: reference_library_result(data)),
        "detection": capture(lambda: detection_result(data)),
    }
    validation = validate_bytes(data)
    result["validator"] = {
        "decision": "accept" if validation["valid"] else "reject",
        "valid": validation["valid"],
        "issue_codes": [issue["code"] for issue in validation["issues"]],
        "coverage": validation["coverage"],
    }
    return result


class AuditBuilder:
    def __init__(self) -> None:
        self.rng = random.Random(SEED)
        self.sources: dict[str, bytes] = {}
        self.source_rows: list[dict[str, Any]] = []
        self.pins: dict[str, str] = {}
        self.cases: list[Case] = []
        self.writer_checks: dict[tuple[str, int, int, int], dict[str, Any]] = {}

    def read_pinned(self, relative: str) -> bytes:
        data = (ROOT / relative).read_bytes()
        digest = sha256(data)
        previous = self.pins.setdefault(relative, digest)
        if previous != digest:
            raise AssertionError(f"input changed during audit: {relative}")
        return data

    def load_sources(self) -> None:
        for relative, expected_hash in GENERATED_HASHES.items():
            data = self.read_pinned(relative)
            if sha256(data) != expected_hash:
                raise AssertionError(f"checked-in fixture hash drifted: {relative}")
            provenance_path = relative + ".provenance.json"
            provenance_data = self.read_pinned(provenance_path)
            provenance = json.loads(provenance_data)
            if provenance["output_sha256"] != expected_hash:
                raise AssertionError(f"provenance output hash mismatch: {relative}")
            native = provenance["native_acceptance"]
            if native["status"] != "verified" or native["scope"] != "exact_output_sha256":
                raise AssertionError(f"fixture lacks exact native qualification: {relative}")
            evidence_path = native["evidence"]
            evidence_data = self.read_pinned(evidence_path)
            evidence = json.loads(evidence_data.decode("utf-8-sig"))
            if not evidence.get("passed") or evidence["candidate"]["sha256"] != expected_hash:
                raise AssertionError(f"native evidence does not pin fixture: {relative}")
            self.sources[relative] = data
            self.source_rows.append(
                {
                    "path": relative,
                    "bytes": len(data),
                    "sha256": expected_hash,
                    "provenance": provenance_path,
                    "provenance_sha256": sha256(provenance_data),
                    "native_acceptance": {
                        "status": "verified",
                        "scope": "exact_output_sha256",
                        "cycles": native["cycles"],
                        "evidence": evidence_path,
                        "evidence_sha256": sha256(evidence_data),
                    },
                }
            )
        native = self.read_pinned(NATIVE_SNAPSHOT)
        self.sources[NATIVE_SNAPSHOT] = native
        self.source_rows.append(
            {
                "path": NATIVE_SNAPSHOT,
                "bytes": len(native),
                "sha256": sha256(native),
                "native_acceptance": {
                    "status": "frozen_native_snapshot",
                    "scope": "read_only_input",
                },
            }
        )

    def writer_repack(
        self,
        source: str,
        *,
        payload: bytes | None = None,
        compression_flag: int | None = None,
        encryption_flag: int | None = None,
        max_crypt_size: int | None = None,
    ) -> bytes:
        template = self.sources[source]
        envelope = decode_envelope_bytes(template, max_plain_bytes=MAX_PLAIN_BYTES)
        payload = envelope.payload if payload is None else bytes(payload)
        compression = envelope.compression_flag if compression_flag is None else compression_flag
        encryption = envelope.encryption_flag if encryption_flag is None else encryption_flag
        cap = envelope.max_crypt_size if max_crypt_size is None else max_crypt_size
        return encode_envelope(
            payload,
            version=envelope.version,
            counts=envelope.declared_counts,
            file_persistent_id=envelope.file_persistent_id,
            compression_flag=compression,
            encryption_flag=encryption,
            max_crypt_size=cap,
            template=template,
        )

    def pack_with_trailer(
        self,
        source: str,
        trailer: bytes,
        *,
        payload: bytes | None = None,
        compression_flag: int = 1,
        encryption_flag: int = 2,
        max_crypt_size: int = 102400,
    ) -> bytes:
        if not compression_flag and trailer:
            raise ValueError("raw bodies have no separately identifiable trailer")
        template = self.sources[source]
        envelope = decode_envelope_bytes(template, max_plain_bytes=MAX_PLAIN_BYTES)
        payload = envelope.payload if payload is None else bytes(payload)
        writer = self.writer_repack(
            source,
            payload=payload,
            compression_flag=compression_flag,
            encryption_flag=encryption_flag,
            max_crypt_size=max_crypt_size,
        )
        header_length = u32be(writer, 4)
        header = bytearray(writer[:header_length])
        plain_body = (
            zlib.compress(payload, 6) + bytes(trailer)
            if compression_flag
            else payload
        )
        encrypted = crypt_length(len(plain_body), max_crypt_size, encryption_flag)
        body = plain_body
        if encrypted:
            body = (
                AES.new(AES_KEY, AES.MODE_ECB).encrypt(plain_body[:encrypted])
                + plain_body[encrypted:]
            )
        header[8:12] = (len(header) + len(body)).to_bytes(4, "big")
        packed = bytes(header) + body

        no_trailer_body = zlib.compress(payload, 6) if compression_flag else payload
        no_trailer_encrypted = crypt_length(
            len(no_trailer_body), max_crypt_size, encryption_flag
        )
        manual_no_trailer = no_trailer_body
        if no_trailer_encrypted:
            manual_no_trailer = (
                AES.new(AES_KEY, AES.MODE_ECB).encrypt(
                    no_trailer_body[:no_trailer_encrypted]
                )
                + no_trailer_body[no_trailer_encrypted:]
            )
        no_trailer_header = bytearray(header)
        no_trailer_header[8:12] = (
            len(no_trailer_header) + len(manual_no_trailer)
        ).to_bytes(4, "big")
        manual_writer = bytes(no_trailer_header) + manual_no_trailer
        if manual_writer != writer:
            raise AssertionError("manual trailer packer disagrees with independent writer")
        key = (source, compression_flag, encryption_flag, max_crypt_size)
        self.writer_checks[key] = {
            "source": source,
            "compression_flag": compression_flag,
            "encryption_flag": encryption_flag,
            "max_crypt_size": max_crypt_size,
            "manual_matches_reference_writer_without_trailer": True,
            "writer_bytes": len(writer),
            "writer_sha256": sha256(writer),
        }
        decoded = decode_envelope_bytes(packed, max_plain_bytes=MAX_PLAIN_BYTES)
        if decoded.payload != payload or decoded.trailer != trailer:
            raise AssertionError("independent envelope did not recover packed payload/trailer")
        return packed

    def add(self, case: Case) -> None:
        if any(existing.case_id == case.case_id for existing in self.cases):
            raise AssertionError(f"duplicate case id: {case.case_id}")
        self.cases.append(case)

    def add_baselines(self) -> None:
        for source, data in self.sources.items():
            case_name = Path(source).stem.replace(".", "-")
            self.add(
                Case(
                    f"baseline-{case_name}",
                    "baseline",
                    source,
                    "checked-in input without mutation",
                    data,
                    "valid",
                )
            )
        for source, expected_hash in GENERATED_HASHES.items():
            repacked = self.writer_repack(source)
            exact = repacked == self.sources[source]
            if not exact:
                raise AssertionError(f"reference writer failed exact fixture repack: {source}")
            envelope = decode_envelope_bytes(self.sources[source])
            key = (
                source,
                envelope.compression_flag,
                envelope.encryption_flag,
                envelope.max_crypt_size,
            )
            self.writer_checks[key] = {
                "source": source,
                "compression_flag": envelope.compression_flag,
                "encryption_flag": envelope.encryption_flag,
                "max_crypt_size": envelope.max_crypt_size,
                "reference_writer_repack_exact": True,
                "expected_sha256": expected_hash,
                "writer_sha256": sha256(repacked),
                "writer_bytes": len(repacked),
            }

    def add_trailer_cases(self) -> None:
        source = "TEST_CORPUS/generated/reference-one-track-zlib.itl"
        for length in (1, 15, 16, 17, 31, 32, 33):
            trailer = self.rng.randbytes(length)
            packed = self.pack_with_trailer(source, trailer)
            self.add(
                Case(
                    f"trailer-opaque-{length:02d}",
                    "compressed_trailer",
                    source,
                    f"append {length} fixed-seed opaque bytes after the first zlib member",
                    packed,
                    "trailer_valid",
                    {"trailer_bytes": length, "seed": SEED},
                    expected_trailer=trailer,
                )
            )

        member = zlib.compress(b"deterministic-second-member", 6)
        packed = self.pack_with_trailer(source, member)
        self.add(
            Case(
                "trailer-concatenated-zlib-member",
                "compressed_trailer",
                source,
                "append a complete second zlib member; only the first member is payload",
                packed,
                "trailer_valid",
                {"second_member_plaintext": "deterministic-second-member"},
                expected_trailer=member,
            )
        )

        payload = decode_envelope_bytes(self.sources[source]).payload
        compressed_length = len(zlib.compress(payload, 6))
        configs = [
            (0, 0, "flag0"),
            (1, 0, "flag1"),
            (2, 0, "flag2-cap0"),
            (2, 15, "flag2-cap15"),
            (2, 16, "flag2-cap16"),
            (2, 17, "flag2-cap17"),
            (2, compressed_length - 1, "flag2-before-stream-end"),
            (2, compressed_length, "flag2-at-stream-end"),
            (2, compressed_length + 1, "flag2-after-stream-end"),
        ]
        for flag, cap, label in configs:
            trailer = self.rng.randbytes(17)
            packed = self.pack_with_trailer(
                source,
                trailer,
                encryption_flag=flag,
                max_crypt_size=cap,
            )
            self.add(
                Case(
                    f"trailer-encryption-{label}",
                    "trailer_encryption_boundary",
                    source,
                    "append 17 opaque bytes and vary AES interval selection/rounding",
                    packed,
                    "trailer_valid",
                    {
                        "encryption_flag": flag,
                        "max_crypt_size": cap,
                        "compressed_member_bytes": compressed_length,
                    },
                    expected_trailer=trailer,
                )
            )

        clear_trailer = self.rng.randbytes(17)
        clear_case = self.pack_with_trailer(
            source,
            clear_trailer,
            encryption_flag=0,
            max_crypt_size=0,
        )
        corrupted = bytearray(clear_case)
        corrupted[-1] ^= 1
        changed_trailer = clear_trailer[:-1] + bytes([clear_trailer[-1] ^ 1])
        self.add(
            Case(
                "trailer-one-byte-corruption",
                "trailer_corruption",
                source,
                "flip one bit in the opaque trailer while leaving the zlib member intact",
                bytes(corrupted),
                "trailer_valid",
                {"file_offset": len(corrupted) - 1, "xor": 1},
                expected_trailer=changed_trailer,
            )
        )

        native = NATIVE_SNAPSHOT
        native_trailer = b"\x00native-trailer-audit\xff"
        native_envelope = decode_envelope_bytes(self.sources[native])
        packed_native = self.pack_with_trailer(
            native,
            native_trailer,
            compression_flag=native_envelope.compression_flag,
            encryption_flag=native_envelope.encryption_flag,
            max_crypt_size=native_envelope.max_crypt_size,
        )
        self.add(
            Case(
                "trailer-native-profile-write-guard",
                "compressed_trailer",
                native,
                "repack the frozen native payload and append an opaque trailer in memory",
                packed_native,
                "trailer_valid",
                {"native_input_modified": False},
                expected_trailer=native_trailer,
                semantic_write_refused=True,
            )
        )

    def add_envelope_cases(self) -> None:
        source = "TEST_CORPUS/generated/reference-one-track-zlib.itl"
        base = self.sources[source]
        for delta in (-1, 1):
            changed = patch_u32(base, 8, len(base) + delta, "big")
            self.add(
                Case(
                    f"outer-declared-size-{delta:+d}",
                    "outer_size",
                    source,
                    f"change hdfm+0x08 by {delta:+d} without changing file bytes",
                    changed,
                    "outer_size_mismatch",
                    {"header_offset": 8, "declared_size_delta": delta},
                )
            )
        for header_length in (0x5F, 0x60, 0x91, len(base) + 1):
            changed = patch_u32(base, 4, header_length, "big")
            self.add(
                Case(
                    f"outer-header-length-{header_length}",
                    "outer_header_length",
                    source,
                    f"set hdfm+0x04 header length to {header_length}",
                    changed,
                    "envelope_invalid",
                    {"header_offset": 4, "value": header_length},
                )
            )
        for cut in (0, 3, 4, 0x5F, 0x60, 0x8F, 0x90):
            self.add(
                Case(
                    f"truncate-prefix-{cut:03d}",
                    "truncation",
                    source,
                    f"retain only the first {cut} file bytes",
                    base[:cut],
                    "envelope_invalid",
                    {"retained_bytes": cut},
                )
            )

        payload = decode_envelope_bytes(base).payload
        plain_zlib = self.writer_repack(
            source,
            payload=payload,
            compression_flag=1,
            encryption_flag=0,
            max_crypt_size=0,
        )
        checksum = bytearray(plain_zlib)
        checksum[-1] ^= 1
        self.add(
            Case(
                "zlib-checksum-one-bit-corruption",
                "compressed_corruption",
                source,
                "flip one bit in the Adler-32 tail of an unencrypted zlib body",
                bytes(checksum),
                "envelope_invalid",
                {"file_offset": len(checksum) - 1, "xor": 1},
            )
        )
        for removed in (1, 4, 8):
            truncated = patch_outer_size(plain_zlib[:-removed])
            self.add(
                Case(
                    f"zlib-truncate-{removed:02d}",
                    "truncation",
                    source,
                    f"remove {removed} compressed tail bytes and repair only outer size",
                    truncated,
                    "envelope_invalid",
                    {"removed_tail_bytes": removed, "outer_size_repaired": True},
                )
            )

    def add_semantic_cases(self) -> None:
        source = "TEST_CORPUS/generated/reference-one-track-raw.itl"
        base = self.sources[source]
        envelope = decode_envelope_bytes(base)
        payload = envelope.payload
        library = ReferenceLibrary.from_bytes(base)
        first = library.sections[0]
        track_section = library.section(1)
        if track_section is None or track_section.root is None:
            raise AssertionError("track section missing from audit seed")
        track = library.track_records[0]
        name = track.children[0]
        playlist = library.playlist_records[0]

        def repack(changed_payload: bytes) -> bytes:
            return self.writer_repack(
                source,
                payload=changed_payload,
                compression_flag=0,
                encryption_flag=0,
                max_crypt_size=0,
            )

        boundary_mutations = [
            (
                "section-total-minus-one",
                8,
                first.total_length - 1,
                "shrink the first msdh total length by one byte",
            ),
            (
                "section-total-plus-one",
                8,
                first.total_length + 1,
                "extend the first msdh total length into the next section",
            ),
            (
                "section-header-short",
                4,
                15,
                "set the first msdh header length below the 16-byte minimum",
            ),
            (
                "track-total-below-header",
                track.offset + 8,
                len(track.header) - 1,
                "set mith total length below its header length",
            ),
            (
                "track-total-plus-one",
                track.offset + 8,
                track.total_length + 1,
                "extend mith total length one byte past the enclosing list",
            ),
            (
                "track-header-minus-one",
                track.offset + 4,
                len(track.header) - 1,
                "move the first child offset one byte into the track header",
            ),
            (
                "track-header-plus-one",
                track.offset + 4,
                len(track.header) + 1,
                "move the first child offset one byte into the child tag",
            ),
            (
                "text-total-minus-one",
                name.offset + 8,
                name.total_length - 1,
                "shrink the first mhoh text object by one byte",
            ),
            (
                "text-total-plus-one",
                name.offset + 8,
                name.total_length + 1,
                "extend the first mhoh text object by one byte",
            ),
        ]
        for case_id, offset, value, recipe in boundary_mutations:
            changed_payload = patch_u32(payload, offset, value, "little")
            self.add(
                Case(
                    case_id,
                    "record_length",
                    source,
                    recipe,
                    repack(changed_payload),
                    "semantic_boundary_invalid",
                    {"payload_offset": offset, "u32le": value},
                )
            )

        boundary = library.sections[1].offset
        inserted = payload[:boundary] + b"\x00" + payload[boundary:]
        deleted = payload[:boundary] + payload[boundary + 1 :]
        self.add(
            Case(
                "section-offset-insert-one",
                "section_offset",
                source,
                "insert one byte at the second msdh offset without updating section lengths",
                repack(inserted),
                "semantic_boundary_invalid",
                {"payload_offset": boundary, "insert_hex": "00"},
            )
        )
        self.add(
            Case(
                "section-offset-delete-one",
                "section_offset",
                source,
                "delete one byte at the second msdh offset without updating section lengths",
                repack(deleted),
                "semantic_boundary_invalid",
                {"payload_offset": boundary, "deleted_hex": payload[boundary:boundary+1].hex()},
            )
        )

        count_mutations = [
            (
                "track-root-count-plus-one",
                track_section.root.offset + 8,
                u32le(payload, track_section.root.offset + 8) + 1,
                "count.root_mismatch",
                "increment the mlth declared child count",
            ),
            (
                "track-child-count-zero",
                track.offset + 12,
                0,
                "count.record_mismatch",
                "set the mith declared child count to zero",
            ),
            (
                "playlist-metadata-count-plus-one",
                playlist.offset + 12,
                u32le(payload, playlist.offset + 12) + 1,
                "count.playlist_mismatch",
                "increment the miph metadata-object count",
            ),
        ]
        for case_id, offset, value, issue, recipe in count_mutations:
            changed_payload = patch_u32(payload, offset, value, "little")
            self.add(
                Case(
                    case_id,
                    "declared_count",
                    source,
                    recipe,
                    repack(changed_payload),
                    "semantic_count_invalid",
                    {"payload_offset": offset, "u32le": value},
                    validator_issue=issue,
                )
            )

        outer_count = patch_u32(base, 0x44, u32be(base, 0x44) + 1, "big")
        self.add(
            Case(
                "outer-track-count-plus-one",
                "declared_count",
                source,
                "increment hdfm+0x44 without changing payload records",
                outer_count,
                "semantic_count_invalid",
                {"header_offset": 0x44, "delta": 1},
                validator_issue="count.outer_mismatch",
            )
        )

        mfdh = first.root
        if mfdh is None:
            raise AssertionError("mfdh missing from audit seed")
        logical_offset = mfdh.offset + 8
        logical = u32le(payload, logical_offset)
        changed_payload = patch_u32(payload, logical_offset, logical + 1, "little")
        self.add(
            Case(
                "mfdh-logical-size-plus-one",
                "logical_size",
                source,
                "increment mfdh logical size without changing payload bytes",
                repack(changed_payload),
                "logical_size_invalid",
                {"payload_offset": logical_offset, "delta": 1},
                validator_issue="size.logical_mismatch",
            )
        )

    def build(self) -> None:
        self.load_sources()
        self.add_baselines()
        self.add_trailer_cases()
        self.add_envelope_cases()
        self.add_semantic_cases()

    def limit_matrix(self) -> list[dict[str, Any]]:
        rows = []
        for source in (
            "TEST_CORPUS/generated/reference-one-track-raw.itl",
            "TEST_CORPUS/generated/reference-one-track-zlib.itl",
        ):
            data = self.sources[source]
            plain_bytes = len(decode_envelope_bytes(data).payload)
            for delta in (-1, 0):
                limit = plain_bytes + delta
                primary = capture(
                    lambda d=data, n=limit: {
                        "payload_bytes": len(Container.from_bytes(d, max_plain_bytes=n).payload)
                    }
                )
                reference = capture(
                    lambda d=data, n=limit: {
                        "payload_bytes": len(
                            decode_envelope_bytes(d, max_plain_bytes=n).payload
                        )
                    }
                )
                expected = "reject" if delta == -1 else "accept"
                if primary["decision"] != expected or reference["decision"] != expected:
                    raise AssertionError(f"plaintext limit boundary disagreement: {source}/{limit}")
                rows.append(
                    {
                        "source": source,
                        "payload_bytes": plain_bytes,
                        "max_plain_bytes": limit,
                        "expected": expected,
                        "primary_container": primary,
                        "reference_envelope": reference,
                    }
                )
        return rows

    def evaluate_case(self, case: Case) -> dict[str, Any]:
        actual = outcomes(case.data)
        expected = EXPECTED_DECISIONS[case.expectation]
        for tool, decision in expected.items():
            if actual[tool]["decision"] != decision:
                raise AssertionError(
                    f"{case.case_id}: {tool} {actual[tool]['decision']} != {decision}"
                )
        primary = actual["primary_container"]
        reference = actual["reference_envelope"]
        if primary["decision"] != reference["decision"]:
            raise AssertionError(f"{case.case_id}: envelope decoder decision disagreement")
        if primary["decision"] == "accept":
            for key in ("payload_bytes", "payload_sha256", "trailer_bytes", "trailer_sha256"):
                if primary[key] != reference[key]:
                    raise AssertionError(f"{case.case_id}: envelope decoder {key} disagreement")
        if case.expected_trailer is not None:
            expected_hash = sha256(case.expected_trailer)
            if primary.get("trailer_sha256") != expected_hash:
                raise AssertionError(f"{case.case_id}: trailer bytes were not recovered exactly")
            codes = actual["validator"]["issue_codes"]
            if "scope.compressed_trailer" not in codes:
                raise AssertionError(f"{case.case_id}: validator omitted trailer scope warning")
            coverage = actual["validator"]["coverage"]["compressed_trailer"]
            if coverage != {
                "present": True,
                "bytes": len(case.expected_trailer),
                "semantically_validated": False,
            }:
                raise AssertionError(f"{case.case_id}: validator trailer coverage is inaccurate")
        if case.validator_issue and case.validator_issue not in actual["validator"]["issue_codes"]:
            raise AssertionError(
                f"{case.case_id}: validator omitted {case.validator_issue}"
            )
        semantic_gate: dict[str, Any] | None = None
        if case.semantic_write_refused is not None:
            def try_write() -> dict[str, Any]:
                library = Library.from_bytes(case.data, max_plain_bytes=MAX_PLAIN_BYTES)
                track = library.tracks[0]
                track.set(rating=track.get("rating"))
                return {"allowed": True}

            semantic_gate = capture(try_write)
            refused = semantic_gate["decision"] == "reject"
            if refused != case.semantic_write_refused:
                raise AssertionError(f"{case.case_id}: semantic write guard decision drifted")
        return {
            "id": case.case_id,
            "family": case.family,
            "source": case.source,
            "recipe": case.recipe,
            "mutation": case.mutation,
            "candidate": {"bytes": len(case.data), "sha256": sha256(case.data)},
            "expectation": case.expectation,
            "outcomes": actual,
            **({"semantic_write_gate": semantic_gate} if semantic_gate else {}),
        }

    def report(self) -> dict[str, Any]:
        rows = [self.evaluate_case(case) for case in self.cases]
        limits = self.limit_matrix()
        family_counts = Counter(case.family for case in self.cases)
        trailer_cases = sum(case.expected_trailer is not None for case in self.cases)
        generated_baselines = [
            row
            for row in rows
            if row["family"] == "baseline" and row["source"] in GENERATED_HASHES
        ]
        if not all(row["outcomes"]["primary_library"]["decision"] == "accept" for row in generated_baselines):
            raise AssertionError("primary Library still rejects an exact native-qualified fixture")
        for relative, digest in self.pins.items():
            if sha256((ROOT / relative).read_bytes()) != digest:
                raise AssertionError(f"read-only input changed: {relative}")
        return {
            "schema": "windows-itl.trailer-coverage-audit.v1",
            "status": "passed",
            "seed": {"hex": f"0x{SEED:08x}", "decimal": SEED},
            "scope": {
                "profile": "12.13.10.3",
                "claims": "deterministic structural/parser behavior for the exact listed corpus and mutations",
                "native_actions": False,
                "frozen_inputs_modified": False,
            },
            "sources": self.source_rows,
            "coverage": {
                "cases": len(rows),
                "families": dict(sorted(family_counts.items())),
                "trailer_cases": trailer_cases,
                "plaintext_limit_probes": len(limits),
                "tool_layers": [
                    "itlkit.Container(strict)",
                    "itlkit.Container(strict_size=False)",
                    "itlkit.Library",
                    "REFERENCE_PARSER envelope",
                    "REFERENCE_PARSER ReferenceLibrary",
                    "REFERENCE_PARSER detect_bytes",
                    "VALIDATOR validate_bytes",
                    "REFERENCE_WRITER encode_envelope cross-check",
                ],
                "regions": [
                    "outer header length and declared size",
                    "AES interval/cap block boundaries",
                    "zlib checksum/end marker and unused_data trailer",
                    "plaintext budget exact/one-below boundary",
                    "msdh section lengths and offsets",
                    "list/record header and total lengths",
                    "declared root/record/playlist/outer counts",
                    "mfdh logical coverage size",
                ],
            },
            "reference_writer_checks": [
                self.writer_checks[key] for key in sorted(self.writer_checks)
            ],
            "expectation_profiles": EXPECTED_DECISIONS,
            "plaintext_limit_probes": limits,
            "cases": rows,
            "findings": [
                {
                    "id": "F-01",
                    "result": "no unexplained envelope differential",
                    "evidence": "Primary and independent envelope decisions plus payload/trailer hashes agreed for every case.",
                },
                {
                    "id": "F-02",
                    "result": "compressed trailer is a structural boundary, not validated semantics",
                    "evidence": f"{trailer_cases} opaque/concatenated/encryption-boundary cases were retained exactly and now receive scope.compressed_trailer.",
                },
                {
                    "id": "F-03",
                    "result": "a second zlib member remains opaque trailer data",
                    "evidence": "Neither decoder implicitly merges the concatenated member into the semantic payload.",
                },
                {
                    "id": "F-04",
                    "result": "forensic outer-size relaxation is isolated",
                    "evidence": "Only primary Container(strict_size=False) accepted the two declared-size mismatches; strict/high-level/reference tools rejected them.",
                },
                {
                    "id": "F-05",
                    "result": "primary read gate corrected for exact native-qualified zero secondary IDs",
                    "evidence": "All four exact generated hashes parse and no-op round-trip in primary Library; semantic writes still require the nonzero observed write profile.",
                },
            ],
            "limitations": [
                "No mutated candidate was run in native iTunes; structural acceptance is not native acceptance.",
                "Opaque trailer bytes have no provenance or decoder and remain semantically unvalidated.",
                "The audit is a finite fixed-seed boundary matrix, not coverage-guided fuzzing or a universal format proof.",
                "Unknown sections and records can still contain hidden dependencies.",
                "Only the exact listed 12.13.10.3 corpus and mutation recipes are covered.",
            ],
        }


def json_bytes(value: Any) -> bytes:
    return (
        json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    ).encode("utf-8")


def build_audit() -> tuple[AuditBuilder, dict[str, Any]]:
    builder = AuditBuilder()
    builder.build()
    return builder, builder.report()


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_REPORT)
    parser.add_argument("--list-cases", action="store_true")
    parser.add_argument("--case")
    parser.add_argument("--write-repro", type=Path)
    args = parser.parse_args(argv)

    builder = AuditBuilder()
    builder.build()
    if args.list_cases:
        for case in builder.cases:
            print(case.case_id)
        return 0
    if args.write_repro is not None:
        if not args.case:
            parser.error("--write-repro requires --case")
        match = [case for case in builder.cases if case.case_id == args.case]
        if len(match) != 1:
            parser.error(f"unknown case: {args.case}")
        args.write_repro.parent.mkdir(parents=True, exist_ok=True)
        args.write_repro.write_bytes(match[0].data)
        print(
            json.dumps(
                {
                    "case": match[0].case_id,
                    "path": str(args.write_repro),
                    "bytes": len(match[0].data),
                    "sha256": sha256(match[0].data),
                },
                sort_keys=True,
            )
        )
        return 0
    if args.case:
        parser.error("--case is only used with --write-repro")

    report = builder.report()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(json_bytes(report))
    print(
        json.dumps(
            {
                "status": report["status"],
                "cases": report["coverage"]["cases"],
                "output": str(args.output),
                "sha256": sha256(json_bytes(report)),
            },
            sort_keys=True,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
