"""Regressions for the deterministic coverage-guided parser campaign."""
from __future__ import annotations

import hashlib
import importlib.util
import json
from pathlib import Path

from itlkit import ITLError


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "run_coverage_guided_fuzz_20260925.py"
REPORT = ROOT / "evidence" / "research" / "20260925" / "coverage-guided-fuzz" / "report.json"


def load_campaign_module():
    spec = importlib.util.spec_from_file_location("coverage_guided_fuzz_20260925", SCRIPT)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_retained_report_has_complete_hashes_and_consistent_arithmetic() -> None:
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    assert report["schema"] == "windows-itunes-itl.coverage-guided-fuzz.v1"
    assert report["status"] == "completed_bounded_offline_campaign"
    assert report["target_commit"] == "7d2382cfba9c5093f3fd734f5ada1bf66cff2217"
    assert report["generator"]["path"] == "scripts/research/run_coverage_guided_fuzz_20260925.py"
    assert report["generator"]["sha256"] == hashlib.sha256(SCRIPT.read_bytes()).hexdigest()
    assert report["runtime"] == {
        "pycryptodome_version": "3.23.0",
        "python_implementation": "CPython",
        "python_version": "3.12.3",
        "zlib_compile_version": "1.3",
        "zlib_runtime_version": "1.3",
    }
    assert report["bounds"] == {
        "filesystem_publication_operations": 0,
        "max_input_bytes": 131072,
        "max_plain_bytes": 131072,
        "mutation_iterations": 20000,
        "native_itunes_operations": 0,
        "processes": 1,
    }
    assert report["anomalies"] == []

    expected_sources = {
        path.relative_to(ROOT).as_posix()
        for path in sorted((ROOT / "itlkit").glob("*.py"))
    }
    assert set(report["source_sha256"]) == expected_sources
    for relative, expected in report["source_sha256"].items():
        assert hashlib.sha256((ROOT / relative).read_bytes()).hexdigest() == expected
    for seed in report["seed_files"]:
        raw = (ROOT / seed["path"]).read_bytes()
        assert len(raw) == seed["bytes"]
        assert hashlib.sha256(raw).hexdigest() == seed["sha256"]

    summary = report["summary"]
    assert summary == {
        "accepted_mutations": 9090,
        "anomaly_count": 0,
        "control_executions": 35,
        "coverage_admission_count": 34,
        "final_edge_count_sum_not_union": 849,
        "mutation_executions": 20000,
        "refused_mutations": 10910,
    }
    candidate_hashes: set[str] = set()
    for target in report["algorithm"]["target_schedule"]:
        target_report = report["targets"][target]
        assert sum(target_report["control_outcomes"].values()) == target_report["seed_count"]
        assert sum(target_report["mutation_outcomes"].values()) == 5000
        assert target_report["queue_final_count"] == (
            target_report["seed_count"] + target_report["coverage_admission_count"]
        )
        assert target_report["coverage_admission_count"] == len(target_report["coverage_admissions"])
        assert target_report["final_edge_count"] == len(target_report["final_edges"])
        assert len(target_report["final_edges"]) == len(set(target_report["final_edges"]))
        final_edges = set(target_report["final_edges"])
        for admission in target_report["coverage_admissions"]:
            assert admission["new_edge_count"] == len(admission["new_edges"])
            assert set(admission["new_edges"]) <= final_edges
            assert admission["candidate_sha256"] not in candidate_hashes
            candidate_hashes.add(admission["candidate_sha256"])
    assert len(candidate_hashes) == summary["coverage_admission_count"]


def test_small_campaign_is_deterministic_and_exception_taxonomy_is_strict(monkeypatch) -> None:
    campaign = load_campaign_module()
    first = campaign.run_campaign(64)
    second = campaign.run_campaign(64)
    assert first == second
    assert first["summary"]["control_executions"] == 35
    assert first["summary"]["mutation_executions"] == 64
    assert first["anomalies"] == []
    assert campaign.EXPECTED_EXCEPTIONS == (ITLError,)

    tracer = campaign.ArcTracer()
    outcome, detail, _ = campaign.execute_target("model", b"\x00", tracer)
    assert outcome == "refused"
    assert detail["exception"] == "FormatError"
    assert tracer.last_line == {}

    def unexpected_value_error(_data: bytes) -> dict:
        raise ValueError("unexpected internal failure")

    monkeypatch.setitem(campaign.TARGETS, "model", unexpected_value_error)
    outcome, detail, _ = campaign.execute_target("model", b"anything", tracer)
    assert outcome == "anomaly"
    assert detail["exception"] == "ValueError"
    assert tracer.last_line == {}
