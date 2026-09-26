"""Normalize the bounded U-01 multi-version native matrix retained on 2026-09-27."""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
EVIDENCE = ROOT / "evidence/research/20260927/u01-sampled-version-matrix"
DEFAULT_OUTPUT = EVIDENCE / "matrix-summary.json"
INPUT_VERSION = "12.13.10.3"
TRUNCATED_SHA256 = "883cf0d4f6c0e751de87e11e9a14d9e844c8d044eb6864e4ffa06eb05c3747f5"
OUTER_FILE_PID = "D2F61BE0A69CA302"
COM_LIBRARY_PID = "9751B29CECF5340B"
TRACK_PID = "D018EAABC195E072"
PLAYLIST_PID = "5F8F30E1ABE6E4A2"

BUILDS: tuple[dict[str, Any], ...] = (
    {
        "key": "12.13.9.1",
        "directory": "12.13.9.1",
        "version": "12.13.9.1",
        "direction": "downgrade_from_12.13.10.3_input",
        "executable_sha256": "6805f52ca3a3a55b31418e302acd8862023078e2f726e44880ab53df48ad2bc5",
        "executable_bytes": 38_840_784,
        "thumbprint": "EB32ED01B82E90A4B8FC1601CE22B0FD6E05C52F",
        "provenance": "provenance/itunes-12.13.9.1.json",
    },
    {
        "key": "12.13.11.1-independent",
        "directory": "12.13.11.1-independent",
        "version": "12.13.11.1",
        "direction": "upgrade_from_12.13.10.3_input",
        "executable_sha256": "c69e719cd3f2f9374e71c954a6de87002b6988af65129943983a2f17490dd73c",
        "executable_bytes": 38_952_912,
        "thumbprint": "5ABF5D5265D74C9EAD19246DFAB611AA5DCFE791",
        "provenance": "provenance/itunes-12.13.11.1.json",
    },
)

COHORTS = (
    "exact-one-track",
    "exact-three-track",
    "semantic-positive-112",
    "historical-negative-replay-113",
)

EXPECTED_INPUT_HASHES = {
    "reference-one-track-raw": "c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74",
    "reference-one-track-zlib": "25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad",
    "reference-three-track-raw": "7d9b274765471d2d77440049273b210138e36b998d39d4790fe750d60c32406b",
    "reference-three-track-zlib": "73dbb405fbd2b68b62d29913b697a72100f8606cdb2ee704c55908e4de389e17",
    "u01-codec-track-indexed-positive": "1a84651212b08f6b7aaf37b40764c195d827d95868d0b51950e1f035c2527721",
    "u01-codec-fresh-modified-negative": "34e4b4348ee4db611d59c1da23791700558c3c91bc44504e4d89a8e5c228ec0f",
}

EXPECTED_SAVED_HASHES = {
    "12.13.9.1": {
        "reference-one-track-raw": [
            "a61e7d9eb143b4239a878141fc178242eb0b581a872f2486ab0dcade4e79addb",
            "c60e1ac92eabbb40b46c48c5c10e25310fbc03162bb6f21afc9584f3bd48d4a7",
        ],
        "reference-one-track-zlib": [
            "f6db7097daede2929a207ea0945098ed7bd40fd174674d8471e0a30b1ca54f66",
            "f4711e4409fd87f46a21bc14af00698eaa862c9b00a20df062f9bf2adc7584c4",
        ],
        "reference-three-track-raw": [
            "6438014e25479bc3b9078630a7a445a6cacb6af5867094bc1613f27129763afb",
            "cbce0a03588bb78c6b42f0241737814e481b318cd1b5184afc612f04bffe69ca",
        ],
        "reference-three-track-zlib": [
            "7ef0f2204152794f6c60029dc264732b364cbe160caaf1be1a90cf97cd9a6ffe",
            "ff88170271b6ad3de3215f2ea97f41cf94801bc21d8c50323bc460d651cfe670",
        ],
        "u01-codec-track-indexed-positive": [
            "7ed8e680025db5efc07768aa8ce3cedd2de50a0059c644a9e9d6f3c74da0bca9",
            "26985c0ef1bd82073985568731fd70407243285a2f5e16c1c8e03b441c465e4e",
        ],
        "u01-codec-fresh-modified-negative": [
            "e58c5e7189e60bd609b1f42dc6ab21697cf0a0e6b11b3f7aeb1936fb3b545073",
            "42b07e5f9eb4c197f9be97dee633fbb035fabd1beb8fb3b7423a51e778bb178a",
        ],
    },
    "12.13.11.1-independent": {
        "reference-one-track-raw": [
            "78f0ae431da4e6794f8cb66b12ecdebbeb1891498e753c0ff8804b8ca7d942d5",
            "34401e8c1fdde316698887d7cdc8eca446bdc550b3945e90d9cf345c239d7562",
        ],
        "reference-one-track-zlib": [
            "b4b82d112aaba33731321e45a4483be98048ebbced432e6dde7f281dd64d4777",
            "a82a1d14d6773b56c64061232c587120bb7759c942dee662f1c81c2b019956bf",
        ],
        "reference-three-track-raw": [
            "068c67c0770792088308e8ae625558113f3183ddfb4b3300de8aa5a9329c28ca",
            "7bb1186296af270a8552cd9c5fc47cbc59b8f6ee828a14ccfdbe0a6fb6054b47",
        ],
        "reference-three-track-zlib": [
            "0fccf498996ab89401edba055cd010b70c1c6ecefa560adb9324aa282ddfce0b",
            "a839229daf5759dd40227197da567b2d55cf17a448ce954ce1abf50b0b1790f4",
        ],
        "u01-codec-track-indexed-positive": [
            "6d5b8879532b6754ca03c89c6f863394dfc45f7f6f24aae837c5eb2cd64f52ab",
            "bbb109fb2eac2fee8eab451e8cd9cf112ab03ea6a5889c222089169691ec8089",
        ],
        "u01-codec-fresh-modified-negative": [
            "854ced914e1c35d27ef2d6193a77235a64bed4c21e643452272ba2dad4ec2a9f",
            "5b7a9ae8c82700dd9eff98adcfc2c636a6bad66fa758c407bccc743570feecbb",
        ],
    },
}

SEMANTIC_112_PARSER = {
    "name": "A",
    "artist": "Codec Artist Ω",
    "album": "Codec Album 新規",
    "album_artist": "Codec Album Artist 🎼",
    "comment": "One-field comment — 測定",
    "rating": 80,
    "play_count": 7,
    "skip_count": 3,
    "track_number": 2,
    "year": 2024,
}
SEMANTIC_112_COM = {
    "Name": "A",
    "Artist": "Codec Artist Ω",
    "Album": "Codec Album 新規",
    "AlbumArtist": "Codec Album Artist 🎼",
    "Comment": "One-field comment — 測定",
    "Rating": 80,
    "PlayedCount": 7,
    "SkippedCount": 3,
    "TrackNumber": 2,
    "Year": 2024,
}
SEMANTIC_113_PARSER = {
    "name": "Codec Fresh 🧪",
    "rating": 80,
    "play_count": 7,
    "skip_count": 2,
    "track_number": 9,
    "year": 2032,
}
SEMANTIC_113_COM = {
    "Name": "Codec Fresh 🧪",
    "Rating": 80,
    "PlayedCount": 7,
    "SkippedCount": 2,
    "TrackNumber": 9,
    "Year": 2032,
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


def file_facts(path: Path) -> dict[str, Any]:
    return {"path": relative(path), "bytes": path.stat().st_size, "sha256": sha256_file(path)}


def pick(values: dict[str, Any], expected: dict[str, Any]) -> dict[str, Any]:
    selected = {key: values.get(key) for key in expected}
    require(selected == expected, f"semantic values changed: expected {expected!r}, got {selected!r}")
    return selected


def selected_semantics(case_name: str, cycle: dict[str, Any]) -> dict[str, Any] | None:
    if case_name not in {
        "u01-codec-track-indexed-positive",
        "u01-codec-fresh-modified-negative",
    }:
        return None
    parser_summary = cycle["reference_summary"]
    parser_track = next(row for row in parser_summary["tracks"] if row["persistent_id"] == TRACK_PID)
    com_state = cycle["worker"]["samples"][-1]["state"]
    com_track = next(row for row in com_state["tracks"] if row["persistent_id"] == TRACK_PID)
    if case_name == "u01-codec-track-indexed-positive":
        parser_values = pick(parser_track, SEMANTIC_112_PARSER)
        com_values = pick(com_track, SEMANTIC_112_COM)
        parser_playlist = next(row for row in parser_summary["playlists"] if row["persistent_id"] == PLAYLIST_PID)
        com_playlist = next(row for row in com_state["playlists"] if row["persistent_id"] == PLAYLIST_PID)
        parser_members = [row["track_persistent_id"] for row in parser_playlist["members"]]
        com_members = [row["persistent_id"] for row in com_playlist["members"]]
        expected_members = ["8F11E62B0DC9F837", "C8ADF4DC10AFC270"]
        require(parser_playlist["name"] == "Synthetic 調査 🎼", "parser playlist name changed")
        require(com_playlist["name"] == "Synthetic 調査 🎼", "COM playlist name changed")
        require(parser_members == expected_members, "parser playlist order changed")
        require(com_members == expected_members, "COM playlist order changed")
        playlist = {
            "persistent_id": PLAYLIST_PID,
            "name": "Synthetic 調査 🎼",
            "members": expected_members,
        }
    else:
        parser_values = pick(parser_track, SEMANTIC_113_PARSER)
        com_values = pick(com_track, SEMANTIC_113_COM)
        playlist = None
    return {
        "track_persistent_id": TRACK_PID,
        "independent_parser": parser_values,
        "itunes_com": com_values,
        "selected_playlist": playlist,
    }


def normalize_case(
    build: dict[str, Any], cohort_name: str, cohort_root: Path, case: dict[str, Any]
) -> dict[str, Any]:
    case_name = case["name"]
    require(case_name in EXPECTED_INPUT_HASHES, f"unexpected case {case_name}")
    require(case["status"] == "passed" and case["passed"] is True, f"case failed: {case_name}")
    require(case["candidate"]["sha256"] == EXPECTED_INPUT_HASHES[case_name], f"input hash changed: {case_name}")
    require(case["candidate_reference_summary_errors"] == [], f"input parser errors: {case_name}")
    require(case["candidate_reference_summary"]["version"] == INPUT_VERSION, f"input version changed: {case_name}")
    require(case["expected_input"]["version"] == INPUT_VERSION, f"expected input version changed: {case_name}")
    require(case["expected_native"]["version"] == build["version"], f"native version changed: {case_name}")
    require(case["cycles_requested"] == 2 and len(case["cycles"]) == 2, f"cycle count changed: {case_name}")
    require(case["final_forbidden_artifacts"] == [], f"final fallback artifacts: {case_name}")
    require(case["profile_junction_remove"]["removed"] is True and case["profile_junction_remove"]["command"]["returncode"] == 0, f"profile cleanup failed: {case_name}")

    expected_file_pid = case["expected_native"].get(
        "file_persistent_id", case["expected_native"]["library_persistent_id"]
    )
    expected_com_pid = case["expected_native"]["library_persistent_id"]
    if case_name.startswith("u01-codec-"):
        require(expected_file_pid == OUTER_FILE_PID, f"outer file PID changed: {case_name}")
        require(expected_com_pid == COM_LIBRARY_PID, f"COM library PID changed: {case_name}")
        require(expected_file_pid != expected_com_pid, f"identity split collapsed: {case_name}")

    cycles: list[dict[str, Any]] = []
    previous_saved_hash: str | None = None
    for index, cycle in enumerate(case["cycles"], start=1):
        require(cycle["cycle"] == index, f"cycle order changed: {case_name}")
        require(cycle["status"] == "passed", f"cycle failed: {case_name}/{index}")
        require(cycle["worker_exit_code"] == 0 and cycle["itunes_exit_code"] == 0, f"process exit changed: {case_name}/{index}")
        require(cycle["worker"]["accepted"] is True, f"COM gate rejected: {case_name}/{index}")
        require(cycle["worker"]["quit_requested"] is True, f"normal Quit missing: {case_name}/{index}")
        require(cycle["worker"]["errors"] == [], f"COM errors: {case_name}/{index}")
        require(cycle["reference_summary_errors"] == [], f"parser errors: {case_name}/{index}")
        require(cycle["forbidden_before"] == [] and cycle["forbidden_after"] == [], f"fallback artifacts: {case_name}/{index}")
        require(cycle["expected_prelaunch_sha256"] == cycle["prelaunch"]["sha256"], f"prelaunch expectation changed: {case_name}/{index}")
        if index == 1:
            require(cycle["prelaunch"]["sha256"] == EXPECTED_INPUT_HASHES[case_name], f"first input changed: {case_name}")
        else:
            require(cycle["prelaunch"]["sha256"] == previous_saved_hash, f"restart did not use prior save: {case_name}")
        samples = cycle["worker"]["samples"]
        require(len(samples) == 2, f"COM sample count changed: {case_name}/{index}")
        require(all(sample["errors"] == [] for sample in samples), f"COM sample errors: {case_name}/{index}")
        require(all(sample["state"]["version"] == build["version"] for sample in samples), f"COM version changed: {case_name}/{index}")
        require(all(sample["state"]["library_persistent_id"] == expected_com_pid for sample in samples), f"COM identity changed: {case_name}/{index}")
        parser_summary = cycle["reference_summary"]
        require(parser_summary["version"] == build["version"], f"saved ITL version changed: {case_name}/{index}")
        require(parser_summary["file_persistent_id"] == expected_file_pid, f"outer identity changed: {case_name}/{index}")

        saved_path = cohort_root / "cases" / case_name / f"cycle-{index}" / "native-saved.itl"
        saved = file_facts(saved_path)
        expected_saved = EXPECTED_SAVED_HASHES[build["key"]][case_name][index - 1]
        require(saved["sha256"] == expected_saved, f"saved hash changed: {case_name}/{index}")
        require(cycle["saved"]["sha256"] == saved["sha256"], f"retained save hash mismatch: {case_name}/{index}")
        require(cycle["saved"]["bytes"] == saved["bytes"], f"retained save size mismatch: {case_name}/{index}")
        previous_saved_hash = saved["sha256"]
        cycles.append(
            {
                "cycle": index,
                "prelaunch_sha256": cycle["prelaunch"]["sha256"],
                "saved": saved,
                "saved_itl_version": parser_summary["version"],
                "outer_file_persistent_id": parser_summary["file_persistent_id"],
                "com_library_persistent_id": expected_com_pid,
                "worker_exit_code": cycle["worker_exit_code"],
                "itunes_exit_code": cycle["itunes_exit_code"],
                "normal_com_quit": True,
                "worker_errors": 0,
                "independent_parser_errors": 0,
                "forbidden_artifacts": 0,
                "selected_semantics": selected_semantics(case_name, cycle),
            }
        )

    if case_name == "u01-codec-track-indexed-positive":
        classification = "version_specific_semantic_positive_112"
    elif case_name == "u01-codec-fresh-modified-negative":
        classification = "historical_negative_113_replay_passed_not_stable_negative"
    else:
        classification = "exact_hash_reference_fixture_positive"
    return {
        "name": case_name,
        "classification": classification,
        "input": {
            "sha256": case["candidate"]["sha256"],
            "bytes": case["candidate"]["bytes"],
            "itl_version": case["candidate_reference_summary"]["version"],
        },
        "track_count": case["expected_native"]["track_count"],
        "expected_outer_file_persistent_id": expected_file_pid,
        "expected_com_library_persistent_id": expected_com_pid,
        "cycles": cycles,
        "passed": True,
    }


def normalize_negative(build: dict[str, Any], build_root: Path) -> dict[str, Any]:
    candidate_path = EVIDENCE / "inputs/reference-three-track-zlib-truncated-1-byte.itl"
    candidate = file_facts(candidate_path)
    require(candidate["sha256"] == TRUNCATED_SHA256 and candidate["bytes"] == 878, "truncated input changed")
    observation_path = build_root / "negative/truncated-zlib-preflight-observation.json"
    summary_path = build_root / "negative/truncated-zlib-preflight/summary.json"
    observation = read_json(observation_path)
    summary = read_json(summary_path)
    require(observation["candidate_sha256"] == TRUNCATED_SHA256, "negative observation hash changed")
    require(observation["harness_exit_code"] == 1, "negative harness exit changed")
    require(observation["process_count_before"] == 0 and observation["process_count_after"] == 0, "iTunes process observed in negative")
    require(observation["profile_existed_before"] is False and observation["profile_existed_after"] is False, "profile created in negative")
    require(summary["status"] == "failed_with_preserved_evidence" and summary["all_passed"] is False, "negative summary status changed")
    require(summary["passed_cases"] == 0 and summary["failed_cases"] == 1, "negative case totals changed")
    require(len(summary["cases"]) == 1, "negative case count changed")
    case = summary["cases"][0]
    expected_error = "RuntimeError: independent reference parser failed: itl-reference-parser: declared file size does not match actual size\n"
    require(case["status"] == "failed" and case["passed"] is False, "negative case unexpectedly passed")
    require(case["error"] == expected_error, "negative error changed")
    require("cycles" not in case, "negative unexpectedly reached a native cycle")
    executable = summary["environment"]["itunes"]
    require(executable["sha256"] == build["executable_sha256"], "negative executable hash changed")
    require(executable["file_version"] == build["version"], "negative executable version changed")
    return {
        "classification": "structural_independent_parser_preflight_negative_itunes_not_launched",
        "candidate": candidate,
        "harness_exit_code": observation["harness_exit_code"],
        "error": case["error"].strip(),
        "native_cycles_started": 0,
        "itunes_process_count_before": observation["process_count_before"],
        "itunes_process_count_after": observation["process_count_after"],
        "profile_existed_before": observation["profile_existed_before"],
        "profile_existed_after": observation["profile_existed_after"],
        "evidence": {
            "observation": relative(observation_path),
            "summary": relative(summary_path),
        },
        "native_itunes_rejection_established": False,
    }


def normalize_build(build: dict[str, Any]) -> dict[str, Any]:
    build_root = EVIDENCE / build["directory"]
    cases: list[dict[str, Any]] = []
    executable_record: dict[str, Any] | None = None
    for cohort_name in COHORTS:
        cohort_root = build_root / "native" / cohort_name
        summary = read_json(cohort_root / "summary.json")
        require(summary["status"] == "passed" and summary["all_passed"] is True, f"cohort failed: {build['key']}/{cohort_name}")
        require(summary["failed_cases"] == 0, f"failed cases retained: {build['key']}/{cohort_name}")
        require(summary["cycles_required"] == 2, f"cycle requirement changed: {build['key']}/{cohort_name}")
        require(summary["qualification_parameters"] == {
            "expected_executable_version": build["version"],
            "expected_executable_sha256": build["executable_sha256"],
            "expected_native_version": build["version"],
            "input_versions": [INPUT_VERSION],
        }, f"qualification parameters changed: {build['key']}/{cohort_name}")
        executable = summary["environment"]["itunes"]
        signature = json.loads(executable["authenticode"]["output"])
        require(executable["sha256"] == build["executable_sha256"], f"executable hash changed: {build['key']}")
        require(executable["file_version"] == build["version"] and executable["product_version"] == build["version"], f"executable version changed: {build['key']}")
        require(executable["errors"] == [], f"executable identity errors: {build['key']}")
        require(signature["Status"] == "Valid" and "Apple Inc." in signature["Subject"], f"signature invalid: {build['key']}")
        require(signature["Thumbprint"] == build["thumbprint"], f"signer thumbprint changed: {build['key']}")
        current_executable = {
            "path": executable["path"],
            "bytes": build["executable_bytes"],
            "sha256": executable["sha256"],
            "file_version": executable["file_version"],
            "product_version": executable["product_version"],
            "authenticode_status": signature["Status"],
            "signer_subject": signature["Subject"],
            "signer_thumbprint": signature["Thumbprint"],
        }
        if executable_record is None:
            executable_record = current_executable
        else:
            require(executable_record == current_executable, f"cohort executable identity drift: {build['key']}")
        for case in summary["cases"]:
            normalized = normalize_case(build, cohort_name, cohort_root, case)
            normalized["cohort"] = cohort_name
            cases.append(normalized)

    require(len(cases) == 6 and {row["name"] for row in cases} == set(EXPECTED_INPUT_HASHES), f"positive case set changed: {build['key']}")
    provenance_path = build_root / build["provenance"]
    provenance = read_json(provenance_path)
    provenance_executable = provenance["executable"]
    require(provenance_executable["bytes"] == build["executable_bytes"], f"provenance executable size changed: {build['key']}")
    require(provenance_executable["sha256"] == build["executable_sha256"], f"provenance executable hash changed: {build['key']}")
    require(provenance_executable["file_version"] == build["version"], f"provenance version changed: {build['key']}")
    if build["key"] == "12.13.9.1":
        provenance_signature = provenance["authenticode"]
    else:
        provenance_signature = provenance_executable["authenticode"]
    require(provenance_signature["status"] == "Valid", f"provenance signature invalid: {build['key']}")
    require(provenance_signature["thumbprint"] == build["thumbprint"], f"provenance thumbprint changed: {build['key']}")

    return {
        "key": build["key"],
        "native_itunes_version": build["version"],
        "input_itl_version": INPUT_VERSION,
        "compatibility_direction": build["direction"],
        "executable": executable_record,
        "provenance": relative(provenance_path),
        "cases": cases,
        "positive_case_count": len(cases),
        "passed_native_cycles": sum(len(case["cycles"]) for case in cases),
        "normal_quit_cycles": sum(len(case["cycles"]) for case in cases),
        "negative": normalize_negative(build, build_root),
    }


def first_launch_setup() -> dict[str, Any]:
    path = EVIDENCE / "12.13.9.1/provenance/first-launch-setup.json"
    setup = read_json(path)
    actions = [row["action"] for row in setup["actions"]]
    require(setup["version_target"] == "12.13.9.1" and setup["com_version"] == "12.13.9.1", "first-launch version changed")
    require(setup["main_window_stable"] and setup["finished"], "first-launch setup incomplete")
    require(setup["com_quit_requested"] and not setup["com_quit_timed_out"], "first-launch normal Quit changed")
    require(setup["itunes_exit_after_setup"] == 0 and setup["itunes_processes_after"] == "0", "first-launch process exit changed")
    require(setup["junction_remove"]["returncode"] == 0 and not setup["profile_exists_after"], "first-launch profile cleanup changed")
    require(actions == ["accept_eula", "dismiss_known_audio_warning", "decline_update_and_do_not_ask"], "first-launch actions changed")
    return {
        "version": setup["com_version"],
        "actions": actions,
        "normal_com_quit": True,
        "itunes_exit_code": setup["itunes_exit_after_setup"],
        "itunes_processes_after": 0,
        "profile_junction_removed": True,
        "evidence": relative(path),
    }


def reproduction_scope() -> dict[str, Any]:
    path = EVIDENCE / "12.13.11.1-independent/provenance/runner-environment.json"
    provenance = read_json(path)
    scope = provenance["independence_scope"]
    gha = provenance["gha_mcp"]
    require(gha["env_id"] == "win-p0qfbqby" and gha["run_id"] == "36258961725", "reproduction runner identity changed")
    require(scope["separate_runtime_from_prior_12_13_11_1_experiment"] is True, "separate-runtime evidence changed")
    require(scope["prior_comparison_env_id"] == "win-7h5jwzza", "prior runner identity changed")
    require(provenance["lineage"]["same_runner_prior_native_build"]["version"] == "12.13.9.1", "upgrade lineage changed")
    require(provenance["lineage"]["upgrade_target"]["version"] == "12.13.11.1", "upgrade target changed")
    return {
        "separate_runtime_from_prior_12_13_11_1_experiment": True,
        "current_runner_env_id": gha["env_id"],
        "current_runner_run_id": gha["run_id"],
        "prior_runner_env_id": scope["prior_comparison_env_id"],
        "prior_runner_run_id": scope["prior_comparison_run_id"],
        "shared_inputs": scope["shared_inputs"],
        "same_runner_first_ran_12_13_9_1_then_upgraded_in_place": True,
        "independently_implemented_harness": False,
        "independently_sourced_executable": False,
        "limitations": scope["limitations"],
        "evidence": relative(path),
    }


def build_summary() -> dict[str, Any]:
    builds = [normalize_build(build) for build in BUILDS]
    case_count = sum(build["positive_case_count"] for build in builds)
    cycle_count = sum(build["passed_native_cycles"] for build in builds)
    return {
        "schema": "windows-itl.u01-sampled-version-matrix-20260927.v1",
        "status": "bounded_sampled_multi_version_matrix_completed_u01_open",
        "generator": {"path": relative(Path(__file__)), "sha256": sha256_file(Path(__file__))},
        "platform": "Windows Server 2025 10.0.26100",
        "first_launch_setup_12_13_9_1": first_launch_setup(),
        "builds": builds,
        "reproduction_scope": reproduction_scope(),
        "totals": {
            "native_builds": len(builds),
            "positive_cases": case_count,
            "passed_native_cycles": cycle_count,
            "normal_quit_process_exit_zero_cycles": cycle_count,
            "failed_native_cycles": 0,
            "worker_or_independent_parser_error_cycles": 0,
            "forbidden_fallback_cycles": 0,
            "structural_preflight_negatives": len(builds),
            "structural_negatives_that_launched_itunes": 0,
        },
        "result": {
            "exact_hash_downgrade_open_save_restart_qualified": True,
            "exact_hash_upgrade_open_save_restart_qualified": True,
            "version_specific_semantic_candidate_112_passed_on_both_builds": True,
            "historical_candidate_113_failure_reproduced": False,
            "historical_candidate_113_is_stable_negative": False,
            "structural_negative_is_native_itunes_rejection": False,
            "separate_runner_12_13_11_1_reproduction": True,
            "independently_implemented_harness": False,
            "independently_sourced_executable": False,
            "u01_closed": False,
            "universal_itl_support": False,
            "full_analysis_specification_gate": False,
        },
        "claim_limits": [
            "The positive result is limited to six pinned 12.13.10.3 input hashes, two signed executable hashes, and two cycles per input/build.",
            "The 12.13.9.1 result is exact-hash downgrade/open/save/restart compatibility; it does not admit the public structural editing helpers on 12.13.9.1 or establish arbitrary editing.",
            "Candidate 112 retains selected text/scalar values and one ordinary-playlist order on both tested builds, but it is one version-specific candidate rather than complete field or structural coverage.",
            "Candidate 113 passed both cycles on both tested builds, so the historical zero-cycle failure did not reproduce and is not a stable negative.",
            "The one-byte-truncated zlib input failed the independent parser before profile creation or any iTunes cycle; it is structural preflight evidence, not native iTunes rejection.",
            "The 12.13.11.1 repetition used a separate GHA runner/runtime from the earlier comparison but shared fixtures, repository harness code, and the exact executable hash; that runner first ran 12.13.9.1 and was upgraded in place.",
            "This is neither an independently implemented harness nor an independently sourced executable, and it does not qualify other builds, editions, values, record families, media, or unknown bytes.",
            "U-01, universal ITL support, and the complete-analysis/specification gate remain open/false.",
        ],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    report = build_summary()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
