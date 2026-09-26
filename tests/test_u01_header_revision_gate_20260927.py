"""Regressions for the predeclared U-01 outer-header revision gate."""
from __future__ import annotations

import hashlib
import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EVIDENCE = ROOT / "evidence/research/20260927/u01-header-revision-gate"
REPORT = EVIDENCE / "ghidra-header-revision-gate.json"
MANIFEST = EVIDENCE / "candidate-manifest.json"
PREFLIGHT = EVIDENCE / "preflight-report.json"
PLAN = EVIDENCE / "native-two-attempt-plan.json"
CANDIDATE = EVIDENCE / "candidate/native-12.12.10.1-header-major-68.itl"
SOURCE = (
    ROOT
    / "evidence/research/20260927/u01-distinct-build-12.12.10.1"
    / "positive-qualification/cases/native-authored-one-track-positive"
    / "cycle-2/native-saved.itl"
)
GENERATOR = ROOT / "scripts/research/build_u01_header_revision_candidate_20260927.py"
GHIDRA_SCRIPT = ROOT / "scripts/ghidra/U01HeaderRevisionGate.java"
NATIVE_WRAPPER = ROOT / "scripts/windows/u01_header_revision_gate_20260927.py"
NATIVE_HARNESS = ROOT / "scripts/windows/u01_distinct_build_20260927.py"
NATIVE_COMMON = ROOT / "scripts/windows/reference_generated_native.py"

EXPECTED_HASHES = {
    REPORT: "2242e7fe1db95d95bb412df594143c2783eb84683e56188fd361b2e3276923c2",
    GHIDRA_SCRIPT: "c23f9b48ecd6b5c5121d8c5c0b166c0a2bbf41055b84fc84ae23de7b84b8b5dc",
    GENERATOR: "6418daa2dfe9c268e75c1dfff2f30869439ad9e89d467b660a087a936559d067",
    NATIVE_WRAPPER: "fd43735bd0cebdd58ad1729f2fe4973d3165df5727b294714e0b4131486e3464",
    NATIVE_HARNESS: "2f8e2339d816549991929baebbb7468d7e8903999246f41a7a23270773dc97f5",
    NATIVE_COMMON: "74787f93b149f46946528af9c385d2d90ee483d3b0337ff1f318f477b7a11e68",
    MANIFEST: "2a9a0b7719e1f4e17d3ff6b71d934d881fb69771d3d49b9ee1fc8332ba59b315",
    PREFLIGHT: "843adae57d24f22a9081493642b213c519c45bdd33c3f21c1631333ead975163",
    PLAN: "8251b6a1c11e12f8a195b999bd70b7aab1e0c27fe3a196e0d157e1aeaa34b59c",
    SOURCE: "9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772",
    CANDIDATE: "287a9b91315be1a4917cc1a2530013c076bab824e2099885ac89d8e7ccebe59a",
}


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load_module(path: Path, name: str):
    spec = importlib.util.spec_from_file_location(name, path)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def compact_window(report: dict, name: str) -> list[tuple[str, str, list[str]]]:
    return [
        (row["rva"], row["mnemonic"], row["operands"])
        for row in report["instruction_windows"][name]
    ]


def test_locked_artifact_identities_and_report_provenance() -> None:
    assert {path.relative_to(ROOT).as_posix(): sha256(path) for path in EXPECTED_HASHES} == {
        path.relative_to(ROOT).as_posix(): expected for path, expected in EXPECTED_HASHES.items()
    }
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    assert report["schema"] == "windows-itl.u01-ghidra-header-revision-gate-20260927.v1"
    assert report["classification"] == "bounded derived static metadata only; no Apple bytes retained"
    assert report["tool"] == {
        "name": "Ghidra",
        "version": "12.1.3",
        "analysis_mode": "saved full headless static analysis; target executable never launched",
    }
    assert report["executable"] == {
        "name": "iTunes.exe",
        "sha256": "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b",
        "image_base": "0x140000000",
        "function_count": 62218,
        "binary_retained": False,
    }


def test_header_producer_reader_normalizer_constructor_and_serializer_are_locked() -> None:
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    functions = report["functions"]
    assert functions["parser"]["entry_rva"] == "0x10ad0b0"
    assert functions["header_reader"]["entry_rva"] == "0x10ace80"
    assert functions["outer_header_endian_normalizer"]["entry_rva"] == "0x108de90"
    assert functions["header_constructor"]["entry_rva"] == "0x10917e0"
    assert functions["header_serializer"]["entry_rva"] == "0x1094c80"
    assert functions["writer_pipeline"]["entry_rva"] == "0x109eaf0"

    producer = compact_window(report, "parser_header_object_allocation_and_reader_call")
    assert ("0x10ad17e", "CALL", ["0x140bd9f80"]) in producer
    assert ("0x10ad183", "MOV", ["R14", "RAX"]) in producer
    assert ("0x10ad216", "CALL", ["0x1410ace80"]) in producer

    zeroes = compact_window(report, "header_reader_zeroes_exact_0x90_bytes")
    assert len(zeroes) == 10
    assert zeroes[0] == ("0x10acedd", "XORPS", ["XMM0", "XMM0"])
    assert zeroes[-1] == ("0x10aceff", "MOVUPS", ["xmmword ptr [RDX + 0x80]", "XMM0"])
    reader = compact_window(report, "header_reader_fixed_read_normalize_and_validate")
    assert ("0x10acfd3", "MOV", ["EBP", "0x90"]) in reader
    assert ("0x10acfed", "CALL", ["RAX"]) in reader
    assert ("0x10acff8", "CALL", ["0x14108de90"]) in reader
    assert ("0x10acfff", "SUB", ["EAX", "0x6864666d"]) in reader

    assert compact_window(report, "endian_normalizer_revision_words") == [
        ("0x108dee1", "MOVZX", ["EAX", "word ptr [RCX + 0xc]"]),
        ("0x108dee5", "ROL", ["AX", "0x8"]),
        ("0x108dee9", "MOV", ["word ptr [RCX + 0xc]", "AX"]),
        ("0x108deed", "MOVZX", ["EAX", "word ptr [RCX + 0xe]"]),
        ("0x108def1", "ROL", ["AX", "0x8"]),
        ("0x108def5", "MOV", ["word ptr [RCX + 0xe]", "AX"]),
    ]
    constructor = compact_window(report, "header_constructor_current_revision")
    assert ("0x109181a", "MOV", ["dword ptr [RCX]", "0x6864666d"]) in constructor
    assert ("0x1091820", "MOV", ["dword ptr [RCX + 0x4]", "0x90"]) in constructor
    assert ("0x1091888", "MOV", ["dword ptr [RBX + 0xc]", "0x10043"]) in constructor
    serializer = compact_window(report, "header_serializer_copy_normalize_write")
    assert ("0x1094d62", "MOVUPS", ["XMM0", "xmmword ptr [RBX + 0x80]"]) in serializer
    assert ("0x1094d7a", "CALL", ["0x14108de90"]) in serializer
    assert ("0x1094d8f", "MOV", ["qword ptr [RSP + 0x20]", "0x90"]) in serializer
    assert ("0x1094d98", "CALL", ["0x140bb36b0"]) in serializer
    pipeline = compact_window(report, "writer_pipeline_construct_and_emit_header")
    assert ("0x109eb8a", "CALL", ["0x1410917e0"]) in pipeline
    assert ("0x109ec15", "CALL", ["0x141094c80"]) in pipeline
    assert ("0x109f0b0", "CALL", ["0x141094c80"]) in pipeline
    assert ("0x109f0ce", "CALL", ["0x14108de90"]) in pipeline
    assert ("0x109f0d6", "MOV", ["qword ptr [RSP + 0x28]", "0x90"]) in pipeline


def test_exact_parser_alternate_gate_and_status_resource_bridge_are_locked() -> None:
    report = json.loads(REPORT.read_text(encoding="utf-8"))
    assert compact_window(report, "parser_header_word_ceiling")[:4] == [
        ("0x10ad257", "MOVZX", ["EAX", "word ptr [R14 + 0xc]"]),
        ("0x10ad25c", "CMP", ["AX", "0x43"]),
        ("0x10ad260", "JBE", ["0x1410ad26f"]),
        ("0x10ad262", "MOV", ["ESI", "0xfffffc94"]),
    ]
    assert compact_window(report, "parser_current_revision_tuple_check") == [
        ("0x10ad2c6", "CMP", ["AX", "0x43"]),
        ("0x10ad2ca", "JNZ", ["0x1410ad2d4"]),
        ("0x10ad2cc", "CMP", ["word ptr [R14 + 0xe]", "0x1"]),
        ("0x10ad2d2", "JZ", ["0x1410ad2e4"]),
    ]
    assert compact_window(report, "alternate_parser_revision_ceiling") == [
        ("0x10f4d21", "CMP", ["word ptr [RBX + 0xc]", "0x43"]),
        ("0x10f4d26", "JBE", ["0x1410f4d32"]),
        ("0x10f4d28", "MOV", ["EDI", "0xfffffc94"]),
        ("0x10f4d2d", "JMP", ["0x1410f52b0"]),
    ]
    assert compact_window(report, "direct_caller_status_comparison") == [
        ("0x53db8d", "CMP", ["R14D", "0xfffffc94"]),
        ("0x53db94", "JZ", ["0x14053e30f"]),
    ]
    error_path = compact_window(report, "status_error_path_to_group_0x1f43")
    assert ("0x53e387", "MOV", ["ECX", "0x1f43"]) in error_path
    assert ("0x53e38c", "MOV", ["R8D", "R14D"]) in error_path
    assert ("0x53e394", "CALL", ["0x140ebbf20"]) in error_path

    descriptor = report["group_0x1f43_error_descriptor"]
    assert descriptor["rva"] == "0x19fd7e8"
    assert descriptor["entry_count"] == 3
    assert descriptor["entries"][0] == {
        "index": 0,
        "rva": "0x19fd7b8",
        "status_u32": "0xfffffc94",
        "status_signed": -876,
        "metadata_u32": "0x2af80002",
        "primary_resource_id": "0x1f420003",
        "secondary_resource_id": "0x00000000",
        "resource_role_from_prior_exact_build_evidence": "newer_version_message",
    }
    assert [row["instruction"]["rva"] for row in report["status_0xfffffc94_immediate_uses"]] == [
        "0x53db8d", "0x5aef49", "0x108a422", "0x10ad262",
        "0x10ad2b9", "0x10f4d17", "0x10f4d28", "0x10f4d48",
    ]
    assert [row["instruction"]["rva"] for row in report["group_0x1f43_immediate_uses"]] == [
        "0x1fb583", "0x53e387", "0x7e48df",
    ]


def test_candidate_is_one_byte_payload_and_semantic_preserving_derivative() -> None:
    source = SOURCE.read_bytes()
    candidate = CANDIDATE.read_bytes()
    assert len(source) == len(candidate) == 4904
    assert source[0x0C:0x10] == bytes.fromhex("00430001")
    assert candidate[0x0C:0x10] == bytes.fromhex("00440001")
    assert [(index, before, after) for index, (before, after) in enumerate(zip(source, candidate, strict=True)) if before != after] == [
        (13, 67, 68)
    ]

    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    assert manifest["mutation"] == {
        "difference_count": 1,
        "differences": [{"offset": 13, "before": 67, "after": 68}],
        "description": "raw file offset 0x0d: 0x43 -> 0x44",
        "version_label_mutated": False,
        "payload_mutated": False,
    }
    preflight = json.loads(PREFLIGHT.read_text(encoding="utf-8"))
    independent = preflight["independent_parser"]
    assert independent["source_parse_succeeded"] is True
    assert independent["candidate_parse_succeeded"] is True
    assert independent["source_and_candidate_normalized_semantics_equal"] is True
    assert independent["normalization_excludes_only_top_level_file_sha256"] is True
    assert independent["version"] == "12.12.10.1"
    assert independent["file_persistent_id"] == "C4CF98746C40D802"
    assert independent["encryption_mode"] == 2
    assert independent["compression_mode"] == 1
    assert independent["actual_file_size"] == independent["declared_file_size"] == 4904
    assert independent["declared_counts"] == {
        "sections": 11, "tracks": 1, "playlists": 15, "albums": 1, "artists": 1
    }
    assert preflight["decoded_payload"] == {
        "source_length": 106776,
        "candidate_length": 106776,
        "source_sha256": "826863edfd2c6f44c7835b0cfebf7aa821e364490090bcdf49d82f29f458e4e9",
        "candidate_sha256": "826863edfd2c6f44c7835b0cfebf7aa821e364490090bcdf49d82f29f458e4e9",
        "byte_identical": True,
    }
    census = preflight["baseline_corpus_revision_census"]
    assert census["git_commit"] == "e0e715c7ce994beae25e023f7600bdeaef46b576"
    assert census["tracked_itl_count"] == 431
    assert census["short_file_count"] == 0
    assert census["raw_offsets_0x0c_through_0x0f_counts"] == {"00430001": 431}
    assert census["representative_sample"] is False
    assert preflight["all_offline_gates_passed"] is True

    generator = load_module(GENERATOR, "u01_header_revision_generator")
    rebuilt_candidate, rebuilt_manifest, rebuilt_preflight = generator.generate()
    assert rebuilt_candidate == CANDIDATE.read_bytes()
    assert rebuilt_manifest == MANIFEST.read_bytes()
    assert rebuilt_preflight == PREFLIGHT.read_bytes()


def test_preoutcome_plan_is_complete_and_records_zero_launch_boundary() -> None:
    plan = json.loads(PLAN.read_text(encoding="utf-8"))
    assert plan["schema"] == "windows-itl.u01-header-revision-two-attempt-plan-20260927.v1"
    assert plan["state_at_declaration"] == {
        "native_launches_for_this_candidate": 0,
        "native_outcomes_observed_for_this_candidate": 0,
        "candidate_selected_before_native_outcome": True,
        "post_hoc_candidate_substitution_allowed": False,
    }
    assert plan["candidate_theory"]["non_version_label_gate"] is True
    assert plan["candidate_theory"]["status"] == -876
    assert plan["candidate_theory"]["group"] == "0x1f43"
    assert plan["candidate_theory"]["resource_id"] == "0x1f420003"
    locks = plan["artifact_lock"]
    assert locks["candidate"]["sha256"] == EXPECTED_HASHES[CANDIDATE]
    assert locks["source"]["sha256"] == EXPECTED_HASHES[SOURCE]
    assert locks["manifest_sha256"] == EXPECTED_HASHES[MANIFEST]
    assert locks["preflight_report_sha256"] == EXPECTED_HASHES[PREFLIGHT]
    assert locks["ghidra_report_sha256"] == EXPECTED_HASHES[REPORT]
    assert locks["ghidra_script_sha256"] == EXPECTED_HASHES[GHIDRA_SCRIPT]
    assert locks["native_harness_sha256"] == EXPECTED_HASHES[NATIVE_WRAPPER]

    gate = plan["mandatory_prelaunch_gate"]
    assert len(gate["all_must_pass"]) == 7
    assert "Abort before the first launch" in gate["failure_policy"]
    protocol = plan["attempt_protocol"]
    assert protocol["attempts"] == 2
    assert protocol["observation_timeout_seconds_per_attempt"] == 90
    assert protocol["expected_modal"]["accepted_window_classes"] == ["iTunesCustomModalDialog", "#32770"]
    assert protocol["expected_modal"]["classification"] == "newer_version"
    assert protocol["expected_modal"]["title_alone_is_never_sufficient"] is True
    assert protocol["expected_modal"]["static_resource_id"] == "0x1f420003"
    assert protocol["expected_modal"]["static_chain_is_not_itself_modal_observation"] is True
    assert "Do not capture" in protocol["capture_policy"]["screenshots"]
    assert "not modal success" in protocol["fallback_and_cleanup"]["timeout_or_unexpected_modal"]
    assert set(plan["predeclared_outcome_classes"]) == {
        "two_attempt_success", "partial_or_single_modal", "timeout_or_main_window_only",
        "invalid_library_or_other_modal", "input_changed_or_native_save", "prelaunch_gate_failure",
    }
    assert plan["claim_limits"][-1].startswith("No timeout, forced termination")

    report = json.loads(REPORT.read_text(encoding="utf-8"))
    boundary = report["bounded_conclusion"]
    assert boundary["exact_product_modal_observed"] is False
    assert boundary["native_itunes_launches"] == 0
    assert boundary["product_facing_native_negative_established"] is False
    assert boundary["u01_status"] == "open"


def test_modal_classifier_distinguishes_newer_invalid_ambiguous_and_title_only() -> None:
    harness = load_module(NATIVE_HARNESS, "u01_distinct_harness_classifier")

    def window(*texts: str, title: str = "iTunes") -> dict:
        return {
            "title": title,
            "children": [{"text": text} for text in texts],
        }

    newer = window(
        "The file iTunes Library.itl cannot be read because it was created by a newer version of iTunes."
    )
    invalid = window(
        "The file iTunes Library.itl cannot be read because it does not appear to be a valid library file."
    )
    ambiguous = window(
        "The file cannot be read because it was created by a newer version of iTunes.",
        "It cannot be read because it does not appear to be a valid library file.",
    )
    title_only = window(title="created by a newer version of iTunes")
    unrelated = window("A newer version of iTunes is available.")

    assert harness.classify_library_modal(newer) == "newer_version"
    assert harness.classify_library_modal(invalid) == "invalid_library"
    assert harness.classify_library_modal(ambiguous) == "ambiguous_library_error"
    assert harness.classify_library_modal(title_only) is None
    assert harness.classify_library_modal(unrelated) is None
    assert harness.product_modal_matches(newer) is True
    assert harness.product_modal_matches(invalid) is False
    assert harness.product_modal_matches(ambiguous) is False
