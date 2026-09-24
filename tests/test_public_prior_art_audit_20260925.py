from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts/research/audit_public_prior_art_20260925.py"
spec = spec_from_file_location("public_prior_art_audit_20260925", SCRIPT)
module = module_from_spec(spec)
assert spec.loader is not None
spec.loader.exec_module(module)


def test_checked_in_reference_fixture_records_mixed_parser_outcomes():
    row = module.audit_itl(
        ROOT / "TEST_CORPUS/generated/reference-one-track-zlib.itl",
        display_path="reference-one-track-zlib.itl",
    )
    assert row["container"]["ok"] is True
    assert row["container"]["exact_noop"] is True
    assert row["container"]["forced_rebuild"]["payload_equal"] is True
    assert row["container"]["forced_rebuild"]["trailer_equal"] is True
    assert row["library"]["ok"] is False
    assert row["library"]["error_type"] == "FormatError"
    assert row["reference_detect"]["status"] == "recognized"
    assert row["reference_library"]["ok"] is True


def test_attempt_records_fail_closed_error_type_and_message():
    result = module._attempt(lambda: (_ for _ in ()).throw(ValueError("bounded")))
    assert result == {"ok": False, "error_type": "ValueError", "error": "bounded"}


def test_source_pins_are_full_sha1s_and_claims_are_bounded():
    assert len(module.SOURCES) == 6
    for source in module.SOURCES.values():
        assert len(source["commit"]) == 40
        int(source["commit"], 16)
        assert source["repository"].startswith("https://github.com/")
        assert source["scope"]


def test_checked_in_historical_report_has_bounded_expected_summary():
    import json

    evidence = ROOT / "evidence/research/20260925/public-prior-art"
    report = json.loads((evidence / "audit.json").read_text(encoding="utf-8"))
    assert report["native_actions"] is False
    assert report["third_party_fixture_bytes_copied"] is False
    assert report["summary"] == {
        "big_endian_payloads": 13,
        "container_decoded": 14,
        "container_exact_noop": 14,
        "forced_rebuild_payload_equal": 14,
        "forced_rebuild_trailer_equal": 14,
        "little_endian_payloads": 1,
        "reference_library_parsed": 1,
        "reference_recognized": 0,
        "reference_unsupported": 14,
        "semantic_library_parsed": 0,
        "source_checkouts": 6,
        "titl_fixtures": 14,
    }
    assert not list(evidence.rglob("*.itl"))


def test_upstream_status_distinguishes_setup_and_unexecuted_tests():
    import json

    path = ROOT / "evidence/research/20260925/public-prior-art/external-test-status.json"
    checks = json.loads(path.read_text(encoding="utf-8"))["checks"]
    assert checks["smart-playlist-io"]["initial_test_exit_code"] == 4
    assert checks["smart-playlist-io"]["result"]["passed"] == 144
    assert checks["itunes_smartplaylist"]["result"]["passed"] == 18
    assert checks["libitlp"]["initial_build_exit_code"] == 2
    assert checks["libitlp"]["retry_build_exit_code"] == 0
    assert "tests not executed" in checks["titl"]["result"]
