from __future__ import annotations

import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "audit_rating_kind_corpus_20260925.py"
EVIDENCE = ROOT / "evidence" / "research" / "20260925" / "rating-kind-corpus-audit"

spec = importlib.util.spec_from_file_location("audit_rating_kind_corpus_20260925", SCRIPT)
assert spec is not None and spec.loader is not None
audit = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = audit
spec.loader.exec_module(audit)


def test_frozen_rating_kind_corpus_counts_and_digest() -> None:
    report = audit.build_report()
    assert report["scope"]["json_files_total"] == 344
    assert report["scope"]["input_file_set_sha256"] == (
        "c4a60795026f58d5ee7a4b71ac63bad7efb2af4ddceb068d543af138ad221404"
    )
    assert report["summary"] == {
        "raw_observations": 1306,
        "unique_source_identity_states": 332,
        "distinct_joint_states": 4,
        "track_rating_kind_codes": [0, 1],
        "album_rating_kind_codes": [0, 1],
        "nonzero_track_rating_values_by_kind_code": {"0": [80], "1": [60]},
        "nonzero_album_rating_values_by_kind_code": {"0": [60], "1": [80]},
    }


def test_nonzero_values_coexist_with_both_raw_kind_codes() -> None:
    report = audit.build_report()
    states = {item["key"]: item for item in report["states"]}
    assert {item["raw_occurrences"] for item in states.values()} == {21, 36, 78, 1171}
    inherited = states["Rating=60|RatingKind=1|AlbumRating=60|AlbumRatingKind=0"]
    assert inherited["first_witness"]["source"].endswith(
        "field-matrix-20260922/cases/album-rating-explicit/expected-reload-state.json"
    )
    computed_album = states["Rating=80|RatingKind=0|AlbumRating=80|AlbumRatingKind=1"]
    assert computed_album["first_witness"]["source"].endswith(
        "field-matrix-20260922/cases/rating-explicit/expected-reload-state.json"
    )
    assert report["findings"]["track_rating_value_alone_determines_kind"] is False
    assert report["findings"]["album_rating_value_alone_determines_kind"] is False


def test_report_keeps_u14_and_native_claims_bounded() -> None:
    report = audit.build_report()
    assert report["scope"]["native_actions_performed"] is False
    assert report["scope"]["raw_occurrences_are_independent_runs"] is False
    assert report["public_prior_art"]["classification"].endswith(
        "not current-native evidence"
    )
    assert "U-14 remains open." in report["limitations"]
    assert any("Loved or Disliked" in item for item in report["limitations"])


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
