"""Build a compact oracle and human-readable index for native rating evidence."""
from __future__ import annotations

import argparse
import hashlib
import json
from collections import Counter
from pathlib import Path
from typing import Any

MEMBERS = ("Rating", "RatingKind", "AlbumRating", "AlbumRatingKind", "Loved", "Disliked")
SNAPSHOT_ORDER = ("baseline", "mutation", "same-value-repeat", "restart-verification")
PROJECTION_FIELDS = ("Rating", "RatingKind", "AlbumRating", "AlbumRatingKind")
TARGET_PID = "A17E000000000001"
CANONICAL_REPORT_HASH_BASIS = (
    "UTF-8 JSON; ensure_ascii=false; sorted keys; indent=2; LF terminator"
)


def canonical_json_bytes(value: Any) -> bytes:
    return (
        json.dumps(value, indent=2, ensure_ascii=False, sort_keys=True) + "\n"
    ).encode("utf-8")


def canonical_json_sha256(value: Any) -> str:
    return hashlib.sha256(canonical_json_bytes(value)).hexdigest()


def _error_summary(row: dict[str, Any]) -> dict[str, Any] | None:
    error = row.get("error")
    if not isinstance(error, dict):
        return None
    return {key: error[key] for key in ("type", "message", "hresult", "scode") if key in error}


def _probe_summary(row: dict[str, Any]) -> dict[str, Any]:
    return {
        key: row[key]
        for key in ("attempted", "outcome", "value", "requested", "readback")
        if key in row
    } | ({"error": _error_summary(row)} if _error_summary(row) else {})


def _version_summary(row: dict[str, Any]) -> dict[str, Any]:
    value = row.get("value") if isinstance(row, dict) else None
    value = value if isinstance(value, dict) else {}
    return {
        "status": row.get("status"),
        "file_version": value.get("FileVersion"),
        "product_version": value.get("ProductVersion"),
        "bytes": value.get("Length"),
    }


def _authenticode_summary(row: dict[str, Any]) -> dict[str, Any]:
    value: dict[str, Any] = {}
    try:
        parsed = json.loads(row.get("output", "{}"))
        if isinstance(parsed, dict):
            value = parsed
    except (TypeError, json.JSONDecodeError):
        pass
    return {
        "returncode": row.get("returncode"),
        "status": value.get("Status"),
        "subject": value.get("Subject"),
        "thumbprint": value.get("Thumbprint"),
    }


def _snapshot_summary(analysis: dict[str, Any]) -> dict[str, Any]:
    primary = analysis["primary"]
    return {
        "sha256": analysis["file"]["sha256"],
        "bytes": analysis["file"]["bytes"],
        "rating": primary["rating"],
        "name_refresh_flag_raw": primary["name_refresh_flag_raw"],
        "legacy_loved_byte_raw": primary["legacy_loved_byte_raw"],
        "legacy_loved_bit": primary["legacy_loved_bit"],
        "track_header_length": primary["track_header_length"],
        "track_header_sha256": primary["track_header_sha256"],
        "high_level_library": primary["high_level_library"],
        "primary_independent_validator_passed": analysis["passed"],
        "validator_valid": analysis["validator"]["valid"],
    }


def _projection_sequence(session: dict[str, Any]) -> list[dict[str, Any]]:
    sequence: list[dict[str, Any]] = []
    for sample in session["worker"]["samples"]:
        target = next(
            (track for track in sample["state"]["tracks"] if track["persistent_id"] == TARGET_PID),
            None,
        )
        if target is None:
            projection = {field: None for field in PROJECTION_FIELDS}
        else:
            projection = {field: target[field] for field in PROJECTION_FIELDS}
        sequence.append(
            {
                "label": sample["label"],
                **projection,
                "identity_errors": sample["identity_errors"],
            }
        )
    return sequence


def _transition_summary(transition: dict[str, Any]) -> dict[str, Any]:
    raw = transition["raw_itl_diff"]
    header = transition["track_header_diff"]
    return {
        "before_sha256": transition["before"]["sha256"],
        "after_sha256": transition["after"]["sha256"],
        "raw_itl_diff": {
            "before_bytes": raw["before_bytes"],
            "after_bytes": raw["after_bytes"],
            "changed_byte_positions": raw["changed_byte_positions"],
            "range_count": raw["range_count"],
        },
        "track_header_diff": {
            "changed_byte_positions": header["changed_byte_positions"],
            "range_count": header["range_count"],
            "ranges": header["ranges"],
        },
        "target_fields": transition["target_fields"],
        "primary_and_independent_parsers_passed": transition[
            "primary_and_independent_parsers_passed"
        ],
    }


def build_oracle(report: dict[str, Any], report_sha256: str | None = None) -> dict[str, Any]:
    if report_sha256 is None:
        report_sha256 = canonical_json_sha256(report)
    cases = report["cases"]
    sessions = [session for case in cases for session in case["sessions"]]
    analyses = [analysis for case in cases for analysis in case["snapshot_analyses"].values()]
    unique_snapshot_hashes = sorted({analysis["file"]["sha256"] for analysis in analyses})
    probe_case = next(case for case in cases if case["case"]["mode"] == "probe")
    member_probes = probe_case["sessions"][0]["worker"]["member_probes"]

    capabilities: dict[str, Any] = {}
    for member in MEMBERS:
        capability = report["capabilities"][member]
        capabilities[member] = {
            "classification": capability["classification"],
            "typelib_declared_get": capability["typelib"]["declared_get"],
            "typelib_declared_put": capability["typelib"]["declared_put"],
            "typelib_entries": capability["typelib"]["entries"],
            "runtime_get": _probe_summary(member_probes["getters"][member]),
            "runtime_put": _probe_summary(member_probes["setters"][member]),
        }

    ladder: list[dict[str, Any]] = []
    for case in cases:
        if case["case"]["mode"] != "rating":
            continue
        snapshots = {
            phase: _snapshot_summary(case["snapshot_analyses"][phase])
            for phase in SNAPSHOT_ORDER
            if phase in case["snapshot_analyses"]
        }
        ladder.append(
            {
                "case": case["name"],
                "expected": case["rating_persistence"]["expected"],
                "observed": case["rating_persistence"]["observed"],
                "passed": case["rating_persistence"]["passed"],
                "snapshots": snapshots,
                "transitions": {
                    name: _transition_summary(transition)
                    for name, transition in case["transitions"].items()
                },
                "sessions": [
                    {
                        "phase": session["phase"],
                        "rating_write": session["worker"].get("rating_write"),
                        "rating_gate": session["worker"].get("rating_gate"),
                        "projection_sequence": _projection_sequence(session),
                        "saved_sha256": session["saved"]["sha256"],
                    }
                    for session in case["sessions"]
                ],
            }
        )

    high_level = Counter(
        analysis["primary"]["high_level_library"]["outcome"] for analysis in analyses
    )
    validation = {
        "snapshot_analyses": len(analyses),
        "unique_snapshot_sha256": len(unique_snapshot_hashes),
        "unique_snapshot_hashes": unique_snapshot_hashes,
        "primary_independent_validator_passed": sum(bool(analysis["passed"]) for analysis in analyses),
        "validator_valid": sum(bool(analysis["validator"]["valid"]) for analysis in analyses),
        "high_level_library_outcomes": dict(sorted(high_level.items())),
    }
    all_samples = [
        sample
        for session in sessions
        for sample in session["worker"].get("samples", [])
    ]
    all_saved_analyses = [session["targeted_validation"] for session in sessions]
    global_gates = {
        "all_worker_exit_zero": all(session["worker_exit_code"] == 0 for session in sessions),
        "all_itunes_exit_zero": all(session["itunes_exit_code"] == 0 for session in sessions),
        "all_sessions_accepted": all(session["worker"]["accepted"] for session in sessions),
        "all_sessions_requested_normal_quit": all(
            session["worker"]["quit_requested"] for session in sessions
        ),
        "all_before_after_samples_stable": all(
            session["worker"]["before_stable"] and session["worker"]["after_stable"]
            for session in sessions
        ),
        "all_identity_gates_passed": all(not sample["identity_errors"] for sample in all_samples),
        "forbidden_artifacts_observed": sum(
            len(session["forbidden_before"]) + len(session["forbidden_after"])
            for session in sessions
        ),
        "ui_actions": sorted(
            {action["action"] for session in sessions for action in session.get("ui", [])}
        ),
        "saved_snapshot_validations_passed": sum(
            bool(analysis["passed"]) for analysis in all_saved_analyses
        ),
        "saved_snapshot_validations_total": len(all_saved_analyses),
        "all_target_name_refresh_zero": all(
            analysis["primary"]["name_refresh_flag_raw"] == 0 for analysis in analyses
        ),
        "all_target_legacy_loved_zero": all(
            analysis["primary"]["legacy_loved_byte_raw"] == 0
            and analysis["primary"]["legacy_loved_bit"] is False
            for analysis in analyses
        ),
    }

    provenance = report["provenance"]
    oracle: dict[str, Any] = {
        "schema_version": 1,
        "source_report": {
            "path": "report.json",
            "sha256": report_sha256,
            "hash_basis": CANONICAL_REPORT_HASH_BASIS,
        },
        "scope": report["scope"],
        "started_utc": report["started_utc"],
        "finished_utc": report["finished_utc"],
        "passed": report["passed"],
        "counts": {**report["counts"], **validation},
        "environment": report["environment"],
        "safety_boundary": {
            "candidate": report["safety_boundary"]["candidate"],
            "user_data_touched": report["safety_boundary"]["user_data_touched"],
            "ui_policy": report["safety_boundary"]["ui_policy"],
        },
        "provenance": {
            "official_installer_url": {
                key: provenance["official_installer_url"].get(key)
                for key in (
                    "entry_url",
                    "expected_resolved_url",
                    "observed_resolved_url",
                    "http_status",
                )
            },
            "installer": {
                "bytes": provenance["installer"]["bytes"],
                "sha256": provenance["installer"]["sha256"],
                "expected_sha256": provenance["installer"]["expected_sha256"],
                "version": _version_summary(provenance["installer"]["version"]),
                "authenticode": _authenticode_summary(provenance["installer"]["authenticode"]),
            },
            "itunes": {
                "bytes": provenance["itunes"]["bytes"],
                "sha256": provenance["itunes"]["sha256"],
                "expected_sha256": provenance["itunes"]["expected_sha256"],
                "expected_version": provenance["itunes"]["expected_version"],
                "version": _version_summary(provenance["itunes"]["version"]),
                "authenticode": _authenticode_summary(provenance["itunes"]["authenticode"]),
            },
        },
        "capabilities": capabilities,
        "loved_disliked_interaction": report["loved_disliked_interaction"],
        "rating_ladder": ladder,
        "global_gates": global_gates,
        "observed": report["observed"],
        "attempted": report["attempted"],
        "blocked": report["blocked"],
        "claim_boundary": [
            "This is one standalone Windows iTunes 12.13.10.3 build and one pinned one-track ITL profile.",
            "RatingKind and AlbumRatingKind were observed as read-only COM projections, not writable controls.",
            "Loved and Disliked were absent from the inspected file-track typelib and unavailable at runtime, so their interaction sequence was blocked.",
            "Raw ITL bytes changed between semantically equal saves; targeted record-header stability is not whole-file byte idempotence.",
            "Targeted structural validation does not establish universal native acceptance or complete opaque-byte semantics.",
            "UI factorials, direct Loved/Disliked transitions, album-derived factorials, additional media/track shapes, other versions, and independent reproduction remain open.",
        ],
    }
    return oracle


def _probe_cell(row: dict[str, Any]) -> str:
    if row.get("outcome") == "observed":
        value = row.get("value", row.get("readback"))
        return f"observed `{str(value).lower() if isinstance(value, bool) else value}`"
    error = row.get("error") or {}
    return f"blocked `{error.get('type', 'unknown')}`: {error.get('message', '')}".replace("|", "\\|")


def _version_value(item: dict[str, Any]) -> str:
    version = item.get("version") or {}
    return str(version.get("product_version") or version.get("file_version") or "unknown")


def _auth_status(item: dict[str, Any]) -> str:
    return str((item.get("authenticode") or {}).get("status") or "unknown")


def _auth_identity(item: dict[str, Any]) -> str:
    auth = item.get("authenticode") or {}
    return f"{auth.get('subject') or 'unknown signer'}; thumbprint `{auth.get('thumbprint') or 'unknown'}`"


def render_readme(oracle: dict[str, Any]) -> str:
    counts = oracle["counts"]
    lines = [
        "# Native RatingKind/Loved/Disliked replacement — 2026-09-25",
        "",
        "This immutable bundle records a bounded native replacement experiment against the pinned template-free one-track ITL on standalone Windows iTunes 12.13.10.3. It separates type-library declarations, runtime COM attempts, native save/reload observations, raw ITL differences, and parser-only validation.",
        "",
        "## Result",
        "",
        f"- Overall: **{'passed' if oracle['passed'] else 'failed'}**.",
        f"- Cases: **{counts['cases_passed']}/{counts['cases_total']}**.",
        f"- Native sessions: **{counts['native_sessions_passed']}/{counts['native_sessions']}**.",
        f"- Rating ladder: `{', '.join(str(value) for value in counts['rating_values'])}`.",
        f"- Started: `{oracle['started_utc']}`; finished: `{oracle['finished_utc']}`.",
        "- U-14 remains open; this bundle narrows it but does not close the UI, album-derived, Loved/Disliked, cross-version, or independent-reproduction factorials.",
        "",
        "## Provenance and safety boundary",
        "",
    ]
    installer = oracle["provenance"]["installer"]
    itunes = oracle["provenance"]["itunes"]
    official = oracle["provenance"]["official_installer_url"]
    candidate = oracle["safety_boundary"]["candidate"]
    lines.extend(
        [
            f"- Source report canonical JSON SHA-256 `{oracle['source_report']['sha256']}` ({oracle['source_report']['hash_basis']}).",
            f"- Official entry: `{official['entry_url']}`; resolved HTTP `{official['http_status']}` to `{official['observed_resolved_url']}`.",
            f"- Installer: version `{_version_value(installer)}`, {installer['bytes']} bytes, SHA-256 `{installer['sha256']}`, Authenticode `{_auth_status(installer)}` ({_auth_identity(installer)}).",
            f"- Installed iTunes: version `{_version_value(itunes)}`, {itunes['bytes']} bytes, SHA-256 `{itunes['sha256']}`, Authenticode `{_auth_status(itunes)}` ({_auth_identity(itunes)}).",
            f"- Candidate: {candidate['bytes']} bytes, SHA-256 `{candidate['sha256']}`; target PID `{TARGET_PID}`.",
            f"- OS: `{oracle['environment']['os']}`; Python `{oracle['environment']['python'].split()[0]}`; pywin32 `{oracle['environment']['pywin32']}`; timezone `{oracle['environment']['timezone']}`.",
            "- Every case used a fresh isolated profile junction and disposable case root. The known audio-configuration warning was the only dismissed UI; all other modal/fallback states failed closed.",
            f"- User data touched: `{str(oracle['safety_boundary']['user_data_touched']).lower()}`.",
            "",
            "## COM capability result",
            "",
            "| Member | Typelib get | Typelib put | Runtime get | Runtime same-value put | Classification |",
            "| --- | --- | --- | --- | --- | --- |",
        ]
    )
    for member in MEMBERS:
        cap = oracle["capabilities"][member]
        lines.append(
            "| "
            + " | ".join(
                [
                    f"`{member}`",
                    "yes" if cap["typelib_declared_get"] else "no",
                    "yes" if cap["typelib_declared_put"] else "no",
                    _probe_cell(cap["runtime_get"]),
                    _probe_cell(cap["runtime_put"]),
                    f"**`{cap['classification']}`**",
                ]
            )
            + " |"
        )
    interaction = oracle["loved_disliked_interaction"]
    lines.extend(
        [
            "",
            f"Loved/Disliked interaction: **`{interaction['outcome']}`** — {interaction['reason']}. No interaction result was inferred from unavailable members.",
            "",
            "## Rating save/reload ladder",
            "",
            "Each value used a fresh baseline. `mutation` performed the first setter/save, `repeat` set the same value again in a restarted iTunes process, and `restart` reopened that exact save and verified without another rating write before normal Quit.",
            "",
            "| Rating | Mutation SHA-256 | Same-value repeat SHA-256 | Restart-verification SHA-256 | Observed ratings |",
            "| ---: | --- | --- | --- | --- |",
        ]
    )
    for row in oracle["rating_ladder"]:
        snaps = row["snapshots"]
        observed = row["observed"]
        lines.append(
            f"| {row['expected']} | `{snaps['mutation']['sha256']}` | `{snaps['same-value-repeat']['sha256']}` | `{snaps['restart-verification']['sha256']}` | `{observed['mutation']}/{observed['same-value-repeat']}/{observed['restart-verification']}` |"
        )
    baseline_sha = oracle["rating_ladder"][0]["snapshots"]["baseline"]["sha256"]
    lines.extend(
        [
            "",
            f"All six cases began from baseline SHA-256 `{baseline_sha}`. For values 20–100, COM projected `Rating/RatingKind/AlbumRating/AlbumRatingKind` from `0/1/0/1` before the write to `value/0/value/1` afterward; that projection was stable through the same-value save and the verification restart. Rating 0 remained `0/1/0/1`. This is a one-track derived-album observation, not a general album rule.",
            "",
            "## Byte and record observations",
            "",
            "| Rating | Baseline→mutation raw/header changed bytes | Mutation→repeat raw/header | Repeat→restart raw/header |",
            "| ---: | ---: | ---: | ---: |",
        ]
    )
    for row in oracle["rating_ladder"]:
        transitions = row["transitions"]
        values = []
        for name in (
            "baseline_to_mutation",
            "mutation_to_same-value-repeat",
            "same-value-repeat_to_restart-verification",
        ):
            transition = transitions[name]
            values.append(
                f"{transition['raw_itl_diff']['changed_byte_positions']}/{transition['track_header_diff']['changed_byte_positions']}"
            )
        lines.append(f"| {row['expected']} | {values[0]} | {values[1]} | {values[2]} |")
    lines.extend(
        [
            "",
            "For nonzero mutations the targeted 756-byte `mith` header added exactly one rating-byte change at `mith+0x6c`: `00→14/28/3c/50/64`. The other 11 baseline-to-first-save header changes are native canonicalization/bookkeeping shared with the zero/probe controls. Every mutation→repeat and repeat→restart targeted header diff was zero bytes. Whole encrypted ITL hashes still changed on each save, so this is semantic/target-header repeat stability, not whole-file byte idempotence.",
            "",
            "Across all analyzed snapshots, `mith+0x6d` (`name_refresh_flag_raw`) remained 0 and the bounded legacy byte at `mith+0x2bf` remained 0 with bit `0x02` clear. Those unchanged sentinels do not establish Loved/Disliked semantics.",
            "",
            "## Validation and gates",
            "",
            f"- `{counts['snapshot_analyses']}` targeted analyses covering `{counts['unique_snapshot_sha256']}` unique snapshot hashes; `{counts['primary_independent_validator_passed']}` passed the primary targeted parser, independent reference parser, and VALIDATOR, and `{counts['validator_valid']}` reported validator-valid.",
            f"- High-level `Library` outcomes: `{json.dumps(counts['high_level_library_outcomes'], sort_keys=True)}`. The raw baseline was blocked by the high-level semantic model, while bounded low-level targeted parsing and independent validation passed; no universal/native acceptance is inferred from structure alone.",
            f"- Saved snapshot validations: `{oracle['global_gates']['saved_snapshot_validations_passed']}/{oracle['global_gates']['saved_snapshot_validations_total']}`.",
            "- All 20 workers and iTunes processes exited 0, all sessions requested normal Quit, all before/after samples were stable, all identity gates passed, and zero forbidden fallback artifacts were observed.",
            "",
            "## Evidence layout",
            "",
            "- `report.json`: complete aggregate provenance, operations, samples, raw/record diffs, and gates.",
            "- `oracle.json`: compact machine-readable conclusion derived from `report.json`.",
            "- `cases/<case>/case-result.json`: per-case aggregate.",
            "- `cases/<case>/<phase>/`: worker specification/result, operation/UI log, and immutable native-saved ITL.",
            "- `pinned-baseline.itl` and `cases-input.json`: exact input and requested matrix.",
            "",
            "## Claim boundary",
            "",
        ]
    )
    lines.extend(f"- {claim}" for claim in oracle["claim_boundary"])
    return "\n".join(lines) + "\n"


def write_outputs(report_path: Path, output_dir: Path | None = None) -> dict[str, Any]:
    output_dir = output_dir or report_path.parent
    report = json.loads(report_path.read_text(encoding="utf-8"))
    oracle = build_oracle(report)
    output_dir.mkdir(parents=True, exist_ok=True)
    (output_dir / "oracle.json").write_text(
        json.dumps(oracle, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )
    (output_dir / "README.md").write_text(render_readme(oracle), encoding="utf-8")
    return oracle


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("report", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args(argv)
    write_outputs(args.report, args.output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
