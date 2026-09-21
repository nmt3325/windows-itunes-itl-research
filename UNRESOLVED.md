# Unresolved questions and major gaps

These gaps are intentional completion blockers for any claim of universal ITL support. A refusal is not a hidden implementation success.

## Critical gaps

### U-01 — version breadth

**State:** unresolved.

Only the named standalone Windows 12.13.10.3 profile has the full packaged native evidence. The 12.13.9.1 profile is admitted for bounded behavior without an equivalent native matrix. Other releases may change header, section, record, index, or callback semantics.

**Closure evidence required:** version-pinned native fixtures, two-cycle acceptance/negative cases, static provenance, and a separate matrix row for each newly admitted version.

### U-02 — big-endian semantic payloads

**State:** opaque preservation only.

The outer header describes payload byte order, but `Library` intentionally implements little-endian record/text semantics only. `Container` can preserve or rebuild raw bytes without understanding them.

**Closure evidence required:** independent BE fixtures, endian-aware record/string primitives, count/reference tests, and native acceptance on an exact BE-producing version.

### U-03 — general identity and string-pool allocation

**State:** conservative guards, not a complete allocator.

Known pools and identity namespaces are checked, but unknown consumers, reference-only encodings, callback ownership, compaction, and complete allocation/high-water rules are unresolved.

**Closure evidence required:** static consumer census plus native differential allocation/COW tests covering shared and unshared objects, collision cases, deletion, restart, and repeated allocation.

### U-04 — arbitrary cross-library import and new-track construction

**State:** research-only exact candidates.

The public `Library.add_track_from` remains same-lineage restoration. Separate research transformations produced accepted cross-library and constructed-WAV candidates, but those results do not establish a general API, arbitrary paths, arbitrary donors, or arbitrary media.

**Closure evidence required:** a production algorithm with explicit donor/recipient constraints, complete dependency remapping, deterministic refusal policy, diverse fixtures, negative cases, and independent native cycles for newly generated outputs.

### U-05 — general shared-object copy-on-write

**State:** refused outside the closed profile.

Selected local-WAV album/artist maintenance works when the old object is not shared in an unsupported way. General shared album/artist/string/sort object COW is not native-qualified.

**Closure evidence required:** multi-track sharing matrices, all known pool consumers, identity allocation provenance, peer-record preservation, raw reference closure, and native reload checks.

### U-06 — recursive, smart, system, and master playlist semantics

**State:** preserved/compared/refused.

Flat ordinary playlist CRUD is supported. Grouped/nested items, arbitrary smart rules, system definitions, automatic sort/display behavior, and external playlist-item references remain unresolved.

**Closure evidence required:** record grammar for nested items and rule objects, evaluation/ownership semantics, matching negative fixtures, and native persistence tests without losing opaque rules.

### U-07 — store, cloud, DRM, queue, and history profiles

**State:** out of supported scope.

Sections 20/22/23, store indexes, cloud/store track types, DRM state, and queue/history semantics are incomplete or opaque.

**Closure evidence required:** synthetic or lawfully controlled fixtures, bounded static/dynamic evidence, privacy-safe oracles, and fail-closed integration tests.

## Major semantic gaps

### U-08 — media relocation and URL/path objects

Changing text URL/path alone can contradict an opaque file-location object. The supported code refuses this case and does not move media.

Closure requires decoding and updating all location representations, path normalization/encoding rules, filesystem behavior, and native reopen tests on relocated synthetic media.

### U-09 — non-WAV structural edits and media-format breadth

Closed track structural/index operations require the observed native local-WAV template. Encoded media artifacts prove generation/provenance, not general ITL construction or playback for MP3/AAC/ALAC/AIFF.

Closure requires per-format native templates, field/dependency comparison, construction/import tests, and explicit playback/non-playback gates.

### U-10 — complete sort/rank/cache regeneration

Selected text edits and known pool guards do not define every sort key, rank word, cache, or callback. The Name-refresh bit is a bounded correction, not a general rank reset rule.

Closure requires consumer mapping and native factorials for empty/missing/nonempty names, multiple scripts, normalization, sort fields, and system views.

### U-11 — date/time semantics

HFS values are treated as displayed local wall seconds from 1904 with an explicit caller-provided offset. Raw zero remains unset. Historical timezone, DST, fold/gap, locale, and cross-version policies are not inferred.

Closure requires native tests across zones and DST transitions, explicit policy decisions, and backward-compatible serialization tests.

### U-12 — long strings and UI/COM truncation

A long Comment can exist on disk while the tested COM setter/read path truncates around 255 characters. Field-specific UI/COM limits and disk limits are not universally known.

Closure requires direct-file and native setter matrices by field, encoding, size boundary, save/reload, and disk-vs-COM comparisons.

### U-13 — unknown compressed trailers and opaque dependency edits

`Container` preserves bytes after a valid zlib stream, but `Library` refuses semantic writes when such a trailer exists. Unknown sections/records may contain hidden references.

Closure requires provenance for the trailer/record, a decoder or safe independence proof, and negative reference tests.

### U-14 — full `loved`/disliked/rating-kind semantics

The API exposes a bounded legacy `loved` bit and preserves neighboring bytes. Static/dynamic evidence does not establish every UI state, RatingKind, AlbumRatingKind, or disliked transition.

Closure requires native setter/readback factorials, adjacent-bit sentinels, album-derived behavior, and restart persistence.

## Validation and operational gaps

### U-15 — audible playback

The bounded silent-playback attempt did not establish playback. Import acceptance, metadata persistence, and a normal process exit are not evidence of successful decoding/output.

Closure requires a deterministic target-playing state plus position advance or target play-count change under a controlled audio configuration, with media hashes and post-test restoration.

### U-16 — native evidence generalization

Native acceptance is exact-candidate evidence. The repository does not contain a proof that all values, combinations, counts, library sizes, or unknown bytes within a nominal profile are safe.

Closure requires a deliberately sampled compatibility matrix, retained failures, independent reproduction, and confidence intervals or an explicit finite supported domain.

### U-17 — fuzzing breadth and crash/power-loss behavior

The bounded fuzz corpus executed 503 deterministic cases with zero recorded anomalies, but it was not coverage-guided and performed no native, parallel, crash, power-loss, symlink-race, or hostile-directory campaign.

Closure requires separate parser coverage/fault campaigns and filesystem threat-model tests. Those results still would not prove native acceptance.

### U-18 — historical replay tooling

Some static/research scripts retain historical root/tool-layout assumptions; private-source-dependent excerpts and full Ghidra/Unicorn runtime reproduction are not staged.

Closure requires a clean disposable bootstrap, pinned tool versions, synthetic/public inputs, and end-to-end replay receipts without private artifacts.

## Completion policy

- These items remain open even when all current tests pass.
- A future change may close one item only with a concrete implementation, negative tests, evidence links, and an updated [`VERSION_MATRIX.md`](VERSION_MATRIX.md)/[`completion-status.yaml`](completion-status.yaml).
- “Implemented” without native qualification must stay distinguishable from “native-qualified.”
- No percentage-complete claim should be derived from the number of resolved rows; the unknown format surface is not a measured denominator.
