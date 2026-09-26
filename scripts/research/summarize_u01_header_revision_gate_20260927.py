"""Normalize and verify the predeclared U-01 header-revision native outcome."""
from __future__ import annotations

import argparse
import copy
import hashlib
import json
from pathlib import Path
from typing import Any

from REFERENCE_PARSER.core import ReferenceLibrary

ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "evidence/research/20260927/u01-header-revision-gate"
RAW = EVIDENCE / "native-outcome"
DEFAULT_OUTPUT = EVIDENCE / "native-outcome-summary.json"
CANDIDATE = EVIDENCE / "candidate/native-12.12.10.1-header-major-68.itl"
CANDIDATE_SHA256 = "287a9b91315be1a4917cc1a2530013c076bab824e2099885ac89d8e7ccebe59a"
SEMANTIC_SHA256 = "4b6264d499b8b3380ec53008cdf2e5144f17852f2e79e1743c343b2d36026e57"
EXE_SHA256 = "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b"
THUMBPRINT = "67A9953123BD5F01B1BC0BB98A950D9CA869CD02"
PREOUTCOME_COMMIT = "5987155aeb4702f751afe827f0f2fda8c337f298"
EXPECTED_ERROR = "RuntimeError: iTunes exited nonzero after normal product-modal dismissal/close"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def read_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8-sig"))


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def facts(path: Path) -> dict[str, Any]:
    data = path.read_bytes()
    return {
        "path": path.relative_to(ROOT).as_posix(),
        "bytes": len(data),
        "sha256": sha256_bytes(data),
    }


def canonical_sha256(value: object) -> str:
    data = json.dumps(
        value, ensure_ascii=False, sort_keys=True, separators=(",", ":")
    ).encode("utf-8")
    return sha256_bytes(data)


def json_bytes(value: object) -> bytes:
    return (json.dumps(value, ensure_ascii=False, indent=2) + "\n").encode("utf-8")


def semantic_hash(summary: dict[str, Any]) -> str:
    normalized = copy.deepcopy(summary)
    normalized.pop("sha256")
    return canonical_sha256(normalized)


def exact_newer_version_message(attempt: dict[str, Any]) -> str:
    messages = [
        str(child.get("text", ""))
        for child in attempt["target_modal"]["children"]
        if child.get("visible") is True
        and "cannot be read" in str(child.get("text", "")).casefold()
        and "created by a newer version of itunes" in str(child.get("text", "")).casefold()
    ]
    require(len(messages) == 1, f"expected exactly one newer-version message, got {messages!r}")
    return messages[0]


def normalize_attempt(index: int, embedded: dict[str, Any]) -> dict[str, Any]:
    attempt_dir = RAW / f"attempt-{index}"
    result_path = attempt_dir / "result.json"
    live_summary_path = attempt_dir / "live-after-attempt-summary.json"
    live_path = attempt_dir / "live-after-attempt.itl"
    result = read_json(result_path)
    live_summary = read_json(live_summary_path)
    live_data = live_path.read_bytes()

    require(result == embedded, f"attempt {index} embedded/raw result mismatch")
    require(result["attempt"] == index, f"attempt {index} number changed")
    require(result["status"] == "failed_with_preserved_evidence", f"attempt {index} raw status changed")
    require(result["target_modal_observed"] is True, f"attempt {index} modal was not observed")
    require(result["target_modal_dismissed"] is True, f"attempt {index} modal was not dismissed")
    require(result["observed_library_modal_classification"] == "newer_version", f"attempt {index} modal classification changed")
    require(result["target_modal"]["class"] == "iTunesCustomModalDialog", f"attempt {index} modal class changed")

    message = exact_newer_version_message(result)
    ok_controls = [
        child
        for child in result["target_modal"]["children"]
        if child.get("class") == "Button"
        and str(child.get("text", "")).strip() == "OK"
        and child.get("id") == 1
        and child.get("visible") is True
        and child.get("enabled") is True
    ]
    require(len(ok_controls) == 1, f"attempt {index} visible enabled OK control count changed")
    require(result["dismiss_button"] == ok_controls[0], f"attempt {index} dismissed control changed")
    require(result["normal_close_method"] == "target_modal_ok_process_exit", f"attempt {index} close method changed")
    require(result["forced_termination"] is False, f"attempt {index} was force terminated")
    require(result["itunes_exit_code"] == 1, f"attempt {index} exit code changed")
    require(result["error"] == EXPECTED_ERROR, f"attempt {index} strict error changed")

    identity_points = {
        "before_launch": result["input_before"]["sha256"],
        "while_modal_visible": result["input_while_modal"]["sha256"],
        "after_process_exit": result["final_input_after_process_end"]["sha256"],
        "retained_copy": result["retained_live_after_attempt"]["sha256"],
        "retained_file": sha256_bytes(live_data),
    }
    require(set(identity_points.values()) == {CANDIDATE_SHA256}, f"attempt {index} candidate identity changed")
    require(len(live_data) == 4904, f"attempt {index} retained ITL size changed")
    require(live_data[0x0C:0x10] == bytes.fromhex("00440001"), f"attempt {index} revision tuple changed")

    parsed_summary = ReferenceLibrary.from_bytes(live_data).semantic_summary()
    require(parsed_summary == live_summary, f"attempt {index} retained summary is not independently reproducible")
    require(result["final_reference_summary_after_process_end"] == live_summary, f"attempt {index} raw final summary changed")
    require(live_summary["sha256"] == CANDIDATE_SHA256, f"attempt {index} summary file hash changed")
    final_semantic_hash = semantic_hash(live_summary)
    require(final_semantic_hash == SEMANTIC_SHA256, f"attempt {index} normalized semantics changed")

    require(result["final_forbidden_after_process_end"] == [], f"attempt {index} forbidden fallback appeared")
    require(result["profile_junction_remove"]["removed"] is True, f"attempt {index} profile junction was not removed")
    require(result["profile_exists_after"] is False, f"attempt {index} profile remained")
    require(result["process_cleanup_passed"] is True, f"attempt {index} process cleanup failed")

    non_exit_gates = {
        "exact_newer_version_modal_observed": True,
        "exact_newer_version_modal_dismissed": True,
        "exact_visible_enabled_ok_control": True,
        "product_exited_after_modal_dismissal_without_forced_termination": True,
        "candidate_identity_unchanged": True,
        "normalized_semantics_unchanged": True,
        "forbidden_fallback_absent": True,
        "profile_junction_removed": True,
        "process_cleanup_passed": True,
    }
    require(all(non_exit_gates.values()), f"attempt {index} non-exit gate failed")

    return {
        "attempt": index,
        "raw_evidence": {
            "result": facts(result_path),
            "retained_semantic_summary": facts(live_summary_path),
            "retained_itl": facts(live_path),
        },
        "modal": {
            "observed": True,
            "classification": "newer_version",
            "window_class": result["target_modal"]["class"],
            "message_text": message,
            "visible_enabled_ok_controls": 1,
            "dismissed": True,
        },
        "process": {
            "normal_close_method": result["normal_close_method"],
            "exit_code": result["itunes_exit_code"],
            "forced_termination": False,
            "process_cleanup_passed": True,
        },
        "candidate_preservation": {
            "identity_sha256_at_all_observation_points": CANDIDATE_SHA256,
            "identity_points": identity_points,
            "raw_revision_tuple_hex": live_data[0x0C:0x10].hex(),
            "normalized_semantic_summary_sha256": final_semantic_hash,
            "independent_parser_rebuild_matches_retained_summary": True,
            "forbidden_fallback_artifacts": [],
        },
        "profile_cleanup": {
            "junction_removed": True,
            "profile_exists_after": False,
        },
        "strict_predeclared_attempt_gate": {
            "passed": False,
            "passed_non_exit_gates": non_exit_gates,
            "failed_gates": ["itunes_exit_code_zero"],
            "observed_exit_code": 1,
            "required_exit_code": 0,
            "raw_status": result["status"],
            "raw_error": result["error"],
        },
    }


def generate() -> bytes:
    manifest_path = EVIDENCE / "candidate-manifest.json"
    preflight_path = EVIDENCE / "preflight-report.json"
    plan_path = EVIDENCE / "native-two-attempt-plan.json"
    raw_summary_path = RAW / "summary.json"
    manifest = read_json(manifest_path)
    preflight = read_json(preflight_path)
    plan = read_json(plan_path)
    raw_summary = read_json(raw_summary_path)

    candidate_data = CANDIDATE.read_bytes()
    require(len(candidate_data) == 4904 and sha256_bytes(candidate_data) == CANDIDATE_SHA256, "candidate identity changed")
    require(manifest["candidate"]["sha256"] == CANDIDATE_SHA256, "candidate manifest changed")
    require(manifest["candidate"]["raw_revision_bytes_hex"] == "00440001", "candidate manifest tuple changed")
    require(preflight["all_offline_gates_passed"] is True, "offline preflight no longer passes")
    require(preflight["independent_parser"]["normalized_semantic_summary_sha256"] == SEMANTIC_SHA256, "preflight semantic hash changed")
    require(plan["artifact_lock"]["candidate"]["sha256"] == CANDIDATE_SHA256, "plan candidate lock changed")
    require(plan["attempt_protocol"]["attempts"] == 2, "predeclared attempt count changed")
    require(any("Require exit code 0" in row for row in plan["attempt_protocol"]["normal_dismissal_and_exit"]), "exit-zero plan gate missing")
    require(plan["state_at_declaration"]["native_launches_for_this_candidate"] == 0, "plan was not pre-outcome")
    require(plan["state_at_declaration"]["native_outcomes_observed_for_this_candidate"] == 0, "plan was not pre-outcome")
    require(plan["state_at_declaration"]["post_hoc_candidate_substitution_allowed"] is False, "post-hoc substitution was allowed")

    candidate_summary = ReferenceLibrary.from_bytes(candidate_data).semantic_summary()
    require(candidate_summary["sha256"] == CANDIDATE_SHA256, "candidate parser identity changed")
    require(semantic_hash(candidate_summary) == SEMANTIC_SHA256, "candidate semantic hash changed")

    require(raw_summary["schema"] == "windows-itl.u01-header-revision-native-summary-20260927.v1", "raw summary schema changed")
    require(raw_summary["repository_commit"] == PREOUTCOME_COMMIT, "raw summary pre-outcome commit changed")
    require(raw_summary["status"] == "failed_with_preserved_evidence", "raw summary status changed")
    require(raw_summary["candidate"]["sha256"] == CANDIDATE_SHA256, "raw summary candidate changed")
    require(raw_summary["attempts_required"] == 2 and len(raw_summary["attempts"]) == 2, "raw attempt count changed")
    require(raw_summary["native_launches"] == 2, "native launch count changed")
    require(raw_summary["passed_attempts"] == 0 and raw_summary["all_passed"] is False, "raw strict result changed")
    require(raw_summary["post_hoc_candidate_substitution_allowed"] is False, "raw summary allowed substitution")

    executable = raw_summary["executable_preflight_rechecked_by_wrapper"]
    signature = executable["authenticode"]
    require(executable["sha256"] == EXE_SHA256, "executable identity changed")
    require(executable["file_version"] == executable["product_version"] == "12.12.10.1", "executable version changed")
    require(signature["status"] == "Valid", "Authenticode status changed")
    require("Apple Inc." in signature["subject"], "Authenticode subject changed")
    require(signature["thumbprint"] == THUMBPRINT, "Authenticode thumbprint changed")

    attempts = [
        normalize_attempt(index, embedded)
        for index, embedded in enumerate(raw_summary["attempts"], start=1)
    ]
    require([row["process"]["exit_code"] for row in attempts] == [1, 1], "normalized exit codes changed")
    require(all(row["modal"]["observed"] and row["modal"]["dismissed"] for row in attempts), "modal reproduction changed")
    require(all(not row["process"]["forced_termination"] for row in attempts), "forced termination appeared")
    require(all(row["strict_predeclared_attempt_gate"]["failed_gates"] == ["itunes_exit_code_zero"] for row in attempts), "a non-exit strict gate failed")

    value = {
        "schema": "windows-itl.u01-header-revision-native-outcome-normalized-20260927.v1",
        "classification": "deterministic normalized derivative of preserved raw native evidence",
        "source_boundary": {
            "preoutcome_repository_commit": PREOUTCOME_COMMIT,
            "candidate_selected_before_native_outcome": True,
            "post_hoc_candidate_substitution_allowed": False,
            "prelaunch_wrapper_refusals_before_product_start": 1,
            "product_processes_started_by_prelaunch_refusal": 0,
            "native_launches_after_corrected_bundle_was_committed_pushed_and_verified": 2,
            "additional_native_launch_authorized": False,
        },
        "inputs": {
            "candidate_manifest": facts(manifest_path),
            "independent_preflight": facts(preflight_path),
            "predeclared_two_attempt_plan": facts(plan_path),
            "raw_native_summary": facts(raw_summary_path),
        },
        "executable": {
            "edition": "Apple standalone Windows x64 iTunes",
            "file_version": executable["file_version"],
            "product_version": executable["product_version"],
            "bytes": 39260512,
            "sha256": executable["sha256"],
            "authenticode_status": signature["status"],
            "signer_subject": signature["subject"],
            "signer_certificate_thumbprint": signature["thumbprint"],
            "binary_retained": False,
        },
        "candidate": {
            **facts(CANDIDATE),
            "source_sha256": manifest["source"]["sha256"],
            "difference_count": manifest["mutation"]["difference_count"],
            "difference": manifest["mutation"]["differences"][0],
            "raw_revision_tuple_hex": "00440001",
            "normalized_revision_tuple": [68, 1],
            "version_label": preflight["version_label"]["candidate"],
            "encryption_mode": preflight["independent_parser"]["encryption_mode"],
            "compression_mode": preflight["independent_parser"]["compression_mode"],
            "normalized_semantic_summary_sha256": SEMANTIC_SHA256,
            "independent_structural_and_semantic_preflight_passed": True,
        },
        "static_prediction": preflight["static_gate_prediction"],
        "attempts": attempts,
        "aggregate_result": {
            "native_launches": 2,
            "attempts_required": 2,
            "exact_newer_version_product_modal_observations": 2,
            "exact_newer_version_product_modal_dismissals": 2,
            "exit_codes": [1, 1],
            "forced_terminations": 0,
            "candidate_identity_and_semantics_unchanged_attempts": 2,
            "forbidden_fallback_attempts": 0,
            "profile_and_process_cleanup_passed_attempts": 2,
            "strict_predeclared_passed_attempts": 0,
            "strict_two_attempt_plan_passed": False,
            "only_strict_attempt_gate_failure": "itunes_exit_code_zero",
            "bounded_static_gate_to_product_modal_causal_confirmation": True,
            "status": "bounded_causal_confirmation_with_strict_exit_code_gate_failure",
        },
        "claim_boundaries": {
            "exact_product_modal_observed": True,
            "repeated_exact_candidate_modal_observation": True,
            "bounded_product_facing_native_negative_observation": True,
            "strict_product_negative_qualification_passed": False,
            "full_predeclared_success": False,
            "u01_closed": False,
            "reference_parser_profile_admitted": False,
            "writer_profile_admitted": False,
            "arbitrary_12_12_10_1_editing_qualified": False,
            "universal_itl_support": False,
            "independent_native_reproduction": False,
            "full_analysis_specification_gate": False,
            "unresolved_item": "U-01",
        },
    }
    return json_bytes(value)


def check_or_write(*, write: bool, output: Path) -> None:
    expected = generate()
    if write:
        output.write_bytes(expected)
    elif not output.is_file() or output.read_bytes() != expected:
        raise RuntimeError(f"normalized output differs: {output.relative_to(ROOT).as_posix()}")
    print(
        json.dumps(
            {
                "mode": "write" if write else "check",
                "output": output.relative_to(ROOT).as_posix(),
                "bytes": len(expected),
                "sha256": sha256_bytes(expected),
                "native_launches": 2,
                "modal_observations": 2,
                "strict_passed_attempts": 0,
                "u01_closed": False,
            },
            sort_keys=True,
        )
    )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--write", action="store_true")
    mode.add_argument("--check", action="store_true")
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args(argv)
    output = args.output if args.output.is_absolute() else ROOT / args.output
    check_or_write(write=args.write, output=output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
