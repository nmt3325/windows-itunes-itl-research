#!/usr/bin/env python3
"""Read-only allocation/COW/rank census for the checked-in ITL corpus.

This is an offline structural audit.  It deliberately separates container and
record-boundary parsing from ``Library``'s stricter modeled invariants.  Its
observations are per snapshot and are not native acceptance or a proof of an
allocator policy.
"""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import sys
from typing import Iterable

REPO_ROOT = Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from itlkit import Container, Library, parse_sections, serialize_sections  # noqa: E402
from itlkit.library import read_text  # noqa: E402
from itlkit.model import Node  # noqa: E402

SCHEMA = "windows-itl-research.allocation-graph-audit.v1"
MAX_RAW_GUARD_STEPS = 1_000_000
RANK_OFFSETS = tuple(range(0x290, 0x2AC, 4))

# This is intentionally the implemented map from itlkit/atoms.py, not a claim
# that every mhoh type belongs to one of these pools.
KNOWN_POOLS: dict[tuple[bytes, int], str] = {}
for _owner, _codes, _pool in (
    (b"mith", (2,), "name"),
    (b"mith", (3,), "album"),
    (b"miah", (300,), "album"),
    (b"mith", (4, 12, 27), "artist"),
    (b"miah", (301, 302), "artist"),
    (b"miih", (400,), "artist"),
    (b"mith", (5,), "genre"),
    (b"mith", (8,), "comment"),
    (b"mith", (30,), "sort_name"),
    (b"mith", (31,), "sort_album"),
    (b"mith", (32, 33, 34), "sort_artist"),
    (b"miih", (401,), "sort_artist"),
):
    for _code in _codes:
        KNOWN_POOLS[_owner, _code] = _pool

SORT_TYPES = {
    (b"mith", 30): "sort_name",
    (b"mith", 31): "sort_album",
    (b"mith", 32): "sort_artist",
    (b"mith", 33): "sort_album_artist",
    (b"mith", 34): "sort_artist_aux",
    (b"miih", 401): "sort_artist_aux_object",
}


def _safe_uint(data: bytes | bytearray, offset: int, size: int = 4, *, endian: str = "little") -> int | None:
    if offset < 0 or offset + size > len(data):
        return None
    return int.from_bytes(data[offset : offset + size], endian)


def _error(exc: BaseException) -> dict[str, str]:
    return {"type": type(exc).__name__, "message": str(exc)}


def _distribution(values: Iterable[int]) -> dict[str, int]:
    counts = Counter(values)
    return {str(value): counts[value] for value in sorted(counts)}


def _value_stats(values: Iterable[int | None], *, expected_count: int | None = None) -> dict:
    materialized = list(values)
    observed = [value for value in materialized if value is not None]
    counts = Counter(observed)
    duplicates = [
        {"value": value, "count": count}
        for value, count in sorted(counts.items())
        if value != 0 and count > 1
    ]
    return {
        "scope": "file",
        "expected_count": len(materialized) if expected_count is None else expected_count,
        "observed_count": len(observed),
        "unavailable_count": len(materialized) - len(observed),
        "zero_count": counts.get(0, 0),
        "positive_count": sum(value > 0 for value in observed),
        "unique_positive_count": len({value for value in observed if value > 0}),
        "duplicate_positive_groups": duplicates,
        "maximum": max(observed, default=None),
    }


def _records(sections: list[Node], section_type: int, tag: bytes) -> list[Node]:
    result: list[Node] = []
    for section in sections:
        if section.section_type != section_type:
            continue
        for root in section.children or ():
            result.extend(child for child in root.children or () if child.tag == tag)
    return result


def _all_nodes(sections: list[Node]) -> list[Node]:
    return [node for section in sections for node in section.walk()]


def _scoped_item_stats(playlists: list[Node], offset: int, size: int) -> dict:
    values_by_owner: list[list[int | None]] = []
    for playlist in playlists:
        items = [child for child in playlist.children or () if child.tag == b"mtph"]
        values_by_owner.append([_safe_uint(item.header, offset, size) for item in items])

    zero_count = 0
    observed_count = 0
    unavailable_count = 0
    within_owner_duplicates = []
    value_owners: dict[int, set[int]] = defaultdict(set)
    maximum: int | None = None
    for owner_index, values in enumerate(values_by_owner):
        observed = [value for value in values if value is not None]
        observed_count += len(observed)
        unavailable_count += len(values) - len(observed)
        zero_count += sum(value == 0 for value in observed)
        counts = Counter(observed)
        for value, count in sorted(counts.items()):
            if value > 0:
                value_owners[value].add(owner_index)
            if value > 0 and count > 1:
                within_owner_duplicates.append(
                    {"playlist_index": owner_index, "value": value, "count": count}
                )
        if observed:
            local_max = max(observed)
            maximum = local_max if maximum is None else max(maximum, local_max)

    cross_owner = [
        {"value": value, "playlist_count": len(owners)}
        for value, owners in sorted(value_owners.items())
        if len(owners) > 1
    ]
    return {
        "scope": "within_playlist",
        "playlist_count": len(playlists),
        "observed_count": observed_count,
        "unavailable_count": unavailable_count,
        "zero_count": zero_count,
        "within_owner_duplicate_groups": within_owner_duplicates,
        "cross_owner_overlap_groups": cross_owner,
        "maximum": maximum,
    }


def _cross_domain_overlaps(domains: dict[str, list[int | None]]) -> list[dict]:
    positive = {
        name: {value for value in values if value is not None and value > 0}
        for name, values in domains.items()
    }
    result = []
    names = sorted(positive)
    for index, left in enumerate(names):
        for right in names[index + 1 :]:
            overlap = sorted(positive[left] & positive[right])
            if overlap:
                result.append(
                    {
                        "left": left,
                        "right": right,
                        "count": len(overlap),
                        "examples": overlap[:20],
                    }
                )
    return result


def _allocation_observation(header: bytes, sections: list[Node]) -> dict:
    raw_model = header + serialize_sections(sections)
    values: dict[str, list[int | None]] = defaultdict(list)
    unavailable = Counter()
    for node in _all_nodes(sections):
        fields: tuple[tuple[str, int], ...] = ()
        if node.tag == b"mith":
            fields = (("track_local", 0x10), ("track_secondary", 0x1F4))
        elif node.tag == b"miah":
            fields = (("album_local", 0x10),)
        elif node.tag == b"miih":
            fields = (("artist_local", 0x10),)
        elif node.tag == b"mtph":
            fields = (("item_local", 0x10), ("item_order_token", 0x20))
        elif node.tag == b"miph":
            fields = (("playlist_local", 0xD40),)
        for name, offset in fields:
            value = _safe_uint(node.header, offset)
            values[name].append(value)
            if value is None:
                unavailable[name] += 1

    observed = [value for rows in values.values() for value in rows if value is not None]
    base_maximum = max([0, *observed])
    candidate = base_maximum + 1
    skipped = 0
    while candidate < 2**32 and candidate.to_bytes(4, "little") in raw_model:
        candidate += 1
        skipped += 1
        if skipped >= MAX_RAW_GUARD_STEPS:
            break
    exact = skipped < MAX_RAW_GUARD_STEPS
    first_free = candidate if exact and candidate < 2**32 else None
    maxima = {
        name: max((value for value in rows if value is not None), default=None)
        for name, rows in sorted(values.items())
    }
    return {
        "algorithm_scope": "mirrors itlkit.operations.Allocator local-ID input fields and raw LE collision guard",
        "field_maxima": maxima,
        "unavailable_fields": dict(sorted(unavailable.items())),
        "global_base_maximum": base_maximum,
        "naive_next_id": candidate if skipped == 0 and candidate < 2**32 else base_maximum + 1,
        "first_free_after_raw_guard": first_free,
        "raw_guard_skipped_values": skipped,
        "raw_guard_scan_exact": exact,
        "fields_attaining_global_maximum": sorted(
            name for name, value in maxima.items() if value == base_maximum and value is not None
        ),
        "fields_over_approximated_by_global_high_water": sorted(
            name
            for name, value in maxima.items()
            if value is not None and value < base_maximum
        ),
    }


def _aux_observation(tracks: list[Node], targets: list[Node], *, reference_offset: int, label: str) -> dict:
    target_ids = [_safe_uint(node.header, 0x10) for node in targets]
    target_counts = Counter(value for value in target_ids if value is not None)
    consumers: dict[int, list[dict]] = defaultdict(list)
    zero_references = 0
    unavailable_references = 0
    for track_index, track in enumerate(tracks):
        reference = _safe_uint(track.header, reference_offset)
        if reference is None:
            unavailable_references += 1
            continue
        if reference == 0:
            zero_references += 1
            continue
        consumers[reference].append(
            {
                "track_index": track_index,
                "track_local_id": _safe_uint(track.header, 0x10),
                "track_persistent_id": _safe_uint(track.header, 0x80, 8),
            }
        )

    missing = [
        {"local_id": value, "consumer_count": len(rows)}
        for value, rows in sorted(consumers.items())
        if target_counts.get(value, 0) == 0
    ]
    ambiguous = [
        {"local_id": value, "target_count": target_counts[value], "consumer_count": len(rows)}
        for value, rows in sorted(consumers.items())
        if target_counts.get(value, 0) > 1
    ]
    shared = [
        {
            "local_id": value,
            "consumer_count": len(rows),
            "target_count": target_counts.get(value, 0),
            "consumers": rows[:20],
        }
        for value, rows in sorted(consumers.items())
        if len(rows) > 1
    ]
    referenced = set(consumers)
    orphans = sorted(value for value in target_counts if value > 0 and value not in referenced)
    return {
        "target": label,
        "target_count": len(targets),
        "reference_count": sum(len(rows) for rows in consumers.values()),
        "zero_reference_count": zero_references,
        "unavailable_reference_count": unavailable_references,
        "duplicate_positive_target_ids": [
            {"local_id": value, "count": count}
            for value, count in sorted(target_counts.items())
            if value > 0 and count > 1
        ],
        "missing_target_groups": missing,
        "ambiguous_target_groups": ambiguous,
        "shared_reference_groups": shared,
        "maximum_fanout": max((len(rows) for rows in consumers.values()), default=0),
        "orphan_positive_target_count": len(orphans),
        "orphan_positive_target_examples": orphans[:20],
    }


def _atom_observation(sections: list[Node]) -> dict:
    owners = [
        node
        for node in _all_nodes(sections)
        if node.tag in (b"mith", b"miah", b"miih")
    ]
    pool_stats: dict[str, Counter] = defaultdict(Counter)
    binding_rows: dict[tuple[str, int], list[dict]] = defaultdict(list)
    unmapped = Counter()
    decode_errors = Counter()
    sort_types = Counter()
    sort_atom_ids: dict[str, list[int]] = defaultdict(list)
    known_occurrences = 0

    for owner_index, owner in enumerate(owners):
        for child in owner.children or ():
            if child.tag != b"mhoh":
                continue
            type_code = child.type_code
            key = (owner.tag, type_code)
            pool = KNOWN_POOLS.get(key)
            if pool is None:
                unmapped[f"{owner.tag.decode('ascii', errors='replace')}/{type_code}"] += 1
                continue
            known_occurrences += 1
            stats = pool_stats[pool]
            stats["occurrences"] += 1
            atom_id = _safe_uint(child.header, 0x10)
            if atom_id is None:
                stats["missing_atom_id"] += 1
            elif atom_id == 0:
                stats["zero_atom_id"] += 1
            else:
                stats["positive_atom_id"] += 1
            try:
                value = read_text(child)
            except Exception as exc:  # malformed/opaque input is reported, never rewritten
                stats["opaque_or_invalid_text"] += 1
                decode_errors[type(exc).__name__] += 1
                value = None
            if value == "":
                stats["empty_text"] += 1
                if atom_id and atom_id > 0:
                    stats["positive_id_empty_text"] += 1
            elif value is not None:
                stats["nonempty_text"] += 1
                if atom_id == 0:
                    stats["zero_id_nonempty_text"] += 1
                if atom_id is not None and atom_id > 0:
                    binding_rows[pool, atom_id].append(
                        {
                            "owner_index": owner_index,
                            "owner_tag": owner.tag.decode("ascii", errors="replace"),
                            "owner_offset": owner.offset,
                            "type_code": type_code,
                            "text_sha256": hashlib.sha256(value.encode("utf-8")).hexdigest(),
                        }
                    )
            sort_name = SORT_TYPES.get(key)
            if sort_name is not None:
                sort_types[f"{owner.tag.decode('ascii')}/{type_code}"] += 1
                if atom_id is not None:
                    sort_atom_ids[sort_name].append(atom_id)

    conflicts = []
    shared = []
    for (pool, atom_id), rows in sorted(binding_rows.items()):
        digests = sorted({row["text_sha256"] for row in rows})
        owners_in_group = {row["owner_index"] for row in rows}
        summary = {
            "pool": pool,
            "atom_id": atom_id,
            "occurrence_count": len(rows),
            "owner_count": len(owners_in_group),
            "distinct_text_sha256_count": len(digests),
            "text_sha256": digests,
        }
        if len(digests) > 1:
            conflicts.append(summary)
        if len(owners_in_group) > 1:
            shared.append(summary)

    return {
        "scope": "known pool map only; unmapped mhoh types are occurrences, not inferred pools",
        "known_pool_occurrences": known_occurrences,
        "known_pool_stats": {
            pool: dict(sorted(stats.items())) for pool, stats in sorted(pool_stats.items())
        },
        "binding_group_count": len(binding_rows),
        "conflicting_binding_groups": conflicts,
        "shared_cross_owner_binding_groups": shared,
        "unmapped_owner_type_occurrences": dict(sorted(unmapped.items())),
        "decode_error_types": dict(sorted(decode_errors.items())),
        "sort_type_occurrences": dict(sorted(sort_types.items())),
        "sort_atom_id_distributions": {
            name: _distribution(values) for name, values in sorted(sort_atom_ids.items())
        },
    }


def _rank_observation(tracks: list[Node]) -> dict:
    distributions: dict[str, Counter] = {
        f"0x{offset:x}": Counter() for offset in RANK_OFFSETS
    }
    vectors = Counter()
    wire6d = Counter()
    incomplete = 0
    for track in tracks:
        values = [_safe_uint(track.header, offset) for offset in RANK_OFFSETS]
        if any(value is None for value in values):
            incomplete += 1
        else:
            complete = [int(value) for value in values]
            vectors[",".join(str(value) for value in complete)] += 1
            for offset, value in zip(RANK_OFFSETS, complete):
                distributions[f"0x{offset:x}"][value] += 1
        value6d = _safe_uint(track.header, 0x6D, 1)
        if value6d is not None:
            wire6d[value6d] += 1
    return {
        "scope": "raw per-track observations; no collation, tie-break, or regeneration semantics inferred",
        "complete_rank_vector_count": sum(vectors.values()),
        "incomplete_rank_vector_count": incomplete,
        "rank_vectors": dict(sorted(vectors.items())),
        "rank_word_distributions": {
            offset: {str(value): count for value, count in sorted(counts.items())}
            for offset, counts in distributions.items()
        },
        "wire6d_distribution": {
            str(value): count for value, count in sorted(wire6d.items())
        },
        "wire6d_bit0_distribution": {
            "clear": sum(count for value, count in wire6d.items() if not (value & 1)),
            "set": sum(count for value, count in wire6d.items() if value & 1),
        },
    }


def analyze_model(container_header: bytes, sections: list[Node]) -> dict:
    tracks = _records(sections, 1, b"mith")
    playlists = _records(sections, 2, b"miph")
    albums = _records(sections, 9, b"miah")
    artists = _records(sections, 11, b"miih")
    items = [
        item
        for playlist in playlists
        for item in playlist.children or ()
        if item.tag == b"mtph"
    ]

    local_domains = {
        "track_local": [_safe_uint(node.header, 0x10) for node in tracks],
        "track_secondary": [_safe_uint(node.header, 0x1F4) for node in tracks],
        "album_local": [_safe_uint(node.header, 0x10) for node in albums],
        "artist_local": [_safe_uint(node.header, 0x10) for node in artists],
        "playlist_local": [_safe_uint(node.header, 0xD40) for node in playlists],
    }
    # Item uniqueness is per playlist.  Flattened values are used only to make
    # numeric cross-domain overlap visible, never as a global uniqueness gate.
    local_overlap_domains = {
        **local_domains,
        "item_local_all_playlists": [_safe_uint(node.header, 0x10) for node in items],
    }
    persistent_domains = {
        "track_persistent": [_safe_uint(node.header, 0x80, 8) for node in tracks],
        "album_persistent": [_safe_uint(node.header, 0x14, 8) for node in albums],
        "artist_persistent": [_safe_uint(node.header, 0x14, 8) for node in artists],
        "playlist_persistent": [_safe_uint(node.header, 0x1B8, 8) for node in playlists],
    }
    persistent_overlap_domains = {
        **persistent_domains,
        "item_persistent_all_playlists": [_safe_uint(node.header, 0x44, 8) for node in items],
    }
    identities = {
        "namespace_rule": "uniqueness is checked in modeled domains, not globally",
        "local_domains": {
            name: _value_stats(values) for name, values in sorted(local_domains.items())
        },
        "persistent_domains": {
            name: _value_stats(values) for name, values in sorted(persistent_domains.items())
        },
        "item_local_within_playlist": _scoped_item_stats(playlists, 0x10, 4),
        "item_persistent_within_playlist": _scoped_item_stats(playlists, 0x44, 8),
        "local_cross_domain_overlaps": _cross_domain_overlaps(local_overlap_domains),
        "persistent_cross_domain_overlaps": _cross_domain_overlaps(persistent_overlap_domains),
    }
    return {
        "record_counts": {
            "tracks": len(tracks),
            "albums": len(albums),
            "artists": len(artists),
            "playlists": len(playlists),
            "items": len(items),
        },
        "identities": identities,
        "allocator": _allocation_observation(container_header, sections),
        "auxiliary_references": {
            "album": _aux_observation(
                tracks, albums, reference_offset=0xDC, label="miah"
            ),
            "artist": _aux_observation(
                tracks, artists, reference_offset=0x1E0, label="miih"
            ),
        },
        "string_pools": _atom_observation(sections),
        "sort_rank_cache": _rank_observation(tracks),
    }


def _path_label(path: Path, root: Path) -> str:
    try:
        return path.resolve().relative_to(root.resolve()).as_posix()
    except ValueError:
        return path.resolve().as_posix()


def audit_file(path: Path, root: Path, *, max_plain_bytes: int = 512 * 1024 * 1024) -> dict:
    result: dict = {
        "path": _path_label(path, root),
        "container": {"status": "not_run"},
        "structure": {"status": "not_run"},
        "high_level_library": {"status": "not_run"},
    }
    try:
        data = path.read_bytes()
    except OSError as exc:
        result.update({"bytes": None, "sha256": None, "read_error": _error(exc)})
        return result
    result.update({"bytes": len(data), "sha256": hashlib.sha256(data).hexdigest()})

    try:
        container = Container.from_bytes(data, max_plain_bytes=max_plain_bytes)
    except Exception as exc:
        result["container"] = {"status": "error", "error": _error(exc)}
        return result
    result["container"] = {
        "status": "ok",
        "version": container.version,
        "header_bytes": len(container.header),
        "payload_bytes": len(container.payload),
        "trailer_bytes": len(container.trailer),
        "encryption_flag": container.encryption_flag,
        "compression_flag": container.compression_flag,
        "payload_byteorder": container.payload_byteorder,
    }

    try:
        sections = parse_sections(container.payload)
    except Exception as exc:
        result["structure"] = {"status": "error", "error": _error(exc)}
        return result
    result["structure"] = {
        "status": "ok",
        "section_count": len(sections),
        "section_types": [section.section_type for section in sections],
        "node_count": sum(1 for section in sections for _ in section.walk()),
    }
    try:
        result["model"] = analyze_model(container.header, sections)
    except Exception as exc:
        # A single unexpected modeled-field shape must not suppress parse coverage.
        result["model"] = {"status": "error", "error": _error(exc)}

    try:
        Library.from_bytes(data, max_plain_bytes=max_plain_bytes)
    except Exception as exc:
        result["high_level_library"] = {"status": "error", "error": _error(exc)}
    else:
        result["high_level_library"] = {"status": "ok"}
    return result


def discover_itl_files(root: Path, inputs: Iterable[Path] = ()) -> list[Path]:
    requested = list(inputs)
    if not requested:
        requested = [root / "TEST_CORPUS", root / "evidence"]
    files: set[Path] = set()
    for entry in requested:
        candidate = entry if entry.is_absolute() else root / entry
        if candidate.is_file() and candidate.suffix.lower() == ".itl":
            files.add(candidate.resolve())
        elif candidate.is_dir():
            files.update(
                path.resolve()
                for path in candidate.rglob("*.itl")
                if ".git" not in path.parts and path.is_file()
            )
    return sorted(files, key=lambda path: _path_label(path, root))


def _aggregate(files: list[dict]) -> dict:
    hashes: dict[str, list[str]] = defaultdict(list)
    versions = Counter()
    container_errors = Counter()
    structure_errors = Counter()
    library_errors = Counter()
    rank_vectors = Counter()
    wire6d = Counter()
    totals = Counter()
    files_with = Counter()

    for row in files:
        if row.get("sha256"):
            hashes[row["sha256"]].append(row["path"])
        if row["container"]["status"] == "ok":
            versions[row["container"]["version"]] += 1
        elif row["container"]["status"] == "error":
            error = row["container"]["error"]
            container_errors[f"{error['type']}: {error['message']}"] += 1
        if row["structure"]["status"] == "error":
            error = row["structure"]["error"]
            structure_errors[f"{error['type']}: {error['message']}"] += 1
        if row["high_level_library"]["status"] == "error":
            error = row["high_level_library"]["error"]
            library_errors[f"{error['type']}: {error['message']}"] += 1
        model = row.get("model")
        if not model or model.get("status") == "error":
            continue
        for key, value in model["record_counts"].items():
            totals[key] += value
        identities = model["identities"]
        if identities["local_cross_domain_overlaps"]:
            files_with["local_cross_domain_overlap"] += 1
        if identities["persistent_cross_domain_overlaps"]:
            files_with["persistent_cross_domain_overlap"] += 1
        for domain in identities["local_domains"].values():
            totals["local_zero_values"] += domain["zero_count"]
            totals["local_duplicate_positive_groups"] += len(domain["duplicate_positive_groups"])
        for domain in identities["persistent_domains"].values():
            totals["persistent_zero_values"] += domain["zero_count"]
            totals["persistent_duplicate_positive_groups"] += len(domain["duplicate_positive_groups"])
        for key in ("item_local_within_playlist", "item_persistent_within_playlist"):
            scoped = identities[key]
            totals[f"{key}_zero_values"] += scoped["zero_count"]
            totals[f"{key}_duplicate_positive_groups"] += len(scoped["within_owner_duplicate_groups"])
            if scoped["zero_count"] or scoped["within_owner_duplicate_groups"]:
                files_with[f"{key}_issue"] += 1
        allocator = model["allocator"]
        totals["allocator_raw_guard_skipped_values"] += allocator["raw_guard_skipped_values"]
        if allocator["raw_guard_skipped_values"]:
            files_with["allocator_raw_guard_skip"] += 1
        if allocator["fields_over_approximated_by_global_high_water"]:
            files_with["allocator_global_high_water_overapproximation"] += 1
        for aux in model["auxiliary_references"].values():
            totals["aux_missing_target_groups"] += len(aux["missing_target_groups"])
            totals["aux_ambiguous_target_groups"] += len(aux["ambiguous_target_groups"])
            totals["aux_shared_reference_groups"] += len(aux["shared_reference_groups"])
            if aux["shared_reference_groups"]:
                files_with["shared_aux_reference"] += 1
        pools = model["string_pools"]
        totals["known_pool_occurrences"] += pools["known_pool_occurrences"]
        totals["known_pool_conflicting_binding_groups"] += len(pools["conflicting_binding_groups"])
        totals["known_pool_shared_binding_groups"] += len(pools["shared_cross_owner_binding_groups"])
        totals["unmapped_owner_type_occurrences"] += sum(pools["unmapped_owner_type_occurrences"].values())
        if pools["conflicting_binding_groups"]:
            files_with["known_pool_conflict"] += 1
        if pools["shared_cross_owner_binding_groups"]:
            files_with["known_pool_sharing"] += 1
        for stats in pools["known_pool_stats"].values():
            totals["known_pool_zero_id_nonempty_text"] += stats.get("zero_id_nonempty_text", 0)
            totals["known_pool_positive_id_empty_text"] += stats.get("positive_id_empty_text", 0)
            totals["known_pool_opaque_or_invalid_text"] += stats.get("opaque_or_invalid_text", 0)
        for key, count in pools["sort_type_occurrences"].items():
            totals[f"sort_type_occurrences:{key}"] += count
        ranks = model["sort_rank_cache"]
        rank_vectors.update(ranks["rank_vectors"])
        wire6d.update({int(key): value for key, value in ranks["wire6d_distribution"].items()})

    duplicate_groups = [
        {"sha256": digest, "paths": sorted(paths)}
        for digest, paths in sorted(hashes.items())
        if len(paths) > 1
    ]
    return {
        "files_scanned": len(files),
        "bytes_scanned": sum(row.get("bytes") or 0 for row in files),
        "unique_sha256": len(hashes),
        "duplicate_path_count": sum(len(group["paths"]) - 1 for group in duplicate_groups),
        "duplicate_sha256_groups": duplicate_groups,
        "container_ok": sum(row["container"]["status"] == "ok" for row in files),
        "structure_ok": sum(row["structure"]["status"] == "ok" for row in files),
        "model_ok": sum(bool(row.get("model")) and row["model"].get("status") != "error" for row in files),
        "high_level_library_ok": sum(row["high_level_library"]["status"] == "ok" for row in files),
        "versions": dict(sorted(versions.items())),
        "record_and_issue_totals": dict(sorted(totals.items())),
        "files_with_observation": dict(sorted(files_with.items())),
        "rank_vectors": dict(sorted(rank_vectors.items())),
        "wire6d_distribution": {str(value): wire6d[value] for value in sorted(wire6d)},
        "error_counts": {
            "container": dict(sorted(container_errors.items())),
            "structure": dict(sorted(structure_errors.items())),
            "high_level_library": dict(sorted(library_errors.items())),
        },
    }


def audit_paths(root: Path, paths: Iterable[Path] = (), *, max_plain_bytes: int = 512 * 1024 * 1024) -> dict:
    root = root.resolve()
    path_list = list(paths)
    discovered = discover_itl_files(root, path_list)
    files = [audit_file(path, root, max_plain_bytes=max_plain_bytes) for path in discovered]
    return {
        "schema": SCHEMA,
        "scope": {
            "root": ".",
            "source_roots": ["TEST_CORPUS", "evidence"] if not path_list else [],
            "selection": "explicit inputs" if path_list else "TEST_CORPUS/**/*.itl plus evidence/**/*.itl",
            "comparison_unit": "one file snapshot; identities are never compared globally across libraries",
            "mode": "offline, read-only, bounded structural parse",
        },
        "known_pool_map": [
            {
                "owner_tag": owner.decode("ascii"),
                "type_code": type_code,
                "pool": pool,
            }
            for (owner, type_code), pool in sorted(
                KNOWN_POOLS.items(), key=lambda item: (item[0][0], item[0][1])
            )
        ],
        "limitations": [
            "No result in this audit is native-qualified.",
            "Allocator high-water output mirrors the current implementation; it does not establish native allocation policy.",
            "Known string-pool mapping is partial; unmapped mhoh types are counted without assigning pool semantics.",
            "Rank words, wire6d, and sort atoms are reported independently; collation, tie-breaking, and cache regeneration remain unresolved.",
            "High-level Library failures are coverage classifications, not proof that the container or bounded record tree is malformed.",
            "Opaque persistent-ID byte scans and unknown reference consumers are outside this census.",
        ],
        "summary": _aggregate(files),
        "files": files,
    }


def _parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="*", type=Path, help="ITL files or directories; defaults to the checked-in corpus")
    parser.add_argument("--root", type=Path, default=REPO_ROOT, help="repository root used for discovery and relative path labels")
    parser.add_argument("-o", "--output", type=Path, help="write JSON here instead of stdout")
    parser.add_argument("--max-plain-bytes", type=int, default=512 * 1024 * 1024, help="per-file decompression limit")
    parser.add_argument("--compact", action="store_true", help="emit compact JSON")
    parser.add_argument("--strict-library", action="store_true", help="also fail when the high-level Library model rejects a file")
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = _parse_args(argv)
    if args.max_plain_bytes < 1:
        raise SystemExit("--max-plain-bytes must be positive")
    result = audit_paths(args.root, args.paths, max_plain_bytes=args.max_plain_bytes)
    text = json.dumps(
        result,
        ensure_ascii=False,
        sort_keys=True,
        indent=None if args.compact else 2,
        separators=(",", ":") if args.compact else None,
    ) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8")
        print(
            f"wrote {args.output}: {result['summary']['files_scanned']} files, "
            f"{result['summary']['structure_ok']} structurally parsed"
        )
    else:
        sys.stdout.write(text)
    hard_errors = result["summary"]["files_scanned"] - result["summary"]["model_ok"]
    if args.strict_library:
        hard_errors += result["summary"]["files_scanned"] - result["summary"]["high_level_library_ok"]
    return 1 if hard_errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
