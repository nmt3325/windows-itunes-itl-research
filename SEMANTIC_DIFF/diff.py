"""Deterministic semantic diff built on the independent reference parser."""
from __future__ import annotations

from pathlib import Path

from REFERENCE_PARSER.core import ReferenceLibrary

TRACK_FIELDS = (
    "track_id",
    "name",
    "album",
    "artist",
    "album_artist",
    "composer",
    "genre",
    "comment",
    "sort_name",
    "sort_album",
    "sort_artist",
    "sort_album_artist",
    "year",
    "track_number",
    "track_count",
    "disc_number",
    "disc_count",
    "rating",
    "play_count",
    "play_date",
    "skip_count",
    "skip_date",
    "unplayed",
    "file_size",
    "total_time",
    "sample_rate",
    "bit_rate",
    "url",
    "path",
)
PLAYLIST_FIELDS = ("playlist_id", "name", "members", "smart_rule_objects", "special_object")


def _index(items: list[dict], entity: str) -> tuple[dict[str, dict], list[dict]]:
    indexed: dict[str, dict] = {}
    problems = []
    for position, item in enumerate(items):
        key = item.get("persistent_id")
        if not key or key == "0000000000000000":
            key = f"missing:{position}"
            problems.append(
                {"entity": entity, "position": position, "problem": "missing persistent ID"}
            )
        if key in indexed:
            problems.append(
                {"entity": entity, "position": position, "problem": f"duplicate key {key}"}
            )
            key = f"duplicate:{key}:{position}"
        indexed[key] = item
    return indexed, problems


def _playlist_normalized(item: dict) -> dict:
    value = dict(item)
    value["members"] = [
        member.get("track_persistent_id") or f"local:{member.get('track_id')}"
        for member in item.get("members", [])
    ]
    return value


def _entity_diff(before: list[dict], after: list[dict], fields: tuple[str, ...], entity: str) -> dict:
    before_index, before_problems = _index(before, entity)
    after_index, after_problems = _index(after, entity)
    before_keys, after_keys = set(before_index), set(after_index)
    changed = []
    for key in sorted(before_keys & after_keys):
        field_changes = []
        for field in fields:
            old, new = before_index[key].get(field), after_index[key].get(field)
            if old != new:
                field_changes.append({"field": field, "before": old, "after": new})
        if field_changes:
            changed.append({"persistent_id": key, "changes": field_changes})
    return {
        "added": sorted(after_keys - before_keys),
        "removed": sorted(before_keys - after_keys),
        "changed": changed,
        "identity_problems": before_problems + after_problems,
    }


def semantic_diff_libraries(before: ReferenceLibrary, after: ReferenceLibrary) -> dict:
    before_tracks = list(before.track_semantics())
    after_tracks = list(after.track_semantics())
    before_playlists = [_playlist_normalized(x) for x in before.playlist_semantics()]
    after_playlists = [_playlist_normalized(x) for x in after.playlist_semantics()]
    tracks = _entity_diff(before_tracks, after_tracks, TRACK_FIELDS, "track")
    playlists = _entity_diff(before_playlists, after_playlists, PLAYLIST_FIELDS, "playlist")

    envelope_changes = []
    envelope_fields = {
        "version": (before.envelope.version, after.envelope.version),
        "file_persistent_id": (
            f"{before.envelope.file_persistent_id:016X}",
            f"{after.envelope.file_persistent_id:016X}",
        ),
        "encryption_flag": (
            before.envelope.encryption_flag,
            after.envelope.encryption_flag,
        ),
        "compression_flag": (
            before.envelope.compression_flag,
            after.envelope.compression_flag,
        ),
        "payload_byteorder": (
            before.envelope.payload_byteorder,
            after.envelope.payload_byteorder,
        ),
    }
    for field, (old, new) in envelope_fields.items():
        if old != new:
            envelope_changes.append({"field": field, "before": old, "after": new})

    before_sections = {
        f"{section.section_type}:{section.index}": {
            "type": section.section_type,
            "index": section.index,
            "sha256": __import__("hashlib").sha256(section.raw).hexdigest(),
            "opaque": section.root is None,
        }
        for section in before.sections
    }
    after_sections = {
        f"{section.section_type}:{section.index}": {
            "type": section.section_type,
            "index": section.index,
            "sha256": __import__("hashlib").sha256(section.raw).hexdigest(),
            "opaque": section.root is None,
        }
        for section in after.sections
    }
    section_digest_changes = []
    for key in sorted(set(before_sections) | set(after_sections)):
        old, new = before_sections.get(key), after_sections.get(key)
        if old != new:
            section_digest_changes.append({"section": key, "before": old, "after": new})

    has_differences = bool(
        envelope_changes
        or tracks["added"]
        or tracks["removed"]
        or tracks["changed"]
        or tracks["identity_problems"]
        or playlists["added"]
        or playlists["removed"]
        or playlists["changed"]
        or playlists["identity_problems"]
        or section_digest_changes
        or before.envelope.sha256 != after.envelope.sha256
    )
    return {
        "schema": "reference-itl.semantic-diff.v1",
        "before_sha256": before.envelope.sha256,
        "after_sha256": after.envelope.sha256,
        "has_differences": has_differences,
        "envelope_changes": envelope_changes,
        "tracks": tracks,
        "playlists": playlists,
        "section_digest_changes": section_digest_changes,
        "coverage": {
            "compared_track_fields": list(TRACK_FIELDS),
            "compared_playlist_fields": list(PLAYLIST_FIELDS),
            "opaque_or_unmodeled_changes": "reported only as section digest changes",
            "native_acceptance": "not evaluated",
        },
    }


def semantic_diff_bytes(before: bytes, after: bytes) -> dict:
    return semantic_diff_libraries(
        ReferenceLibrary.from_bytes(before), ReferenceLibrary.from_bytes(after)
    )


def semantic_diff(before_path: str | Path, after_path: str | Path) -> dict:
    return semantic_diff_bytes(Path(before_path).read_bytes(), Path(after_path).read_bytes())
