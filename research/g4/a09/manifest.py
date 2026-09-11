"""Declared expectation manifests for G4-B native candidates (task a09).

The G4 contract requires that candidate intent is declared BEFORE execution:
input and output hashes, complete old and new identifiers, metadata,
locations, playlist membership and order, and the native changes that are
permitted. This module turns that sentence into a machine-checked artifact.

a08 owns the comparison and capture protocol and therefore owns the manifest
format. At the time a09 authored this module a08 had published nothing, so
the schema below is a09 defined, field complete against the contract gate,
and deliberately flat so field names can be renamed when a08 publishes. The
gap is recorded in every manifest under ``format_alignment`` rather than
quietly assumed.

Pure standard library. No native APIs, no iTunes, no COM, no UI.
"""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

EXPECTATION_SCHEMA = "itlkit.g4.a09.expectation.v1"
HEX64 = re.compile(r"^[0-9a-f]{64}$")
CANDIDATE_KINDS = ("native_import_discovery", "independent_writer_acceptance")
ASSIGNMENTS = ("declared", "native_assigned_to_observe")
ID_DOMAINS = (
    "track_id",
    "track_persistent_id",
    "file_persistent_id",
    "master_persistent_id",
    "album_persistent_id",
    "artist_persistent_id",
)
MANDATORY_PROTECTED = (
    "media_file_bytes",
    "media_file_mtime",
    "playlist_membership",
    "playlist_order",
    "library_track_count",
)
OBSERVATION_SLOTS = (
    "library_output_sha256",
    "native_raw_fields",
    "observed_identities",
    "observed_locations",
    "observed_playlists",
    "restart_cycle_results",
    "raw_disk_comparison",
    "com_comparison",
)
REQUIRED_TOP = (
    "schema",
    "declaration_state",
    "candidate_id",
    "candidate_kind",
    "operator",
    "authored_by",
    "format_alignment",
    "preflight",
    "library",
    "media_inputs",
    "identities",
    "locations",
    "playlists",
    "permitted_native_changes",
    "acceptance",
    "observations",
    "run_completed",
)
MEDIA_REGISTRY_FIELDS = (
    "filename",
    "size_bytes",
    "sha256",
    "pcm_sha256",
    "sample_rate_hz",
    "channels",
    "bits_per_sample",
    "frames",
    "mtime_ns",
)

FORMAT_ALIGNMENT = {
    "format_owner": "a08",
    "a08_format_published_at_authoring_time": False,
    "status": "missing",
    "note": (
        "a08 had published no manifest format when a09 authored these manifests. "
        "This schema is a09 defined and covers every field the contract gate requires. "
        "Rename or re-nest fields when a08 publishes; do not treat this as a08 approved."
    ),
}


def _nonempty(value):
    return isinstance(value, str) and value.strip() != ""


def build_template(registry, *, candidate_id, candidate_kind, fixture_ids=None, playlist_name="A09 Declared Order"):
    """Build an unfilled manifest template bound to reproducible fixtures."""
    if candidate_kind not in CANDIDATE_KINDS:
        raise ValueError("unknown candidate kind %r" % (candidate_kind,))
    rows = {row["fixture_id"]: row for row in registry["fixtures"]}
    chosen = list(fixture_ids) if fixture_ids else [row["fixture_id"] for row in registry["fixtures"]]
    media = []
    for fixture_id in chosen:
        row = rows[fixture_id]
        media.append(
            {
                "fixture_id": fixture_id,
                "filename": row["filename"],
                "size_bytes": row["size_bytes"],
                "sha256": row["sha256"],
                "pcm_sha256": row["pcm_sha256"],
                "sample_rate_hz": row["sample_rate_hz"],
                "channels": row["channels"],
                "bits_per_sample": row["bits_per_sample"],
                "frames": row["frames"],
                "duration_ms": row["duration_ms"],
                "mtime_ns": row["mtime_ns"],
                "metadata_shape": row["metadata_shape"],
                "embedded_metadata": row["metadata"],
                "generator": registry["generator"],
                "declared_location": None,
                "expected_native_title_source": None,
            }
        )
    default_assignment = (
        "declared" if candidate_kind == "independent_writer_acceptance" else "native_assigned_to_observe"
    )
    identities = []
    for fixture_id in chosen:
        for domain in ID_DOMAINS:
            identities.append(
                {
                    "media_fixture_id": fixture_id,
                    "domain": domain,
                    "old": {"present": None, "value": None, "absent_reason": None},
                    "new": {
                        "assignment": default_assignment,
                        "value": None,
                        "observation_slot": "observations.observed_identities",
                    },
                }
            )
    expected_output = (
        {"sha256": None, "size_bytes": None}
        if candidate_kind == "independent_writer_acceptance"
        else {
            "sha256": None,
            "size_bytes": None,
            "unpredictable_reason": None,
            "capture_required": True,
        }
    )
    return {
        "schema": EXPECTATION_SCHEMA,
        "declaration_state": "template",
        "candidate_id": candidate_id,
        "candidate_kind": candidate_kind,
        "operator": "a10",
        "authored_by": "a09",
        "format_alignment": dict(FORMAT_ALIGNMENT),
        "preflight": {"a08_review_id": None, "a11_review_id": None, "coordinator_slot": None},
        "library": {
            "intended_library_path": None,
            "profile_note": "Isolated synthetic library only. Never a real or personal library.",
            "input": {"sha256": None, "size_bytes": None, "mtime_ns": None},
            "expected_output": expected_output,
        },
        "media_inputs": media,
        "identities": {
            "domains": list(ID_DOMAINS),
            "rule": "Distinct id domains are never equated. Old ids are declared present or explicitly absent with a reason.",
            "entries": identities,
        },
        "locations": {
            "before": [{"fixture_id": fixture_id, "path": None} for fixture_id in chosen],
            "after": [{"fixture_id": fixture_id, "path": None} for fixture_id in chosen],
        },
        "playlists": [
            {
                "name": playlist_name,
                "persistent_id": {"assignment": default_assignment, "value": None},
                "membership": list(chosen),
                "order": list(chosen),
            }
        ],
        "permitted_native_changes": {
            "allowed": [
                "date_added",
                "library_internal_ordering_keys",
                "native_assigned_identifiers",
            ],
            "must_not_change": list(MANDATORY_PROTECTED),
            "note": "Anything not listed as allowed is a finding, not an acceptable variation.",
        },
        "acceptance": {
            "restart_cycles": 2,
            "damaged_file_fallback_allowed": False,
            "repair_allowed": False,
            "normal_save_and_exit_required": True,
            "raw_disk_comparison_required": True,
            "com_comparison_required": True,
            "playback_is_separate_endpoint": True,
        },
        "observations": {slot: None for slot in OBSERVATION_SLOTS},
        "run_completed": False,
    }


def validate(manifest, registry=None):
    """Return a list of human readable problems. Empty means structurally sound."""
    errors = []
    if not isinstance(manifest, dict):
        return ["manifest must be a JSON object"]
    for key in REQUIRED_TOP:
        if key not in manifest:
            errors.append("missing top level key: %s" % key)
    if errors:
        return errors
    if manifest["schema"] != EXPECTATION_SCHEMA:
        errors.append("schema must be %s" % EXPECTATION_SCHEMA)
    state = manifest["declaration_state"]
    if state not in ("template", "declared"):
        errors.append("declaration_state must be template or declared")
    kind = manifest["candidate_kind"]
    if kind not in CANDIDATE_KINDS:
        errors.append("candidate_kind must be one of %s" % (CANDIDATE_KINDS,))
    media = manifest["media_inputs"]
    if not isinstance(media, list) or not media:
        return errors + ["media_inputs must be a non-empty list"]
    fixture_ids = [entry.get("fixture_id") for entry in media]
    if len(set(fixture_ids)) != len(fixture_ids):
        errors.append("media_inputs contains duplicate fixture ids")

    if registry is not None:
        rows = {row["fixture_id"]: row for row in registry.get("fixtures", [])}
        for entry in media:
            row = rows.get(entry.get("fixture_id"))
            if row is None:
                errors.append("%s: not present in the fixture registry" % entry.get("fixture_id"))
                continue
            for name in MEDIA_REGISTRY_FIELDS:
                if entry.get(name) != row.get(name):
                    errors.append(
                        "%s: %s declared %r but the registry records %r"
                        % (entry.get("fixture_id"), name, entry.get(name), row.get(name))
                    )

    observations = manifest["observations"]
    if not isinstance(observations, dict):
        errors.append("observations must be an object")
    else:
        for slot in OBSERVATION_SLOTS:
            if slot not in observations:
                errors.append("observations is missing slot: %s" % slot)
        if manifest.get("run_completed") is not True:
            for slot, value in observations.items():
                if value not in (None, [], {}):
                    errors.append(
                        "observations.%s must stay empty until the run is executed" % slot
                    )

    if state != "declared":
        return errors

    if not _nonempty(manifest["candidate_id"]) or manifest["candidate_id"].upper().startswith("TEMPLATE"):
        errors.append("candidate_id must be a real identifier before a run")
    if manifest["operator"] != "a10":
        errors.append("operator must be a10, the only task permitted to run native")
    if not _nonempty(manifest["authored_by"]):
        errors.append("authored_by is required")

    preflight = manifest["preflight"] or {}
    for key in ("a08_review_id", "a11_review_id", "coordinator_slot"):
        if not _nonempty(preflight.get(key)):
            errors.append("preflight.%s is required before a native run" % key)

    library = manifest["library"] or {}
    if not _nonempty(library.get("intended_library_path")):
        errors.append("library.intended_library_path is required")
    source = library.get("input") or {}
    if not HEX64.match(str(source.get("sha256", ""))):
        errors.append("library.input.sha256 must be a lowercase hex sha256")
    if not isinstance(source.get("size_bytes"), int) or source.get("size_bytes", 0) <= 0:
        errors.append("library.input.size_bytes must be a positive integer")
    if not isinstance(source.get("mtime_ns"), int):
        errors.append("library.input.mtime_ns must be an integer")
    expected = library.get("expected_output") or {}
    if kind == "independent_writer_acceptance":
        if not HEX64.match(str(expected.get("sha256", ""))):
            errors.append(
                "independent writer acceptance must predeclare library.expected_output.sha256"
            )
        if not isinstance(expected.get("size_bytes"), int) or expected.get("size_bytes", 0) <= 0:
            errors.append("independent writer acceptance must predeclare the output size")
    else:
        if expected.get("sha256") is not None:
            errors.append("native import discovery must not predeclare an output hash")
        if not _nonempty(expected.get("unpredictable_reason")):
            errors.append("library.expected_output.unpredictable_reason is required when no hash is declared")
        if expected.get("capture_required") is not True:
            errors.append("library.expected_output.capture_required must be true")

    for entry in media:
        fixture_id = entry.get("fixture_id", "<unknown>")
        if not HEX64.match(str(entry.get("sha256", ""))) or not HEX64.match(str(entry.get("pcm_sha256", ""))):
            errors.append("%s: sha256 and pcm_sha256 must be lowercase hex" % fixture_id)
        if not _nonempty(entry.get("declared_location")):
            errors.append("%s: declared_location is required" % fixture_id)
        if not isinstance(entry.get("embedded_metadata"), dict):
            errors.append(
                "%s: embedded_metadata must be an object, an empty object means no embedded tags"
                % fixture_id
            )
        if not _nonempty(entry.get("expected_native_title_source")):
            errors.append("%s: expected_native_title_source is required" % fixture_id)

    identities = manifest["identities"] or {}
    entries = identities.get("entries")
    if not isinstance(entries, list) or not entries:
        errors.append("identities.entries must be a non-empty list")
    else:
        seen = set()
        for entry in entries:
            fixture_id = entry.get("media_fixture_id")
            domain = entry.get("domain")
            seen.add((fixture_id, domain))
            label = "%s/%s" % (fixture_id, domain)
            if fixture_id not in fixture_ids:
                errors.append("%s: identity entry references an undeclared fixture" % label)
            if domain not in ID_DOMAINS:
                errors.append("%s: unknown identity domain" % label)
            old = entry.get("old") or {}
            new = entry.get("new") or {}
            if old.get("present") is True and not _nonempty(old.get("value")):
                errors.append("%s: old id declared present but has no value" % label)
            elif old.get("present") is False and not _nonempty(old.get("absent_reason")):
                errors.append("%s: absent old id needs an absent_reason" % label)
            elif old.get("present") not in (True, False):
                errors.append("%s: old.present must be true or false" % label)
            assignment = new.get("assignment")
            if assignment not in ASSIGNMENTS:
                errors.append("%s: new.assignment must be one of %s" % (label, (ASSIGNMENTS,)))
            elif assignment == "declared":
                if not _nonempty(new.get("value")):
                    errors.append("%s: declared new id needs a value" % label)
            else:
                if new.get("value") is not None:
                    errors.append("%s: an id to be observed must stay null until captured" % label)
                if not _nonempty(new.get("observation_slot")):
                    errors.append("%s: an id to be observed needs an observation_slot" % label)
                if kind == "independent_writer_acceptance":
                    errors.append(
                        "%s: independent writer acceptance must declare every new id in advance" % label
                    )
        for fixture_id in fixture_ids:
            for domain in ID_DOMAINS:
                if (fixture_id, domain) not in seen:
                    errors.append("identities is missing %s for %s" % (domain, fixture_id))

    locations = manifest["locations"] or {}
    for phase in ("before", "after"):
        rows = locations.get(phase)
        if not isinstance(rows, list) or len(rows) != len(media):
            errors.append("locations.%s must declare exactly one entry per media input" % phase)
            continue
        declared = set()
        for row in rows:
            declared.add(row.get("fixture_id"))
            if not _nonempty(row.get("path")):
                errors.append("locations.%s: %s needs a path" % (phase, row.get("fixture_id")))
        missing = [f for f in fixture_ids if f not in declared]
        if missing:
            errors.append("locations.%s is missing %s" % (phase, missing))

    playlists = manifest["playlists"]
    if not isinstance(playlists, list) or not playlists:
        errors.append("playlists must be declared, use an empty membership list to declare none")
    else:
        for playlist in playlists:
            name = playlist.get("name")
            if not _nonempty(name):
                errors.append("every playlist needs a name")
            persistent = playlist.get("persistent_id") or {}
            assignment = persistent.get("assignment")
            if assignment not in ASSIGNMENTS:
                errors.append("%s: playlist persistent_id.assignment is invalid" % name)
            elif assignment == "declared" and not _nonempty(persistent.get("value")):
                errors.append("%s: declared playlist persistent id needs a value" % name)
            elif assignment == "native_assigned_to_observe" and persistent.get("value") is not None:
                errors.append("%s: playlist id to be observed must stay null" % name)
            membership = playlist.get("membership")
            order = playlist.get("order")
            if not isinstance(membership, list) or not isinstance(order, list):
                errors.append("%s: membership and order must both be lists" % name)
                continue
            unknown = [f for f in membership if f not in fixture_ids]
            if unknown:
                errors.append("%s: membership references undeclared fixtures %s" % (name, unknown))
            if len(set(membership)) != len(membership):
                errors.append("%s: membership contains duplicates" % name)
            if sorted(order) != sorted(membership):
                errors.append("%s: order must be a permutation of membership" % name)

    permitted = manifest["permitted_native_changes"] or {}
    allowed = permitted.get("allowed")
    protected = permitted.get("must_not_change")
    if not isinstance(allowed, list) or any(not _nonempty(x) for x in allowed):
        errors.append("permitted_native_changes.allowed must be a list of field names")
    if not isinstance(protected, list) or not protected or any(not _nonempty(x) for x in protected):
        errors.append("permitted_native_changes.must_not_change must be a non-empty list")
    if isinstance(allowed, list) and isinstance(protected, list):
        overlap = sorted(set(allowed) & set(protected))
        if overlap:
            errors.append("permitted_native_changes: %s is both allowed and protected" % overlap)
        missing = [f for f in MANDATORY_PROTECTED if f not in protected]
        if missing:
            errors.append("permitted_native_changes.must_not_change is missing %s" % missing)

    acceptance = manifest["acceptance"] or {}
    cycles = acceptance.get("restart_cycles")
    if not isinstance(cycles, int) or cycles < 2:
        errors.append("acceptance.restart_cycles must be at least 2")
    for key in ("damaged_file_fallback_allowed", "repair_allowed"):
        if acceptance.get(key) is not False:
            errors.append("acceptance.%s must be false" % key)
    for key in (
        "normal_save_and_exit_required",
        "raw_disk_comparison_required",
        "com_comparison_required",
        "playback_is_separate_endpoint",
    ):
        if acceptance.get(key) is not True:
            errors.append("acceptance.%s must be true" % key)

    return errors


def is_runnable(manifest, registry=None):
    """A manifest is runnable only when it is declared and free of problems."""
    errors = validate(manifest, registry=registry)
    if manifest.get("declaration_state") != "declared":
        errors = errors + ["declaration_state is not declared, so no native run is authorised"]
    return (not errors, errors)


def load_json(path):
    return json.loads(Path(path).read_text(encoding="utf-8"))


def write_json(path, payload):
    target = Path(path)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    return target


DEFAULT_REGISTRY = "research/g4/a09/fixture-registry.json"
DEFAULT_TEMPLATE_DIR = "research/g4/a09/expectations"


def default_templates(registry):
    all_ids = [row["fixture_id"] for row in registry["fixtures"]]
    writer_ids = [
        fixture_id
        for fixture_id in all_ids
        if fixture_id
        in (
            "ITL-G2-PCM-48000-001",
            "ITL-G4-A09-PCM-44100-MONO-1000",
            "ITL-G4-A09-PCM-48000-MONO-1500-ID3U",
        )
    ]
    return {
        "candidate-native-import-discovery.json": build_template(
            registry,
            candidate_id="TEMPLATE-native-import-discovery",
            candidate_kind="native_import_discovery",
            fixture_ids=all_ids,
            playlist_name="A09 Import Discovery Order",
        ),
        "candidate-independent-writer-acceptance.json": build_template(
            registry,
            candidate_id="TEMPLATE-independent-writer-acceptance",
            candidate_kind="independent_writer_acceptance",
            fixture_ids=writer_ids,
            playlist_name="A09 Writer Acceptance Order",
        ),
    }


def main(argv=None):
    parser = argparse.ArgumentParser(description="a09 declared expectation manifests")
    parser.add_argument("--registry", default=DEFAULT_REGISTRY)
    parser.add_argument("--write-templates", nargs="?", const=DEFAULT_TEMPLATE_DIR)
    parser.add_argument("--validate", action="append", default=[])
    parser.add_argument("--require-runnable", action="store_true")
    args = parser.parse_args(argv)

    registry = load_json(args.registry)
    status = 0

    if args.write_templates:
        for name, manifest in default_templates(registry).items():
            target = write_json(Path(args.write_templates) / name, manifest)
            problems = validate(manifest, registry=registry)
            print("TEMPLATE %s problems=%d" % (target, len(problems)))
            for problem in problems:
                print("  PROBLEM " + problem)
            if problems:
                status = 1

    for path in args.validate:
        manifest = load_json(path)
        runnable, problems = is_runnable(manifest, registry=registry)
        print("VALIDATE %s runnable=%s problems=%d" % (path, runnable, len(problems)))
        for problem in problems:
            print("  PROBLEM " + problem)
        if args.require_runnable and not runnable:
            status = 1
        elif not args.require_runnable and validate(manifest, registry=registry):
            status = 1

    return status


if __name__ == "__main__":
    raise SystemExit(main())
