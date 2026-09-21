"""Independent, bounded reader for observed Windows iTunes ITL files.

This package intentionally does not import :mod:`itlkit`.  It is a small
reference implementation derived from the checked-in format notes and evidence.
It parses only explicit lengths/counts and never searches opaque bytes for tags.
"""
from __future__ import annotations

from dataclasses import dataclass
import hashlib
from pathlib import Path
from typing import Iterable, Iterator
import zlib

AES_KEY = b"BHUILuilfghuila3"
DEFAULT_MAX_PLAIN_BYTES = 512 * 1024 * 1024
MAX_RECORDS = 1_000_000
MAX_DEPTH = 32

SUPPORTED_PROFILES = {
    "12.13.10.3": {
        "semantic_read": True,
        "identity_write": True,
        "cross_version_write": False,
        "track_header_lengths": [756],
        "playlist_header_lengths": [3500],
    },
    "12.13.9.1": {
        "semantic_read": True,
        "identity_write": True,
        "cross_version_write": False,
        "track_header_lengths": [756],
        "playlist_header_lengths": [3500],
    },
}

SECTION_ROOTS: dict[int, tuple[bytes, str]] = {
    16: (b"mfdh", "fixed"),
    12: (b"mhgh", "count"),
    9: (b"mlah", "count"),
    11: (b"mlih", "count"),
    1: (b"mlth", "count"),
    13: (b"mlth", "count"),
    2: (b"mlph", "count"),
    14: (b"mlph", "count"),
    15: (b"mlrh", "fixed_children"),
    20: (b"mlqh", "mixed"),
    21: (b"mlsh", "count"),
}
RECURSIVE_TAGS = {b"mith", b"miph", b"miah", b"miih", b"miqh", b"mtph"}
TEXT_TYPES = {
    2: "name",
    3: "album",
    4: "artist",
    5: "genre",
    6: "kind",
    8: "comment",
    11: "url",
    12: "composer",
    13: "path",
    27: "album_artist",
    30: "sort_name",
    31: "sort_album",
    32: "sort_artist",
    33: "sort_album_artist",
    60: "purchaser_name",
    100: "playlist_name",
}


class ReferenceError(Exception):
    """Base class for deterministic reference-tool errors."""


class FormatError(ReferenceError):
    """The bytes violate a required envelope or record boundary."""


class UnsupportedError(ReferenceError):
    """The file is well framed but outside the implemented profile."""


def _need(data: bytes | bytearray, offset: int, width: int, label: str) -> None:
    if offset < 0 or width < 0 or offset + width > len(data):
        raise FormatError(f"truncated {label} at 0x{offset:x}")


def u16le(data: bytes | bytearray, offset: int) -> int:
    _need(data, offset, 2, "u16")
    return int.from_bytes(data[offset : offset + 2], "little")


def u32le(data: bytes | bytearray, offset: int) -> int:
    _need(data, offset, 4, "u32")
    return int.from_bytes(data[offset : offset + 4], "little")


def u64le(data: bytes | bytearray, offset: int) -> int:
    _need(data, offset, 8, "u64")
    return int.from_bytes(data[offset : offset + 8], "little")


def u32be(data: bytes | bytearray, offset: int) -> int:
    _need(data, offset, 4, "big-endian u32")
    return int.from_bytes(data[offset : offset + 4], "big")


def u64be(data: bytes | bytearray, offset: int) -> int:
    _need(data, offset, 8, "big-endian u64")
    return int.from_bytes(data[offset : offset + 8], "big")


def hex_pid(value: int | None) -> str | None:
    return None if value is None else f"{value:016X}"


@dataclass(frozen=True)
class Envelope:
    raw: bytes
    header: bytes
    payload: bytes
    trailer: bytes
    version: str
    encryption_flag: int
    compression_flag: int
    payload_byteorder: str
    max_crypt_size: int

    @property
    def file_persistent_id(self) -> int:
        return u64be(self.header, 0x34)

    @property
    def declared_counts(self) -> dict[str, int]:
        return {
            "sections": u32be(self.header, 0x30),
            "tracks": u32be(self.header, 0x44),
            "playlists": u32be(self.header, 0x48),
            "albums": u32be(self.header, 0x4C),
            "artists": u32be(self.header, 0x54),
        }

    @property
    def sha256(self) -> str:
        return hashlib.sha256(self.raw).hexdigest()


def _pascal_version(header: bytes) -> str:
    _need(header, 0x10, 1, "version length")
    size = header[0x10]
    if size > 31 or 0x11 + size > len(header):
        raise FormatError("invalid Pascal version string")
    try:
        return header[0x11 : 0x11 + size].decode("ascii", errors="strict")
    except UnicodeDecodeError as exc:
        raise FormatError("version string is not ASCII") from exc


def _crypt_length(body_length: int, cap: int, flag: int) -> int:
    if flag == 0:
        interval = 0
    elif flag == 1:
        interval = body_length
    elif flag == 2:
        interval = min(body_length, cap)
    else:
        raise UnsupportedError(f"unsupported encryption flag {flag}")
    return interval // 16 * 16


def decode_envelope_bytes(
    data: bytes, *, max_plain_bytes: int = DEFAULT_MAX_PLAIN_BYTES
) -> Envelope:
    """Decode the hdfm envelope with independent AES/zlib handling."""
    data = bytes(data)
    if type(max_plain_bytes) is not int or max_plain_bytes < 1:
        raise ValueError("max_plain_bytes must be a positive integer")
    if len(data) < 0x60 or data[:4] != b"hdfm":
        raise FormatError("expected hdfm envelope")
    header_length = u32be(data, 4)
    if header_length < 0x60 or header_length > len(data):
        raise FormatError("invalid outer header length")
    header = data[:header_length]
    if u32be(header, 4) != len(header):
        raise FormatError("outer header length does not match header bytes")
    if u32be(header, 8) != len(data):
        raise FormatError("declared file size does not match actual size")
    encryption_flag = header[0x41]
    compression_flag = header[0x43]
    max_crypt_size = u32be(header, 0x5C)
    body = data[header_length:]
    encrypted_length = _crypt_length(len(body), max_crypt_size, encryption_flag)
    if encrypted_length:
        try:
            from Crypto.Cipher import AES
        except ImportError as exc:  # pragma: no cover - dependency is declared
            raise UnsupportedError("PyCryptodome is required for encrypted ITL files") from exc
        body = (
            AES.new(AES_KEY, AES.MODE_ECB).decrypt(body[:encrypted_length])
            + body[encrypted_length:]
        )
    if compression_flag:
        inflater = zlib.decompressobj()
        try:
            payload = inflater.decompress(body, max_plain_bytes + 1)
        except zlib.error as exc:
            raise FormatError(f"invalid zlib stream: {exc}") from exc
        if len(payload) > max_plain_bytes or inflater.unconsumed_tail:
            raise FormatError("decompressed payload exceeds configured limit")
        if not inflater.eof:
            raise FormatError("truncated zlib stream")
        trailer = inflater.unused_data
    else:
        if len(body) > max_plain_bytes:
            raise FormatError("raw payload exceeds configured limit")
        payload, trailer = body, b""
    return Envelope(
        raw=data,
        header=header,
        payload=payload,
        trailer=trailer,
        version=_pascal_version(header),
        encryption_flag=encryption_flag,
        compression_flag=compression_flag,
        payload_byteorder="little" if header[0x52] else "big",
        max_crypt_size=max_crypt_size,
    )


def decode_envelope(path: str | Path, **kwargs) -> Envelope:
    return decode_envelope_bytes(Path(path).read_bytes(), **kwargs)


@dataclass(frozen=True)
class Record:
    tag: bytes
    offset: int
    header: bytes
    payload: bytes
    children: tuple["Record", ...]
    total_length: int
    path: str
    framing: str = "total"

    @property
    def header_length(self) -> int:
        return len(self.header)

    @property
    def raw(self) -> bytes:
        if self.children:
            return self.header + b"".join(child.raw for child in self.children)
        return self.header + self.payload

    def walk(self) -> Iterator["Record"]:
        yield self
        for child in self.children:
            yield from child.walk()

    def dump(self, *, include_header_hex: bool = False) -> dict:
        result = {
            "path": self.path,
            "tag": self.tag.decode("ascii", errors="replace"),
            "offset": self.offset,
            "header_length": self.header_length,
            "total_length": self.total_length,
            "framing": self.framing,
            "child_count": len(self.children),
            "raw_sha256": hashlib.sha256(self.raw).hexdigest(),
        }
        if self.tag == b"mhoh" and len(self.header) >= 16:
            result["type_code"] = u32le(self.header, 12)
        if include_header_hex:
            result["header_hex"] = self.header.hex()
        if self.children:
            result["children"] = [
                child.dump(include_header_hex=include_header_hex)
                for child in self.children
            ]
        else:
            result["payload_length"] = len(self.payload)
        return result


@dataclass(frozen=True)
class Section:
    section_type: int
    offset: int
    header: bytes
    total_length: int
    root: Record | None
    opaque_payload: bytes
    index: int

    @property
    def path(self) -> str:
        return f"section[{self.index}]/type[{self.section_type}]"

    @property
    def raw(self) -> bytes:
        return self.header + (self.root.raw if self.root else self.opaque_payload)

    def dump(self, *, include_header_hex: bool = False) -> dict:
        result = {
            "path": self.path,
            "tag": "msdh",
            "type": self.section_type,
            "offset": self.offset,
            "header_length": len(self.header),
            "total_length": self.total_length,
            "opaque": self.root is None,
            "raw_sha256": hashlib.sha256(self.raw).hexdigest(),
        }
        if include_header_hex:
            result["header_hex"] = self.header.hex()
        if self.root:
            result["root"] = self.root.dump(include_header_hex=include_header_hex)
        else:
            result["opaque_payload_length"] = len(self.opaque_payload)
        return result


def _prefix(data: bytes, offset: int, end: int) -> tuple[bytes, int, int]:
    if offset + 12 > end:
        raise FormatError(f"truncated record prefix at 0x{offset:x}")
    tag = data[offset : offset + 4]
    header_length = u32le(data, offset + 4)
    total_length = u32le(data, offset + 8)
    if header_length < 12 or offset + header_length > end:
        raise FormatError(f"invalid {tag!r} header length at 0x{offset + 4:x}")
    return tag, header_length, total_length


def _parse_sequence(
    data: bytes,
    start: int,
    end: int,
    *,
    path: str,
    depth: int = 0,
    fixed_tag: bytes | None = None,
    budget: list[int] | None = None,
) -> tuple[Record, ...]:
    if depth > MAX_DEPTH:
        raise FormatError("record nesting exceeds maximum depth")
    budget = budget if budget is not None else [MAX_RECORDS]
    result: list[Record] = []
    cursor = start
    index = 0
    while cursor < end:
        budget[0] -= 1
        if budget[0] < 0:
            raise FormatError("record count exceeds configured limit")
        tag, header_length, declared_total = _prefix(data, cursor, end)
        if fixed_tag is not None:
            if tag != fixed_tag:
                raise FormatError(
                    f"expected fixed {fixed_tag!r}, got {tag!r} at 0x{cursor:x}"
                )
            total_length = header_length
            framing = "fixed"
        else:
            total_length = declared_total
            framing = "total"
            if total_length < header_length or cursor + total_length > end:
                raise FormatError(
                    f"invalid {tag!r} total length at 0x{cursor + 8:x}"
                )
        header = data[cursor : cursor + header_length]
        record_path = f"{path}/{tag.decode('ascii', errors='replace')}[{index}]"
        body_start, record_end = cursor + header_length, cursor + total_length
        if tag in RECURSIVE_TAGS:
            children = _parse_sequence(
                data,
                body_start,
                record_end,
                path=record_path,
                depth=depth + 1,
                budget=budget,
            )
            payload = b""
        else:
            children = ()
            payload = data[body_start:record_end]
        result.append(
            Record(
                tag=tag,
                offset=cursor,
                header=header,
                payload=payload,
                children=children,
                total_length=total_length,
                path=record_path,
                framing=framing,
            )
        )
        cursor = record_end
        index += 1
    if cursor != end:
        raise FormatError(f"record sequence did not terminate at 0x{end:x}")
    return tuple(result)


def parse_sections(payload: bytes) -> tuple[Section, ...]:
    payload = bytes(payload)
    sections: list[Section] = []
    cursor = 0
    budget = [MAX_RECORDS]
    while cursor < len(payload):
        tag, header_length, total_length = _prefix(payload, cursor, len(payload))
        if tag != b"msdh" or header_length < 16:
            raise FormatError(f"expected msdh section at 0x{cursor:x}")
        if total_length < header_length or cursor + total_length > len(payload):
            raise FormatError(f"invalid msdh size at 0x{cursor + 8:x}")
        section_type = u32le(payload, cursor + 12)
        header = payload[cursor : cursor + header_length]
        body_start, end = cursor + header_length, cursor + total_length
        root_spec = SECTION_ROOTS.get(section_type)
        root: Record | None = None
        opaque = b""
        section_path = f"section[{len(sections)}]/type[{section_type}]"
        if root_spec is None:
            opaque = payload[body_start:end]
        else:
            expected_tag, framing = root_spec
            root_tag, root_header_length, root_third = _prefix(payload, body_start, end)
            if root_tag != expected_tag:
                raise FormatError(
                    f"section {section_type} expected {expected_tag!r}, got {root_tag!r}"
                )
            root_header = payload[body_start : body_start + root_header_length]
            root_path = f"{section_path}/{root_tag.decode('ascii')}[0]"
            if framing == "fixed":
                if body_start + root_header_length != end:
                    raise FormatError("fixed mfdh root has trailing bytes")
                root = Record(
                    root_tag,
                    body_start,
                    root_header,
                    b"",
                    (),
                    root_header_length,
                    root_path,
                    "fixed",
                )
            else:
                child_fixed = b"mprh" if framing == "fixed_children" else None
                children = _parse_sequence(
                    payload,
                    body_start + root_header_length,
                    end,
                    path=root_path,
                    depth=1,
                    fixed_tag=child_fixed,
                    budget=budget,
                )
                root = Record(
                    root_tag,
                    body_start,
                    root_header,
                    b"",
                    children,
                    end - body_start,
                    root_path,
                    framing,
                )
        sections.append(
            Section(
                section_type=section_type,
                offset=cursor,
                header=header,
                total_length=total_length,
                root=root,
                opaque_payload=opaque,
                index=len(sections),
            )
        )
        cursor = end
    return tuple(sections)


def _safe_int(header: bytes, offset: int, width: int) -> int | None:
    if offset < 0 or offset + width > len(header):
        return None
    return int.from_bytes(header[offset : offset + width], "little")


def decode_text_object(record: Record) -> tuple[str | None, dict]:
    """Decode the narrow observed mhoh string representations."""
    if record.tag != b"mhoh" or len(record.header) < 16:
        return None, {"error": "not a decodable mhoh object"}
    type_code = u32le(record.header, 12)
    if len(record.payload) < 16:
        return None, {"type_code": type_code, "error": "text prefix is truncated"}
    encoding = u32le(record.payload, 0)
    byte_length = u32le(record.payload, 4)
    if 16 + byte_length > len(record.payload):
        return None, {
            "type_code": type_code,
            "encoding": encoding,
            "error": "declared text length exceeds object body",
        }
    raw = record.payload[16 : 16 + byte_length]
    try:
        if encoding == 1:
            if byte_length % 2:
                raise UnicodeError("UTF-16LE byte length is odd")
            text = raw.decode("utf-16-le", errors="strict")
        elif encoding == 3:
            text = raw.decode("latin-1", errors="strict")
        elif encoding == 2 and type_code == 11:
            text = raw.decode("ascii", errors="strict")
        else:
            return None, {
                "type_code": type_code,
                "encoding": encoding,
                "error": "unsupported text encoding/type combination",
            }
    except UnicodeError as exc:
        return None, {
            "type_code": type_code,
            "encoding": encoding,
            "error": str(exc),
        }
    return text, {
        "type_code": type_code,
        "encoding": encoding,
        "suffix_length": len(record.payload) - 16 - byte_length,
    }


def _text_fields(owner: Record) -> tuple[dict[str, str | None], list[dict]]:
    grouped: dict[int, list[Record]] = {}
    for child in owner.children:
        if child.tag == b"mhoh" and len(child.header) >= 16:
            grouped.setdefault(u32le(child.header, 12), []).append(child)
    result: dict[str, str | None] = {}
    problems: list[dict] = []
    for type_code, name in TEXT_TYPES.items():
        objects = grouped.get(type_code, [])
        if not objects:
            result[name] = None
        elif len(objects) != 1:
            result[name] = None
            problems.append(
                {"field": name, "error": "duplicate text objects", "count": len(objects)}
            )
        else:
            text, metadata = decode_text_object(objects[0])
            result[name] = text
            if text is None:
                problems.append({"field": name, **metadata})
    return result, problems


@dataclass(frozen=True)
class ReferenceLibrary:
    envelope: Envelope
    sections: tuple[Section, ...]

    @classmethod
    def from_bytes(cls, data: bytes) -> "ReferenceLibrary":
        envelope = decode_envelope_bytes(data)
        if envelope.payload_byteorder != "little":
            raise UnsupportedError("semantic parser supports little-endian payloads only")
        return cls(envelope=envelope, sections=parse_sections(envelope.payload))

    @classmethod
    def read(cls, path: str | Path) -> "ReferenceLibrary":
        return cls.from_bytes(Path(path).read_bytes())

    def section(self, section_type: int) -> Section | None:
        matches = [s for s in self.sections if s.section_type == section_type]
        return matches[0] if len(matches) == 1 else None

    def records(self, section_type: int, tag: bytes) -> tuple[Record, ...]:
        section = self.section(section_type)
        if section is None or section.root is None:
            return ()
        return tuple(child for child in section.root.children if child.tag == tag)

    @property
    def track_records(self) -> tuple[Record, ...]:
        return self.records(1, b"mith")

    @property
    def playlist_records(self) -> tuple[Record, ...]:
        return self.records(2, b"miph")

    @property
    def album_records(self) -> tuple[Record, ...]:
        return self.records(9, b"miah")

    @property
    def artist_records(self) -> tuple[Record, ...]:
        return self.records(11, b"miih")

    def track_semantics(self) -> tuple[dict, ...]:
        result: list[dict] = []
        for record in self.track_records:
            text, problems = _text_fields(record)
            pid = _safe_int(record.header, 0x80, 8)
            item = {
                "persistent_id": hex_pid(pid),
                "track_id": _safe_int(record.header, 0x10, 4),
                "record_kind_raw": _safe_int(record.header, 0x14, 4),
                "date_modified": _safe_int(record.header, 0x20, 4),
                "file_size": _safe_int(record.header, 0x24, 4),
                "total_time": _safe_int(record.header, 0x28, 4),
                "track_number": _safe_int(record.header, 0x2C, 4),
                "track_count": _safe_int(record.header, 0x30, 4),
                "year": _safe_int(record.header, 0x34, 4),
                "bit_rate": _safe_int(record.header, 0x38, 4),
                "play_count": _safe_int(record.header, 0x4C, 4),
                "play_date": _safe_int(record.header, 0x64, 4),
                "disc_number": _safe_int(record.header, 0x68, 2),
                "disc_count": _safe_int(record.header, 0x6A, 2),
                "rating": _safe_int(record.header, 0x6C, 1),
                "name_refresh_flag_raw": _safe_int(record.header, 0x6D, 1),
                "date_added": _safe_int(record.header, 0x78, 4),
                "skip_count": _safe_int(record.header, 0xD8, 4),
                "album_id": _safe_int(record.header, 0xDC, 4),
                "unplayed_raw": _safe_int(record.header, 0xEE, 1),
                "sample_rate": _safe_int(record.header, 0xF4, 4),
                "skip_date": _safe_int(record.header, 0x11C, 4),
                "artist_id": _safe_int(record.header, 0x1E0, 4),
                "header_length": len(record.header),
                **{k: text.get(k) for k in TEXT_TYPES.values() if k != "playlist_name"},
            }
            if item["unplayed_raw"] is not None and self.envelope.version == "12.13.10.3":
                item["unplayed"] = not bool(item["unplayed_raw"] & 1)
            else:
                item["unplayed"] = None
            if problems:
                item["text_decode_problems"] = problems
            result.append(item)
        return tuple(result)

    def playlist_semantics(self) -> tuple[dict, ...]:
        tracks_by_local = {
            track["track_id"]: track["persistent_id"]
            for track in self.track_semantics()
            if track["track_id"] is not None
        }
        result: list[dict] = []
        for record in self.playlist_records:
            text, problems = _text_fields(record)
            members = []
            for child in record.children:
                if child.tag != b"mtph":
                    continue
                local_track = _safe_int(child.header, 0x18, 4)
                members.append(
                    {
                        "track_id": local_track,
                        "track_persistent_id": tracks_by_local.get(local_track),
                        "item_id": _safe_int(child.header, 0x10, 4),
                        "order_token": _safe_int(child.header, 0x20, 8),
                        "item_persistent_id": hex_pid(
                            _safe_int(child.header, 0x44, 8)
                        ),
                    }
                )
            item = {
                "persistent_id": hex_pid(_safe_int(record.header, 0x1B8, 8)),
                "playlist_id": _safe_int(record.header, 0xD40, 4),
                "name": text.get("playlist_name"),
                "header_length": len(record.header),
                "members": members,
                "smart_rule_objects": sum(
                    child.tag == b"mhoh"
                    and len(child.header) >= 16
                    and u32le(child.header, 12) in (101, 102)
                    for child in record.children
                ),
                "special_object": any(
                    child.tag == b"mhoh"
                    and len(child.header) >= 16
                    and u32le(child.header, 12) == 103
                    for child in record.children
                ),
            }
            if problems:
                item["text_decode_problems"] = problems
            result.append(item)
        return tuple(result)

    def semantic_summary(self) -> dict:
        return {
            "schema": "reference-itl.semantic.v1",
            "sha256": self.envelope.sha256,
            "version": self.envelope.version,
            "file_persistent_id": hex_pid(self.envelope.file_persistent_id),
            "envelope": {
                "header_length": len(self.envelope.header),
                "encryption_flag": self.envelope.encryption_flag,
                "compression_flag": self.envelope.compression_flag,
                "payload_byteorder": self.envelope.payload_byteorder,
                "trailer_length": len(self.envelope.trailer),
                "declared_counts": self.envelope.declared_counts,
            },
            "sections": [
                {
                    "type": section.section_type,
                    "offset": section.offset,
                    "size": section.total_length,
                    "opaque": section.root is None,
                }
                for section in self.sections
            ],
            "tracks": list(self.track_semantics()),
            "playlists": list(self.playlist_semantics()),
        }

    def record_dump(self, *, include_header_hex: bool = False) -> dict:
        return {
            "schema": "reference-itl.record-dump.v1",
            "source_sha256": self.envelope.sha256,
            "version": self.envelope.version,
            "sections": [
                section.dump(include_header_hex=include_header_hex)
                for section in self.sections
            ],
        }


def detect_bytes(data: bytes) -> dict:
    """Return a machine-readable version/support decision without guessing."""
    report: dict = {
        "schema": "reference-itl.version-detection.v1",
        "sha256": hashlib.sha256(data).hexdigest(),
        "status": "malformed",
        "version": None,
        "profile": None,
        "evidence": [],
        "limitations": [
            "The Pascal version label is authoritative only for the observed envelope.",
            "No native iTunes acceptance is implied by structural detection.",
        ],
    }
    try:
        envelope = decode_envelope_bytes(data)
        report["version"] = envelope.version
        report["evidence"].extend(
            [
                {"check": "magic", "value": "hdfm", "ok": True},
                {"check": "header_length", "value": len(envelope.header), "ok": True},
                {"check": "declared_size", "value": len(data), "ok": True},
                {"check": "pascal_version", "value": envelope.version, "ok": True},
                {
                    "check": "payload_byteorder",
                    "value": envelope.payload_byteorder,
                    "ok": envelope.payload_byteorder == "little",
                },
                {
                    "check": "encryption_flag",
                    "value": envelope.encryption_flag,
                    "ok": envelope.encryption_flag in (0, 1, 2),
                },
            ]
        )
        if envelope.payload_byteorder != "little":
            report["status"] = "unsupported"
            report["reason"] = "big-endian payload semantics are not implemented"
            return report
        sections = parse_sections(envelope.payload)
        report["evidence"].append(
            {
                "check": "section_boundaries",
                "value": [s.section_type for s in sections],
                "ok": True,
            }
        )
        profile = SUPPORTED_PROFILES.get(envelope.version)
        if profile is None:
            report["status"] = "unsupported"
            report["reason"] = "version label is not in the observed profile allowlist"
        else:
            report["status"] = "recognized"
            report["profile"] = profile
            report["reason"] = "observed version label and bounded section framing agree"
    except UnsupportedError as exc:
        report["status"] = "unsupported"
        report["reason"] = str(exc)
    except (FormatError, ValueError) as exc:
        report["reason"] = str(exc)
    return report


def detect(path: str | Path) -> dict:
    return detect_bytes(Path(path).read_bytes())


def iter_records(sections: Iterable[Section]) -> Iterator[Record]:
    for section in sections:
        if section.root:
            yield from section.root.walk()
