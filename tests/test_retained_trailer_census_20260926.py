"""Regression tests for the bounded retained-corpus U-13 trailer census."""
from __future__ import annotations

import hashlib
import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/audit_retained_trailer_census_20260926.py"
REPORT = ROOT / "evidence/research/20260926/retained-trailer-census/report.json"
KNOWN = "evidence/research/20260925/native-trailer-u13/candidates/opaque-trailer-17-reference-one-track-zlib.itl"


def load_module():
    spec = importlib.util.spec_from_file_location("retained_trailer_census", SCRIPT)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_retained_trailer_census_is_complete_bounded_and_claim_limited():
    report = json.loads(REPORT.read_text())
    assert report["schema"] == "windows-itl.retained-trailer-census-20260926.v1"
    assert report["status"] == "completed_retained_corpus_census_u13_open"
    assert report["generator"] == {
        "path": "scripts/research/audit_retained_trailer_census_20260926.py",
        "sha256": hashlib.sha256(SCRIPT.read_bytes()).hexdigest(),
    }
    assert report["source_set"]["entries"] == 390
    assert report["source_set"]["representative_sample"] is False
    assert report["counts"] == {
        "byte_exact_no_op_roundtrips": 390,
        "files_with_compressed_trailer": 1,
        "files_without_compressed_trailer": 389,
        "manifest_hashes_verified": 390,
        "native_itunes_operations": 0,
        "network_operations": 0,
        "non_known_witness_files_with_trailer": 0,
        "parse_failures": 0,
        "production_code_changes": 0,
        "proprietary_binary_reads": 0,
        "strict_container_parses": 390,
    }
    assert report["distributions"]["versions"] == {"12.13.10.3": 390}
    assert report["distributions"]["compression_flags"] == {"0": 23, "1": 367}
    assert report["distributions"]["trailer_lengths"] == {"17": 1}
    assert report["parse_failures"] == []
    assert report["trailer_witnesses"] == [{
        "file_sha256": "10b17fbdd783ad17e6fa3b488ee6421f43a417b9350de547754d24d4369e4e34",
        "known_intentional_u13_witness": True,
        "path": KNOWN,
        "trailer_bytes": 17,
        "trailer_sha256": "103ea80001690bf2fccc5b4fb924760bf817e9c0b798c085e5359f68b10616ab",
    }]
    summary = report["summary"]
    assert summary["only_trailer_witness_is_known_intentional_u13_candidate"] is True
    assert summary["retained_corpus_prevalence_claim_supported"] is False
    assert summary["trailer_semantics_recovered"] is False
    assert summary["native_acceptance_established"] is False
    assert summary["u13_status"] == "open"
    assert summary["universal_itl_support"] is False
    assert summary["independent_reimplementation_passed"] is False


def test_retained_report_rebuilds_byte_exactly():
    module = load_module()
    rebuilt = (json.dumps(module.build_report(), indent=2, sort_keys=True) + "\n").encode()
    assert rebuilt == REPORT.read_bytes()
