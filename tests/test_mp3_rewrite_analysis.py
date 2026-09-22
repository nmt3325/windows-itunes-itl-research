"""Offline fail-closed tests for the retained MP3 ID3v2.2 comparison."""
from __future__ import annotations

from pathlib import Path

import pytest

from scripts.research import analyze_mp3_rewrite as analyzer


def synchsafe(value: int) -> bytes:
    if not 0 <= value < (1 << 28):
        raise ValueError(value)
    return bytes(((value >> 21) & 0x7F, (value >> 14) & 0x7F, (value >> 7) & 0x7F, value & 0x7F))


def tagged(lyrics: str = "hello", *, padding: bytes = b"\x00" * 7) -> tuple[bytes, bytes]:
    audio = b"\xff\xfb\x90\x64synthetic-audio"
    payload = b"\x00eng\x00" + lyrics.encode("latin-1") + b"\x00"
    frame = b"ULT" + len(payload).to_bytes(3, "big") + payload
    tag_payload = frame + padding
    return audio, b"ID3\x02\x00\x00" + synchsafe(len(tag_payload)) + tag_payload + audio


def tagged_utf16(lyrics: str, *, padding: bytes = b"\x00" * 7) -> tuple[bytes, bytes, bytes]:
    audio = b"\xff\xfb\x90\x64synthetic-audio"
    description_storage = b"\xff\xfe\x00\x00"
    text_storage = b"\xff\xfe" + lyrics.encode("utf-16-le") + b"\x00\x00"
    payload = b"\x01eng" + description_storage + text_storage
    frame = b"ULT" + len(payload).to_bytes(3, "big") + payload
    tag_payload = frame + padding
    rewritten = b"ID3\x02\x00\x00" + synchsafe(len(tag_payload)) + tag_payload + audio
    return audio, rewritten, payload


def generated_boundary_tag(
    length: int,
    *,
    stored_payload_bytes: int | None = None,
    padding_bytes: int = analyzer.ITUNES_ID3V22_PADDING_BYTES,
) -> tuple[bytes, bytes]:
    audio = b"\xff\xfb\x90\x64synthetic-generated-audio"
    generated = b"".join(analyzer.generated_ascii_chunks(length))
    payload = b"\x00eng\x00" + generated + b"\x00"
    if stored_payload_bytes is None:
        stored_payload_bytes = len(payload) % analyzer.ID3V22_FRAME_SIZE_MODULUS
    frame = b"ULT" + stored_payload_bytes.to_bytes(3, "big") + payload
    tag_payload = frame + (b"\x00" * padding_bytes)
    rewritten = b"ID3\x02\x00\x00" + synchsafe(len(tag_payload)) + tag_payload + audio
    return audio, rewritten


def test_synchsafe32_decodes_and_rejects_high_bits() -> None:
    assert analyzer.decode_synchsafe32(bytes.fromhex("00005027")) == 10279
    with pytest.raises(ValueError, match="high bit"):
        analyzer.decode_synchsafe32(b"\x80\x00\x00\x00")
    with pytest.raises(ValueError, match="exactly four"):
        analyzer.decode_synchsafe32(b"\x00\x00\x00")


def test_parse_exact_ult_and_padding() -> None:
    _, rewritten = tagged("Plain ASCII lyrics line one")
    parsed = analyzer.parse_id3v22(rewritten)
    assert parsed["major_version"] == 2
    assert parsed["revision"] == 0
    assert parsed["flags"] == 0
    assert parsed["padding_bytes"] == 7
    assert len(parsed["frames"]) == 1
    lyrics = parsed["frames"][0]["unsynchronized_lyrics"]
    assert lyrics == {
        "encoding": 0,
        "encoding_name": "ISO-8859-1",
        "language": "eng",
        "description": "",
        "description_bytes": 0,
        "description_storage_bytes": 1,
        "description_terminator_bytes": 1,
        "text": "Plain ASCII lyrics line one",
        "text_bytes": 27,
        "text_storage_bytes": 28,
        "text_terminator_bytes": 1,
        "text_characters": 27,
        "text_utf8_bytes": 27,
        "text_sha256": "889404d34e082e8dcede882a5cc7a09cd4c9d1f8fd52c9629c632a5c0f6fd52f",
        "payload_hex": (b"\x00eng\x00Plain ASCII lyrics line one\x00").hex(),
    }


def test_parse_exact_utf16_ult() -> None:
    value = "Line one — 第二行 🎤"
    _, rewritten, payload = tagged_utf16(value)
    parsed = analyzer.parse_id3v22(rewritten)
    lyrics = parsed["frames"][0]["unsynchronized_lyrics"]
    assert lyrics == {
        "encoding": 1,
        "encoding_name": "UTF-16 with BOM",
        "language": "eng",
        "description": "",
        "description_bytes": 0,
        "description_storage_bytes": 4,
        "description_terminator_bytes": 2,
        "description_bom_hex": "fffe",
        "text": value,
        "text_bytes": 34,
        "text_storage_bytes": 38,
        "text_terminator_bytes": 2,
        "text_bom_hex": "fffe",
        "text_characters": 16,
        "text_utf8_bytes": 27,
        "text_sha256": analyzer.sha256_bytes(value.encode("utf-8")),
        "payload_hex": payload.hex(),
    }


def test_compare_rewrite_proves_byte_identical_audio_tail(tmp_path: Path) -> None:
    original, rewritten = tagged()
    original_path = tmp_path / "original.mp3"
    rewritten_path = tmp_path / "rewritten.mp3"
    original_path.write_bytes(original)
    rewritten_path.write_bytes(rewritten)
    report = analyzer.compare_rewrite(original_path, rewritten_path, expected_lyrics="hello")
    assert report["analysis_passed"] is True
    assert report["audio_tail"]["byte_identical_to_original"] is True
    assert report["audio_tail"]["sha256"] == analyzer.sha256_bytes(original)
    assert report["assertions"]["size_delta_bytes"] == report["id3v22"]["audio_offset"]


def test_compare_rewrite_rejects_changed_audio_tail(tmp_path: Path) -> None:
    original, rewritten = tagged()
    original_path = tmp_path / "original.mp3"
    rewritten_path = tmp_path / "rewritten.mp3"
    original_path.write_bytes(original)
    rewritten_path.write_bytes(rewritten[:-1] + bytes([rewritten[-1] ^ 1]))
    with pytest.raises(ValueError, match="audio tail differs"):
        analyzer.compare_rewrite(original_path, rewritten_path)


def test_parser_rejects_nonzero_padding() -> None:
    _, rewritten = tagged(padding=b"\x00\x00\x01")
    with pytest.raises(ValueError, match="padding contains"):
        analyzer.parse_id3v22(rewritten)


def test_parser_rejects_unsupported_version_and_flags() -> None:
    _, rewritten = tagged()
    wrong_version = rewritten[:3] + b"\x03" + rewritten[4:]
    with pytest.raises(ValueError, match="expected ID3v2.2"):
        analyzer.parse_id3v22(wrong_version)
    wrong_flags = rewritten[:5] + b"\x40" + rewritten[6:]
    with pytest.raises(ValueError, match="unsupported ID3v2.2 flags"):
        analyzer.parse_id3v22(wrong_flags)


def test_parser_rejects_truncated_declared_payload() -> None:
    _, rewritten = tagged()
    truncated = rewritten[:6] + synchsafe(len(rewritten) + 100) + rewritten[10:]
    with pytest.raises(ValueError, match="declared ID3 payload exceeds"):
        analyzer.parse_id3v22(truncated)


def test_expected_lyrics_is_exact(tmp_path: Path) -> None:
    original, rewritten = tagged("actual")
    original_path = tmp_path / "original.mp3"
    rewritten_path = tmp_path / "rewritten.mp3"
    original_path.write_bytes(original)
    rewritten_path.write_bytes(rewritten)
    with pytest.raises(ValueError, match="ULT text mismatch"):
        analyzer.compare_rewrite(original_path, rewritten_path, expected_lyrics="expected")


def test_generated_ascii_boundary_fingerprints_match_retained_requests() -> None:
    expected = {
        16_777_209: "e014850d61cb17e7b2c644971184c3ebabdfc49bbfc69246d24984d5eee5f090",
        16_777_210: "370d1110817ccfc7f4de9d804719d8cd3d3eff7dd1476b01cc34f78875396f9f",
    }
    for length, digest in expected.items():
        fingerprint = analyzer.generated_ascii_fingerprint(length)
        assert fingerprint["characters"] == length
        assert fingerprint["utf8_bytes"] == length
        assert fingerprint["sha256"] == digest
        assert fingerprint["contains_nul"] is False


def test_frame_size_classifier_marks_exact_maximum_and_first_wrap() -> None:
    maximum = analyzer.classify_id3v22_frame_size(0xFFFFFF, 0xFFFFFF)
    assert maximum["boundary"] == "maximum_representable_unsigned_24bit_payload"
    assert maximum["relation"] == "exact_unsigned_24bit_value"
    assert maximum["specification_conformant"] is True

    first_wrap = analyzer.classify_id3v22_frame_size(0x1000000, 0)
    assert first_wrap["boundary"] == "first_nonrepresentable_unsigned_24bit_payload"
    assert first_wrap["relation"] == "wrapped_modulo_2^24"
    assert first_wrap["classification"] == "frame_size_wrap_nonconformant_id3v22_tag"
    assert first_wrap["specification_conformant"] is False

    larger_wrap = analyzer.classify_id3v22_frame_size(17_000_006, 222_790)
    assert larger_wrap["modulo_remainder"] == 222_790
    with pytest.raises(ValueError, match="neither exact nor"):
        analyzer.classify_id3v22_frame_size(17_000_006, 222_791)


def test_generated_ascii_boundary_analyzer_accepts_exact_shape(tmp_path: Path) -> None:
    original, rewritten = generated_boundary_tag(64)
    original_path = tmp_path / "original.mp3"
    rewritten_path = tmp_path / "rewritten.mp3"
    original_path.write_bytes(original)
    rewritten_path.write_bytes(rewritten)

    report = analyzer.analyze_generated_ascii_lyrics_boundary(
        original_path,
        rewritten_path,
        requested_characters=64,
    )
    assert report["analysis_passed"] is True
    assert report["frame_size_boundary"]["relation"] == "exact_unsigned_24bit_value"
    assert report["assertions"]["requested_text_byte_exact"] is True
    assert report["assertions"]["fixed_zero_padding_bytes"] == 10_240
    assert report["id3v22"]["trailing_zero_bytes"] == 10_241
    assert report["audio_tail"]["byte_identical_to_complete_original"] is True


def test_generated_ascii_boundary_analyzer_classifies_first_wrap_and_strict_rejection(
    tmp_path: Path,
) -> None:
    length = analyzer.ID3V22_MAX_FRAME_PAYLOAD_BYTES - 5
    assert length == 16_777_210
    original, rewritten = generated_boundary_tag(length)
    original_path = tmp_path / "original.mp3"
    rewritten_path = tmp_path / "rewritten.mp3"
    original_path.write_bytes(original)
    rewritten_path.write_bytes(rewritten)

    report = analyzer.analyze_generated_ascii_lyrics_boundary(
        original_path,
        rewritten_path,
        requested_characters=length,
    )
    boundary = report["frame_size_boundary"]
    assert boundary["actual_payload_bytes"] == 0x1000000
    assert boundary["stored_payload_bytes"] == 0
    assert boundary["boundary"] == "first_nonrepresentable_unsigned_24bit_payload"
    assert report["id3v22"]["specification_conformant"] is False
    assert report["ordinary_strict_parser_probe"]["result"] == "rejected"
    assert "zero-length" in report["ordinary_strict_parser_probe"]["error"]
    with pytest.raises(ValueError, match="zero-length"):
        analyzer.parse_id3v22(rewritten)


def test_generated_ascii_boundary_analyzer_rejects_wrong_size_or_text(tmp_path: Path) -> None:
    original, wrong_size = generated_boundary_tag(64, stored_payload_bytes=1)
    original_path = tmp_path / "original.mp3"
    rewritten_path = tmp_path / "rewritten.mp3"
    original_path.write_bytes(original)
    rewritten_path.write_bytes(wrong_size)
    with pytest.raises(ValueError, match="does not equal the representable"):
        analyzer.analyze_generated_ascii_lyrics_boundary(
            original_path,
            rewritten_path,
            requested_characters=64,
        )

    _, valid = generated_boundary_tag(64)
    corrupted = bytearray(valid)
    corrupted[21 + 20] ^= 1
    rewritten_path.write_bytes(corrupted)
    with pytest.raises(ValueError, match="generated ULT text differs"):
        analyzer.analyze_generated_ascii_lyrics_boundary(
            original_path,
            rewritten_path,
            requested_characters=64,
        )
