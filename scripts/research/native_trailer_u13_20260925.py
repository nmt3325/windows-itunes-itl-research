"""Generate and analyze the bounded U-13 native compressed-trailer matrix.

This script deliberately reuses the exact fixed-seed ``trailer-opaque-17``
witness from ``audit_trailer_coverage.py`` and its exact trailer-free source.
It does not infer trailer semantics or safe editability. Native execution is
performed separately by the existing fail-closed Windows harness
``scripts/windows/reference_generated_native.py``.
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from itlkit import Container
from REFERENCE_PARSER.core import ReferenceLibrary, decode_envelope_bytes, detect_bytes
from VALIDATOR.validator import validate_bytes

SCHEMA = "windows-itl.native-trailer-u13.v1"
BASE_COMMIT = "a6876a532e0abc12535316a97ad20897eccedf7d"
SOURCE_PATH = "TEST_CORPUS/generated/reference-one-track-zlib.itl"
AUDIT_SCRIPT = ROOT / "scripts" / "research" / "audit_trailer_coverage.py"
AUDIT_REPORT = ROOT / "evidence" / "research" / "20260925" / "trailer-coverage-audit" / "report.json"
REFERENCE_CASES = ROOT / "scripts" / "windows" / "reference_generated_native_cases.json"
DEFAULT_OUTPUT = ROOT / "evidence" / "research" / "20260925" / "native-trailer-u13"
CONTROL_NAME = "u13-control-no-trailer"
CANDIDATE_NAME = "u13-opaque-trailer-17"
AUDIT_CONTROL_ID = "baseline-reference-one-track-zlib"
AUDIT_CANDIDATE_ID = "trailer-opaque-17"
EXPECTED_CONTROL_SHA256 = "25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad"
EXPECTED_CANDIDATE_SHA256 = "10b17fbdd783ad17e6fa3b488ee6421f43a417b9350de547754d24d4369e4e34"
EXPECTED_PAYLOAD_SHA256 = "666c74d34556f413a76a31691be9b20f1eec8f2a9459f15b7b98f2ea0dcfa797"
EXPECTED_TRAILER_SHA256 = "103ea80001690bf2fccc5b4fb924760bf817e9c0b798c085e5359f68b10616ab"
EMPTY_SHA256 = hashlib.sha256(b"").hexdigest()
CLAIM_BOUNDARIES = [
    "Exact-candidate evidence only: one 17-byte fixed-seed opaque trailer and its exact trailer-free control.",
    "Native acceptance, if observed, does not establish trailer meaning, provenance, safe semantic editability, or universal ITL support.",
    "Parser, validator, no-op, and envelope agreement are structural evidence and are not substitutes for native acceptance.",
    "Repeated saves and the copied control are phase-chain observations, not independent experiments.",
    "Results are bounded to the signed standalone Windows iTunes 12.13.10.3 executable and the retained one-track semantic profile.",
]


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def json_bytes(value: Any) -> bytes:
    return (json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode("utf-8")


def write_bytes_exact(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)


def write_json(path: Path, value: Any) -> None:
    write_bytes_exact(path, json_bytes(value))


def repo_relative(path: Path) -> str:
    resolved = path.resolve()
    try:
        return resolved.relative_to(ROOT).as_posix()
    except ValueError:
        return resolved.name


def load_audit_module():
    spec = importlib.util.spec_from_file_location("u13_audit_source", AUDIT_SCRIPT)
    if spec is None or spec.loader is None:
        raise RuntimeError("unable to load trailer audit module")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def expected_semantics() -> dict[str, Any]:
    cases = json.loads(REFERENCE_CASES.read_text(encoding="utf-8"))
    matches = [row["expected"] for row in cases if row["name"] == "reference-one-track-zlib"]
    if len(matches) != 1:
        raise AssertionError("reference one-track zlib semantics are not uniquely pinned")
    return matches[0]


def normalized_validator(report: dict[str, Any]) -> dict[str, Any]:
    return {
        "valid": report["valid"],
        "issue_codes": [issue["code"] for issue in report["issues"]],
        "coverage": report["coverage"],
    }


def inspect_bytes(data: bytes) -> dict[str, Any]:
    primary = Container.from_bytes(data)
    reference = decode_envelope_bytes(data)
    reference_library = ReferenceLibrary.from_bytes(data)
    detection = detect_bytes(data)
    validator = validate_bytes(data)
    if primary.payload != reference.payload or primary.trailer != reference.trailer:
        raise AssertionError("primary/reference envelope analysis disagrees")
    if detection.get("status") != "recognized":
        raise AssertionError("candidate is not recognized by the independent detector")
    return {
        "file": {"bytes": len(data), "sha256": sha256_bytes(data)},
        "primary": {
            "version": primary.version,
            "compression_flag": primary.compression_flag,
            "encryption_flag": primary.encryption_flag,
            "max_crypt_size": primary.max_crypt_size,
            "payload_bytes": len(primary.payload),
            "payload_sha256": sha256_bytes(primary.payload),
            "trailer_bytes": len(primary.trailer),
            "trailer_sha256": sha256_bytes(primary.trailer),
            "trailer_hex": primary.trailer.hex(),
            "no_op_exact": primary.to_bytes() == data,
        },
        "reference": {
            "version": reference.version,
            "payload_bytes": len(reference.payload),
            "payload_sha256": sha256_bytes(reference.payload),
            "trailer_bytes": len(reference.trailer),
            "trailer_sha256": sha256_bytes(reference.trailer),
            "tracks": len(reference_library.track_records),
            "playlists": len(reference_library.playlist_records),
            "sections": len(reference_library.sections),
            "detection": detection,
        },
        "validator": normalized_validator(validator),
    }


def generation_material() -> tuple[bytes, bytes, dict[str, Any], dict[str, Any]]:
    module = load_audit_module()
    builder = module.AuditBuilder()
    builder.build()
    candidates = {case.case_id: case for case in builder.cases}
    control = builder.sources[SOURCE_PATH]
    candidate = candidates[AUDIT_CANDIDATE_ID].data
    control_audit = candidates[AUDIT_CONTROL_ID]
    candidate_audit = candidates[AUDIT_CANDIDATE_ID]
    if sha256_bytes(control) != EXPECTED_CONTROL_SHA256:
        raise AssertionError("control hash drifted")
    if sha256_bytes(candidate) != EXPECTED_CANDIDATE_SHA256:
        raise AssertionError("opaque-trailer candidate hash drifted")
    control_analysis = inspect_bytes(control)
    candidate_analysis = inspect_bytes(candidate)
    if control_analysis["primary"]["payload_sha256"] != EXPECTED_PAYLOAD_SHA256:
        raise AssertionError("control payload hash drifted")
    if candidate_analysis["primary"]["payload_sha256"] != EXPECTED_PAYLOAD_SHA256:
        raise AssertionError("candidate payload differs from exact control")
    if control_analysis["primary"]["trailer_sha256"] != EMPTY_SHA256:
        raise AssertionError("control unexpectedly has a trailer")
    if candidate_analysis["primary"]["trailer_bytes"] != 17:
        raise AssertionError("candidate trailer length drifted")
    if candidate_analysis["primary"]["trailer_sha256"] != EXPECTED_TRAILER_SHA256:
        raise AssertionError("candidate trailer hash drifted")
    audit_report = json.loads(AUDIT_REPORT.read_text(encoding="utf-8"))
    audit_rows = {row["id"]: row for row in audit_report["cases"]}
    for case_id, case, data in (
        (AUDIT_CONTROL_ID, control_audit, control),
        (AUDIT_CANDIDATE_ID, candidate_audit, candidate),
    ):
        if audit_rows[case_id]["candidate"]["sha256"] != sha256_bytes(data):
            raise AssertionError(f"retained audit row hash mismatch: {case_id}")
        if case.case_id != case_id:
            raise AssertionError("audit case identity mismatch")
    return control, candidate, control_analysis, candidate_analysis


def generate(output: Path) -> dict[str, Any]:
    output = output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    candidates_dir = output / "candidates"
    control_path = candidates_dir / "control-reference-one-track-zlib.itl"
    candidate_path = candidates_dir / "opaque-trailer-17-reference-one-track-zlib.itl"
    generation_path = output / "generation.json"
    manifest_path = output / "native-cases.json"
    for path in (control_path, candidate_path, generation_path, manifest_path):
        if path.exists():
            raise RuntimeError(f"refusing to overwrite retained artifact: {path}")
    control, candidate, control_analysis, candidate_analysis = generation_material()
    write_bytes_exact(control_path, control)
    write_bytes_exact(candidate_path, candidate)
    semantics = expected_semantics()
    native_manifest = [
        {
            "name": CONTROL_NAME,
            "candidate": repo_relative(control_path),
            "sha256": EXPECTED_CONTROL_SHA256,
            "expected": semantics,
        },
        {
            "name": CANDIDATE_NAME,
            "candidate": repo_relative(candidate_path),
            "sha256": EXPECTED_CANDIDATE_SHA256,
            "expected": semantics,
        },
    ]
    write_json(manifest_path, native_manifest)
    report = {
        "schema": SCHEMA,
        "operation": "deterministic_generation",
        "source_repository_commit": BASE_COMMIT,
        "source": {
            "path": SOURCE_PATH,
            "sha256": EXPECTED_CONTROL_SHA256,
            "retained_native_qualification": "evidence/native/reference-generated-20260922-passed/qualification-summary.json",
        },
        "audit": {
            "script": repo_relative(AUDIT_SCRIPT),
            "script_sha256": sha256_file(AUDIT_SCRIPT),
            "report": repo_relative(AUDIT_REPORT),
            "report_sha256": sha256_file(AUDIT_REPORT),
            "seed": "0x20260925",
            "control_case_id": AUDIT_CONTROL_ID,
            "candidate_case_id": AUDIT_CANDIDATE_ID,
        },
        "native_harness": {
            "path": "scripts/windows/reference_generated_native.py",
            "policy": "existing fail-closed isolated harness; two cycles; no weakened gates",
            "case_manifest": repo_relative(manifest_path),
        },
        "cases": [
            {"name": CONTROL_NAME, "role": "exact_trailer_free_control", "path": repo_relative(control_path), "analysis": control_analysis},
            {"name": CANDIDATE_NAME, "role": "fixed_seed_opaque_trailer_candidate", "path": repo_relative(candidate_path), "analysis": candidate_analysis},
        ],
        "pair_gate": {
            "same_semantic_payload_sha256": EXPECTED_PAYLOAD_SHA256,
            "control_trailer_sha256": EMPTY_SHA256,
            "candidate_trailer_bytes": 17,
            "candidate_trailer_sha256": EXPECTED_TRAILER_SHA256,
        },
        "claim_boundaries": CLAIM_BOUNDARIES,
    }
    write_json(generation_path, report)
    return report


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8-sig"))


def artifact_row(path: Path, label: str) -> dict[str, Any]:
    analysis = inspect_bytes(path.read_bytes())
    return {"label": label, "path": repo_relative(path), "analysis": analysis}


def trailer_fate(before: dict[str, Any], after: dict[str, Any]) -> str:
    left = before["analysis"]["primary"]
    right = after["analysis"]["primary"]
    if left["trailer_bytes"] == 0 and right["trailer_bytes"] == 0:
        return "remained_absent"
    if left["trailer_bytes"] > 0 and right["trailer_bytes"] == 0:
        return "stripped"
    if (left["trailer_bytes"], left["trailer_sha256"]) == (right["trailer_bytes"], right["trailer_sha256"]):
        return "preserved_exactly"
    return "transformed"


def summarize_cycle(cycle: dict[str, Any], cycle_dir: Path) -> dict[str, Any]:
    com_path = cycle_dir / "com.json"
    result_path = cycle_dir / "result.json"
    row: dict[str, Any] = {
        "cycle": cycle.get("cycle"),
        "status": cycle.get("status"),
        "prelaunch": cycle.get("prelaunch"),
        "worker_exit_code": cycle.get("worker_exit_code"),
        "worker_accepted": (cycle.get("worker") or {}).get("accepted"),
        "worker_errors": (cycle.get("worker") or {}).get("errors"),
        "quit_requested": (cycle.get("worker") or {}).get("quit_requested"),
        "itunes_exit_code": cycle.get("itunes_exit_code"),
        "forbidden_before": cycle.get("forbidden_before"),
        "forbidden_after": cycle.get("forbidden_after"),
        "ui_actions": [entry.get("action") for entry in cycle.get("ui", [])],
        "reference_summary_errors": cycle.get("reference_summary_errors"),
        "result_json": {"path": repo_relative(result_path), "sha256": sha256_file(result_path)} if result_path.is_file() else None,
        "com_json": {"path": repo_relative(com_path), "sha256": sha256_file(com_path)} if com_path.is_file() else None,
    }
    saved_path = cycle_dir / "native-saved.itl"
    failure_path = cycle_dir / "live-at-failure.itl"
    if saved_path.is_file():
        row["artifact"] = artifact_row(saved_path, f"cycle-{cycle.get('cycle')}-native-saved")
    elif failure_path.is_file():
        row["artifact"] = artifact_row(failure_path, f"cycle-{cycle.get('cycle')}-live-at-failure")
    else:
        row["artifact"] = None
    if cycle.get("windows_at_failure") is not None:
        row["windows_at_failure"] = cycle["windows_at_failure"]
    if cycle.get("error") is not None:
        row["error"] = cycle["error"]
    return row


def analyze(output_root: Path, native_evidence: Path, output: Path, environment_provenance: Path | None) -> dict[str, Any]:
    output_root = output_root.resolve()
    native_evidence = native_evidence.resolve()
    generation = load_json(output_root / "generation.json")
    manifest = load_json(output_root / "native-cases.json")
    summary = load_json(native_evidence / "summary.json")
    by_name = {row["name"]: row for row in summary["cases"]}
    cases: list[dict[str, Any]] = []
    for case in manifest:
        name = case["name"]
        if name not in by_name:
            raise AssertionError(f"native summary is missing case {name}")
        case_result_path = native_evidence / "cases" / name / "result.json"
        retained_case = load_json(case_result_path)
        input_path = ROOT / case["candidate"]
        phases = [artifact_row(input_path, "candidate-input")]
        cycles = []
        for cycle in retained_case.get("cycles", []):
            cycle_number = cycle["cycle"]
            cycle_dir = native_evidence / "cases" / name / f"cycle-{cycle_number}"
            cycle_row = summarize_cycle(cycle, cycle_dir)
            cycles.append(cycle_row)
            if cycle_row["artifact"] is not None:
                phases.append(cycle_row["artifact"])
        phase_chain: list[dict[str, Any]] = []
        for index in range(1, len(phases)):
            phase_chain.append({
                "from": phases[index - 1]["label"],
                "to": phases[index]["label"],
                "file_changed": phases[index - 1]["analysis"]["file"]["sha256"] != phases[index]["analysis"]["file"]["sha256"],
                "payload_changed": phases[index - 1]["analysis"]["primary"]["payload_sha256"] != phases[index]["analysis"]["primary"]["payload_sha256"],
                "trailer_fate": trailer_fate(phases[index - 1], phases[index]),
            })
        restart_chain_ok = True
        for index in range(1, len(cycles)):
            prior_artifact = cycles[index - 1].get("artifact")
            next_prelaunch = cycles[index].get("prelaunch") or {}
            if prior_artifact is None or prior_artifact["analysis"]["file"]["sha256"] != next_prelaunch.get("sha256"):
                restart_chain_ok = False
        cases.append({
            "name": name,
            "role": "exact_trailer_free_control" if name == CONTROL_NAME else "fixed_seed_opaque_trailer_candidate",
            "native_status": retained_case.get("status"),
            "native_passed": retained_case.get("passed"),
            "case_result": {"path": repo_relative(case_result_path), "sha256": sha256_file(case_result_path)},
            "phases": phases,
            "phase_chain": phase_chain,
            "restart_chain_exact": restart_chain_ok,
            "cycles": cycles,
            "final_forbidden_artifacts": retained_case.get("final_forbidden_artifacts"),
            "profile_cleanup_error": retained_case.get("profile_cleanup_error"),
            "stopped_gate_error": retained_case.get("stopped_gate_error"),
        })
    candidate = next(row for row in cases if row["name"] == CANDIDATE_NAME)
    control = next(row for row in cases if row["name"] == CONTROL_NAME)
    report = {
        "schema": SCHEMA,
        "operation": "retained_native_analysis",
        "matrix_status": summary.get("status"),
        "native_harness_summary": {"path": repo_relative(native_evidence / "summary.json"), "sha256": sha256_file(native_evidence / "summary.json")},
        "generation": {"path": repo_relative(output_root / "generation.json"), "sha256": sha256_file(output_root / "generation.json")},
        "environment_provenance": ({"path": repo_relative(environment_provenance), "sha256": sha256_file(environment_provenance)} if environment_provenance else None),
        "cases": cases,
        "pair_result": {
            "control_native_passed": control["native_passed"],
            "candidate_native_passed": candidate["native_passed"],
            "candidate_phase_fates": [row["trailer_fate"] for row in candidate["phase_chain"]],
            "fresh_isolated_profiles": True,
            "two_cycles_requested_per_case": summary.get("cycles_required") == 2,
            "copied_control_is_not_independent_experiment": True,
        },
        "claim_boundaries": CLAIM_BOUNDARIES,
        "unresolved": [
            "Trailer bytes still lack provenance, a decoder, and a safe independence proof.",
            "This pair cannot establish safe semantic edits, arbitrary trailer handling, other profile shapes, or other iTunes builds.",
            "U-13 remains open regardless of this bounded candidate outcome.",
        ],
    }
    write_json(output, report)
    return report


def verify_retained(output_root: Path, native_evidence: Path, analysis_path: Path) -> dict[str, Any]:
    control, candidate, _, _ = generation_material()
    generation = load_json(output_root / "generation.json")
    analysis = load_json(analysis_path)
    if generation["pair_gate"]["same_semantic_payload_sha256"] != EXPECTED_PAYLOAD_SHA256:
        raise AssertionError("generation payload claim drifted")
    if analysis["claim_boundaries"] != CLAIM_BOUNDARIES:
        raise AssertionError("claim boundaries drifted")
    if sha256_bytes(control) != EXPECTED_CONTROL_SHA256 or sha256_bytes(candidate) != EXPECTED_CANDIDATE_SHA256:
        raise AssertionError("deterministic cases drifted")
    for case in analysis["cases"]:
        phases = case["phases"]
        for phase in phases:
            path = ROOT / phase["path"]
            observed = inspect_bytes(path.read_bytes())
            if observed != phase["analysis"]:
                raise AssertionError(f"retained phase analysis drifted: {phase['path']}")
        for index in range(1, len(case["cycles"])):
            prior = case["cycles"][index - 1]["artifact"]
            current = case["cycles"][index]["prelaunch"]
            if prior is None or prior["analysis"]["file"]["sha256"] != current["sha256"]:
                raise AssertionError(f"restart phase chain broke: {case['name']}")
    if repo_relative(native_evidence / "summary.json") != analysis["native_harness_summary"]["path"]:
        raise AssertionError("native evidence path drifted")
    return {"status": "passed", "cases": len(analysis["cases"]), "phases": sum(len(row["phases"]) for row in analysis["cases"])}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    generate_parser = sub.add_parser("generate")
    generate_parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT)
    analyze_parser = sub.add_parser("analyze")
    analyze_parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT)
    analyze_parser.add_argument("--native-evidence", type=Path, required=True)
    analyze_parser.add_argument("--output", type=Path)
    analyze_parser.add_argument("--environment-provenance", type=Path)
    verify_parser = sub.add_parser("verify-retained")
    verify_parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT)
    verify_parser.add_argument("--native-evidence", type=Path, required=True)
    verify_parser.add_argument("--analysis", type=Path)
    args = parser.parse_args(argv)
    if args.command == "generate":
        report = generate(args.output_root)
        print(json.dumps({"status": "generated", "cases": len(report["cases"]), "output": repo_relative(args.output_root)}, sort_keys=True))
        return 0
    if args.command == "analyze":
        output = args.output or (args.output_root / "analysis.json")
        report = analyze(args.output_root, args.native_evidence, output, args.environment_provenance)
        print(json.dumps({"status": "analyzed", "matrix_status": report["matrix_status"], "output": repo_relative(output)}, sort_keys=True))
        return 0
    analysis_path = args.analysis or (args.output_root / "analysis.json")
    result = verify_retained(args.output_root, args.native_evidence, analysis_path)
    print(json.dumps(result, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
