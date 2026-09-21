"""Narrow independent writer boundary.

Only deterministic envelope packing for synthetic fixtures and byte-exact
same-version conversion are implemented. Cross-version conversion is explicitly
refused until a field migration is independently specified and accepted.
"""
from __future__ import annotations

import hashlib
import os
from pathlib import Path
import zlib

from REFERENCE_PARSER.core import (
    AES_KEY,
    ReferenceLibrary,
    SUPPORTED_PROFILES,
    decode_envelope_bytes,
    detect_bytes,
)


class WriterError(Exception):
    """Base writer failure."""


class ConversionRefused(WriterError):
    """A requested conversion is not supported and no output was written."""


def _put(buffer: bytearray, offset: int, value: int, width: int, endian: str) -> None:
    if type(value) is not int or value < 0 or value >= 1 << (width * 8):
        raise ValueError(f"value does not fit unsigned {width * 8}-bit field")
    if offset < 0 or offset + width > len(buffer):
        raise ValueError("field does not fit header")
    buffer[offset : offset + width] = value.to_bytes(width, endian)


def _crypt_length(body_length: int, cap: int, flag: int) -> int:
    if flag == 0:
        interval = 0
    elif flag == 1:
        interval = body_length
    elif flag == 2:
        interval = min(body_length, cap)
    else:
        raise ConversionRefused(f"unsupported encryption flag {flag}")
    return interval // 16 * 16


def atomic_write_new(path: str | Path, data: bytes) -> None:
    """Publish a new file without replacing any existing path."""
    path = Path(path)
    if not path.parent.exists():
        raise FileNotFoundError(f"output parent does not exist: {path.parent}")
    flags = os.O_WRONLY | os.O_CREAT | os.O_EXCL
    descriptor = os.open(path, flags, 0o666)
    committed = False
    try:
        with os.fdopen(descriptor, "wb", closefd=True) as stream:
            descriptor = -1
            stream.write(data)
            stream.flush()
            os.fsync(stream.fileno())
        committed = True
    finally:
        if descriptor >= 0:
            os.close(descriptor)
        if not committed:
            try:
                path.unlink()
            except FileNotFoundError:
                pass


def encode_envelope(
    payload: bytes,
    *,
    version: str,
    counts: dict[str, int],
    file_persistent_id: int,
    compression_flag: int = 0,
    encryption_flag: int = 0,
    max_crypt_size: int = 0,
    template: bytes | None = None,
) -> bytes:
    """Pack a supplied payload using a new or explicitly supplied hdfm header.

    This function performs envelope construction only. The caller must label
    provenance and must not infer native acceptance from successful parsing.
    """
    try:
        version_bytes = version.encode("ascii", errors="strict")
    except UnicodeEncodeError as exc:
        raise ValueError("version must be ASCII") from exc
    if not 1 <= len(version_bytes) <= 31:
        raise ValueError("version must contain 1 to 31 ASCII bytes")
    required_counts = {"sections", "tracks", "playlists", "albums", "artists"}
    if set(counts) != required_counts:
        raise ValueError(f"counts must contain exactly {sorted(required_counts)}")
    if template is None:
        header = bytearray(144)
        header[:4] = b"hdfm"
        _put(header, 4, len(header), 4, "big")
    else:
        source = decode_envelope_bytes(template)
        header = bytearray(source.header)
        if len(header) < 0x60:
            raise ConversionRefused("template header is shorter than required profile")
    header[0x10:0x30] = b"\x00" * 0x20
    header[0x10] = len(version_bytes)
    header[0x11 : 0x11 + len(version_bytes)] = version_bytes
    _put(header, 0x30, counts["sections"], 4, "big")
    _put(header, 0x34, file_persistent_id, 8, "big")
    header[0x41] = encryption_flag
    header[0x43] = compression_flag
    _put(header, 0x44, counts["tracks"], 4, "big")
    _put(header, 0x48, counts["playlists"], 4, "big")
    _put(header, 0x4C, counts["albums"], 4, "big")
    header[0x52] = 1  # the independent semantic model is deliberately LE-only
    _put(header, 0x54, counts["artists"], 4, "big")
    _put(header, 0x5C, max_crypt_size, 4, "big")
    body = zlib.compress(bytes(payload), 6) if compression_flag else bytes(payload)
    encrypted_length = _crypt_length(len(body), max_crypt_size, encryption_flag)
    if encrypted_length:
        from Crypto.Cipher import AES

        body = (
            AES.new(AES_KEY, AES.MODE_ECB).encrypt(body[:encrypted_length])
            + body[encrypted_length:]
        )
    _put(header, 8, len(header) + len(body), 4, "big")
    return bytes(header) + body


def convert_version(
    input_path: str | Path, output_path: str | Path, target_version: str
) -> dict:
    """Perform the only qualified conversion: an exact same-version copy."""
    input_path = Path(input_path)
    output_path = Path(output_path)
    raw = input_path.read_bytes()
    detection = detect_bytes(raw)
    if detection["status"] != "recognized":
        raise ConversionRefused(
            f"input profile is not recognized: {detection.get('reason', detection['status'])}"
        )
    source_version = detection["version"]
    if target_version != source_version:
        raise ConversionRefused(
            "cross-version conversion is not implemented; refusing to relabel or "
            f"guess migrations from {source_version} to {target_version}"
        )
    profile = SUPPORTED_PROFILES[source_version]
    if not profile.get("identity_write"):
        raise ConversionRefused(f"identity conversion is disabled for {source_version}")
    ReferenceLibrary.from_bytes(raw)  # independent structural preflight
    atomic_write_new(output_path, raw)
    digest = hashlib.sha256(raw).hexdigest()
    return {
        "schema": "reference-itl.conversion-report.v1",
        "operation": "same-version-byte-exact-copy",
        "source_version": source_version,
        "target_version": target_version,
        "source_sha256": digest,
        "output_sha256": digest,
        "byte_exact": True,
        "cross_version_conversion": False,
        "native_acceptance": {
            "status": "not_retested",
            "claim": "No new native acceptance claim is made for the copied bytes.",
        },
    }
