"""Build the deterministic U-01 structural candidate inventory.

This is an offline-only analysis.  It deliberately does not launch iTunes and
marks the relabelled derivative ineligible until a record/feature/layout theory
stronger than a Pascal version label is established.
"""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import plistlib
import sys
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from itlkit.container import Container
from REFERENCE_PARSER.core import ReferenceLibrary, parse_sections, u32le, u64le

EVIDENCE = ROOT / "evidence/research/20260927/u01-structural-candidate-inventory"
CANDIDATE = EVIDENCE / "candidates/native-12.13.11.1-normalized-to-12.12.10.1.itl"
REPORT = EVIDENCE / "native-structure-inventory.json"
STATIC_EVIDENCE = EVIDENCE / "static-localization-evidence.json"
SOURCE = ROOT / "evidence/research/20260927/itunes-12.13.11.1-version-qualification/native/one-track/cases/reference-one-track-raw/cycle-2/native-saved.itl"
TARGET_VERSION = "12.12.10.1"
SOURCE_VERSION = "12.13.11.1"
EXPECTED_SOURCE_SHA256 = "744c379586231ab6e28c75d805d7ad8696e8325e83e74b1b39568f009e89bdad"
FILES = {
    "native_12_12_input": ROOT / "evidence/research/20260927/u01-distinct-build-12.12.10.1/input-lock/native-authored-input.itl",
    "native_12_12_positive_cycle_1": ROOT / "evidence/research/20260927/u01-distinct-build-12.12.10.1/positive-qualification/cases/native-authored-one-track-positive/cycle-1/native-saved.itl",
    "native_12_12_positive_cycle_2": ROOT / "evidence/research/20260927/u01-distinct-build-12.12.10.1/positive-qualification/cases/native-authored-one-track-positive/cycle-2/native-saved.itl",
    "timeout_12_12_attempt_1": ROOT / "evidence/research/20260927/u01-distinct-build-12.12.10.1/negative-qualification/post-timeout-capture/attempt-1/native-mutated-at-timeout.itl",
    "timeout_12_12_attempt_2": ROOT / "evidence/research/20260927/u01-distinct-build-12.12.10.1/negative-qualification/post-timeout-capture/attempt-2/native-mutated-at-timeout.itl",
    "native_12_13_9_matched_cycle_2": ROOT / "evidence/research/20260927/u01-sampled-version-matrix/12.13.9.1/native/exact-one-track/cases/reference-one-track-raw/cycle-2/native-saved.itl",
    "native_12_13_11_matched_cycle_2": SOURCE,
    "native_12_13_11_independent_cycle_2": ROOT / "evidence/research/20260927/u01-sampled-version-matrix/12.13.11.1-independent/native/exact-one-track/cases/reference-one-track-raw/cycle-2/native-saved.itl",
}
EXPECTED_HASHES = {
    "native_12_12_input": "154146cf6eabdd7b8dd30f74e2c7009d0a8615d38b36edd1a3abbbacfc10cddc",
    "native_12_12_positive_cycle_1": "09db3d7c0425a8350e33c4f461dd465fb476947f3a76c0f1ed4f67e29a284acc",
    "native_12_12_positive_cycle_2": "9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772",
    "timeout_12_12_attempt_1": "b92b3b62dd418a4010e14b2da2e4b92abe7268dcd0d54a560b1cd29a57cdef59",
    "timeout_12_12_attempt_2": "b852b7d439bdf03d988e3f732a076d9f67e872a8314b68eee0435e210fa111f8",
    "native_12_13_9_matched_cycle_2": "c60e1ac92eabbb40b46c48c5c10e25310fbc03162bb6f21afc9584f3bd48d4a7",
    "native_12_13_11_matched_cycle_2": EXPECTED_SOURCE_SHA256,
    "native_12_13_11_independent_cycle_2": "34401e8c1fdde316698887d7cdc8eca446bdc550b3945e90d9cf345c239d7562",
}


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()


def sha256_file(path: Path) -> str:
    return sha256_bytes(path.read_bytes())


def relative(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def facts(path: Path) -> dict[str, Any]:
    return {"path": relative(path), "bytes": path.stat().st_size, "sha256": sha256_file(path)}


def pascal_version(blob: bytes | bytearray, offset: int = 0x10) -> str:
    size = blob[offset]
    require(size <= 31 and offset + 1 + size <= len(blob), "invalid Pascal version field")
    return bytes(blob[offset + 1 : offset + 1 + size]).decode("ascii")


def replace_pascal_version(blob: bytearray, version: str, offset: int = 0x10) -> None:
    encoded = version.encode("ascii")
    previous = blob[offset]
    require(previous == len(encoded), "version normalization requires equal-length labels")
    blob[offset] = len(encoded)
    blob[offset + 1 : offset + 1 + len(encoded)] = encoded


def inner_version(library: ReferenceLibrary) -> str:
    section = library.section(16)
    require(section is not None and section.root is not None and section.root.tag == b"mfdh", "missing mfdh root")
    return pascal_version(section.root.header)


def build_candidate_bytes() -> bytes:
    source_bytes = SOURCE.read_bytes()
    require(sha256_bytes(source_bytes) == EXPECTED_SOURCE_SHA256, "native 12.13.11.1 source changed")
    container = Container.from_bytes(source_bytes)
    require(container.version == SOURCE_VERSION, "unexpected outer source version")
    sections = parse_sections(container.payload)
    roots = [section.root for section in sections if section.section_type == 16 and section.root is not None]
    require(len(roots) == 1 and roots[0].tag == b"mfdh", "expected one mfdh root")
    require(pascal_version(roots[0].header) == SOURCE_VERSION, "unexpected inner source version")

    header = bytearray(container.header)
    payload = bytearray(container.payload)
    replace_pascal_version(header, TARGET_VERSION)
    replace_pascal_version(payload, TARGET_VERSION, roots[0].offset + 0x10)
    container.header = bytes(header)
    container.payload = bytes(payload)
    candidate = container.to_bytes(rebuild=True, compression_level=6)

    parsed = ReferenceLibrary.from_bytes(candidate)
    require(parsed.envelope.version == TARGET_VERSION, "candidate outer version normalization failed")
    require(inner_version(parsed) == TARGET_VERSION, "candidate inner version normalization failed")
    source = ReferenceLibrary.from_bytes(source_bytes)
    require(parsed.envelope.file_persistent_id == source.envelope.file_persistent_id, "outer file identity changed")
    require(parsed.track_semantics() == source.track_semantics(), "track semantics changed")
    require(parsed.playlist_semantics() == source.playlist_semantics(), "playlist semantics changed")

    source_payload = bytearray(source.envelope.payload)
    candidate_payload = bytearray(parsed.envelope.payload)
    source_root = source.section(16).root  # type: ignore[union-attr]
    candidate_root = parsed.section(16).root  # type: ignore[union-attr]
    require(source_root is not None and candidate_root is not None, "mfdh disappeared")
    start = source_root.offset + 0x11
    end = start + len(SOURCE_VERSION)
    candidate_payload[start:end] = source_payload[start:end]
    require(candidate_payload == source_payload, "decoded payload changed outside the inner version label")
    return candidate


def write_candidate() -> dict[str, Any]:
    value = build_candidate_bytes()
    CANDIDATE.parent.mkdir(parents=True, exist_ok=True)
    CANDIDATE.write_bytes(value)
    return facts(CANDIDATE)


def playlist_name(record) -> str | None:
    for child in record.children:
        if child.tag != b"mhoh" or len(child.header) < 16 or u32le(child.header, 12) != 100:
            continue
        if len(child.payload) < 16:
            return None
        encoding = u32le(child.payload, 0)
        size = u32le(child.payload, 4)
        if 16 + size > len(child.payload):
            return None
        codecs = {1: "utf-16-le", 3: "latin-1"}
        codec = codecs.get(encoding)
        return child.payload[16 : 16 + size].decode(codec, errors="strict") if codec else None
    return None


def type_109_objects(library: ReferenceLibrary) -> list[dict[str, Any]]:
    result: list[dict[str, Any]] = []
    for playlist in library.playlist_records:
        for child in playlist.children:
            if child.tag != b"mhoh" or len(child.header) < 16 or u32le(child.header, 12) != 109:
                continue
            try:
                plist = plistlib.loads(child.payload)
                error = None
            except Exception as exc:  # pragma: no cover - retained for future inventory inputs
                plist = None
                error = type(exc).__name__ + ": " + str(exc)
            row = {
                "record_path": child.path,
                "playlist_name": playlist_name(playlist),
                "playlist_persistent_id": f"{u64le(playlist.header, 0x1B8):016X}",
                "record_bytes": len(child.raw),
                "raw_sha256": sha256_bytes(child.raw),
                "payload_format": "xml_plist" if child.payload.startswith(b"<?xml") else "unknown",
                "plist": plist,
            }
            if error:
                row["decode_error"] = error
            result.append(row)
    return result


def inspect(path: Path, *, causal_classification: str) -> dict[str, Any]:
    library = ReferenceLibrary.read(path)
    lengths: dict[str, set[int]] = defaultdict(set)
    mhoh_types: Counter[int] = Counter()
    roots = []
    for section in library.sections:
        if section.root is None:
            continue
        roots.append(
            {
                "section_type": section.section_type,
                "tag": section.root.tag.decode("ascii"),
                "header_length": len(section.root.header),
                "child_count": len(section.root.children),
            }
        )
        for record in section.root.walk():
            lengths[record.tag.decode("ascii", errors="replace")].add(len(record.header))
            if record.tag == b"mhoh" and len(record.header) >= 16:
                mhoh_types[u32le(record.header, 12)] += 1
    mhgh = library.section(12)
    require(mhgh is not None and mhgh.root is not None and len(mhgh.root.header) > 0xE5, "missing mhgh+0xE5")
    return {
        **facts(path),
        "causal_classification": causal_classification,
        "outer_version": library.envelope.version,
        "inner_mfdh_version": inner_version(library),
        "file_persistent_id": f"{library.envelope.file_persistent_id:016X}",
        "expanded_payload_bytes": len(library.envelope.payload),
        "trailer_bytes": len(library.envelope.trailer),
        "section_types": [section.section_type for section in library.sections],
        "section_21_present": any(section.section_type == 21 for section in library.sections),
        "roots": roots,
        "record_header_lengths": {key: sorted(value) for key, value in sorted(lengths.items())},
        "mhoh_type_census": {str(key): value for key, value in sorted(mhoh_types.items())},
        "mhgh_offset_0xe5": mhgh.root.header[0xE5],
        "type_109_objects": type_109_objects(library),
        "track_semantics": list(library.track_semantics()),
        "playlist_count": len(library.playlist_records),
    }


def semantic_projection(row: dict[str, Any]) -> dict[str, Any]:
    return {
        "file_persistent_id": row["file_persistent_id"],
        "track_semantics": row["track_semantics"],
        "playlist_count": row["playlist_count"],
    }


def build_report() -> dict[str, Any]:
    require(CANDIDATE.is_file(), "generate the candidate before building the report")
    classifications = {
        "native_12_12_input": "clean_normal_quit_native_authored_input",
        "native_12_12_positive_cycle_1": "clean_normal_quit_positive_cycle",
        "native_12_12_positive_cycle_2": "clean_normal_quit_positive_cycle",
        "timeout_12_12_attempt_1": "force_terminated_timeout_survivor_observation_only",
        "timeout_12_12_attempt_2": "force_terminated_timeout_survivor_observation_only",
        "native_12_13_9_matched_cycle_2": "clean_normal_quit_native_cycle",
        "native_12_13_11_matched_cycle_2": "clean_normal_quit_native_cycle",
        "native_12_13_11_independent_cycle_2": "clean_normal_quit_separate_runtime_native_cycle",
    }
    inventory = {}
    for name, path in FILES.items():
        require(sha256_file(path) == EXPECTED_HASHES[name], f"locked input changed: {name}")
        inventory[name] = inspect(path, causal_classification=classifications[name])
    candidate = inspect(CANDIDATE, causal_classification="offline_rebuilt_derivative_never_launched")
    source = inventory["native_12_13_11_matched_cycle_2"]
    require(semantic_projection(candidate) == semantic_projection(source), "candidate semantic projection changed")
    require(candidate["outer_version"] == candidate["inner_mfdh_version"] == TARGET_VERSION, "candidate labels differ")
    require(candidate["section_types"] == source["section_types"], "candidate topology changed")
    require(candidate["mhoh_type_census"] == source["mhoh_type_census"], "candidate record census changed")
    require(candidate["type_109_objects"] == source["type_109_objects"], "candidate playlist-view state changed")

    clean_12_12 = [inventory["native_12_12_positive_cycle_1"], inventory["native_12_12_positive_cycle_2"]]
    newer = [
        inventory["native_12_13_9_matched_cycle_2"],
        inventory["native_12_13_11_matched_cycle_2"],
        inventory["native_12_13_11_independent_cycle_2"],
    ]
    require(all(row["mhgh_offset_0xe5"] == 4 for row in clean_12_12 + newer), "mhgh+0xE5 census changed")
    require(all(any(obj["payload_format"] == "xml_plist" for obj in row["type_109_objects"]) for row in clean_12_12 + newer), "type 109 ceased to be plist state")

    static = json.loads(STATIC_EVIDENCE.read_text(encoding="utf-8"))
    require(static["executable"]["sha256"] == "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b", "static executable changed")
    return {
        "schema": "windows-itl.u01-structural-candidate-inventory-20260927.v1",
        "status": "offline_inventory_complete_no_structural_candidate_eligible_no_native_launch",
        "scope": {
            "target_build": "12.12.10.1",
            "target_executable_sha256": static["executable"]["sha256"],
            "native_launches_performed_by_this_inventory": 0,
            "u01_closed": False,
        },
        "static_localization": static,
        "inventory": inventory,
        "offline_derivative": candidate,
        "candidate_decision": {
            "candidate_path": candidate["path"],
            "candidate_sha256": candidate["sha256"],
            "source_path": source["path"],
            "source_sha256": source["sha256"],
            "outer_and_inner_labels_normalized_to": TARGET_VERSION,
            "record_topology_retained": True,
            "selected_semantics_retained": True,
            "type_109_playlist_view_state_retained": True,
            "native_authored_after_normalization": False,
            "eligible_for_12_12_native_negative_launch": False,
            "launch_authorized": False,
            "reason": "No observed record, feature, or layout is both newer-only and plausibly rejection-causing. The retained differences are optional playlist-view state, while the clean 12.12 build itself emits type 109 and mhgh+0xE5=4.",
            "future_launch_requires": [
                "a predeclared feature/layout incompatibility independent of the Pascal labels",
                "exact candidate and control hashes committed and pushed before launch",
                "exact executable and Authenticode identity preflight",
                "two fresh-copy attempts where feasible",
                "exact newer-version versus invalid-library modal classification",
                "normal modal dismissal and normal process exit when a modal appears",
                "strict process cleanup and no XML/backup/damaged-library fallback",
                "separate outer-file and COM-library identity checks",
                "independent-parser semantic checks before and after",
            ],
        },
        "corrected_findings": {
            "mhgh_offset_0xe5_value_4_is_newer_only": False,
            "mhgh_offset_0xe5_value_4_observed_on_clean_12_12": True,
            "type_109_is_unknown_binary_capability_object": False,
            "type_109_is_xml_plist_playlist_view_state": True,
            "two_type_109_objects_establish_version_incompatibility": False,
            "section_21_establishes_version_incompatibility": False,
            "force_terminated_timeout_survivors_are_clean_native_cycles": False,
            "resource_family_localized_but_parser_status_branch_identified": False,
        },
        "bounded_conclusion": "The exact-build resource family and structurally valid derivative are reproducible, but the available data do not support a non-label incompatibility theory. Launching the derivative would turn the experiment into a version-label probe, which is outside the declared U-01 objective; therefore no new iTunes launch was made.",
    }


def write_report() -> dict[str, Any]:
    report = build_report()
    REPORT.parent.mkdir(parents=True, exist_ok=True)
    REPORT.write_text(json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return report


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="verify checked-in candidate and report byte-for-byte")
    args = parser.parse_args(argv)
    candidate = build_candidate_bytes()
    if args.check:
        require(CANDIDATE.read_bytes() == candidate, "checked-in candidate does not rebuild byte-exactly")
        rebuilt = json.dumps(build_report(), ensure_ascii=False, indent=2, sort_keys=True).encode() + b"\n"
        require(REPORT.read_bytes() == rebuilt, "checked-in report does not rebuild byte-exactly")
    else:
        write_candidate()
        write_report()
    print(json.dumps({"candidate": facts(CANDIDATE), "report": facts(REPORT)}, ensure_ascii=True, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
