"""Offline validation of the a08 native acceptance protocol.

These tests never touch iTunes, COM, a UI, or any native library directory.
They feed synthetic captures of known-bad outcomes to the checker and require
that each one is actually detected. A protocol that has never failed on purpose
is not validated, so the failure cases are the point of this file.
"""

from __future__ import annotations

import json
import os
import subprocess
import sys

import pytest

_HERE = os.path.dirname(os.path.abspath(__file__))
_REPO = os.path.dirname(_HERE)
_HARNESS = os.path.join(_REPO, "research", "g4", "a08")
if _HARNESS not in sys.path:
    sys.path.insert(0, _HARNESS)

import g4_a08_acceptance as acceptance  # noqa: E402
import g4_a08_controls as controls  # noqa: E402

ALL_GATES = ["G" + str(index) for index in range(1, 11)]


def _verdict(bundle):
    verdict = acceptance.check_capture(bundle)
    return verdict, set(verdict["codes"])


def test_good_bundle_is_accepted():
    verdict, codes = _verdict(controls.good_bundle())
    assert verdict["accepted"] is True, sorted(codes)
    assert verdict["findings"] == []
    assert verdict["gates_evaluated"] == ALL_GATES
    assert verdict["version_used"] == acceptance.AUTHORIZED_ITUNES_VERSION


def test_path_separator_and_case_are_not_a_mismatch():
    verdict, codes = _verdict(controls.control_windows_path_variant())
    assert verdict["accepted"] is True, sorted(codes)


def test_playback_failure_does_not_retract_acceptance():
    verdict, codes = _verdict(controls.control_playback_failed_but_separate())
    good = acceptance.check_capture(controls.good_bundle())
    assert verdict["accepted"] is True, sorted(codes)
    assert verdict["playback_endpoint"]["outcome"].startswith("failed")
    assert verdict["failed_gates"] == good["failed_gates"]


def test_playback_is_reported_as_its_own_endpoint():
    verdict, _ = _verdict(controls.good_bundle())
    assert verdict["playback_endpoint"]["attempted"] is True
    assert "playback" in verdict["playback_endpoint"]["note"]
    assert "playback" not in json.dumps(verdict["failed_gates"])


@pytest.mark.parametrize(
    "control",
    controls.NEGATIVE_CONTROLS,
    ids=[control["name"] for control in controls.NEGATIVE_CONTROLS],
)
def test_negative_control_is_detected(control):
    verdict, codes = _verdict(control["builder"]())
    missing = sorted(set(control["must_include"]) - codes)
    assert not missing, (
        control["name"]
        + " was not detected; missing "
        + repr(missing)
        + "; observed "
        + repr(sorted(codes))
    )
    assert verdict["accepted"] is False, control["name"]


def test_com_success_alone_is_never_acceptance():
    verdict, codes = _verdict(controls.control_com_call_only())
    assert verdict["accepted"] is False
    assert "G7_COM_CALL_ONLY" in codes
    assert "G4_INSUFFICIENT_RESTART_CYCLES" in codes


def test_empty_library_is_never_acceptance():
    verdict, codes = _verdict(controls.control_empty_library_generated())
    assert verdict["accepted"] is False
    assert "G7_EMPTY_LIBRARY" in codes


def test_every_blocking_gate_has_a_negative_control():
    covered = set()
    for control in controls.NEGATIVE_CONTROLS:
        for code in control["must_include"]:
            covered.add(code.split("_")[0])
    assert set(ALL_GATES) - covered == set()


def test_declaration_validator_accepts_the_reviewed_declaration():
    assert acceptance.validate_declaration(controls.declaration()) == []


def test_declaration_must_enumerate_complete_id_sets():
    decl = controls.declaration()
    decl["ids"]["new"]["track_persistent_ids"] = None
    codes = {item["code"] for item in acceptance.validate_declaration(decl)}
    assert "D_IDS_INCOMPLETE" in codes


def test_declaration_may_not_plan_a_library_identity_change():
    decl = controls.declaration()
    decl["ids"]["new"]["library_persistent_id"] = controls.REBUILT_LIBRARY_ID
    codes = {item["code"] for item in acceptance.validate_declaration(decl)}
    assert "D_LIBRARY_ID_CHANGE" in codes


def test_declaration_flags_stale_version_and_bad_order():
    decl = controls.declaration()
    decl["itunes_version_target"] = controls.HISTORICAL_VERSION
    decl["playlists"][0]["order_expected"] = [controls.TRACK_A, controls.TRACK_A]
    codes = {item["code"] for item in acceptance.validate_declaration(decl)}
    assert "D_VERSION_TARGET_MISMATCH" in codes
    assert "D_ORDER_DUPLICATE" in codes
    assert "D_ORDER_NOT_PERMUTATION" in codes


def test_declaration_requires_metadata_and_location_for_new_ids():
    decl = controls.declaration()
    decl["metadata"] = {controls.TRACK_A: dict(controls.TRACK_META[controls.TRACK_A])}
    decl["locations"] = {
        controls.TRACK_A: controls.TRACK_META[controls.TRACK_A]["location"]
    }
    codes = {item["code"] for item in acceptance.validate_declaration(decl)}
    assert "D_METADATA_MISSING" in codes
    assert "D_LOCATION_MISSING" in codes


def test_declaration_rejects_an_unauthorized_installer():
    decl = controls.declaration()
    decl["installer_sha256"] = "f" * 64
    codes = {item["code"] for item in acceptance.validate_declaration(decl)}
    assert "D_INSTALLER_HASH_MISMATCH" in codes


def test_observed_changes_are_inferred_from_the_capture():
    observed = acceptance.observed_change_kinds(controls.good_bundle())
    assert observed == {"add_track", "add_to_playlist"}


def _run_cli(tmp_path, bundle):
    path = os.path.join(str(tmp_path), "capture.json")
    with open(path, "w", encoding="utf-8") as handle:
        json.dump(bundle, handle)
    return subprocess.run(
        [sys.executable, os.path.join(_HARNESS, "g4_a08_acceptance.py"), path],
        capture_output=True,
        text=True,
        check=False,
    )


def test_cli_accepts_the_good_capture(tmp_path):
    proc = _run_cli(tmp_path, controls.good_bundle())
    assert proc.returncode == 0, proc.stdout + proc.stderr
    assert json.loads(proc.stdout)["accepted"] is True


def test_cli_rejects_a_silently_rebuilt_library(tmp_path):
    proc = _run_cli(tmp_path, controls.control_silent_rebuild())
    assert proc.returncode == 1, proc.stdout + proc.stderr
    verdict = json.loads(proc.stdout)
    assert verdict["accepted"] is False
    assert "G2_LIBRARY_IDENTITY_CHANGED" in verdict["codes"]


def test_harness_performs_no_native_operations():
    banned = ("win32com", "pywinauto", "subprocess", "os.system", "ctypes", "frida", "popen")
    for name in ("g4_a08_acceptance.py", "g4_a08_controls.py"):
        with open(os.path.join(_HARNESS, name), "r", encoding="utf-8") as handle:
            source = handle.read()
        for token in banned:
            assert token not in source, name + " references " + token
