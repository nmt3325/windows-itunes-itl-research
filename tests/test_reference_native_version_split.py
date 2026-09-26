"""Offline regressions for cross-version native iTunes qualification."""
from __future__ import annotations

from scripts.windows import reference_generated_native as native


def expected(version: str = "12.13.10.3") -> dict:
    return {
        "version": version,
        "library_persistent_id": "5245464552454E43",
        "track_count": 0,
        "tracks": [],
        "playlists": [],
    }


def test_input_and_native_versions_are_independent() -> None:
    input_expected = expected()
    native_expected = native.expected_with_version(input_expected, "12.13.11.1")

    assert input_expected["version"] == "12.13.10.3"
    assert native_expected["version"] == "12.13.11.1"
    assert native_expected is not input_expected


def test_candidate_preflight_keeps_input_version_gate() -> None:
    input_expected = expected()
    summary = {
        "version": "12.13.10.3",
        "file_persistent_id": "5245464552454E43",
        "tracks": [],
        "playlists": [],
    }

    assert native.reference_summary_errors(input_expected, summary) == []
    errors = native.reference_summary_errors(
        native.expected_with_version(input_expected, "12.13.11.1"), summary
    )
    assert errors == [
        {"property": "version", "expected": "12.13.11.1", "actual": "12.13.10.3"}
    ]


def test_executable_identity_accepts_only_exact_version_and_hash() -> None:
    observed_hash = "a" * 64
    assert native.executable_identity_errors(
        expected_version="12.13.11.1",
        expected_sha256=observed_hash.upper(),
        observed_sha256=observed_hash,
        observed_file_version="12.13.11.1",
        observed_product_version="12.13.11.1",
    ) == []


def test_executable_identity_refuses_hash_mismatch() -> None:
    errors = native.executable_identity_errors(
        expected_version="12.13.11.1",
        expected_sha256="a" * 64,
        observed_sha256="b" * 64,
        observed_file_version="12.13.11.1",
        observed_product_version="12.13.11.1",
    )
    assert [error["property"] for error in errors] == ["sha256"]


def test_executable_identity_refuses_file_or_product_version_mismatch() -> None:
    errors = native.executable_identity_errors(
        expected_version="12.13.11.1",
        expected_sha256="a" * 64,
        observed_sha256="a" * 64,
        observed_file_version="12.13.10.3",
        observed_product_version="12.13.11.0",
    )
    assert [error["property"] for error in errors] == ["file_version", "product_version"]
