"""Normalize the retained exact-hash iTunes 12.13.11.1 qualification evidence."""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "evidence/research/20260927/itunes-12.13.11.1-version-qualification"
DEFAULT_OUTPUT = EVIDENCE / "qualification-summary.json"
EXPECTED_INPUT_VERSION = "12.13.10.3"
EXPECTED_NATIVE_VERSION = "12.13.11.1"
EXPECTED_EXECUTABLE_SHA256 = "c69e719cd3f2f9374e71c954a6de87002b6988af65129943983a2f17490dd73c"
HARNESS_COMMIT = "39a02b616e7837f37700d30de67c3cc9a9a62d0a"


def read_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8-sig"))


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def relative(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def file_facts(path: Path) -> dict[str, Any]:
    return {"path": relative(path), "bytes": path.stat().st_size, "sha256": sha256_file(path)}


def preflight(label: str, directory: Path) -> dict[str, Any]:
    summary = read_json(directory / "summary.json")
    case = summary["cases"][0]
    cycle = case["cycles"][0]
    modal_rows = [row for row in cycle.get("ui", []) if "modal" in row.get("action", "")]
    texts: list[str] = []
    for row in modal_rows:
        for child in row.get("window", {}).get("children", []):
            text = child.get("text")
            if text:
                texts.append(text)
    candidate_hash = case["candidate"]["sha256"]
    failure_hash = cycle["live_at_failure"]["sha256"]
    return {
        "label": label,
        "status": summary["status"],
        "error": cycle["error"],
        "modal_texts": texts,
        "native_semantic_gate_reached": "worker" in cycle,
        "candidate_unchanged": candidate_hash == failure_hash,
        "candidate_sha256": candidate_hash,
        "native_cycles_completed": 0,
        "classification": "environment_setup_failure_not_itl_rejection",
        "evidence": relative(directory),
    }


def cohort(label: str, directory: Path) -> dict[str, Any]:
    summary = read_json(directory / "summary.json")
    params = summary["qualification_parameters"]
    executable = summary["environment"]["itunes"]
    if summary["status"] != "passed" or not summary["all_passed"]:
        raise ValueError(f"qualification cohort did not pass: {label}")
    if params != {
        "expected_executable_version": EXPECTED_NATIVE_VERSION,
        "expected_executable_sha256": EXPECTED_EXECUTABLE_SHA256,
        "expected_native_version": EXPECTED_NATIVE_VERSION,
        "input_versions": [EXPECTED_INPUT_VERSION],
    }:
        raise ValueError(f"unexpected qualification parameters: {label}")
    if executable["sha256"] != EXPECTED_EXECUTABLE_SHA256:
        raise ValueError(f"unexpected executable hash: {label}")
    if executable["file_version"] != EXPECTED_NATIVE_VERSION or executable["product_version"] != EXPECTED_NATIVE_VERSION:
        raise ValueError(f"unexpected executable version: {label}")
    if executable["errors"]:
        raise ValueError(f"executable identity errors were retained: {label}")
    signature = json.loads(executable["authenticode"]["output"])
    if signature["Status"] != "Valid" or "Apple Inc." not in signature["Subject"]:
        raise ValueError(f"unexpected Authenticode result: {label}")

    cases: list[dict[str, Any]] = []
    for case in summary["cases"]:
        if case["status"] != "passed" or not case["passed"]:
            raise ValueError(f"case did not pass: {case['name']}")
        if case["candidate_reference_summary"]["version"] != EXPECTED_INPUT_VERSION:
            raise ValueError(f"input version mismatch: {case['name']}")
        if case["candidate_reference_summary_errors"]:
            raise ValueError(f"input preflight errors: {case['name']}")
        if case["expected_native"]["version"] != EXPECTED_NATIVE_VERSION:
            raise ValueError(f"native expectation mismatch: {case['name']}")
        if len(case["cycles"]) != 2:
            raise ValueError(f"two cycles were not retained: {case['name']}")

        cycles: list[dict[str, Any]] = []
        for cycle in case["cycles"]:
            cycle_number = cycle["cycle"]
            saved_path = directory / "cases" / case["name"] / f"cycle-{cycle_number}" / "native-saved.itl"
            saved = file_facts(saved_path)
            com_versions = {
                sample["state"]["version"] for sample in cycle["worker"]["samples"]
            }
            if cycle["status"] != "passed" or cycle["worker_exit_code"] != 0 or cycle["itunes_exit_code"] != 0:
                raise ValueError(f"native cycle failed: {case['name']} cycle {cycle_number}")
            if cycle["worker"]["errors"] or cycle["reference_summary_errors"]:
                raise ValueError(f"semantic errors in native cycle: {case['name']} cycle {cycle_number}")
            if cycle["forbidden_before"] or cycle["forbidden_after"]:
                raise ValueError(f"fallback artifacts in native cycle: {case['name']} cycle {cycle_number}")
            if com_versions != {EXPECTED_NATIVE_VERSION} or cycle["reference_summary"]["version"] != EXPECTED_NATIVE_VERSION:
                raise ValueError(f"native version mismatch: {case['name']} cycle {cycle_number}")
            if saved["sha256"] != cycle["saved"]["sha256"] or saved["bytes"] != cycle["saved"]["bytes"]:
                raise ValueError(f"retained native save mismatch: {case['name']} cycle {cycle_number}")
            cycles.append(
                {
                    "cycle": cycle_number,
                    "input_sha256": cycle["prelaunch"]["sha256"],
                    "saved": saved,
                    "com_version": EXPECTED_NATIVE_VERSION,
                    "saved_itl_version": cycle["reference_summary"]["version"],
                    "worker_exit_code": cycle["worker_exit_code"],
                    "itunes_exit_code": cycle["itunes_exit_code"],
                    "normal_quit": cycle["worker"]["quit_requested"] is True and cycle["itunes_exit_code"] == 0,
                    "identity_and_semantic_errors": 0,
                    "forbidden_artifacts": 0,
                }
            )
        cases.append(
            {
                "name": case["name"],
                "candidate": {
                    "path": case["candidate_relative_path"],
                    "bytes": case["candidate"]["bytes"],
                    "sha256": case["candidate"]["sha256"],
                    "input_itl_version": case["candidate_reference_summary"]["version"],
                },
                "track_count": case["expected_input"]["track_count"],
                "cycles": cycles,
                "passed": True,
            }
        )

    return {
        "label": label,
        "status": summary["status"],
        "manifest": file_facts(directory / "case-manifest.json"),
        "executable": {
            "path": executable["path"],
            "bytes": read_json(EVIDENCE / "provenance/itunes-12.13.11.1.json")["executable_bytes"],
            "sha256": executable["sha256"],
            "file_version": executable["file_version"],
            "product_version": executable["product_version"],
            "authenticode_status": signature["Status"],
            "signer_subject": signature["Subject"],
            "signer_thumbprint": signature["Thumbprint"],
        },
        "cases": cases,
        "passed_cases": len(cases),
        "passed_cycles": sum(len(case["cycles"]) for case in cases),
    }


def build_summary() -> dict[str, Any]:
    one = cohort("one-track raw/zlib", EVIDENCE / "native/one-track")
    three = cohort("three-track raw/zlib", EVIDENCE / "native/three-track")
    setup = read_json(EVIDENCE / "provenance/first-launch-setup-12.13.10.3.json")
    negatives = read_json(EVIDENCE / "negative-executable-identity-preflights.json")
    if not setup["accepted_eula"] or setup["com_version"] != EXPECTED_INPUT_VERSION:
        raise ValueError("first-launch setup report is inconsistent")
    if any(row["exit_code"] == 0 or row["root_created"] or row["evidence_created"] for row in negatives["runs"]):
        raise ValueError("an executable identity negative preflight did not fail closed")

    total_cases = one["passed_cases"] + three["passed_cases"]
    total_cycles = one["passed_cycles"] + three["passed_cycles"]
    return {
        "schema": "windows-itl.itunes-version-qualification-20260927.v1",
        "status": "passed_exact_hash_upgrade_qualification",
        "generator": {"path": relative(Path(__file__)), "sha256": sha256_file(Path(__file__))},
        "harness_commit": HARNESS_COMMIT,
        "platform": "Windows Server 2025 10.0.26100",
        "input_itl_version": EXPECTED_INPUT_VERSION,
        "native_itunes_version": EXPECTED_NATIVE_VERSION,
        "executable_sha256": EXPECTED_EXECUTABLE_SHA256,
        "provenance": {
            "itunes_12_13_10_3": relative(EVIDENCE / "provenance/itunes-12.13.10.3.json"),
            "itunes_12_13_11_1": relative(EVIDENCE / "provenance/itunes-12.13.11.1.json"),
            "chocolatey_package_script": relative(EVIDENCE / "provenance/chocolatey-install-12.13.11.1.ps1"),
        },
        "first_launch_setup": {
            "accepted_eula": setup["accepted_eula"],
            "dismissed_known_audio_warning": any(row["action"] == "dismiss_known_audio_warning" for row in setup["actions"]),
            "com_version": setup["com_version"],
            "com_quit_requested": setup["com_quit_requested"],
            "forced_setup_kill_after_quit_timeout": setup["com_quit_timed_out"],
            "profile_junction_removed": setup["junction_remove"]["returncode"] == 0,
            "classification": "controlled_environment_setup_not_native_candidate_qualification",
        },
        "preflight_failures": [
            preflight("initial EULA modal", EVIDENCE / "preflight/12.13.10.3-eula-modal"),
            preflight("12.13.11 update-offer modal", EVIDENCE / "preflight/12.13.10.3-update-offer-modal"),
        ],
        "executable_identity_negative_preflights": {
            "runs": len(negatives["runs"]),
            "all_refused_before_root_or_evidence_creation": all(
                row["exit_code"] != 0 and not row["root_created"] and not row["evidence_created"]
                for row in negatives["runs"]
            ),
            "itunes_processes_after": negatives["itunes_processes_after"],
            "profile_exists_after": negatives["profile_exists_after"],
            "evidence": relative(EVIDENCE / "negative-executable-identity-preflights.json"),
        },
        "cohorts": [one, three],
        "totals": {
            "exact_input_hashes": total_cases,
            "passed_cases": total_cases,
            "passed_native_cycles": total_cycles,
            "failed_cases": 0,
            "failed_native_cycles": 0,
            "normal_quit_cycles": total_cycles,
            "forbidden_artifact_cycles": 0,
        },
        "result": {
            "exact_hash_upgrade_open_save_restart_qualified": True,
            "input_version_rewritten_to_native_version": True,
            "u01_closed": False,
            "universal_itl_support": False,
            "full_analysis_specification_gate": False,
        },
        "claim_limits": [
            "The pass applies only to the exact signed iTunes executable hash and four pinned 12.13.10.3 input fixture hashes retained here.",
            "The two repeated cycles per case are one controlled sequence, not independent reproductions or a population-level compatibility estimate.",
            "Opening, COM identity checks, native saves, normal Quit, and independent parsing do not qualify arbitrary fields, counts, media, opaque records, other iTunes builds, or universal ITL support.",
            "The two 12.13.10.3 preflight failures were unexpected setup/update modals before semantic qualification and are not ITL rejections.",
            "U-01 remains open because version breadth still lacks a deliberately sampled multi-version positive/negative matrix and independent reproduction.",
        ],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    report = build_summary()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8", newline="\n"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
