# Declared expectation manifest format (a09 provisional)

Schema id: `itlkit.g4.a09.expectation.v1`\
Implementation: `research/g4/a09/manifest.py`\
Templates: `research/g4/a09/expectations/`\
Checks: `tests/test_g4_a09_fixtures.py`

## Status: provisional, and why

The research contract assigns the manifest format to a08. When a09 authored
this, a08 had published nothing: the a08 worktree carried no format document and
the shared report directories were empty. Rather than silently invent a peer's
deliverable or stall, a09 defined a working schema and recorded the gap inside
every emitted manifest under `format_alignment`, which carries
`format_owner: "a08"`, `a08_format_published_at_authoring_time: false` and
`status: "missing"`.

When a08 publishes, rename or re-nest fields freely. The names are the
disposable part. The validation rules are the part worth preserving, because
they are what stops an observed native result from being retrofitted into an
expectation after the fact.

## The gate this enforces

A declared expectation manifest is an a10 precondition, not an a10 output. It
must be complete and committed before any native run:

```bash
# emit a starting point
python3 research/g4/a09/manifest.py --registry research/g4/a09/fixture-registry.json --write-templates research/g4/a09/expectations

# a10 fills it in, then must get exit code 0 from this before touching native
python3 research/g4/a09/manifest.py --validate path/to/declaration.json --require-runnable
```

Non-zero exit means the declaration is incomplete and no native run is
authorised. Templates deliberately fail that check.

## Declaration states

| State | Meaning |
| --- | --- |
| `template` | Emitted skeleton. Structurally valid, never runnable. |
| `declared` | Fully specified and reviewed. Runnable when the validator reports no problems. |

`run_completed` stays `false` and every slot under `observations` stays `null`
until the native run has actually happened. Filling an observation while
`run_completed` is `false` is a validation error. That is the anti-retrofit rule
stated mechanically.

## Candidate kinds

| Kind | Output hash rule |
| --- | --- |
| `native_import_discovery` | The library output cannot be predicted byte for byte, so `library.expected_output.sha256` must be `null` with an `unpredictable_reason` and `capture_required: true`. |
| `independent_writer_acceptance` | The writer is deterministic, so the output hash and size must be predeclared. A null output hash here is a validation error. |

## Top level fields

| Field | Purpose |
| --- | --- |
| `schema` | Always `itlkit.g4.a09.expectation.v1`. |
| `declaration_state` | `template` or `declared`. |
| `candidate_id` | Stable id for this candidate run. |
| `candidate_kind` | One of the two kinds above. |
| `operator` | Must be `a10`. Any other value is rejected; a09 may not authorise itself to run native. |
| `authored_by` | Who wrote the declaration, for traceability separate from who runs it. |
| `format_alignment` | Records the a08 format ownership and the publication gap. |
| `preflight` | `a08_review_id`, `a11_review_id`, `coordinator_slot`. All required in the declared state. |
| `library` | `intended_library_path`, `profile_note`, `input` and `expected_output` hash blocks. |
| `media_inputs` | One pinned entry per fixture, re-checked against the fixture registry. |
| `identities` | Complete old and new identifier declarations across every id domain. |
| `locations` | Before and after paths per fixture. |
| `playlists` | Name, persistent id, membership and explicit order. |
| `permitted_native_changes` | `allowed` versus `must_not_change`. |
| `acceptance` | How the run is judged, including restart and fallback policy. |
| `observations` | Eight null slots, filled only after the run. |
| `run_completed` | `false` until the native run has happened. |

The library input hash block is always required, including for discovery: the
starting library must be pinned even when the ending library cannot be.

## Media inputs

Each entry pins one fixture. These nine fields are copied from
`research/g4/a09/fixture-registry.json` and re-checked against it at validation
time, so a manifest cannot drift away from the reproducible generator:

`filename`, `size_bytes`, `sha256`, `pcm_sha256`, `sample_rate_hz`, `channels`,
`bits_per_sample`, `frames`, `mtime_ns`.

A mismatch is reported as `registry records ...`, which is what stops a fixture
from being quietly edited after it was declared.

Each entry also carries `duration_ms`, `metadata_shape`, `embedded_metadata`,
`generator`, and two declaration-only fields that must be filled before a run:

| Field | Meaning |
| --- | --- |
| `declared_location` | Exact intended on-disk path of the file at import time. Empty or missing is rejected. |
| `expected_native_title_source` | Whether the title is expected to come from the filename or from an embedded tag. Makes the tag-versus-filename question a prediction rather than a post-hoc rationalisation. |

## Identities

`identities` has `domains`, a `rule` string, and `entries`. One entry per fixture
per domain, across all six domains: `track_id`, `track_persistent_id`,
`file_persistent_id`, `master_persistent_id`, `album_persistent_id`,
`artist_persistent_id`. A removed entry is reported as missing, so the matrix
cannot be silently thinned.

Distinct id domains are never equated. Each entry declares:

```json
{
  "media_fixture_id": "ITL-G2-PCM-48000-001",
  "domain": "track_persistent_id",
  "old": { "present": false, "value": null, "absent_reason": "fresh library, no prior row" },
  "new": { "assignment": "native_assigned_to_observe", "value": null, "observation_slot": "observations.observed_identities" }
}
```

`old.present` must be stated explicitly; when absent it needs an
`absent_reason` rather than a bare null. `new.assignment` is one of:

| Assignment | Use |
| --- | --- |
| `declared` | The value is predicted up front and must be non-null. |
| `native_assigned_to_observe` | Only valid for `native_import_discovery`, and only with an `observation_slot` naming where the observed value will land. |

An `independent_writer_acceptance` manifest must declare every new id up front;
a native-assigned id there is rejected.

## Locations and playlists

`locations` carries `before` and `after` lists with one path per fixture, so a
move, a consolidate or a silent copy is detectable instead of inferred.

`playlists` entries carry `name`, `persistent_id`, `membership` and an explicit
`order`. The order must be a permutation of the membership, which catches a
dropped or duplicated track at declaration time rather than after the run.

## Permitted native changes

`allowed` lists what the application may change without failing the run, for
example `date_added`, `library_internal_ordering_keys` and
`native_assigned_identifiers`. `must_not_change` is the preservation set and
always contains at least `media_file_bytes`, `media_file_mtime`,
`playlist_membership`, `playlist_order` and `library_track_count`.

A field may not appear in both lists, and none of the mandatory protected fields
may be removed. This is the contract preservation gate expressed as data:
anything not listed as allowed is a finding, not an acceptable variation.

## Acceptance

| Field | Default | Why |
| --- | --- | --- |
| `restart_cycles` | `2` | One restart cannot distinguish a value that survives a save from one that survives a reload. Fewer than two is rejected. |
| `damaged_file_fallback_allowed` | `false` | A run that repaired or replaced a damaged library proves nothing about the original. |
| `repair_allowed` | `false` | Same reasoning. |
| `normal_save_and_exit_required` | `true` | The library must be closed the way the application intends, not killed. |
| `raw_disk_comparison_required` | `true` | The on-disk bytes are the evidence. |
| `com_comparison_required` | `true` | The automation view must be compared against the disk view rather than trusted. |
| `playback_is_separate_endpoint` | `true` | Playback is not evidence about library state. |

## Observations

Eight slots, all `null` until the run happens: `library_output_sha256`,
`native_raw_fields`, `observed_identities`, `observed_locations`,
`observed_playlists`, `restart_cycle_results`, `raw_disk_comparison`,
`com_comparison`. Any populated slot while `run_completed` is `false` is
rejected with `must stay empty`.

## Rejection catalogue

Each of these is covered by a test in `tests/test_g4_a09_fixtures.py`:

| Mutation | Rejected because |
| --- | --- |
| `preflight.a08_review_id` left null | Reviews are a precondition, not paperwork to backfill. |
| Empty `declared_location` | The intended path must be known before the import. |
| `restart_cycles` set to 1 | Cannot separate save persistence from reload persistence. |
| `damaged_file_fallback_allowed` set to true | Would let a repaired library count as evidence. |
| An identity entry removed | The id matrix must stay complete. |
| `media_file_bytes` in both `allowed` and `must_not_change` | Contradictory declaration. |
| An observation populated before the run | Anti-retrofit rule. |
| `operator` set to `a09` | Only a10 may operate native. |
| A media hash edited away from the registry | Declaration must match the reproducible generator. |
| Writer acceptance with a native-assigned id or a null output hash | A deterministic writer must be fully predicted. |
| Playlist `order` not a permutation of `membership` | Membership and order must agree. |

## For a08 and a10

a08 owns the final format: rename fields, re-nest, or replace this schema
wholesale, but keep the rules above, since they are what make the manifest a
gate rather than a form. a10 fills a template, sets `declaration_state` to
`declared`, gets exit code 0 from `--require-runnable`, commits it, and only then
runs native. Observations are appended afterwards with `run_completed` set true.
