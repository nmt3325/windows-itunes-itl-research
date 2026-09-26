from __future__ import annotations

import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "audit_path_time_retained_20260925.py"
EVIDENCE = ROOT / "evidence" / "research" / "20260925" / "path-time-retained-audit"

spec = importlib.util.spec_from_file_location("audit_path_time_retained_20260925", SCRIPT)
assert spec is not None and spec.loader is not None
audit = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = audit
spec.loader.exec_module(audit)


def test_frozen_path_time_inputs_counts_and_digests() -> None:
    report = audit.build_report()
    assert report["scope"]["source_summary_sha256"] == (
        "dce9b5382f454620a848f1f3b9c31be6c9eeaf78fcaa320140c1a349ccd8c996"
    )
    assert report["scope"]["retained_snapshot_file_set_sha256"] == (
        "e38949f720a7c4f2a11ebd910b58bc1edbaee5803bbd38a3b2c094e05e698899"
    )
    assert report["summary"] == {
        "date_cases": 8,
        "accepted": 6,
        "rejected_or_failed": 2,
        "case_snapshots_cross_checked": 8,
        "selected_track_field_values_cross_checked": 1104,
        "tracks_per_case_snapshot": [23],
        "versions": ["12.13.10.3"],
    }
    assert report["scope"]["retained_snapshots_parsed"] == 9


def test_wall_tuple_gap_and_epoch_cases_stay_exact_and_bounded() -> None:
    report = audit.build_report()
    cases = {item["name"]: item for item in report["cases"]}
    equal_names = report["findings"]["four_equal_wall_tuple_scalars"]["case_names"]
    assert [cases[name]["target"]["play_date_after"] for name in equal_names] == [
        3851325296,
        3851325296,
        3851325296,
        3851325296,
    ]
    aware = report["findings"]["aware_utc_input_converted_before_storage"]
    assert aware == {
        "case_name": "034-set-date-aware-instant",
        "input": "2026-01-15T17:34:56+00:00",
        "com_readback": "2026-01-15T12:34:56+00:00",
        "stored_scalar": 3851325296,
    }
    gap = report["findings"]["gap_normalization"]
    assert gap["input"] == "2026-03-08T02:30:00"
    assert gap["com_readback"] == "2026-03-08T03:30:00+00:00"
    assert gap["stored_scalar"] == 3855785400

    epoch = report["findings"]["epoch_boundary_failures"]
    assert epoch["case_names"] == [
        "037-set-date-epoch",
        "038-set-date-epoch-plus-one",
    ]
    assert set(epoch["errors"]) == {"OSError: [Errno 22] Invalid argument"}
    assert all(item["changed_track_count"] == 0 for item in epoch["reference_parser_date_field_changes"])
    assert "does not prove raw ITL scalar 0 or 1 rejection" in epoch["bounded_meaning"]


def test_timezone_transition_is_derived_from_retained_snapshots() -> None:
    report = audit.build_report()
    transition = report["findings"]["timezone_transition"]
    assert transition["case_name"] == "033-set-date-naive-eastern"
    assert transition["changed_track_count"] == 23
    assert transition["field_change_counts"] == {"date_modified": 23, "play_date": 1}
    assert transition["date_modified_deltas_seconds"] == [-14400]
    assert transition["date_added_change_count"] == 0
    assert transition["skip_date_change_count"] == 0
    assert "Cause is not established" in transition["bounded_meaning"]


def test_report_keeps_parser_native_and_u11_claims_bounded() -> None:
    report = audit.build_report()
    assert report["scope"]["native_actions_performed"] is False
    assert report["scope"]["frozen_evidence_modified"] is False
    assert "not a new native experiment or an external oracle" in report["scope"]["parser_boundary"]
    assert report["public_prior_art"]["classification"].endswith(
        "not binary-ITL native evidence"
    )
    assert report["findings"]["u11_closed"] is False
    assert "U-11 remains open." in report["limitations"]
    assert any("not an independent native reproduction" in item for item in report["limitations"])


def test_generator_is_deterministic_and_matches_committed_outputs(tmp_path: Path) -> None:
    first = tmp_path / "first"
    second = tmp_path / "second"
    report1 = audit.write_outputs(first)
    report2 = audit.write_outputs(second)
    assert report1 == report2
    assert (first / "report.json").read_bytes() == (second / "report.json").read_bytes()
    assert (first / "README.md").read_bytes() == (second / "README.md").read_bytes()
    assert json.loads((EVIDENCE / "report.json").read_text(encoding="utf-8")) == report1
    assert (EVIDENCE / "README.md").read_bytes() == (first / "README.md").read_bytes()
