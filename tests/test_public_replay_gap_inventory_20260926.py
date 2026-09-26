from __future__ import annotations

from importlib.util import module_from_spec, spec_from_file_location
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SCRIPT_REL = Path("scripts/static/public_replay_gap_inventory.py")
REPORT_REL = Path("evidence/research/20260926/public-replay-gap-inventory/report.json")


def load_module():
    spec = spec_from_file_location("public_replay_gap_inventory_20260926", ROOT / SCRIPT_REL)
    module = module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


gap_inventory = load_module()


def test_retained_gap_inventory_is_deterministic_and_claim_limited():
    expected = gap_inventory.report_bytes(gap_inventory.build_inventory(ROOT))
    retained = (ROOT / REPORT_REL).read_bytes()
    assert retained == expected
    report = json.loads(retained)
    assert report["schema"] == "windows-itunes-itl.public-replay-gap-inventory.v1"
    assert report["status"] == "completed_public_gap_inventory_u18_open"
    assert report["operations"] == {
        "ghidra_invocations": 0,
        "itunes_launches": 0,
        "native_acceptance_operations": 0,
        "network_operations": 0,
        "proprietary_binary_reads": 0,
        "unicorn_invocations": 0,
    }
    assert report["claim_boundaries"] == {
        "ghidra_end_to_end_reproduced": False,
        "historical_binary_analysis_reproduced": False,
        "independent_reimplementation_passed": False,
        "native_application_acceptance": False,
        "not_independent_experiments": "This inventory is one deterministic repository-local check and does not replay historical binary analysis.",
        "percentage_complete": None,
        "u18_closed": False,
        "unicorn_original_machine_code_reproduced": False,
        "universal_itl_support": False,
    }
    assert str(ROOT) not in retained.decode("utf-8")
    assert "/home/runner/" not in retained.decode("utf-8")
    assert "checked_utc" not in retained.decode("utf-8")


def test_historical_script_gap_inventory_matches_retained_blockers():
    report = gap_inventory.build_inventory(ROOT)
    summary = report["historical_script_summary"]
    assert summary["script_count"] == 6
    assert summary["machine_bound_script_count"] == 5
    assert summary["timing_dependent_script_count"] == 2
    assert summary["matches_retained_preflight_counts"] == {
        "machine_bound": True,
        "timing_dependent": True,
    }
    assert summary["machine_bound_scripts"] == [
        "scripts/static/offline_aes_proof.py",
        "scripts/static/pe_probe.py",
        "scripts/static/prepare_targets.py",
        "scripts/static/rebuild_targets.py",
        "scripts/static/run-headless.ps1",
    ]
    assert summary["timing_dependent_scripts"] == [
        "scripts/static/offline_aes_proof.py",
        "scripts/static/pe_probe.py",
    ]
    by_path = {row["path"]: row for row in report["historical_scripts"]}
    assert by_path["scripts/static/offline_aes_proof.py"]["non_stdlib_import_roots"] == ["Crypto", "pefile", "unicorn"]
    assert by_path["scripts/static/pe_probe.py"]["non_stdlib_import_roots"] == ["capstone", "pefile"]
    assert by_path["scripts/static/prepare_targets.py"]["non_stdlib_import_roots"] == ["capstone", "pefile"]
    assert by_path["scripts/static/rebuild_targets.py"]["non_stdlib_import_roots"] == ["capstone", "pefile"]
    assert by_path["scripts/ghidra/ITLSelective.java"]["has_machine_bound_windows_paths"] is False


def test_dependency_and_input_gaps_remain_explicit():
    report = gap_inventory.build_inventory(ROOT)
    dependencies = report["dependency_pin_matrix"]
    assert dependencies["missing_exact_version_tools"] == ["capstone", "pefile", "pycryptodome"]
    assert dependencies["module"]["staged"] is False
    assert dependencies["toolchain"]["ghidra"]["version"] == "12.1.3"
    assert dependencies["toolchain"]["unicorn"]["version"] == "2.1.4"
    missing = report["missing_input_matrix"]
    assert missing["proprietary_module_staged"] is False
    assert missing["ghidra_distribution_staged"] is False
    assert missing["ghidra_project_cache_staged"] is False
    assert missing["exact_python_dependency_versions_recorded"] is False
    assert missing["current_public_atlas_c_hashes_coherent"] is False
    assert missing["atlas_c_hash_matches"] == 0
    assert missing["atlas_c_hash_mismatches"] == 47
    public_inputs = report["public_input_matrix"]
    assert public_inputs["locked_public_file_count"] == 108
    assert public_inputs["retained_c_rows"] == 47
    assert public_inputs["offline_tests_passing"] == 41


def test_cli_check_report_and_output(tmp_path: Path):
    output = tmp_path / "gap-inventory.json"
    result = subprocess.run(
        [
            sys.executable,
            "-B",
            str(ROOT / SCRIPT_REL),
            "--output",
            str(output),
            "--check-report",
            str(ROOT / REPORT_REL),
        ],
        cwd=tmp_path,
        check=False,
        capture_output=True,
        text=True,
        timeout=30,
    )
    assert result.returncode == 0, result.stderr
    assert "PUBLIC_REPLAY_GAP_INVENTORY_OK" in result.stdout
    assert output.read_bytes() == (ROOT / REPORT_REL).read_bytes()
