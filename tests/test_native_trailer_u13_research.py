import hashlib
import importlib.util
import json
import sys
import zlib

import pytest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "research" / "native_trailer_u13_20260925.py"
EVIDENCE = ROOT / "evidence" / "research" / "20260925" / "native-trailer-u13"
NATIVE = EVIDENCE / "native-run"
GENERATION = EVIDENCE / "generation.json"
ANALYSIS = EVIDENCE / "analysis.json"
PROVENANCE = EVIDENCE / "environment-provenance.json"
EVIDENCE_README = EVIDENCE / "README.md"
DOC = ROOT / "docs" / "native-trailer-u13-20260925.md"
ZLIB_NG = "zlib-ng" in zlib.ZLIB_RUNTIME_VERSION.lower()

SPEC = importlib.util.spec_from_file_location("native_trailer_u13_20260925", SCRIPT)
assert SPEC and SPEC.loader
research = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = research
SPEC.loader.exec_module(research)

CONTROL_SHA256 = "25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad"
CANDIDATE_SHA256 = "10b17fbdd783ad17e6fa3b488ee6421f43a417b9350de547754d24d4369e4e34"
PAYLOAD_SHA256 = "666c74d34556f413a76a31691be9b20f1eec8f2a9459f15b7b98f2ea0dcfa797"
TRAILER_SHA256 = "103ea80001690bf2fccc5b4fb924760bf817e9c0b798c085e5359f68b10616ab"
EMPTY_SHA256 = hashlib.sha256(b"").hexdigest()
EXPECTED_PHASE_HASHES = {
    "u13-control-no-trailer": [
        CONTROL_SHA256,
        "71ab2bb823498fda216008461591677a8e20ec5dabff7ece2d3631e31ddf58d8",
        "04c92369c988e36daf4e7f8ea3b57ca6c2cc541ee0b19ef7783825b51ed06364",
    ],
    "u13-opaque-trailer-17": [
        CANDIDATE_SHA256,
        "76155badb29a2b30ca64aeb0769dabf6bf2d928b877d236fd8bda12ca079d928",
        "7bb3dc35fda5e1f04d06b6d1e4b29c459a47c71c202edff95a045634ef8a304f",
    ],
}
EXPECTED_PHASE_FATES = {
    "u13-control-no-trailer": ["remained_absent", "remained_absent"],
    "u13-opaque-trailer-17": ["stripped", "remained_absent"],
}


def load(path: Path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def test_deterministic_pair_has_exact_bytes_hashes_and_parser_agreement():
    if ZLIB_NG:
        with pytest.raises(AssertionError, match="reference writer failed exact fixture repack"):
            research.generation_material()
        return
    control, candidate, control_analysis, candidate_analysis = research.generation_material()

    assert hashlib.sha256(control).hexdigest() == CONTROL_SHA256
    assert hashlib.sha256(candidate).hexdigest() == CANDIDATE_SHA256
    assert candidate != control
    assert len(candidate) - len(control) == 17

    assert control_analysis["primary"]["payload_sha256"] == PAYLOAD_SHA256
    assert candidate_analysis["primary"]["payload_sha256"] == PAYLOAD_SHA256
    assert control_analysis["primary"]["trailer_sha256"] == EMPTY_SHA256
    assert candidate_analysis["primary"]["trailer_sha256"] == TRAILER_SHA256
    assert candidate_analysis["primary"]["trailer_bytes"] == 17

    for row in (control_analysis, candidate_analysis):
        assert row["primary"]["payload_sha256"] == row["reference"]["payload_sha256"]
        assert row["primary"]["trailer_sha256"] == row["reference"]["trailer_sha256"]
        assert row["primary"]["no_op_exact"] is True
        assert row["reference"]["detection"]["status"] == "recognized"
        assert row["validator"]["valid"] is True

    trailer_scope = candidate_analysis["validator"]["coverage"]["compressed_trailer"]
    assert trailer_scope == {"bytes": 17, "present": True, "semantically_validated": False}
    assert "scope.compressed_trailer" in candidate_analysis["validator"]["issue_codes"]
    assert "scope.compressed_trailer" not in control_analysis["validator"]["issue_codes"]


def test_generation_manifest_and_report_pin_the_audit_without_expanding_claims():
    generation = load(GENERATION)
    manifest = load(EVIDENCE / "native-cases.json")
    generated = {row["name"]: row for row in generation["cases"]}

    assert generation["schema"] == research.SCHEMA
    assert generation["source_repository_commit"] == research.BASE_COMMIT
    assert generation["audit"]["seed"] == "0x20260925"
    assert generation["audit"]["control_case_id"] == "baseline-reference-one-track-zlib"
    assert generation["audit"]["candidate_case_id"] == "trailer-opaque-17"
    assert generation["pair_gate"] == {
        "candidate_trailer_bytes": 17,
        "candidate_trailer_sha256": TRAILER_SHA256,
        "control_trailer_sha256": EMPTY_SHA256,
        "same_semantic_payload_sha256": PAYLOAD_SHA256,
    }
    assert generation["claim_boundaries"] == research.CLAIM_BOUNDARIES
    assert [row["name"] for row in manifest] == [
        "u13-control-no-trailer",
        "u13-opaque-trailer-17",
    ]
    assert [row["sha256"] for row in manifest] == [CONTROL_SHA256, CANDIDATE_SHA256]

    for name, row in generated.items():
        observed = research.inspect_bytes((ROOT / row["path"]).read_bytes())
        assert observed == row["analysis"], name


def test_retained_analysis_is_a_deterministic_derivative(tmp_path):
    expected = load(ANALYSIS)
    output = tmp_path / "analysis.json"
    rebuilt = research.analyze(EVIDENCE, NATIVE, output, PROVENANCE)

    assert rebuilt == expected
    assert output.read_bytes() == research.json_bytes(expected)
    if ZLIB_NG:
        with pytest.raises(AssertionError, match="reference writer failed exact fixture repack"):
            research.verify_retained(EVIDENCE, NATIVE, ANALYSIS)
    else:
        assert research.verify_retained(EVIDENCE, NATIVE, ANALYSIS) == {
            "status": "passed",
            "cases": 2,
            "phases": 6,
        }


def test_exact_native_phase_hashes_restart_chain_and_trailer_fate():
    analysis = load(ANALYSIS)
    cases = {row["name"]: row for row in analysis["cases"]}

    assert analysis["matrix_status"] == "passed"
    assert analysis["pair_result"] == {
        "candidate_native_passed": True,
        "candidate_phase_fates": ["stripped", "remained_absent"],
        "control_native_passed": True,
        "copied_control_is_not_independent_experiment": True,
        "fresh_isolated_profiles": True,
        "two_cycles_requested_per_case": True,
    }

    for name, case in cases.items():
        assert case["native_status"] == "passed"
        assert case["native_passed"] is True
        assert case["restart_chain_exact"] is True
        assert case["final_forbidden_artifacts"] == []
        assert case["profile_cleanup_error"] is None
        assert case["stopped_gate_error"] is None
        assert [row["trailer_fate"] for row in case["phase_chain"]] == EXPECTED_PHASE_FATES[name]
        assert [row["analysis"]["file"]["sha256"] for row in case["phases"]] == EXPECTED_PHASE_HASHES[name]
        assert case["cycles"][1]["prelaunch"]["sha256"] == case["cycles"][0]["artifact"]["analysis"]["file"]["sha256"]

        for phase in case["phases"]:
            envelope = phase["analysis"]
            assert envelope["primary"]["payload_sha256"] == envelope["reference"]["payload_sha256"]
            assert envelope["primary"]["trailer_sha256"] == envelope["reference"]["trailer_sha256"]
            assert envelope["primary"]["no_op_exact"] is True
            assert envelope["validator"]["valid"] is True
        assert [phase["analysis"]["primary"]["trailer_bytes"] for phase in case["phases"][1:]] == [0, 0]


def test_all_four_native_cycles_keep_strict_identity_exit_modal_and_fallback_gates():
    analysis = load(ANALYSIS)
    summary = load(NATIVE / "summary.json")

    assert summary["status"] == "passed"
    assert summary["all_passed"] is True
    assert summary["cycles_required"] == 2
    assert summary["passed_cases"] == 2
    assert summary["failed_cases"] == 0
    assert summary["isolation_policy"] == {
        "damaged_library_modal_allowed": False,
        "fallback_identity_allowed": False,
        "initial_live_inventory": "candidate ITL only",
        "normal_quit_required": True,
        "previous_itunes_libraries_allowed": False,
        "xml_allowed": False,
    }

    analysis_cases = {row["name"]: row for row in analysis["cases"]}
    for retained_case in summary["cases"]:
        name = retained_case["name"]
        assert retained_case["status"] == "passed"
        assert retained_case["passed"] is True
        assert retained_case["profile_junction_create"]["returncode"] == 0
        assert retained_case["profile_junction_remove"] == {
            "command": {
                "argv": ["cmd.exe", "/d", "/c", "rmdir", "<USER_ITUNES_PROFILE>"],
                "output": "",
                "returncode": 0,
            },
            "removed": True,
        }
        assert retained_case["final_forbidden_artifacts"] == []
        assert len(retained_case["cycles"]) == 2

        for index, cycle in enumerate(retained_case["cycles"]):
            analyzed_cycle = analysis_cases[name]["cycles"][index]
            assert cycle["status"] == "passed"
            assert cycle["worker_exit_code"] == 0
            assert cycle["itunes_exit_code"] == 0
            assert cycle["worker"]["accepted"] is True
            assert cycle["worker"]["quit_requested"] is True
            assert cycle["worker"]["errors"] == []
            assert cycle["forbidden_before"] == cycle["forbidden_after"] == []
            assert cycle["reference_summary_errors"] == []
            assert [entry["action"] for entry in cycle["ui"]] == ["dismiss_audio_warning"]
            assert analyzed_cycle["artifact"]["analysis"]["file"]["sha256"] == cycle["saved"]["sha256"]

            com = load(NATIVE / "cases" / name / f"cycle-{index + 1}" / "com.json")
            assert com["accepted"] is True
            assert com["quit_requested"] is True
            assert com["errors"] == []
            assert len(com["samples"]) == 2
            assert all(sample["errors"] == [] for sample in com["samples"])
            assert com["samples"][0]["state"] == com["samples"][1]["state"]
            for sample in com["samples"]:
                state = sample["state"]
                assert state["version"] == "12.13.10.3"
                assert state["library_persistent_id"] == "5245464552454E43"
                assert state["track_count"] == 1
                assert [(row["persistent_id"], row["Name"]) for row in state["tracks"]] == [
                    ("A17E000000000001", "Reference Track Zlib")
                ]
                ordinary = [row for row in state["playlists"] if row.get("special_kind") == 0]
                assert [(row["persistent_id"], row["name"]) for row in ordinary] == [
                    ("A17E000000000002", "Reference Playlist Zlib")
                ]
                assert [member["persistent_id"] for member in ordinary[0]["members"]] == [
                    "A17E000000000001"
                ]


def test_signed_environment_provenance_separates_reused_from_fresh_observations():
    provenance = load(PROVENANCE)
    reused = provenance["classification"]["reused_environment_facts"]
    fresh = provenance["classification"]["fresh_pre_experiment_observations"]

    assert reused["source_path"] == "evidence/research/20260925/native-rating-kind/report.json"
    assert reused["source_sha256"] == research.sha256_file(ROOT / reused["source_path"])
    assert fresh["itunes_process_ids"] == []
    assert fresh["profile_present"] is False
    assert fresh["timezone"] == "UTC"
    assert provenance["installer"]["bytes"] == 208064480
    assert provenance["installer"]["sha256"] == provenance["expected_pins"]["installer_sha256"]
    assert provenance["installed_itunes"]["bytes"] == 38952912
    assert provenance["installed_itunes"]["sha256"] == provenance["expected_pins"]["itunes_sha256"]
    assert provenance["installed_itunes"]["product_version"] == "12.13.10.3"
    assert provenance["installer"]["authenticode"]["status"] == "Valid"
    assert provenance["installed_itunes"]["authenticode"]["status"] == "Valid"
    assert provenance["installer"]["authenticode"]["thumbprint"] == provenance["expected_pins"]["apple_thumbprint"]
    assert provenance["installed_itunes"]["authenticode"]["thumbprint"] == provenance["expected_pins"]["apple_thumbprint"]


def test_retained_text_is_sanitized_and_claim_boundaries_keep_u13_open():
    analysis = load(ANALYSIS)
    text_files = [
        *NATIVE.rglob("*.json"),
        *NATIVE.rglob("*.log"),
        PROVENANCE,
        ANALYSIS,
        GENERATION,
        EVIDENCE_README,
        DOC,
    ]
    retained_text = "\n".join(path.read_text(encoding="utf-8-sig") for path in text_files)
    forbidden_values = (
        "win" + "-dj1cymvp",
        "runner" + "admin",
        "D:" + "\\a\\_temp",
        "gha-mcp-" + "credentials",
    )
    for forbidden in forbidden_values:
        assert forbidden not in retained_text

    assert any("safe semantic editability" in claim for claim in analysis["claim_boundaries"])
    assert any("not independent experiments" in claim for claim in analysis["claim_boundaries"])
    assert analysis["unresolved"][-1] == "U-13 remains open regardless of this bounded candidate outcome."
    assert "U-13 remains open" in EVIDENCE_README.read_text(encoding="utf-8")
    assert "U-13 remains open" in DOC.read_text(encoding="utf-8")
    assert "U-13 remains open" in (ROOT / "UNRESOLVED.md").read_text(encoding="utf-8")
