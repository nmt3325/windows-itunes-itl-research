"""Normalize the predeclared iTunes 12.12.10.1 U-01 experiment."""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "evidence/research/20260927/u01-distinct-build-12.12.10.1"
DEFAULT_OUTPUT = EVIDENCE / "distinct-build-summary.json"
VERSION = "12.12.10.1"
EXE_SHA256 = "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b"
EXE_BYTES = 39_260_512
INSTALLER_SHA256 = "31465167704b2fd795aafc14cf5c04261d7c3ae663d087f63842e431aa204abc"
INSTALLER_BYTES = 211_230_064
PACKAGE_SHA256 = "47327162dc0c2d1b23bd0921664fd1879fa05a9b1c5b3a84c730a3d1ac01c396"
PACKAGE_BYTES = 3_718
THUMBPRINT = "67A9953123BD5F01B1BC0BB98A950D9CA869CD02"
INPUT_SHA256 = "154146cf6eabdd7b8dd30f74e2c7009d0a8615d38b36edd1a3abbbacfc10cddc"
MEDIA_SHA256 = "6df7b7eaf17f07e213238b7bcd6692a3d6ea844cee377d761bcc7f8434261792"
OUTER_PID = "C4CF98746C40D802"
COM_LIBRARY_PID = "6002C2960B55A3CB"
TRACK_PID = "C8FB5925BC26E77C"
PLAYLIST_PID = "5FA9D851819CFC35"
POSITIVE_SAVED_HASHES = (
    "09db3d7c0425a8350e33c4f461dd465fb476947f3a76c0f1ed4f67e29a284acc",
    "9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772",
)
NEGATIVE_INPUT_SHA256 = "c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74"
NEGATIVE_OUTPUT_HASHES = (
    "b92b3b62dd418a4010e14b2da2e4b92abe7268dcd0d54a560b1cd29a57cdef59",
    "b852b7d439bdf03d988e3f732a076d9f67e872a8314b68eee0435e210fa111f8",
)
SELECTED_SEMANTICS = {
    "name": "U01 12.12.10.1 Native α",
    "artist": "Distinct Build Artist Ω",
    "album": "Distinct Build Album 2023",
    "album_artist": "Distinct Album Artist β",
    "comment": "Predeclared native baseline — 20260927",
    "rating": 80,
    "play_count": 2,
    "skip_count": 1,
    "track_number": 1,
    "year": 2023,
}
COM_SEMANTICS = {
    "Name": SELECTED_SEMANTICS["name"],
    "Artist": SELECTED_SEMANTICS["artist"],
    "Album": SELECTED_SEMANTICS["album"],
    "AlbumArtist": SELECTED_SEMANTICS["album_artist"],
    "Comment": SELECTED_SEMANTICS["comment"],
    "Rating": SELECTED_SEMANTICS["rating"],
    "PlayedCount": SELECTED_SEMANTICS["play_count"],
    "SkippedCount": SELECTED_SEMANTICS["skip_count"],
    "TrackNumber": SELECTED_SEMANTICS["track_number"],
    "Year": SELECTED_SEMANTICS["year"],
}


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


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


def facts(path: Path) -> dict[str, Any]:
    return {"path": relative(path), "bytes": path.stat().st_size, "sha256": sha256_file(path)}


def select(row: dict[str, Any], expected: dict[str, Any]) -> dict[str, Any]:
    result = {key: row.get(key) for key in expected}
    require(result == expected, f"selected semantics changed: {result!r}")
    return result


def parse_authenticode(command: dict[str, Any]) -> dict[str, Any]:
    require(command["returncode"] == 0, "Authenticode probe failed")
    value = json.loads(command["output"])
    require(value["Status"] == "Valid", "Authenticode status changed")
    require("Apple Inc." in value["Subject"], "Authenticode subject changed")
    require(value["Thumbprint"] == THUMBPRINT, "Authenticode thumbprint changed")
    return {
        "status": value["Status"],
        "subject": value["Subject"],
        "thumbprint": value["Thumbprint"],
    }


def validate_provenance() -> dict[str, Any]:
    plan_path = EVIDENCE / "predeclared-plan.json"
    lock_path = EVIDENCE / "provenance/build-identity-lock.json"
    installer_path = EVIDENCE / "provenance/installer-identity.json"
    plan = read_json(plan_path)
    lock = read_json(lock_path)
    installer = read_json(installer_path)
    state = plan["state_at_declaration"]
    require(state["native_itunes_12_12_10_1_launches"] == 0, "plan was not prelaunch")
    require(state["native_candidate_outcomes_observed"] == 0, "candidate outcome was observed before plan")
    require(state["post_hoc_negative_selection_allowed"] is False, "post-hoc selection was allowed")
    target = plan["target_build"]
    require(target["version"] == VERSION, "planned build changed")
    require(target["chocolatey_package_sha256"] == PACKAGE_SHA256, "package hash changed")
    require(target["apple_installer_expected_sha256"] == INSTALLER_SHA256, "planned installer hash changed")
    negative = plan["negative_qualification"]
    require(negative["input_sha256"] == NEGATIVE_INPUT_SHA256, "planned negative changed")
    require(negative["isolated_attempts"] == 2, "planned negative attempt count changed")

    executable = lock["executable"]
    require(lock["pre_native_state"] == {"itunes_process_count": 0, "profile_exists": False, "candidate_runs": 0}, "identity lock was not pre-native")
    require(executable["bytes"] == EXE_BYTES and executable["sha256"] == EXE_SHA256, "executable identity changed")
    require(executable["file_version"] == executable["product_version"] == VERSION, "executable version changed")
    require(executable["authenticode"]["status"] == "Valid", "locked executable signature changed")
    require(executable["authenticode"]["thumbprint"] == THUMBPRINT, "locked executable thumbprint changed")
    require(lock["installer"]["bytes"] == INSTALLER_BYTES and lock["installer"]["sha256"] == INSTALLER_SHA256, "installer identity changed")
    require(lock["chocolatey_package"]["bytes"] == PACKAGE_BYTES and lock["chocolatey_package"]["sha256"] == PACKAGE_SHA256, "package identity changed")
    require(installer["bytes"] == INSTALLER_BYTES and installer["sha256"] == INSTALLER_SHA256, "independent installer lock changed")
    require(installer["package_expected_sha256"] == INSTALLER_SHA256, "package/installer expectation changed")
    require(installer["authenticode"]["status"] == "Valid" and installer["authenticode"]["thumbprint"] == THUMBPRINT, "installer signature changed")
    return {
        "predeclared_plan": facts(plan_path),
        "build_identity_lock": facts(lock_path),
        "predeclared_before_native_launch_or_candidate_outcome": True,
        "post_hoc_negative_substitution_allowed": False,
        "runner_environment_id": lock["runner_environment_id"],
        "package": {"bytes": PACKAGE_BYTES, "sha256": PACKAGE_SHA256},
        "installer": {
            "url": installer["url"],
            "bytes": INSTALLER_BYTES,
            "sha256": INSTALLER_SHA256,
            "authenticode": installer["authenticode"],
            "binary_retained": False,
        },
        "executable": {
            "version": VERSION,
            "bytes": EXE_BYTES,
            "sha256": EXE_SHA256,
            "authenticode": executable["authenticode"],
            "binary_retained": False,
        },
    }


def validate_setup() -> tuple[dict[str, Any], dict[str, Any]]:
    setup = read_json(EVIDENCE / "input-lock/setup-result.json")
    lock = read_json(EVIDENCE / "input-lock/input-lock.json")
    input_path = EVIDENCE / "input-lock/native-authored-input.itl"
    media_path = EVIDENCE / "input-lock/media/u01-12.12.10.1-523hz.wav"
    require(setup["status"] == "passed", "native input setup failed")
    require(setup["com_version"] == VERSION and setup["com_samples_stable"] is True, "setup COM gate failed")
    require(setup["normal_com_quit_requested"] is True and setup["itunes_exit_code"] == 0, "setup did not exit normally")
    require(setup["forced_termination"] is False, "setup was force terminated")
    require(setup["forbidden_after"] == [] and setup["process_cleanup_passed"] is True, "setup cleanup/fallback gate failed")
    require(setup["profile_exists_after"] is False, "setup profile junction remained")
    require([row["action"] for row in setup["ui"]] == ["accept_eula", "dismiss_known_audio_warning", "decline_update_and_do_not_ask"], "setup UI sequence changed")
    require(facts(input_path)["sha256"] == INPUT_SHA256 and facts(input_path)["bytes"] == 4865, "locked input changed")
    require(facts(media_path)["sha256"] == MEDIA_SHA256 and facts(media_path)["bytes"] == 44144, "locked media changed")
    require(lock["input"]["sha256"] == INPUT_SHA256 and lock["media"]["sha256"] == MEDIA_SHA256, "lock facts changed")
    require(lock["outer_file_persistent_id"] == OUTER_PID, "outer file identity changed")
    require(lock["com_library_persistent_id"] == COM_LIBRARY_PID, "COM library identity changed")
    require(lock["identity_domains_are_distinct"] is True and OUTER_PID != COM_LIBRARY_PID, "identity domains collapsed")
    require(lock["com_gate_errors"] == lock["reference_summary_errors"] == [], "setup semantic gates failed")
    detect = json.loads(lock["reference_detect"])
    require(detect["status"] == "unsupported" and detect["version"] == VERSION and detect["profile"] is None, "12.12.10.1 was unexpectedly admitted")
    expected = lock["expected"]
    require(expected["version"] == VERSION and expected["track_count"] == 1, "locked expected state changed")
    require(expected["tracks"] == [{"persistent_id": TRACK_PID, **SELECTED_SEMANTICS}], "locked track semantics changed")
    require(expected["playlists"] == [{"persistent_id": PLAYLIST_PID, "name": "Synthetic U01 12.12.10.1", "members": [TRACK_PID]}], "locked playlist changed")
    return expected, {
        "classification": "native_authored_input_generation_not_independent_writer_or_qualification_cycle",
        "status": "passed",
        "input": facts(input_path),
        "media": facts(media_path),
        "reference_detector_status": detect["status"],
        "reference_detector_reason": detect["reason"],
        "outer_file_persistent_id": OUTER_PID,
        "com_library_persistent_id": COM_LIBRARY_PID,
        "identity_domains_are_distinct": True,
        "track_persistent_id": TRACK_PID,
        "playlist_persistent_id": PLAYLIST_PID,
        "selected_track_semantics": SELECTED_SEMANTICS,
        "ordinary_playlist": {"name": "Synthetic U01 12.12.10.1", "members": [TRACK_PID]},
        "stable_com_samples": 2,
        "normal_com_quit": True,
        "itunes_exit_code": 0,
        "forbidden_artifacts": 0,
        "remaining_itunes_processes": 0,
    }


def validate_positive(expected: dict[str, Any]) -> dict[str, Any]:
    summary = read_json(EVIDENCE / "positive-qualification/summary.json")
    require(summary["status"] == "passed" and summary["all_passed"] is True, "positive qualification failed")
    require(summary["passed_cases"] == 1 and summary["failed_cases"] == 0, "positive case totals changed")
    require(summary["cycles_required"] == 2, "positive cycle requirement changed")
    executable = summary["environment"]["itunes"]
    require(executable["sha256"] == EXE_SHA256 and executable["file_version"] == executable["product_version"] == VERSION, "positive executable identity changed")
    auth = parse_authenticode(executable["authenticode"])
    case = summary["cases"][0]
    require(case["name"] == "native-authored-one-track-positive", "positive case changed")
    require(case["passed"] is True and case["status"] == "passed", "positive case failed")
    require(case["candidate"]["sha256"] == INPUT_SHA256, "positive candidate changed")
    require(case["expected"] == case["expected_native"] == expected, "positive expected state changed")
    require(case["candidate_reference_summary_errors"] == [], "positive input parser gate failed")
    require(case["final_forbidden_artifacts"] == [], "positive final fallback artifacts appeared")
    require(case["profile_junction_remove"]["removed"] is True, "positive profile cleanup failed")
    cycles = []
    previous = INPUT_SHA256
    for index, (cycle, expected_hash) in enumerate(zip(case["cycles"], POSITIVE_SAVED_HASHES, strict=True), 1):
        require(cycle["cycle"] == index and cycle["status"] == "passed", f"positive cycle {index} failed")
        require(cycle["expected_prelaunch_sha256"] == cycle["prelaunch"]["sha256"] == previous, f"positive cycle {index} chain changed")
        require(cycle["worker_exit_code"] == cycle["itunes_exit_code"] == 0, f"positive cycle {index} process exit changed")
        require(cycle["worker"]["accepted"] is True and cycle["worker"]["quit_requested"] is True, f"positive cycle {index} COM gate failed")
        require(cycle["worker"]["errors"] == [] and cycle["reference_summary_errors"] == [], f"positive cycle {index} semantic error")
        require(cycle["forbidden_before"] == cycle["forbidden_after"] == [], f"positive cycle {index} fallback artifact")
        require(len(cycle["worker"]["samples"]) == 2, f"positive cycle {index} sample count changed")
        for sample in cycle["worker"]["samples"]:
            require(sample["errors"] == [], f"positive cycle {index} COM sample error")
            state = sample["state"]
            require(state["version"] == VERSION and state["library_persistent_id"] == COM_LIBRARY_PID, f"positive cycle {index} COM identity changed")
            track = next(row for row in state["tracks"] if row["persistent_id"] == TRACK_PID)
            require(select(track, COM_SEMANTICS) == COM_SEMANTICS, f"positive cycle {index} COM semantics changed")
            playlist = next(row for row in state["playlists"] if row["persistent_id"] == PLAYLIST_PID)
            require(playlist["name"] == "Synthetic U01 12.12.10.1", f"positive cycle {index} playlist name changed")
            require([row["persistent_id"] for row in playlist["members"]] == [TRACK_PID], f"positive cycle {index} playlist order changed")
        parser = cycle["reference_summary"]
        require(parser["version"] == VERSION and parser["file_persistent_id"] == OUTER_PID, f"positive cycle {index} parser identity changed")
        parser_track = next(row for row in parser["tracks"] if row["persistent_id"] == TRACK_PID)
        require(select(parser_track, SELECTED_SEMANTICS) == SELECTED_SEMANTICS, f"positive cycle {index} parser semantics changed")
        parser_playlist = next(row for row in parser["playlists"] if row["persistent_id"] == PLAYLIST_PID)
        require(parser_playlist["name"] == "Synthetic U01 12.12.10.1", f"positive cycle {index} parser playlist changed")
        require([row["track_persistent_id"] for row in parser_playlist["members"]] == [TRACK_PID], f"positive cycle {index} parser order changed")
        saved_path = EVIDENCE / f"positive-qualification/cases/native-authored-one-track-positive/cycle-{index}/native-saved.itl"
        saved = facts(saved_path)
        require(saved["sha256"] == cycle["saved"]["sha256"] == expected_hash, f"positive cycle {index} saved hash changed")
        previous = expected_hash
        cycles.append({
            "cycle": index,
            "prelaunch_sha256": cycle["prelaunch"]["sha256"],
            "saved": saved,
            "saved_version": parser["version"],
            "outer_file_persistent_id": parser["file_persistent_id"],
            "com_library_persistent_id": COM_LIBRARY_PID,
            "stable_com_samples": 2,
            "selected_track_semantics": SELECTED_SEMANTICS,
            "ordinary_playlist": {"persistent_id": PLAYLIST_PID, "name": "Synthetic U01 12.12.10.1", "members": [TRACK_PID]},
            "worker_exit_code": 0,
            "itunes_exit_code": 0,
            "normal_com_quit": True,
            "worker_errors": 0,
            "independent_parser_errors": 0,
            "forbidden_artifacts": 0,
        })
    return {
        "classification": "exact_native_authored_input_two_sequential_native_cycles",
        "status": "passed",
        "executable_authenticode": auth,
        "case_count": 1,
        "passed_cycles": 2,
        "failed_cycles": 0,
        "cycles": cycles,
    }


def validate_negative() -> dict[str, Any]:
    summary = read_json(EVIDENCE / "negative-qualification/summary.json")
    capture = read_json(EVIDENCE / "negative-qualification/post-timeout-capture/capture.json")
    require(summary["candidate"]["sha256"] == NEGATIVE_INPUT_SHA256, "negative input changed")
    require(summary["reference_summary_before_errors"] == [], "negative parser preflight failed")
    require(summary["reference_summary_before"]["version"] == "12.13.10.3", "negative input version changed")
    require(summary["attempts_required"] == 2 and len(summary["attempts"]) == 2, "negative attempts changed")
    require(summary["status"] == "failed_with_preserved_evidence" and summary["all_passed"] is False and summary["passed_attempts"] == 0, "negative unexpectedly passed")
    require(len(capture["attempts"]) == 2, "negative timeout captures changed")
    attempts = []
    for index, (attempt, captured, output_hash) in enumerate(zip(summary["attempts"], capture["attempts"], NEGATIVE_OUTPUT_HASHES, strict=True), 1):
        require(attempt["attempt"] == captured["attempt"] == index, "negative attempt order changed")
        require(attempt["input_before"]["sha256"] == NEGATIVE_INPUT_SHA256, "negative fresh-copy policy changed")
        require(attempt["status"] == "failed_with_preserved_evidence", "negative attempt status changed")
        require(attempt["target_modal_observed"] is False and attempt["target_modal_dismissed"] is False, "target product modal classification changed")
        require(attempt["error"] == "TimeoutError: predeclared newer-version product modal was not observed", "negative failure reason changed")
        require(attempt["forced_termination"] is True, "negative attempt was not force-terminated after timeout")
        require(attempt["process_cleanup_passed"] is True and attempt["profile_exists_after"] is False, "negative cleanup changed")
        require(captured["hash_changed"] is True and captured["captured_output"]["sha256"] == output_hash, "negative timeout output hash changed")
        require(captured["serialized_version_before"] == "12.13.10.3" and captured["serialized_version_after"] == VERSION, "negative timeout version mutation changed")
        require(captured["outer_file_persistent_id_after"] == "5245464552454E43", "negative outer identity changed")
        require(captured["semantic_preservation_errors_ignoring_version"] == [], "negative selected semantics changed")
        require(captured["forbidden_artifacts_after_force_kill"] == [], "negative forbidden artifacts appeared")
        output_path = EVIDENCE / f"negative-qualification/post-timeout-capture/attempt-{index}/native-mutated-at-timeout.itl"
        parser_path = EVIDENCE / f"negative-qualification/post-timeout-capture/attempt-{index}/parser-summary.json"
        output = facts(output_path)
        parser = read_json(parser_path)
        require(output["sha256"] == output_hash and output["bytes"] == (3866 if index == 1 else 3876), "negative retained timeout file changed")
        require(parser["sha256"] == output_hash and parser["version"] == VERSION, "negative timeout parser result changed")
        attempts.append({
            "attempt": index,
            "fresh_input_sha256": NEGATIVE_INPUT_SHA256,
            "independent_parser_preflight_errors": 0,
            "target_product_modal_observed": False,
            "timeout_seconds": 90,
            "normal_dismissal_or_quit": False,
            "forced_termination_after_timeout": True,
            "process_cleanup_passed": True,
            "profile_exists_after": False,
            "post_timeout_output": output,
            "serialized_version_after": VERSION,
            "outer_file_persistent_id_after": parser["file_persistent_id"],
            "selected_semantics_preserved_ignoring_version": True,
            "forbidden_artifacts": 0,
            "qualification": "failed_predeclared_negative_timeout_survivor_not_normal_native_cycle",
        })
    return {
        "classification": "predeclared_product_facing_negative_failed_without_post_hoc_substitution",
        "status": "failed_with_preserved_evidence",
        "input": facts(ROOT / "TEST_CORPUS/generated/reference-one-track-raw.itl"),
        "attempts_required": 2,
        "attempts_passed": 0,
        "target_product_modals_observed": 0,
        "normally_closed_attempts": 0,
        "force_terminated_after_timeout_attempts": 2,
        "post_timeout_native_mutations_observed": 2,
        "product_facing_native_rejection_established": False,
        "attempts": attempts,
    }


def build_summary() -> dict[str, Any]:
    provenance = validate_provenance()
    expected, setup = validate_setup()
    positive = validate_positive(expected)
    negative = validate_negative()
    return {
        "schema": "windows-itl.u01-distinct-build-12.12.10.1-20260927.v1",
        "status": "bounded_distinct_build_positive_passed_predeclared_negative_failed_u01_open",
        "provenance": provenance,
        "setup": setup,
        "positive_qualification": positive,
        "negative_qualification": negative,
        "totals": {
            "distinct_native_builds": 1,
            "native_authored_positive_inputs": 1,
            "passed_positive_native_cycles": 2,
            "failed_positive_native_cycles": 0,
            "normal_quit_process_exit_zero_positive_cycles": 2,
            "positive_worker_or_independent_parser_error_cycles": 0,
            "positive_forbidden_fallback_cycles": 0,
            "predeclared_negative_attempts": 2,
            "predeclared_negative_attempts_passing_declared_gate": 0,
            "predeclared_negative_target_product_modals": 0,
            "predeclared_negative_force_terminations_after_timeout": 2,
            "post_timeout_mutated_itls_retained": 2,
        },
        "result": {
            "genuinely_nonadjacent_version_pinned_build_added": True,
            "lawful_public_provenance_locked_before_native_launch": True,
            "native_authored_positive_two_cycle_qualification_passed": True,
            "all_predeclared_selected_semantics_preserved_in_positive_cycles": True,
            "predeclared_product_facing_negative_reproduced": False,
            "product_facing_native_negative_established": False,
            "post_timeout_native_mutation_observed_on_both_failed_negative_attempts": True,
            "negative_timeout_mutations_are_normal_native_cycles": False,
            "version_12_12_10_1_reference_parser_profile_admitted": False,
            "independent_writer_qualified": False,
            "independently_implemented_harness": False,
            "independently_sourced_executable": False,
            "arbitrary_12_12_10_1_editing_qualified": False,
            "u01_closed": False,
            "universal_itl_support": False,
            "full_analysis_specification_gate": False,
        },
        "claim_limits": [
            "The positive input was authored by the same native iTunes 12.12.10.1 build; it does not qualify an independent writer or arbitrary edits.",
            "The two positive cycles share one runner, executable, harness, and lineage and are not independent experiments.",
            "The predeclared newer-version modal did not appear. Both attempts timed out and required force termination, so they fail rather than satisfy the declared native-negative gate.",
            "The two post-timeout files show mutation to a 12.12.10.1 envelope with selected semantics preserved, but they were captured only after force termination and are not normally-quit qualification cycles.",
            "12.12.10.1 remains outside the reference parser/writer supported profile allowlist; semantic observation alone does not admit a write profile.",
            "No Apple installer or executable is retained; only hashes, sizes, signature identity, source metadata, and public package metadata are committed.",
            "U-01 remains open, universal ITL support remains false, and the complete-analysis/specification gate remains false.",
        ],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    summary = build_summary()
    args.output.write_text(
        json.dumps(summary, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
