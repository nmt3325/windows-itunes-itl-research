"""Build and verify the exact U-01 outer-header revision candidate.

The only mutation is raw file offset 0x0d, 0x43 -> 0x44.  The script is
hash-gated, deterministic, and never invokes iTunes.
"""
from __future__ import annotations

import argparse
import copy
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from REFERENCE_PARSER.core import ReferenceLibrary, decode_envelope_bytes

BASE_COMMIT = "e0e715c7ce994beae25e023f7600bdeaef46b576"
SOURCE_REL = Path(
    "evidence/research/20260927/u01-distinct-build-12.12.10.1/"
    "positive-qualification/cases/native-authored-one-track-positive/"
    "cycle-2/native-saved.itl"
)
EVIDENCE_REL = Path("evidence/research/20260927/u01-header-revision-gate")
CANDIDATE_REL = EVIDENCE_REL / "candidate/native-12.12.10.1-header-major-68.itl"
MANIFEST_REL = EVIDENCE_REL / "candidate-manifest.json"
PREFLIGHT_REL = EVIDENCE_REL / "preflight-report.json"
SOURCE_SHA256 = "9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772"
CANDIDATE_SHA256 = "287a9b91315be1a4917cc1a2530013c076bab824e2099885ac89d8e7ccebe59a"
PAYLOAD_SHA256 = "826863edfd2c6f44c7835b0cfebf7aa821e364490090bcdf49d82f29f458e4e9"
MUTATION_OFFSET = 0x0D
SOURCE_BYTE = 0x43
CANDIDATE_BYTE = 0x44


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def json_bytes(value: object) -> bytes:
    return (json.dumps(value, ensure_ascii=False, indent=2) + "\n").encode("utf-8")


def canonical_sha256(value: object) -> str:
    encoded = json.dumps(
        value, ensure_ascii=False, sort_keys=True, separators=(",", ":")
    ).encode("utf-8")
    return sha256(encoded)


def git(*args: str, binary: bool = False) -> bytes | str:
    result = subprocess.run(
        ["git", *args], cwd=ROOT, check=True, stdout=subprocess.PIPE
    ).stdout
    return result if binary else result.decode("utf-8")


def semantic_without_file_sha(data: bytes) -> tuple[dict, str]:
    summary = ReferenceLibrary.from_bytes(data).semantic_summary()
    file_sha = summary.pop("sha256")
    return summary, file_sha


def baseline_header_revision_census() -> dict:
    paths = [
        Path(line)
        for line in str(git("ls-tree", "-r", "--name-only", BASE_COMMIT)).splitlines()
        if line.endswith(".itl")
    ]
    tuples: dict[str, int] = {}
    short: list[str] = []
    for path in paths:
        data = git("show", f"{BASE_COMMIT}:{path.as_posix()}", binary=True)
        assert isinstance(data, bytes)
        if len(data) < 0x10:
            short.append(path.as_posix())
            continue
        key = data[0x0C:0x10].hex()
        tuples[key] = tuples.get(key, 0) + 1
    if len(paths) != 431 or short or tuples != {"00430001": 431}:
        raise RuntimeError(
            f"baseline corpus revision census changed: count={len(paths)} short={short} tuples={tuples}"
        )
    return {
        "git_commit": BASE_COMMIT,
        "tracked_itl_count": len(paths),
        "short_file_count": len(short),
        "raw_offsets_0x0c_through_0x0f_counts": tuples,
        "all_have_current_raw_tuple_00430001": True,
        "representative_sample": False,
        "claim": "exhaustive census of ITLs tracked by the pinned baseline tree only",
    }


def generate() -> tuple[bytes, bytes, bytes]:
    source = (ROOT / SOURCE_REL).read_bytes()
    if len(source) != 4904 or sha256(source) != SOURCE_SHA256:
        raise RuntimeError("source identity mismatch")
    if source[0x0C:0x10] != bytes.fromhex("00430001"):
        raise RuntimeError("source outer-header revision tuple changed")
    candidate_array = bytearray(source)
    if candidate_array[MUTATION_OFFSET] != SOURCE_BYTE:
        raise RuntimeError("source mutation byte changed")
    candidate_array[MUTATION_OFFSET] = CANDIDATE_BYTE
    candidate = bytes(candidate_array)
    if len(candidate) != 4904 or sha256(candidate) != CANDIDATE_SHA256:
        raise RuntimeError("candidate identity mismatch")
    differences = [
        {"offset": index, "before": before, "after": after}
        for index, (before, after) in enumerate(zip(source, candidate, strict=True))
        if before != after
    ]
    if differences != [{"offset": 13, "before": 67, "after": 68}]:
        raise RuntimeError(f"unexpected candidate byte differences: {differences}")

    source_envelope = decode_envelope_bytes(source)
    candidate_envelope = decode_envelope_bytes(candidate)
    source_semantics, source_semantic_file_sha = semantic_without_file_sha(source)
    candidate_semantics, candidate_semantic_file_sha = semantic_without_file_sha(candidate)
    if source_semantic_file_sha != SOURCE_SHA256 or candidate_semantic_file_sha != CANDIDATE_SHA256:
        raise RuntimeError("semantic parser file identity mismatch")
    if source_envelope.payload != candidate_envelope.payload:
        raise RuntimeError("decoded payload changed")
    if sha256(source_envelope.payload) != PAYLOAD_SHA256:
        raise RuntimeError("decoded payload identity changed")
    if source_semantics != candidate_semantics:
        raise RuntimeError("normalized semantic summary changed")

    manifest = {
        "schema": "windows-itl.u01-header-revision-candidate-manifest-20260927.v1",
        "classification": "exact one-byte ITL candidate identity; no Apple executable or resource bytes",
        "source": {
            "path": SOURCE_REL.as_posix(),
            "bytes": len(source),
            "sha256": SOURCE_SHA256,
            "raw_revision_bytes_hex": source[0x0C:0x10].hex(),
            "normalized_revision_tuple": [67, 1],
        },
        "candidate": {
            "path": CANDIDATE_REL.as_posix(),
            "bytes": len(candidate),
            "sha256": CANDIDATE_SHA256,
            "raw_revision_bytes_hex": candidate[0x0C:0x10].hex(),
            "normalized_revision_tuple": [68, 1],
        },
        "mutation": {
            "difference_count": 1,
            "differences": differences,
            "description": "raw file offset 0x0d: 0x43 -> 0x44",
            "version_label_mutated": False,
            "payload_mutated": False,
        },
        "native_executable_lock": {
            "edition": "Apple standalone Windows x64 iTunes",
            "file_version": "12.12.10.1",
            "product_version": "12.12.10.1",
            "bytes": 39260512,
            "sha256": "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b",
            "authenticode_status": "Valid",
            "signer_subject": "Apple Inc.",
            "signer_certificate_thumbprint": "67A9953123BD5F01B1BC0BB98A950D9CA869CD02",
        },
    }
    manifest_data = json_bytes(manifest)

    declared_size = int.from_bytes(candidate[8:12], "big")
    normalized_semantic_sha = canonical_sha256(source_semantics)
    preflight = {
        "schema": "windows-itl.u01-header-revision-preflight-20260927.v1",
        "classification": "deterministic offline structural and semantic preflight",
        "candidate_manifest_sha256": sha256(manifest_data),
        "independent_parser": {
            "implementation": "REFERENCE_PARSER/core.py::ReferenceLibrary.from_bytes",
            "source_parse_succeeded": True,
            "candidate_parse_succeeded": True,
            "source_and_candidate_normalized_semantics_equal": True,
            "normalization_excludes_only_top_level_file_sha256": True,
            "normalized_semantic_summary_sha256": normalized_semantic_sha,
            "version": candidate_envelope.version,
            "file_persistent_id": f"{candidate_envelope.file_persistent_id:016X}",
            "header_length": len(candidate_envelope.header),
            "actual_file_size": len(candidate),
            "declared_file_size": declared_size,
            "declared_size_matches_actual": declared_size == len(candidate),
            "encryption_mode": candidate_envelope.encryption_flag,
            "compression_mode": candidate_envelope.compression_flag,
            "payload_byteorder": candidate_envelope.payload_byteorder,
            "trailer_length": len(candidate_envelope.trailer),
            "declared_counts": candidate_envelope.declared_counts,
            "track_count": len(candidate_semantics["tracks"]),
            "playlist_count": len(candidate_semantics["playlists"]),
        },
        "decoded_payload": {
            "source_length": len(source_envelope.payload),
            "candidate_length": len(candidate_envelope.payload),
            "source_sha256": sha256(source_envelope.payload),
            "candidate_sha256": sha256(candidate_envelope.payload),
            "byte_identical": source_envelope.payload == candidate_envelope.payload,
        },
        "version_label": {
            "source": source_envelope.version,
            "candidate": candidate_envelope.version,
            "equal": source_envelope.version == candidate_envelope.version,
        },
        "identity_and_semantics": {
            "file_persistent_id_equal": source_envelope.file_persistent_id == candidate_envelope.file_persistent_id,
            "declared_counts_equal": source_envelope.declared_counts == candidate_envelope.declared_counts,
            "normalized_semantic_summary_equal": source_semantics == candidate_semantics,
        },
        "baseline_corpus_revision_census": baseline_header_revision_census(),
        "static_gate_prediction": {
            "raw_candidate_tuple_hex": "00440001",
            "normalized_candidate_tuple": [68, 1],
            "exact_parser_rva": "0x10ad0b0",
            "gate_instruction_rva": "0x10ad25c",
            "condition": "unsigned parsed-header u16 at +0x0c > 0x43",
            "status": -876,
            "caller_explicit_status_compare_rva": "0x53db8d",
            "error_group": "0x1f43",
            "primary_resource_id": "0x1f420003",
            "expected_resource_role": "newer_version_message",
            "version_label_used_by_gate": False,
        },
        "all_offline_gates_passed": True,
        "native_execution_boundary": {
            "launches_during_generation": 0,
            "eligible_only_after_plan_candidate_commit_push_and_remote_verification": True,
            "post_hoc_candidate_substitution_allowed": False,
        },
    }
    return candidate, manifest_data, json_bytes(preflight)


def check_or_write(*, write: bool) -> None:
    candidate, manifest, preflight = generate()
    expected = {
        ROOT / CANDIDATE_REL: candidate,
        ROOT / MANIFEST_REL: manifest,
        ROOT / PREFLIGHT_REL: preflight,
    }
    mismatches: list[str] = []
    for path, data in expected.items():
        if write:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(data)
        elif not path.is_file() or path.read_bytes() != data:
            mismatches.append(path.relative_to(ROOT).as_posix())
    if mismatches:
        raise RuntimeError("generated artifacts differ: " + ", ".join(mismatches))
    print(
        json.dumps(
            {
                "mode": "write" if write else "check",
                "candidate_sha256": sha256(candidate),
                "manifest_sha256": sha256(manifest),
                "preflight_sha256": sha256(preflight),
                "baseline_itls": 431,
                "all_offline_gates_passed": True,
            },
            sort_keys=True,
        )
    )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--write", action="store_true")
    mode.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    check_or_write(write=args.write)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
