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


def parse_ult(payload: bytes) -> dict[str, Any]:
    if len(payload) < 5:
        raise ValueError("ULT payload is too short")
    encoding = payload[0]
    if encoding != 0:
        raise ValueError(f"unsupported ULT text encoding: {encoding}")
    try:
        language = payload[1:4].decode("ascii")
    except UnicodeDecodeError as exc:
        raise ValueError("ULT language is not ASCII") from exc
    terminator = payload.find(b"\x00", 4)
    if terminator < 0:
        raise ValueError("ULT description has no terminator")
    description_bytes = payload[4:terminator]
    stored_text = payload[terminator + 1 :]
    text_terminator_bytes = 1 if stored_text.endswith(b"\x00") else 0
    text_bytes = stored_text[:-1] if text_terminator_bytes else stored_text
    if b"\x00" in text_bytes:
        raise ValueError("ULT text contains an embedded terminator")
    try:
        description = description_bytes.decode("latin-1")
        text = text_bytes.decode("latin-1")
    except UnicodeDecodeError as exc:  # pragma: no cover - latin-1 is total
        raise ValueError("ULT text is not decodable") from exc
    return {
        "encoding": encoding,
        "encoding_name": "ISO-8859-1",
        "language": language,
        "description": description,
        "description_bytes": len(description_bytes),
        "text": text,
        "text_bytes": len(text_bytes),
        "text_storage_bytes": len(stored_text),
        "text_terminator_bytes": text_terminator_bytes,
        "payload_hex": payload.hex(),
    }


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
    args = parser.parse_args(argv)
    report = compare_rewrite(args.original, args.rewritten, expected_lyrics=args.expect_lyrics)
    write_json(args.output, report)
    print(json.dumps({"output": path_label(args.output), "analysis_passed": True, "audio_tail_sha256": report["audio_tail"]["sha256"]}))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
