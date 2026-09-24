from __future__ import annotations

from importlib.util import module_from_spec, spec_from_file_location
import json
from pathlib import Path
import shutil
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
SCRIPT_REL = Path("scripts/static/public_replay_preflight.py")
LOCK_REL = Path("scripts/static/public-replay-lock.json")
REPORT_REL = Path("evidence/research/20260925/public-static-replay-bootstrap/report.json")


def load_module():
    spec = spec_from_file_location("public_static_replay_preflight_20260925", ROOT / SCRIPT_REL)
    module = module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


preflight = load_module()


def make_minimal_public_root(destination: Path) -> Path:
    lock = json.loads((ROOT / LOCK_REL).read_text(encoding="utf-8"))
    paths = [LOCK_REL, *(Path(row["path"]) for row in lock["required_public_files"])]
    for relative in paths:
        target = destination / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(ROOT / relative, target)
    return destination


def run_preflight(root: Path, output: Path, cwd: Path) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, "-B", str(root / SCRIPT_REL), "--output", str(output)],
        cwd=cwd,
        check=False,
        capture_output=True,
        text=True,
        timeout=30,
    )


def test_retained_report_is_exact_and_execution_independent():
    expected = preflight.report_bytes(preflight.build_report(ROOT))
    retained = (ROOT / REPORT_REL).read_bytes()
    assert retained == expected
    report = json.loads(retained)
    assert report["status"] == "preflight_completed_with_expected_blockers"
    assert report["public_surface"]["status"] == "verified_against_lock"
    assert report["operations"] == {
        "ghidra_invocations": 0,
        "itunes_launches": 0,
        "native_acceptance_operations": 0,
        "network_operations": 0,
        "proprietary_binary_reads": 0,
        "unicorn_invocations": 0,
    }
    text = retained.decode("utf-8")
    assert str(ROOT) not in text
    assert "/home/runner/" not in text
    assert "checked_utc" not in text
    assert "elapsed_s" not in text


def test_two_fresh_external_roots_are_byte_identical(tmp_path: Path):
    cwd = tmp_path / "unrelated-cwd"
    cwd.mkdir()
    outputs = []
    for name in ("first-root", "second-root"):
        root = make_minimal_public_root(tmp_path / name)
        output = tmp_path / f"{name}.json"
        result = run_preflight(root, output, cwd)
        assert result.returncode == 0, result.stderr
        assert "PUBLIC_STATIC_REPLAY_PREFLIGHT_OK" in result.stdout
        outputs.append(output.read_bytes())
    assert outputs[0] == outputs[1] == (ROOT / REPORT_REL).read_bytes()


def test_missing_locked_input_fails_closed(tmp_path: Path):
    root = make_minimal_public_root(tmp_path / "missing-root")
    (root / "evidence/static/targets-final.txt").unlink()
    output = tmp_path / "missing-report.json"
    result = run_preflight(root, output, tmp_path)
    assert result.returncode == 1
    assert "missing public input" in result.stderr
    assert not output.exists()


def test_tampered_locked_input_fails_closed(tmp_path: Path):
    root = make_minimal_public_root(tmp_path / "tampered-root")
    target = root / "evidence/static/targets-final.txt"
    target.write_bytes(target.read_bytes() + b"0\n")
    output = tmp_path / "tampered-report.json"
    result = run_preflight(root, output, tmp_path)
    assert result.returncode == 1
    assert "public file size mismatch" in result.stderr
    assert not output.exists()


def test_duplicate_json_key_fails_closed(tmp_path: Path):
    root = make_minimal_public_root(tmp_path / "duplicate-key-root")
    lock = root / LOCK_REL
    value = lock.read_text(encoding="utf-8")
    lock.write_text(
        value.replace(
            '{\n  "schema":',
            '{\n  "schema": "duplicate-control",\n  "schema":',
            1,
        ),
        encoding="utf-8",
        newline="\n",
    )
    output = tmp_path / "duplicate-key-report.json"
    result = run_preflight(root, output, tmp_path)
    assert result.returncode == 1
    assert "duplicate JSON key: schema" in result.stderr
    assert not output.exists()


def test_known_blockers_and_claim_boundaries_remain_explicit():
    report = preflight.build_report(ROOT)
    findings = report["retained_evidence"]["findings"]
    assert findings["atlas_rows"] == 47
    assert findings["atlas_c_hash_matches"] == 0
    assert findings["atlas_c_hash_mismatches"] == 47
    assert report["retained_evidence"]["current_public_atlas_c_hashes_coherent"] is False
    assert report["historical_replay"]["status"] == "unavailable"
    assert report["historical_replay"]["available_from_public_clone"] is False
    assert report["synthetic_controls"] == {
        "case_count": 8,
        "cases_are_independent_experiments": False,
        "negative_cases": 6,
        "positive_cases": 2,
        "status": "passed",
    }
    assert report["claims"] == {
        "historical_binary_analysis_reproduced": False,
        "independent_reimplementation_passed": False,
        "native_application_acceptance": False,
        "percentage_complete": None,
        "u13_closed": False,
        "u17_closed": False,
        "u18_closed": False,
        "universal_itl_support": False,
    }
