# a11 - adversarial review findings (G4-B)

Reviewer task a11. Production code is read-only for this task. Base commit
`1bb05edc2494abc9aa9b59cd2392026f830615a2`, branch `g4/a11`, linux env
`linux-xm801aqb`.

## 0. The primary objective is BLOCKED, and that is the most important finding

The assignment named a02 as the highest-value target and told me to review the
actual diff, explicitly because the historical G3 reviewer reviewed only a
design. **I could not review a02's diff either, for an environment reason, not
a judgement call.**

* `git rev-parse --verify g4/a02` and `refs/remotes/origin/g4/a02` both fail.
* `git ls-remote origin 'refs/heads/g4/*'` returns zero refs: children never push.
* Per the resumption addendum, a02, a10 and a12 run on the windows environment
  `win-r6qwbqfz`; a11 runs on `linux-xm801aqb`. a02's commits exist only in the
  windows clone, which is outside my assigned environment.

The five review targets quote a code fragment
(`shared = ReadLimits(**dict(lim, max_depth=min(lim["max_depth"], 32), ...))`)
that **does not exist at the base commit**. It is a02's new code. So every
statement below about `admission.py` and `playlist_models.py` describes the
base behaviour that a02 is changing, not a02's change.

This is a contract gap, not a a02 defect: a cross-environment reviewer was
assigned a target that is unreachable by construction. See
`contract_changes_needed` in `report.json`.

## 1. Findings ranked by severity

### F1 - medium, reproduced - a05: inventory claims a recipe constant that does not exist

`itlkit/media.py` on `g4/a05`. `new_track_media_fields` reports `format_code`
and `kind_text` with status `recipe_constant_unverified` and value `None` for
every non-WAV family, while `recipe_format_code` / `recipe_kind_text` raise
`MediaError` for exactly the same `MediaFacts`. Two public APIs of one module
contradict each other. The correct status in `FIELD_STATUSES` is
`absent_from_itlkit`.

Why it matters rather than being cosmetic: a05's own document, section 6.3,
tells a08 and a10 that a candidate declaration must carry "the two recipe
constants actually written". A consumer that reads the inventory, which the
document calls the non-stale source of truth, emits `format_code: None` as an
"unverified constant" for an AIFF or MP3 candidate instead of refusing.

Reproduced: `recipe_status_violations = [('aiff','format_code'),
('aiff','kind_text'), ('mp3','format_code'), ('mp3','kind_text')]`,
command_id `e4f697f5c1b74507`. Armed test:
`test_g4_a11_counterexample_a05_recipe_status_implies_a_recipe_constant`.

Partial mitigation, stated for fairness: `unmet_new_media_conditions` does add
a separate `family: only the WAV PCM recipe is admitted` line for non-WAV
input, so a careful consumer can still catch it.

### F2 - medium, reproduced - a05: an unknown chunk is reported as bare media

`metadata_carriers` and `artwork_carriers` are computed from the fixed
allowlists `_PCM_METADATA_CHUNKS` / `_PCM_ARTWORK_CHUNKS`. A WAV carrying an
unlisted chunk such as `XYZ `, `bext`, `iXML` or `axml` is admitted with
`embedded_metadata_present == False` and `artwork_possible == False`, even
though the chunk is preserved and never decoded.

Why it matters: a05's document, section 6.2, instructs a08 and a10 that "if any
carrier is present the candidate is not a bare-media candidate, because native
may read fields itlkit never decoded". An allowlist inverts that rule for
exactly the unknown chunks the rule is meant to catch, so an unknown-chunk WAV
passes preflight as bare media.

Suggested direction, for the owner to decide: classify any chunk outside
`{fmt , data}` for WAV and `{COMM, SSND}` for AIFF as an unknown carrier, or add
an explicit `unknown_chunks` field, instead of extending the allowlist.

Reproduced: `probe:plus_unknown_XYZ` shows `meta_present False` with
`spans (('fmt ',20,16), ('XYZ ',44,4), ('data',56,200))`, command_id
`e4f697f5c1b74507`. Armed test:
`test_g4_a11_counterexample_a05_unknown_chunk_is_an_undecoded_carrier`.

### F3 - low, reproduced - contract conflict between the two depth ceilings

`itlkit.schema.ReadLimits` refuses `max_depth > 32`
("max_depth cannot exceed the current core depth 32"), while
`playlist_models._limits` accepts up to 64 ("playlist recursion ceiling is 64"),
which `docs/playlist-models-v2.md` line 27 also states. The two accepted
domains are therefore not nested, so the same document's promise that a parent
"may pass the pinned shared ReadLimits after integration without changing call
sites" holds only for 1..32: any caller using 33..64 today becomes
unconstructible after integration, with no diagnostic.

This is the surface a02's quoted `min(lim["max_depth"], 32)` clamp touches. A
silent clamp is the risky resolution: a caller that asked for 48 would be
refused at 32 and would read a limit error naming a cap it never configured.
Refusing a mapping above the shared ceiling, or reporting the effective cap, is
preferable. Pinned by
`test_g4_a11_playlist_depth_ceiling_exceeds_the_shared_readlimits_ceiling`.

### F4 - low, observation - a05: chunk spans do not tile a padded file

Odd-length chunks carry a RIFF pad byte that is inside no span, so
`12 + sum(length + 8)` is 255 for a 256-byte file with one odd chunk
(`tiling:plus_ANNO_odd`, command_id `e4f697f5c1b74507`). The pad is recoverable
by the odd-length convention, so nothing is lost, but the document's claim that
the spans let "a round trip be proved byte-exact instead of assumed" is not
literally satisfied. Fix the sentence or record the pad. Deliberately not
written as a failing test, because fixing the document is a legitimate answer.

## 2. Targets checked with a negative result

Stated explicitly so the coordinator does not read silence as coverage. All of
these were executed against the base code, command_id `bf21dfe508624608`.

1. **Depth off-by-one at exactly 32.** Not a defect at base. Depth is 0-based at
   top-level sections, so `max_depth=32` admits 33 physical levels: 32 levels
   accepted, 33 refused with `depth budget exceeded: 33 > 32`. This matches
   `docs/admission-v2.md`. Physical depths 33, 48 and 64 are all refused. The
   two subsystems count differently, which a02 must not conflate: admission
   counts one level per node, playlist SLst nesting costs two levels per nested
   tree (15 nestings accepted, 16 refused at `max_depth=32`), and playlist
   entries start at depth 3.
2. **Budget double counting, negative or zero remainder.** Not reproduced.
   `R = M - 6W` at exactly 0 and at 8 both refuse with `PlaylistLimitError`
   chained from the original `FormatError`; an explicit `max_plain_bytes`
   refusal keeps `FormatError`; the caller's mapping is not mutated; a
   sufficient budget succeeds. No shared-text or JSON-key case was found that
   refuses something the documented formula should accept.
3. **Order and duplicate preservation.** Not reproduced. Duplicate metadata keep
   distinct `child_index` and `occurrence_index`, entry order and duplicate
   track references survive, JSON object keys follow declaration order rather
   than being sorted, and arrays keep their order.
4. **`RawSpan._buffer` omission.** Confirmed safe. No public span fact is lost:
   `offset` and `size` are both exported, and a span reconstructs exactly from
   `payload_hex` with `payload_base_offset`. `_buffer` appears in no export with
   or without `include_raw`, including across 4000 fuzz exports.
5. **Auxiliary admission predicate.** No divergence from the pinned core. At the
   observed widths 88 and 100, duplicate or zero persistent IDs are refused by
   both the core and admission. Above those widths the persistent-ID check is
   skipped by **both**, because it is the core's own observed-size condition,
   which `docs/admission-v2.md` adopts deliberately. Records with absent
   children, foreign tags inside an auxiliary root, and non-96-byte auxiliary
   section or root headers are likewise accepted by both. These are inherited
   gaps in the predicate's reach, not a02-introduced defects; they are pinned by
   tests so a02's hardening cannot silently change the answer in either
   direction.

Fuzzing, 4000 mutated payloads and smart-rule trees: no unexpected exception
class, no private-state leak, no crash. Only diagnostics and
`PlaylistLimitError` were observed.

## 3. Not reviewed

a02 (unreachable), a10 and a12 (windows environment, unreachable, so no native
candidate preflight was possible), a03 and a09 (no commits: both branches are
still at the base commit). a01 and a04 have output but are outside this task's
assignment.
