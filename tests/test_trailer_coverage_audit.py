"""Regressions for the deterministic trailer/coverage differential audit."""
from __future__ import annotations

import hashlib
import json
from pathlib import Path
import subprocess
import sys
import zlib

import pytest

from itlkit import Container, FormatError, Library
from VALIDATOR.validator import validate_bytes


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "audit_trailer_coverage.py"
REPORT = ROOT / "evidence" / "research" / "20260925" / "trailer-coverage-audit" / "report.json"
GENERATED = sorted((ROOT / "TEST_CORPUS" / "generated").glob("*.itl"))
ZLIB_NG = "zlib-ng" in zlib.ZLIB_RUNTIME_VERSION.lower()


def test_exact_native_qualified_fixtures_are_primary_readable_but_not_editable() -> None:
    assert len(GENERATED) == 4
    for path in GENERATED:
        raw = path.read_bytes()
        library = Library.from_bytes(raw)
        assert library.to_bytes() == raw
        assert library.tracks
        with pytest.raises(FormatError, match="zero secondary"):
            library.tracks[0].set(rating=library.tracks[0].get("rating"))


def test_validator_exposes_opaque_compressed_trailer_scope() -> None:
    raw = (ROOT / "TEST_CORPUS" / "generated" / "reference-one-track-zlib.itl").read_bytes()
    container = Container.from_bytes(raw)
    container.trailer = b"\x78\x9cnot-a-second-semantic-payload"
    candidate = container.to_bytes(rebuild=True)
    report = validate_bytes(candidate)

    assert report["valid"] is True
    assert "scope.compressed_trailer" in {issue["code"] for issue in report["issues"]}
    assert report["coverage"]["compressed_trailer"] == {
        "present": True,
        "bytes": len(container.trailer),
        "semantically_validated": False,
    }


def test_trailer_coverage_report_regenerates_byte_exactly(tmp_path: Path) -> None:
    regenerated = tmp_path / "report.json"
    completed = subprocess.run(
        [sys.executable, "-B", str(SCRIPT), "--output", str(regenerated)],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )
    if ZLIB_NG:
        assert completed.returncode != 0
        assert "reference writer failed exact fixture repack" in completed.stderr
        assert not regenerated.exists()
        return
    completed.check_returncode()
    summary = json.loads(completed.stdout)
    report = json.loads(regenerated.read_text(encoding="utf-8"))

    assert summary["status"] == "passed"
    assert summary["cases"] == 57
    assert report["coverage"]["trailer_cases"] == 19
    assert report["coverage"]["plaintext_limit_probes"] == 4
    assert regenerated.read_bytes() == REPORT.read_bytes()


def test_minimized_repro_is_addressable_by_case_id(tmp_path: Path) -> None:
    output = tmp_path / "concatenated-member.itl"
    completed = subprocess.run(
        [
            sys.executable,
            "-B",
            str(SCRIPT),
            "--case",
            "trailer-concatenated-zlib-member",
            "--write-repro",
            str(output),
        ],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )
    if ZLIB_NG:
        assert completed.returncode != 0
        assert "reference writer failed exact fixture repack" in completed.stderr
        assert not output.exists()
        return
    completed.check_returncode()
    receipt = json.loads(completed.stdout)
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    witness = next(
        case for case in report["cases"] if case["id"] == receipt["case"]
    )

    assert hashlib.sha256(output.read_bytes()).hexdigest() == receipt["sha256"]
    assert receipt["sha256"] == witness["candidate"]["sha256"]
    envelope = Container.from_bytes(output.read_bytes())
    assert envelope.trailer.startswith(b"\x78")
