"""Strictly parse and compare the exact ID3v2.2 rewrite in retained MP3 evidence.

This is deliberately not a general tag library.  It supports the ID3v2.2 shape
needed by the retained native evidence, rejects unsupported flags/encodings, and
proves audio-tail equality byte for byte instead of inferring it from lengths.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
FRAME_ID = re.compile(rb"[A-Z0-9]{3}")
GENERATED_ASCII_ALPHABET = b"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
GENERATED_ASCII_MIN_CHARACTERS = 16
GENERATED_ASCII_MAX_CHARACTERS = 20_000_000
ID3V22_FRAME_SIZE_BITS = 24
ID3V22_FRAME_SIZE_MODULUS = 1 << ID3V22_FRAME_SIZE_BITS
ID3V22_MAX_FRAME_PAYLOAD_BYTES = ID3V22_FRAME_SIZE_MODULUS - 1
ITUNES_ID3V22_PADDING_BYTES = 10_240
ULT_ENCODING_LANGUAGE_DESCRIPTION_BYTES = 5
ULT_TEXT_TERMINATOR_BYTES = 1


def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()


def path_label(path: Path) -> str:
    resolved = path.resolve()
    try:
        return resolved.relative_to(ROOT).as_posix()
    except ValueError:
        return resolved.name


def file_facts(path: Path, data: bytes) -> dict[str, Any]:
    return {"path": path_label(path), "bytes": len(data), "sha256": sha256_bytes(data)}


def decode_synchsafe32(value: bytes) -> int:
    if len(value) != 4:
        raise ValueError("synchsafe integer must contain exactly four bytes")
    if any(byte & 0x80 for byte in value):
        raise ValueError("synchsafe integer contains a high bit")
    return (value[0] << 21) | (value[1] << 14) | (value[2] << 7) | value[3]


def decode_be24(value: bytes) -> int:
    if len(value) != 3:
        raise ValueError("24-bit integer must contain exactly three bytes")
    return int.from_bytes(value, "big")


def _find_utf16_terminator(value: bytes, label: str) -> int:
    if len(value) < 4 or value[:2] not in {b"\xff\xfe", b"\xfe\xff"}:
        raise ValueError(f"{label} lacks a UTF-16 byte-order mark")
    for offset in range(2, len(value) - 1, 2):
        if value[offset : offset + 2] == b"\x00\x00":
            return offset
    raise ValueError(f"{label} has no aligned UTF-16 terminator")


def _decode_utf16_storage(value: bytes, label: str) -> dict[str, Any]:
    if len(value) < 4 or value[:2] not in {b"\xff\xfe", b"\xfe\xff"}:
        raise ValueError(f"{label} lacks a UTF-16 byte-order mark")
    terminator_bytes = 2 if value.endswith(b"\x00\x00") else 0
    encoded = value[:-2] if terminator_bytes else value
    if len(encoded) % 2:
        raise ValueError(f"{label} has an odd UTF-16 byte count")
    try:
        text = encoded.decode("utf-16")
    except UnicodeDecodeError as exc:
        raise ValueError(f"{label} is not valid UTF-16") from exc
    if "\x00" in text:
        raise ValueError(f"{label} contains an embedded terminator")
    return {
        "text": text,
        "content_bytes": len(encoded) - 2,
        "storage_bytes": len(value),
        "terminator_bytes": terminator_bytes,
        "bom_hex": value[:2].hex(),
    }


def parse_ult(payload: bytes) -> dict[str, Any]:
    if len(payload) < 5:
        raise ValueError("ULT payload is too short")
    encoding = payload[0]
    try:
        language = payload[1:4].decode("ascii")
    except UnicodeDecodeError as exc:
        raise ValueError("ULT language is not ASCII") from exc

    if encoding == 0:
        terminator = payload.find(b"\x00", 4)
        if terminator < 0:
            raise ValueError("ULT description has no terminator")
        description_bytes = payload[4:terminator]
        stored_text = payload[terminator + 1 :]
        text_terminator_bytes = 1 if stored_text.endswith(b"\x00") else 0
        text_bytes = stored_text[:-1] if text_terminator_bytes else stored_text
        if b"\x00" in text_bytes:
            raise ValueError("ULT text contains an embedded terminator")
        description = description_bytes.decode("latin-1")
        text = text_bytes.decode("latin-1")
        details: dict[str, Any] = {
            "encoding_name": "ISO-8859-1",
            "description": description,
            "description_bytes": len(description_bytes),
            "description_storage_bytes": len(description_bytes) + 1,
            "description_terminator_bytes": 1,
            "text": text,
            "text_bytes": len(text_bytes),
            "text_storage_bytes": len(stored_text),
            "text_terminator_bytes": text_terminator_bytes,
        }
    elif encoding == 1:
        tail = payload[4:]
        description_terminator = _find_utf16_terminator(tail, "ULT description")
        description_storage = tail[: description_terminator + 2]
        text_storage = tail[description_terminator + 2 :]
        description_info = _decode_utf16_storage(description_storage, "ULT description")
        text_info = _decode_utf16_storage(text_storage, "ULT text")
        description = description_info.pop("text")
        text = text_info.pop("text")
        details = {
            "encoding_name": "UTF-16 with BOM",
            "description": description,
            "description_bytes": description_info.pop("content_bytes"),
            "description_storage_bytes": description_info.pop("storage_bytes"),
            "description_terminator_bytes": description_info.pop("terminator_bytes"),
            "description_bom_hex": description_info.pop("bom_hex"),
            "text": text,
            "text_bytes": text_info.pop("content_bytes"),
            "text_storage_bytes": text_info.pop("storage_bytes"),
            "text_terminator_bytes": text_info.pop("terminator_bytes"),
            "text_bom_hex": text_info.pop("bom_hex"),
        }
        if description_info or text_info:
            raise AssertionError("unreported UTF-16 parse metadata")
    else:
        raise ValueError(f"unsupported ULT text encoding: {encoding}")

    details.update({
        "encoding": encoding,
        "language": language,
        "text_characters": len(text),
        "text_utf8_bytes": len(text.encode("utf-8")),
        "text_sha256": sha256_bytes(text.encode("utf-8")),
        "payload_hex": payload.hex(),
    })
    return details


def parse_id3v22(data: bytes) -> dict[str, Any]:
    if len(data) < 10:
        raise ValueError("input is shorter than an ID3 header")
    if data[:3] != b"ID3":
        raise ValueError("input does not begin with ID3")
    major, revision, flags = data[3], data[4], data[5]
    if major != 2:
        raise ValueError(f"expected ID3v2.2, got major version {major}")
    if flags != 0:
        raise ValueError(f"unsupported ID3v2.2 flags: 0x{flags:02x}")
    payload_bytes = decode_synchsafe32(data[6:10])
    audio_offset = 10 + payload_bytes
    if audio_offset > len(data):
        raise ValueError("declared ID3 payload exceeds the file")

    frames: list[dict[str, Any]] = []
    position = 10
    padding_bytes = 0
    while position < audio_offset:
        remaining = data[position:audio_offset]
        if remaining[0] == 0:
            if any(remaining):
                raise ValueError("ID3 padding contains a nonzero byte")
            padding_bytes = len(remaining)
            position = audio_offset
            break
        if len(remaining) < 6:
            raise ValueError("truncated ID3v2.2 frame header")
        raw_id = remaining[:3]
        if FRAME_ID.fullmatch(raw_id) is None:
            raise ValueError(f"invalid ID3v2.2 frame identifier: {raw_id!r}")
        frame_size = decode_be24(remaining[3:6])
        if frame_size <= 0:
            raise ValueError("zero-length ID3v2.2 frame is unsupported")
        payload_start = position + 6
        payload_end = payload_start + frame_size
        if payload_end > audio_offset:
            raise ValueError("ID3v2.2 frame exceeds the declared tag payload")
        payload = data[payload_start:payload_end]
        frame_id = raw_id.decode("ascii")
        frame: dict[str, Any] = {
            "id": frame_id,
            "header_offset": position,
            "payload_offset": payload_start,
            "payload_bytes": frame_size,
            "payload_sha256": sha256_bytes(payload),
        }
        if frame_id == "ULT":
            frame["unsynchronized_lyrics"] = parse_ult(payload)
        frames.append(frame)
        position = payload_end

    if position != audio_offset:
        raise ValueError("ID3 parser did not consume the declared payload")
    return {
        "identifier": "ID3",
        "major_version": major,
        "revision": revision,
        "flags": flags,
        "synchsafe_size_bytes_hex": data[6:10].hex(),
        "payload_bytes": payload_bytes,
        "header_bytes": 10,
        "audio_offset": audio_offset,
        "frames": frames,
        "padding_bytes": padding_bytes,
        "prefix_sha256": sha256_bytes(data[:audio_offset]),
    }



def generated_ascii_chunks(length: int, *, chunk_size: int = 1 << 20):
    """Yield the deterministic harness value without materializing it in a report."""
    if type(length) is not int or not GENERATED_ASCII_MIN_CHARACTERS <= length <= GENERATED_ASCII_MAX_CHARACTERS:
        raise ValueError("generated ASCII length is outside the bounded range")
    if type(chunk_size) is not int or chunk_size <= 0:
        raise ValueError("generated ASCII chunk size must be positive")

    prefix = f"L{length:09d}:".encode("ascii")
    if len(prefix) >= length:
        raise ValueError("generated ASCII prefix leaves no patterned body")
    yield prefix

    remaining = length - len(prefix)
    alphabet_offset = 0
    alphabet_bytes = len(GENERATED_ASCII_ALPHABET)
    while remaining:
        take = min(remaining, chunk_size)
        repeats = (alphabet_offset + take + alphabet_bytes - 1) // alphabet_bytes
        chunk = (GENERATED_ASCII_ALPHABET * repeats)[alphabet_offset : alphabet_offset + take]
        if len(chunk) != take:
            raise AssertionError("generated ASCII chunk has the wrong length")
        yield chunk
        remaining -= take
        alphabet_offset = (alphabet_offset + take) % alphabet_bytes


def generated_ascii_fingerprint(length: int) -> dict[str, Any]:
    digest = hashlib.sha256()
    first = bytearray()
    last = bytearray()
    edge = 32
    observed_bytes = 0
    for chunk in generated_ascii_chunks(length):
        digest.update(chunk)
        observed_bytes += len(chunk)
        if len(first) < edge:
            first.extend(chunk[: edge - len(first)])
        last.extend(chunk)
        if len(last) > edge:
            del last[:-edge]
    if observed_bytes != length:
        raise AssertionError("generated ASCII fingerprint length mismatch")
    return {
        "kind": "utf8-string-sha256-v1",
        "characters": length,
        "utf8_bytes": length,
        "sha256": digest.hexdigest(),
        "prefix": bytes(first).decode("ascii"),
        "suffix": bytes(last).decode("ascii"),
        "contains_nul": False,
    }


def classify_id3v22_frame_size(actual_payload_bytes: int, stored_payload_bytes: int) -> dict[str, Any]:
    """Classify a stored unsigned-24-bit size without accepting truncation as valid."""
    if type(actual_payload_bytes) is not int or actual_payload_bytes <= 0:
        raise ValueError("actual frame payload size must be a positive integer")
    if type(stored_payload_bytes) is not int or not 0 <= stored_payload_bytes <= ID3V22_MAX_FRAME_PAYLOAD_BYTES:
        raise ValueError("stored frame payload size is outside unsigned-24-bit range")

    modulo_remainder = actual_payload_bytes % ID3V22_FRAME_SIZE_MODULUS
    wrap_count = actual_payload_bytes // ID3V22_FRAME_SIZE_MODULUS
    if actual_payload_bytes <= ID3V22_MAX_FRAME_PAYLOAD_BYTES:
        if stored_payload_bytes != actual_payload_bytes:
            raise ValueError("stored ID3v2.2 frame size does not equal the representable payload size")
        boundary = (
            "maximum_representable_unsigned_24bit_payload"
            if actual_payload_bytes == ID3V22_MAX_FRAME_PAYLOAD_BYTES
            else "within_unsigned_24bit_payload_range"
        )
        relation = "exact_unsigned_24bit_value"
        specification_conformant = True
    else:
        if stored_payload_bytes != modulo_remainder:
            raise ValueError("stored ID3v2.2 frame size is neither exact nor the observed modulo-2^24 wrap")
        boundary = (
            "first_nonrepresentable_unsigned_24bit_payload"
            if actual_payload_bytes == ID3V22_FRAME_SIZE_MODULUS
            else "beyond_unsigned_24bit_payload_range"
        )
        relation = "wrapped_modulo_2^24"
        specification_conformant = False

    return {
        "field_bits": ID3V22_FRAME_SIZE_BITS,
        "field_maximum": ID3V22_MAX_FRAME_PAYLOAD_BYTES,
        "field_modulus": ID3V22_FRAME_SIZE_MODULUS,
        "actual_payload_bytes": actual_payload_bytes,
        "stored_payload_bytes": stored_payload_bytes,
        "stored_payload_hex": f"{stored_payload_bytes:06x}",
        "modulo_remainder": modulo_remainder,
        "wrap_count": wrap_count,
        "relation": relation,
        "boundary": boundary,
        "specification_conformant": specification_conformant,
        "classification": (
            "conforming_id3v22_frame_size"
            if specification_conformant
            else "frame_size_wrap_nonconformant_id3v22_tag"
        ),
    }


def _trailing_zero_count(value: bytes) -> int:
    return len(value) - len(value.rstrip(b"\x00"))


def analyze_generated_ascii_lyrics_boundary(
    original_path: Path,
    rewritten_path: Path,
    *,
    requested_characters: int,
    expected_padding_bytes: int = ITUNES_ID3V22_PADDING_BYTES,
) -> dict[str, Any]:
    """Verify the exact retained iTunes ID3v2.2 ULT ceiling/overflow shape.

    Unlike ``parse_id3v22``, this evidence-specific analyzer can account for a
    payload whose stored 24-bit frame size wrapped.  It never treats that output
    as a valid generic ID3 tag: the ordinary parser is required to reject the
    nonconformant form.
    """
    if type(expected_padding_bytes) is not int or expected_padding_bytes < 0:
        raise ValueError("expected padding size must be a nonnegative integer")

    original = original_path.read_bytes()
    rewritten = rewritten_path.read_bytes()
    if original.startswith(b"ID3"):
        raise ValueError("original evidence unexpectedly begins with ID3")
    if len(rewritten) < 16:
        raise ValueError("rewritten evidence is too short for ID3v2.2 plus one frame")
    if rewritten[:3] != b"ID3":
        raise ValueError("rewritten evidence does not begin with ID3")
    major, revision, flags = rewritten[3], rewritten[4], rewritten[5]
    if (major, revision) != (2, 0):
        raise ValueError(f"expected ID3v2.2.0, got ID3v2.{major}.{revision}")
    if flags != 0:
        raise ValueError(f"unsupported ID3v2.2 flags: 0x{flags:02x}")

    tag_payload_bytes = decode_synchsafe32(rewritten[6:10])
    audio_offset = 10 + tag_payload_bytes
    if audio_offset > len(rewritten):
        raise ValueError("declared ID3 payload exceeds the rewritten file")

    actual_frame_payload_bytes = (
        ULT_ENCODING_LANGUAGE_DESCRIPTION_BYTES
        + requested_characters
        + ULT_TEXT_TERMINATOR_BYTES
    )
    expected_tag_payload_bytes = 6 + actual_frame_payload_bytes + expected_padding_bytes
    if tag_payload_bytes != expected_tag_payload_bytes:
        raise ValueError(
            "declared ID3 payload does not equal ULT header + requested payload + fixed padding"
        )
    if rewritten[10:13] != b"ULT":
        raise ValueError("first ID3v2.2 frame is not ULT")

    stored_frame_payload_bytes = decode_be24(rewritten[13:16])
    size_classification = classify_id3v22_frame_size(
        actual_frame_payload_bytes,
        stored_frame_payload_bytes,
    )

    payload_start = 16
    text_start = payload_start + ULT_ENCODING_LANGUAGE_DESCRIPTION_BYTES
    text_end = text_start + requested_characters
    payload_end = payload_start + actual_frame_payload_bytes
    if payload_end != text_end + ULT_TEXT_TERMINATOR_BYTES:
        raise AssertionError("ULT payload boundary calculation is inconsistent")
    if payload_end + expected_padding_bytes != audio_offset:
        raise ValueError("calculated ULT payload and padding do not reach the declared audio offset")
    if rewritten[payload_start:text_start] != b"\x00eng\x00":
        raise ValueError("ULT does not use encoding 0, language eng, and an empty description")
    if rewritten[text_end:payload_end] != b"\x00":
        raise ValueError("ULT generated text does not have exactly one trailing terminator")

    padding = rewritten[payload_end:audio_offset]
    if len(padding) != expected_padding_bytes or any(padding):
        raise ValueError("ID3v2.2 padding is not the expected all-zero fixed region")
    trailing_zero_bytes = _trailing_zero_count(rewritten[10:audio_offset])
    if trailing_zero_bytes != expected_padding_bytes + ULT_TEXT_TERMINATOR_BYTES:
        raise ValueError("tag trailing-zero count does not equal text terminator plus fixed padding")

    requested_fingerprint = generated_ascii_fingerprint(requested_characters)
    observed_digest = hashlib.sha256()
    cursor = text_start
    compared = 0
    for expected_chunk in generated_ascii_chunks(requested_characters):
        observed_chunk = rewritten[cursor : cursor + len(expected_chunk)]
        if observed_chunk != expected_chunk:
            mismatch = next(
                (index for index, pair in enumerate(zip(observed_chunk, expected_chunk)) if pair[0] != pair[1]),
                min(len(observed_chunk), len(expected_chunk)),
            )
            raise ValueError(f"generated ULT text differs at byte offset {compared + mismatch}")
        observed_digest.update(observed_chunk)
        cursor += len(expected_chunk)
        compared += len(expected_chunk)
    if cursor != text_end or compared != requested_characters:
        raise AssertionError("generated ULT text comparison ended at the wrong boundary")

    observed_fingerprint = {
        "kind": "utf8-string-sha256-v1",
        "characters": requested_characters,
        "utf8_bytes": requested_characters,
        "sha256": observed_digest.hexdigest(),
        "prefix": rewritten[text_start : text_start + 32].decode("ascii"),
        "suffix": rewritten[text_end - 32 : text_end].decode("ascii"),
        "contains_nul": False,
    }
    if observed_fingerprint != requested_fingerprint:
        raise ValueError("observed generated text fingerprint differs from the requested fingerprint")

    rewritten_tail = rewritten[audio_offset:]
    if rewritten_tail != original:
        raise ValueError("rewritten MPEG audio tail differs from the complete original file")
    size_delta = len(rewritten) - len(original)
    if size_delta != audio_offset:
        raise ValueError("file-size delta does not equal the complete ID3 prefix")

    strict_parser_probe: dict[str, Any]
    if size_classification["specification_conformant"]:
        strict_parser_probe = {
            "performed": False,
            "expected_result": "accept",
            "reason": "specialized analyzer avoids materializing multi-megabyte lyrics in the generic report",
        }
    else:
        try:
            parse_id3v22(rewritten)
        except ValueError as exc:
            strict_parser_probe = {
                "performed": True,
                "expected_result": "reject",
                "result": "rejected",
                "error": str(exc),
            }
        else:
            raise ValueError("ordinary strict ID3v2.2 parser accepted nonconformant wrapped output")

    tag_conformant = bool(size_classification["specification_conformant"])
    return {
        "schema": "windows-itunes-itl.mp3-generated-lyrics-boundary-analysis.v1",
        "scope": (
            "one retained deterministic ASCII MP3/ID3v2.2/ULT/COM case on the pinned build; "
            "not a universal Lyrics, UI, Unicode, media-format, tag-version, or iTunes-version limit"
        ),
        "original": file_facts(original_path, original),
        "rewritten": file_facts(rewritten_path, rewritten),
        "requested_generated_ascii": requested_fingerprint,
        "id3v22": {
            "identifier": "ID3",
            "major_version": major,
            "revision": revision,
            "flags": flags,
            "synchsafe_size_bytes_hex": rewritten[6:10].hex(),
            "payload_bytes": tag_payload_bytes,
            "header_bytes": 10,
            "audio_offset": audio_offset,
            "padding_bytes": expected_padding_bytes,
            "trailing_zero_bytes": trailing_zero_bytes,
            "prefix_sha256": sha256_bytes(rewritten[:audio_offset]),
            "specification_conformant": tag_conformant,
        },
        "ult": {
            "frame_id": "ULT",
            "frame_header_offset": 10,
            "payload_offset": payload_start,
            "stored_payload_bytes": stored_frame_payload_bytes,
            "actual_payload_bytes": actual_frame_payload_bytes,
            "encoding": 0,
            "encoding_name": "ISO-8859-1",
            "language": "eng",
            "description": "",
            "description_storage_bytes": 1,
            "text": observed_fingerprint,
            "text_terminator_bytes": ULT_TEXT_TERMINATOR_BYTES,
            "payload_sha256": sha256_bytes(rewritten[payload_start:payload_end]),
        },
        "frame_size_boundary": size_classification,
        "ordinary_strict_parser_probe": strict_parser_probe,
        "audio_tail": {
            "offset": audio_offset,
            "bytes": len(rewritten_tail),
            "sha256": sha256_bytes(rewritten_tail),
            "original_bytes": len(original),
            "original_sha256": sha256_bytes(original),
            "byte_identical_to_complete_original": True,
        },
        "assertions": {
            "original_has_no_leading_id3": True,
            "rewritten_has_id3v22_0": True,
            "ult_is_first_and_only_nonpadding_frame": True,
            "ult_encoding_zero_language_eng_empty_description": True,
            "requested_text_byte_exact": True,
            "requested_text_fingerprint_exact": True,
            "text_terminator_bytes": ULT_TEXT_TERMINATOR_BYTES,
            "fixed_zero_padding_bytes": expected_padding_bytes,
            "size_delta_bytes": size_delta,
            "size_delta_equals_id3_prefix": True,
            "mpeg_audio_tail_byte_identical": True,
            "tag_specification_conformant": tag_conformant,
        },
        "analysis_passed": True,
    }

def compare_rewrite(
    original_path: Path,
    rewritten_path: Path,
    *,
    expected_lyrics: str | None = None,
) -> dict[str, Any]:
    original = original_path.read_bytes()
    rewritten = rewritten_path.read_bytes()
    if original.startswith(b"ID3"):
        raise ValueError("original evidence unexpectedly begins with ID3")
    tag = parse_id3v22(rewritten)
    audio_offset = int(tag["audio_offset"])
    rewritten_tail = rewritten[audio_offset:]
    tail_equal = rewritten_tail == original
    if not tail_equal:
        raise ValueError("rewritten MPEG audio tail differs from the original file")
    delta = len(rewritten) - len(original)
    if delta != audio_offset:
        raise ValueError("file-size delta does not equal the complete ID3 prefix")

    lyrics_frames = [frame for frame in tag["frames"] if frame["id"] == "ULT"]
    if expected_lyrics is not None:
        if len(lyrics_frames) != 1:
            raise ValueError(f"expected exactly one ULT frame, got {len(lyrics_frames)}")
        observed = lyrics_frames[0]["unsynchronized_lyrics"]["text"]
        if observed != expected_lyrics:
            raise ValueError(f"ULT text mismatch: {observed!r} != {expected_lyrics!r}")

    return {
        "schema": "windows-itunes-itl.mp3-id3v22-rewrite-analysis.v1",
        "scope": "one exact retained native MP3 pair; no generic tag-writing or iTunes-version claim",
        "original": file_facts(original_path, original),
        "rewritten": file_facts(rewritten_path, rewritten),
        "id3v22": tag,
        "audio_tail": {
            "offset": audio_offset,
            "bytes": len(rewritten_tail),
            "sha256": sha256_bytes(rewritten_tail),
            "original_bytes": len(original),
            "original_sha256": sha256_bytes(original),
            "byte_identical_to_original": True,
        },
        "assertions": {
            "original_has_no_leading_id3": True,
            "rewritten_has_strict_id3v22": True,
            "size_delta_bytes": delta,
            "size_delta_equals_id3_prefix": True,
            "mpeg_audio_tail_byte_identical": True,
            "expected_lyrics": expected_lyrics,
            "expected_lyrics_exact": expected_lyrics is None or lyrics_frames[0]["unsynchronized_lyrics"]["text"] == expected_lyrics,
        },
        "analysis_passed": True,
    }


def write_json(path: Path, value: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8", newline="\n")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--original", type=Path, required=True)
    parser.add_argument("--rewritten", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--expect-lyrics")
    parser.add_argument(
        "--generated-ascii-characters",
        type=int,
        help="analyze the deterministic generated-ASCII ULT boundary shape",
    )
    args = parser.parse_args(argv)
    if args.generated_ascii_characters is not None:
        if args.expect_lyrics is not None:
            parser.error("--expect-lyrics and --generated-ascii-characters are mutually exclusive")
        report = analyze_generated_ascii_lyrics_boundary(
            args.original,
            args.rewritten,
            requested_characters=args.generated_ascii_characters,
        )
    else:
        report = compare_rewrite(args.original, args.rewritten, expected_lyrics=args.expect_lyrics)
    write_json(args.output, report)
    print(json.dumps({
        "output": path_label(args.output),
        "schema": report["schema"],
        "analysis_passed": True,
        "audio_tail_sha256": report["audio_tail"]["sha256"],
    }))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
