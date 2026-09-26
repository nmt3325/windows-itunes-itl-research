"""Run the committed U-01 header-revision candidate in exactly two attempts.

The mature 12.12.10.1 negative harness supplies fresh profile junctions,
window/control metadata, strict newer-version modal classification, normal
OK/WM_CLOSE cleanup, fallback audits, and fail-closed forced cleanup.  This
wrapper replaces its former candidate with the exact one-byte revision-major
candidate and re-locks the complete independent semantic summary.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

REPO_ROOT = Path(__file__).resolve().parents[2]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from scripts.windows import reference_generated_native as native
from scripts.windows import u01_distinct_build_20260927 as harness

CANDIDATE_REL = Path(
    "evidence/research/20260927/u01-header-revision-gate/"
    "candidate/native-12.12.10.1-header-major-68.itl"
)
PREFLIGHT_REL = Path(
    "evidence/research/20260927/u01-header-revision-gate/preflight-report.json"
)
CANDIDATE_SHA256 = "287a9b91315be1a4917cc1a2530013c076bab824e2099885ac89d8e7ccebe59a"
EXPECTED_EXE_SHA256 = "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b"
EXPECTED_SEMANTIC_SHA256: str


def canonical_sha256(value: object) -> str:
    payload = json.dumps(
        value, ensure_ascii=False, sort_keys=True, separators=(",", ":")
    ).encode("utf-8")
    return hashlib.sha256(payload).hexdigest()


def candidate_preflight_errors(summary: dict) -> list[dict]:
    normalized = dict(summary)
    observed_file_sha = normalized.pop("sha256", None)
    observed_semantic_sha = canonical_sha256(normalized)
    expected = {
        "file_sha256": CANDIDATE_SHA256,
        "semantic_sha256": EXPECTED_SEMANTIC_SHA256,
        "version": "12.12.10.1",
        "file_persistent_id": "C4CF98746C40D802",
        "encryption_flag": 2,
        "compression_flag": 1,
        "track_count": 1,
        "playlist_count": 15,
    }
    observed = {
        "file_sha256": observed_file_sha,
        "semantic_sha256": observed_semantic_sha,
        "version": summary.get("version"),
        "file_persistent_id": summary.get("file_persistent_id"),
        "encryption_flag": summary.get("envelope", {}).get("encryption_flag"),
        "compression_flag": summary.get("envelope", {}).get("compression_flag"),
        "track_count": len(summary.get("tracks", [])),
        "playlist_count": len(summary.get("playlists", [])),
    }
    return [
        {"property": key, "expected": value, "actual": observed[key]}
        for key, value in expected.items()
        if observed[key] != value
    ]


def run(args: argparse.Namespace) -> int:
    global EXPECTED_SEMANTIC_SHA256
    if os.name != "nt":
        raise RuntimeError("native observation requires Windows")
    if not args.confirm_disposable:
        raise RuntimeError("native observation requires --confirm-disposable")

    candidate = REPO_ROOT / CANDIDATE_REL
    preflight = json.loads((REPO_ROOT / PREFLIGHT_REL).read_text(encoding="utf-8"))
    EXPECTED_SEMANTIC_SHA256 = preflight["independent_parser"][
        "normalized_semantic_summary_sha256"
    ]
    if candidate.read_bytes()[0x0C:0x10] != bytes.fromhex("00440001"):
        raise RuntimeError("candidate raw revision tuple mismatch")
    if native.sha256_file(candidate) != CANDIDATE_SHA256:
        raise RuntimeError("candidate SHA-256 mismatch")
    subprocess.run(
        [
            sys.executable,
            str(REPO_ROOT / "scripts/research/build_u01_header_revision_candidate_20260927.py"),
            "--check",
        ],
        cwd=REPO_ROOT,
        check=True,
    )
    parsed = native.reference_summary(candidate)
    errors = candidate_preflight_errors(parsed)
    if errors:
        raise RuntimeError("candidate semantic preflight failed: " + json.dumps(errors))

    identity = native.validate_executable_identity(
        harness.ITUNES_EXE, "12.12.10.1", EXPECTED_EXE_SHA256
    )
    signature = native.authenticode(harness.ITUNES_EXE)
    if signature.get("status") != "Valid" or "Apple Inc." not in str(
        signature.get("signer_subject", "")
    ):
        raise RuntimeError("iTunes Authenticode identity mismatch")

    harness.NEGATIVE_RELATIVE = CANDIDATE_REL
    harness.NEGATIVE_SHA256 = CANDIDATE_SHA256
    harness.NEGATIVE_FILE_PID = "C4CF98746C40D802"
    harness.negative_preflight_errors = candidate_preflight_errors
    exit_code = harness.run_negative(args)

    summary_path = args.evidence.resolve() / "summary.json"
    summary = json.loads(summary_path.read_text(encoding="utf-8"))
    summary["schema"] = "windows-itl.u01-header-revision-native-summary-20260927.v1"
    summary["repository_commit"] = subprocess.check_output(
        ["git", "rev-parse", "HEAD"], cwd=REPO_ROOT, text=True
    ).strip()
    summary["candidate_theory"] = (
        "raw 00 44 00 01 normalizes to revision tuple (68,1), exceeds the exact "
        "parser major ceiling 67, returns -876, and selects resource 0x1f420003"
    )
    summary["static_resource_expectation"] = {
        "parser_rva": "0x10ad0b0",
        "status": -876,
        "group": "0x1f43",
        "resource_id": "0x1f420003",
        "role": "newer_version_message",
    }
    summary["capture_policy"] = (
        "bounded top-level/child window metadata only; no desktop or window bitmap"
    )
    summary["post_hoc_candidate_substitution_allowed"] = False
    summary["native_launches"] = sum(
        1 for attempt in summary.get("attempts", []) if attempt.get("itunes_pid")
    )
    summary["executable_preflight_rechecked_by_wrapper"] = {
        **identity,
        "authenticode": signature,
    }
    native.write_json(summary_path, summary)
    return exit_code


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--evidence", type=Path, required=True)
    parser.add_argument("--confirm-disposable", action="store_true")
    return run(parser.parse_args(argv))


if __name__ == "__main__":
    raise SystemExit(main())
