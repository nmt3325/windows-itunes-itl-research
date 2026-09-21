from __future__ import annotations

import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import pytest

from REFERENCE_PARSER.core import ReferenceLibrary, detect_bytes
from REFERENCE_WRITER.writer import ConversionRefused, convert_version
from SEMANTIC_DIFF.diff import semantic_diff_bytes
from TEST_CORPUS.generate import (
    check_manifest,
    generate_bytes,
    generate_default_corpus,
    provenance_path,
)
from VALIDATOR.validator import validate_bytes


ROOT = Path(__file__).resolve().parents[1]
REFERENCE_DIRECTORIES = (
    "REFERENCE_PARSER",
    "REFERENCE_WRITER",
    "VALIDATOR",
    "SEMANTIC_DIFF",
    "TEST_CORPUS",
)
NATIVE_ONE_TRACK = ROOT / "evidence" / "native" / "snapshots" / "001-one-track.itl"
CHECKED_IN_RAW = ROOT / "TEST_CORPUS" / "generated" / "reference-one-track-raw.itl"


def _imported_modules(tree: ast.AST) -> set[str]:
    result: set[str] = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            result.update(alias.name for alias in node.names)
        elif isinstance(node, ast.ImportFrom) and node.module:
            result.add(node.module)
    return result


def _rewrite_version(raw: bytes, version: str) -> bytes:
    encoded = version.encode("ascii")
    assert 1 <= len(encoded) <= 31
    changed = bytearray(raw)
    changed[0x10:0x30] = bytes(0x20)
    changed[0x10] = len(encoded)
    changed[0x11 : 0x11 + len(encoded)] = encoded
    return bytes(changed)


def _issue_codes(report: dict) -> set[str]:
    return {issue["code"] for issue in report["issues"]}


def test_reference_packages_do_not_import_itlkit() -> None:
    checked = []
    for directory in REFERENCE_DIRECTORIES:
        for path in sorted((ROOT / directory).rglob("*.py")):
            tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
            imported = _imported_modules(tree)
            assert not any(name == "itlkit" or name.startswith("itlkit.") for name in imported), path
            checked.append(path)
    assert len(checked) >= 19


@pytest.mark.parametrize("compressed", [False, True])
def test_generated_library_has_selected_semantics_and_valid_references(compressed: bool) -> None:
    raw, provenance = generate_bytes(compressed=compressed)
    detection = detect_bytes(raw)
    library = ReferenceLibrary.from_bytes(raw)
    summary = library.semantic_summary()
    validation = validate_bytes(raw)

    assert detection["status"] == "recognized"
    assert detection["version"] == "12.13.10.3"
    assert summary["tracks"][0]["name"] == "Reference Track"
    assert summary["tracks"][0]["persistent_id"] == "A17E000000000001"
    assert summary["playlists"][0]["name"] == "Reference Playlist"
    assert summary["playlists"][0]["members"][0]["track_persistent_id"] == "A17E000000000001"
    assert summary["envelope"]["compression_flag"] == int(compressed)
    assert validation["valid"] is True
    assert provenance["template_reused"] is False
    assert provenance["template_sha256"] is None
    assert provenance["native_acceptance"]["status"] == "unverified"
    assert provenance["native_acceptance"]["tested"] is False


def test_version_detector_distinguishes_recognized_unsupported_and_malformed() -> None:
    raw, _ = generate_bytes()
    assert detect_bytes(raw)["status"] == "recognized"
    unsupported = detect_bytes(_rewrite_version(raw, "12.13.99.9"))
    malformed = detect_bytes(b"not an ITL")
    assert unsupported["status"] == "unsupported"
    assert unsupported["version"] == "12.13.99.9"
    assert malformed["status"] == "malformed"


def test_record_dump_is_bounded_and_hashes_records() -> None:
    raw, _ = generate_bytes()
    dump = ReferenceLibrary.from_bytes(raw).record_dump(include_header_hex=True)
    assert dump["schema"] == "reference-itl.record-dump.v1"
    assert dump["source_sha256"] == hashlib.sha256(raw).hexdigest()
    assert [section["type"] for section in dump["sections"]] == [16, 9, 11, 1, 2]
    track_root = dump["sections"][3]["root"]
    track = track_root["children"][0]
    assert track["tag"] == "mith"
    assert track["header_length"] == 756
    assert len(track["raw_sha256"]) == 64
    assert len(track["header_hex"]) == 756 * 2
    assert track["children"][0]["tag"] == "mhoh"


def test_validator_rejects_outer_count_mismatch() -> None:
    raw, _ = generate_bytes()
    corrupt = bytearray(raw)
    corrupt[0x44:0x48] = (2).to_bytes(4, "big")
    report = validate_bytes(bytes(corrupt))
    assert report["valid"] is False
    assert "count.outer_mismatch" in _issue_codes(report)


def test_validator_rejects_dangling_playlist_track_reference() -> None:
    raw, _ = generate_bytes()
    corrupt = bytearray(raw)
    item = corrupt.find(b"mtph", 144)
    assert item >= 144
    corrupt[item + 0x18 : item + 0x1C] = (999).to_bytes(4, "little")
    report = validate_bytes(bytes(corrupt))
    assert report["valid"] is False
    assert "reference.track_missing" in _issue_codes(report)


def test_semantic_diff_uses_persistent_ids_and_reports_section_fallback() -> None:
    before, _ = generate_bytes(track_name="Before", playlist_name="Playlist A")
    after, _ = generate_bytes(track_name="After", playlist_name="Playlist B")
    same = semantic_diff_bytes(before, before)
    changed = semantic_diff_bytes(before, after)

    assert same["has_differences"] is False
    assert changed["has_differences"] is True
    assert changed["tracks"]["changed"][0]["persistent_id"] == "A17E000000000001"
    assert {x["field"] for x in changed["tracks"]["changed"][0]["changes"]} == {"name"}
    assert changed["playlists"]["changed"][0]["persistent_id"] == "A17E000000000002"
    assert changed["section_digest_changes"]
    assert changed["coverage"]["native_acceptance"] == "not evaluated"


def test_identity_conversion_is_exact_and_cross_version_is_fail_closed(tmp_path: Path) -> None:
    raw, _ = generate_bytes()
    source = tmp_path / "source.itl"
    identity = tmp_path / "identity.itl"
    refused = tmp_path / "refused.itl"
    source.write_bytes(raw)

    report = convert_version(source, identity, "12.13.10.3")
    assert report["byte_exact"] is True
    assert report["cross_version_conversion"] is False
    assert identity.read_bytes() == raw

    with pytest.raises(ConversionRefused, match="cross-version conversion is not implemented"):
        convert_version(source, refused, "12.13.9.1")
    assert not refused.exists()


def test_template_use_and_native_acceptance_are_machine_readable() -> None:
    template, _ = generate_bytes()
    generated, provenance = generate_bytes(template_bytes=template)
    assert generated
    assert provenance["generation_mode"] == "template-envelope"
    assert provenance["template_reused"] is True
    assert provenance["template_sha256"] == hashlib.sha256(template).hexdigest()
    assert provenance["native_acceptance"] == {
        "status": "unverified",
        "tested": False,
        "reason": "No iTunes launch/save/reload evidence is associated with this generated output.",
    }


def test_manifest_hashes_generated_files(tmp_path: Path) -> None:
    corpus = tmp_path / "corpus"
    manifest = generate_default_corpus(corpus)
    assert check_manifest(corpus)["ok"] is True
    assert manifest["files"]
    for entry in manifest["files"]:
        path = corpus / entry["path"]
        raw = path.read_bytes()
        assert entry["bytes"] == len(raw)
        assert entry["sha256"] == hashlib.sha256(raw).hexdigest()
        if path.suffix == ".itl":
            provenance = json.loads(provenance_path(path).read_text(encoding="utf-8"))
            assert provenance["native_acceptance"]["status"] == "unverified"
            assert entry["native_acceptance"] == "unverified"
            assert entry["template_reused"] is False


def test_checked_in_manifest_and_corpus() -> None:
    result = check_manifest(ROOT / "TEST_CORPUS")
    assert result["ok"] is True
    assert CHECKED_IN_RAW.exists()
    assert validate_bytes(CHECKED_IN_RAW.read_bytes())["valid"] is True


def test_real_native_fixture_is_parsed_and_validated() -> None:
    assert NATIVE_ONE_TRACK.exists(), "delivery must include the native one-track fixture"
    raw = NATIVE_ONE_TRACK.read_bytes()
    detection = detect_bytes(raw)
    summary = ReferenceLibrary.from_bytes(raw).semantic_summary()
    validation = validate_bytes(raw)
    assert detection["status"] == "recognized"
    assert detection["version"] == "12.13.10.3"
    assert len(summary["tracks"]) == 1
    assert validation["valid"] is True


def _run_module(*arguments: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, "-B", "-m", *arguments],
        cwd=ROOT,
        text=True,
        encoding="utf-8",
        capture_output=True,
        check=False,
    )


@pytest.mark.parametrize(
    "module",
    ["REFERENCE_PARSER", "REFERENCE_WRITER", "VALIDATOR", "SEMANTIC_DIFF", "TEST_CORPUS"],
)
def test_cli_help(module: str) -> None:
    result = _run_module(module, "--help")
    assert result.returncode == 0, result.stderr
    assert "usage:" in result.stdout.lower()


def test_cli_json_and_fail_closed_exit_codes(tmp_path: Path) -> None:
    sample = tmp_path / "sample.itl"
    changed = tmp_path / "changed.itl"
    refused = tmp_path / "refused.itl"
    sample.write_bytes(generate_bytes()[0])
    changed.write_bytes(generate_bytes(track_name="Changed")[0])

    detect = _run_module("REFERENCE_PARSER", "detect", str(sample))
    validate = _run_module("VALIDATOR", str(sample))
    diff = _run_module("SEMANTIC_DIFF", str(sample), str(changed), "--fail-on-change")
    convert = _run_module(
        "REFERENCE_WRITER",
        "convert",
        str(sample),
        str(refused),
        "--to-version",
        "12.13.9.1",
    )

    assert detect.returncode == 0
    assert json.loads(detect.stdout)["status"] == "recognized"
    assert validate.returncode == 0
    assert json.loads(validate.stdout)["valid"] is True
    assert diff.returncode == 1
    assert json.loads(diff.stdout)["has_differences"] is True
    assert convert.returncode == 2
    assert "fail" not in convert.stdout.lower()
    assert not refused.exists()
