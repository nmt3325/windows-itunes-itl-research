"""Independent structural and known-reference validator."""
from __future__ import annotations

import hashlib
from pathlib import Path
from typing import Iterable

from REFERENCE_PARSER.core import (
    FormatError,
    ReferenceError,
    ReferenceLibrary,
    SUPPORTED_PROFILES,
    UnsupportedError,
    detect_bytes,
    u32le,
)


def _issue(severity: str, code: str, path: str, message: str, **details) -> dict:
    value = {"severity": severity, "code": code, "path": path, "message": message}
    if details:
        value["details"] = details
    return value


def _duplicates(values: Iterable[int | str | None]) -> set:
    seen, duplicates = set(), set()
    for value in values:
        if value in (None, 0, "0000000000000000"):
            continue
        if value in seen:
            duplicates.add(value)
        seen.add(value)
    return duplicates


def validate_bytes(data: bytes) -> dict:
    """Validate framing, declared counts, identities and known references.

    Opaque bytes are retained as unvalidated scope rather than searched for
    reference-looking integers. The coverage statement is part of the result.
    """
    issues: list[dict] = []
    digest = hashlib.sha256(data).hexdigest()
    detection = detect_bytes(data)
    if detection["status"] != "recognized":
        issues.append(
            _issue(
                "error",
                "profile.not_recognized",
                "envelope",
                detection.get("reason", detection["status"]),
            )
        )
    try:
        library = ReferenceLibrary.from_bytes(data)
    except (ReferenceError, ValueError) as exc:
        issues.append(_issue("error", "parse.failed", "file", str(exc)))
        return {
            "schema": "reference-itl.validation.v1",
            "sha256": digest,
            "valid": False,
            "version": detection.get("version"),
            "issues": issues,
            "coverage": {
                "envelope_and_record_boundaries": False,
                "known_reference_namespaces": [],
                "opaque_bytes_semantically_validated": False,
            },
            "native_acceptance": "unverified",
        }

    envelope = library.envelope
    profile = SUPPORTED_PROFILES.get(envelope.version, {})
    declared = envelope.declared_counts
    actual = {
        "sections": len(library.sections),
        "tracks": len(library.track_records),
        "playlists": len(library.playlist_records),
        "albums": len(library.album_records),
        "artists": len(library.artist_records),
    }
    for name, expected in declared.items():
        if expected != actual[name]:
            issues.append(
                _issue(
                    "error",
                    "count.outer_mismatch",
                    f"hdfm/{name}",
                    f"declared {expected}, parsed {actual[name]}",
                )
            )

    section_types = [section.section_type for section in library.sections]
    for required_type in (16, 1, 2, 9, 11):
        count = section_types.count(required_type)
        if count != 1:
            issues.append(
                _issue(
                    "error",
                    "section.required_multiplicity",
                    "payload",
                    f"section type {required_type} appears {count} times; expected exactly one",
                )
            )

    mfdh = library.section(16)
    if mfdh and mfdh.root:
        if len(mfdh.root.header) >= 0x34:
            inner_sections = u32le(mfdh.root.header, 0x30)
            if inner_sections != len(library.sections):
                issues.append(
                    _issue(
                        "error",
                        "count.inner_section_mismatch",
                        mfdh.root.path,
                        f"mfdh declares {inner_sections}, parsed {len(library.sections)}",
                    )
                )
        else:
            issues.append(
                _issue("error", "shape.mfdh_short", mfdh.root.path, "mfdh is too short")
            )
        if len(mfdh.root.header) >= 12:
            logical_size = u32le(mfdh.root.header, 8)
            expected_size = len(envelope.header) + len(envelope.payload)
            if logical_size != expected_size:
                issues.append(
                    _issue(
                        "error",
                        "size.logical_mismatch",
                        mfdh.root.path,
                        f"mfdh logical size {logical_size}, expected {expected_size}",
                    )
                )

    for section in library.sections:
        root = section.root
        if root is None:
            issues.append(
                _issue(
                    "warning",
                    "scope.opaque_section",
                    section.path,
                    "section body is retained but not semantically decoded",
                    section_type=section.section_type,
                    bytes=len(section.opaque_payload),
                )
            )
            continue
        if root.framing in ("count", "fixed_children") and len(root.header) >= 12:
            declared_children = u32le(root.header, 8)
            if declared_children != len(root.children):
                issues.append(
                    _issue(
                        "error",
                        "count.root_mismatch",
                        root.path,
                        f"declared {declared_children}, parsed {len(root.children)}",
                    )
                )
        elif root.framing == "mixed" and len(root.header) >= 20:
            declared_mhoh = u32le(root.header, 12)
            declared_miqh = u32le(root.header, 16)
            actual_mhoh = sum(child.tag == b"mhoh" for child in root.children)
            actual_miqh = sum(child.tag == b"miqh" for child in root.children)
            if (declared_mhoh, declared_miqh) != (actual_mhoh, actual_miqh):
                issues.append(
                    _issue(
                        "error",
                        "count.mixed_root_mismatch",
                        root.path,
                        "mixed root counts do not match parsed children",
                        declared=[declared_mhoh, declared_miqh],
                        actual=[actual_mhoh, actual_miqh],
                    )
                )
        for record in root.walk():
            if record is root:
                continue
            if record.tag in {b"mith", b"miah", b"miih", b"miqh", b"mtph"}:
                if len(record.header) < 16:
                    issues.append(
                        _issue("error", "shape.record_short", record.path, "record header < 16")
                    )
                elif u32le(record.header, 12) != len(record.children):
                    issues.append(
                        _issue(
                            "error",
                            "count.record_mismatch",
                            record.path,
                            f"declared {u32le(record.header, 12)}, parsed {len(record.children)}",
                        )
                    )
            elif record.tag == b"miph":
                if len(record.header) < 20:
                    issues.append(
                        _issue("error", "shape.playlist_short", record.path, "miph header < 20")
                    )
                else:
                    expected = (u32le(record.header, 12), u32le(record.header, 16))
                    parsed = (
                        sum(child.tag == b"mhoh" for child in record.children),
                        sum(child.tag == b"mtph" for child in record.children),
                    )
                    if expected != parsed:
                        issues.append(
                            _issue(
                                "error",
                                "count.playlist_mismatch",
                                record.path,
                                "playlist metadata/item counts do not match children",
                                declared=list(expected),
                                actual=list(parsed),
                            )
                        )

    track_semantics = list(library.track_semantics())
    playlist_semantics = list(library.playlist_semantics())
    expected_track_headers = set(profile.get("track_header_lengths", []))
    expected_playlist_headers = set(profile.get("playlist_header_lengths", []))
    for index, track in enumerate(track_semantics):
        path = f"tracks[{index}]"
        if expected_track_headers and track["header_length"] not in expected_track_headers:
            issues.append(
                _issue(
                    "error",
                    "profile.track_header",
                    path,
                    f"unsupported track header length {track['header_length']}",
                )
            )
        for field in ("track_id", "persistent_id"):
            if track[field] in (None, 0, "0000000000000000"):
                issues.append(
                    _issue("error", "identity.zero", f"{path}/{field}", "identity is zero/missing")
                )
        for problem in track.get("text_decode_problems", []):
            issues.append(
                _issue(
                    "warning",
                    "text.not_decoded",
                    f"{path}/{problem.get('field', 'unknown')}",
                    problem.get("error", "text was not decoded"),
                )
            )
    for field in ("track_id", "persistent_id"):
        for duplicate in sorted(_duplicates(track[field] for track in track_semantics)):
            issues.append(
                _issue(
                    "error",
                    "identity.duplicate_track",
                    f"tracks/{field}",
                    f"duplicate value {duplicate}",
                )
            )

    album_ids = {
        int.from_bytes(record.header[0x10:0x14], "little")
        for record in library.album_records
        if len(record.header) >= 0x14
    }
    artist_ids = {
        int.from_bytes(record.header[0x10:0x14], "little")
        for record in library.artist_records
        if len(record.header) >= 0x14
    }
    track_ids = {track["track_id"] for track in track_semantics if track["track_id"]}
    for index, track in enumerate(track_semantics):
        if track["album_id"] not in (None, 0) and track["album_id"] not in album_ids:
            issues.append(
                _issue(
                    "error",
                    "reference.album_missing",
                    f"tracks[{index}]/album_id",
                    f"unresolved local album id {track['album_id']}",
                )
            )
        if track["artist_id"] not in (None, 0) and track["artist_id"] not in artist_ids:
            issues.append(
                _issue(
                    "error",
                    "reference.artist_missing",
                    f"tracks[{index}]/artist_id",
                    f"unresolved local artist id {track['artist_id']}",
                )
            )

    for index, playlist in enumerate(playlist_semantics):
        path = f"playlists[{index}]"
        if expected_playlist_headers and playlist["header_length"] not in expected_playlist_headers:
            issues.append(
                _issue(
                    "error",
                    "profile.playlist_header",
                    path,
                    f"unsupported playlist header length {playlist['header_length']}",
                )
            )
        for field in ("playlist_id", "persistent_id"):
            if playlist[field] in (None, 0, "0000000000000000"):
                issues.append(
                    _issue("error", "identity.zero", f"{path}/{field}", "identity is zero/missing")
                )
        item_ids = [member["item_id"] for member in playlist["members"]]
        item_pids = [member["item_persistent_id"] for member in playlist["members"]]
        for duplicate in sorted(_duplicates(item_ids)):
            issues.append(
                _issue(
                    "error",
                    "identity.duplicate_playlist_item",
                    f"{path}/item_id",
                    f"duplicate item id {duplicate}",
                )
            )
        for duplicate in sorted(_duplicates(item_pids)):
            issues.append(
                _issue(
                    "error",
                    "identity.duplicate_playlist_item_pid",
                    f"{path}/item_persistent_id",
                    f"duplicate item PID {duplicate}",
                )
            )
        for member_index, member in enumerate(playlist["members"]):
            if member["track_id"] not in track_ids:
                issues.append(
                    _issue(
                        "error",
                        "reference.track_missing",
                        f"{path}/members[{member_index}]",
                        f"unresolved local track id {member['track_id']}",
                    )
                )
    for field in ("playlist_id", "persistent_id"):
        for duplicate in sorted(_duplicates(p[field] for p in playlist_semantics)):
            issues.append(
                _issue(
                    "error",
                    "identity.duplicate_playlist",
                    f"playlists/{field}",
                    f"duplicate value {duplicate}",
                )
            )

    return {
        "schema": "reference-itl.validation.v1",
        "sha256": digest,
        "valid": not any(issue["severity"] == "error" for issue in issues),
        "version": envelope.version,
        "counts": {"declared": declared, "parsed": actual},
        "issues": issues,
        "coverage": {
            "envelope_and_record_boundaries": True,
            "known_reference_namespaces": [
                "track local/Persistent IDs",
                "playlist local/Persistent IDs",
                "playlist item IDs and track references",
                "track album and artist local references",
            ],
            "opaque_bytes_semantically_validated": False,
            "opaque_reference_scan": False,
        },
        "native_acceptance": "unverified",
    }


def validate(path: str | Path) -> dict:
    return validate_bytes(Path(path).read_bytes())
