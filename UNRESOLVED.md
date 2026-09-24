# Unresolved questions and major gaps

These gaps are intentional completion blockers for any claim of universal ITL support. A refusal is not a hidden implementation success.

## Critical gaps

### U-01 — version breadth

**State:** unresolved.

Only the named standalone Windows 12.13.10.3 profile has the full packaged native evidence. The 12.13.9.1 profile is admitted for bounded behavior without an equivalent native matrix. Other releases may change header, section, record, index, or callback semantics.

**Closure evidence required:** version-pinned native fixtures, two-cycle acceptance/negative cases, static provenance, and a separate matrix row for each newly admitted version.

### U-02 — big-endian semantic payloads

**State:** open; opaque production preservation plus bounded public prior-art framing evidence.

The outer header describes payload byte order, but `Library` intentionally implements little-endian record/text semantics only. `Container` can preserve or rebuild raw bytes without understanding them. The pinned public-prior-art audit in [`evidence/research/20260925/big-endian-prior-art/`](evidence/research/20260925/big-endian-prior-art/) independently rechecks 14 historical fixtures (13 big-endian, one little-endian): all 14 pass envelope decode, exact no-op serialization, forced-rebuild reparse, and a separate read-only record/count/string/reference census. This is framing evidence, not production BE semantic support. The repository semantic parsers still accept 0/13 big-endian payloads, and no native BE-producing iTunes version was run.

**Closure evidence required:** an endian-aware production semantic implementation, broader independent fixtures and negative tests, complete field/reference validation, and native save/reload acceptance on an exact BE-producing version.

### U-03 — general identity and string-pool allocation

**State:** conservative guards, not a complete allocator.

Known pools and identity namespaces are checked. The independent generator now has deterministic finite allocations for exact one-track and three-track fixtures, and refuses outside a 1–16-track input bound; only the four pinned one-track/three-track hashes are native-qualified. Unknown consumers, reference-only encodings, callback ownership, compaction, collision behavior, and complete allocation/high-water rules remain unresolved.

**Closure evidence required:** static consumer census plus native differential allocation/COW tests covering shared and unshared objects, collision cases, deletion, restart, and repeated allocation.

### U-04 — arbitrary cross-library import and new-track construction

**State:** research-only exact candidates.

The public `Library.add_track_from` remains same-lineage restoration. Separate research transformations produced accepted cross-library and constructed-WAV candidates. The template-free generator now has exact three-track fixtures, but they contain no arbitrary media/location construction. None of these results establishes a general API, arbitrary paths, arbitrary donors, or arbitrary media.

**Closure evidence required:** a production algorithm with explicit donor/recipient constraints, complete dependency remapping, deterministic refusal policy, diverse fixtures, negative cases, and independent native cycles for newly generated outputs.

### U-05 — general shared-object copy-on-write

**State:** refused outside the closed profile.

Selected local-WAV album/artist maintenance works when the old object is not shared in an unsupported way. General shared album/artist/string/sort object COW is not native-qualified.

**Closure evidence required:** multi-track sharing matrices, all known pool consumers, identity allocation provenance, peer-record preservation, raw reference closure, and native reload checks.

### U-06 — recursive, smart, system, and master playlist semantics

**State:** structural AST implemented; semantics/editing unresolved.

[`SMART_PLAYLIST_SPEC.md`](SMART_PLAYLIST_SPEC.md) defines bounded type-101 `SLst` framing, a lossless AST, type-102 offset view, type-103 preservation, and unknown-operator behavior. The original 95-file census contains built-in/system playlists only. A later isolated v24 UI save natively demonstrates nested OR/AND wrapper framing and an Artist/contains string-family leaf, but the displayed operand serialized with length zero and COM membership remained empty. Thus framing has advanced while string persistence, evaluator semantics, independent generation, restart-positive editing, and arbitrary system/master behavior remain unresolved.

**Closure evidence required:** controlled user-created smart playlists spanning every rule family and nested condition, UI edits with isolated byte differentials, semantic evaluation oracles, and two-cycle native persistence for independently generated rules.

### U-07 — store, cloud, DRM, queue, and history profiles

**State:** out of supported scope.

Sections 20/22/23, store indexes, cloud/store track types, DRM state, and queue/history semantics are incomplete or opaque.

**Closure evidence required:** synthetic or lawfully controlled fixtures, bounded static/dynamic evidence, privacy-safe oracles, and fail-closed integration tests.

## Major semantic gaps

### U-08 — media relocation and Windows path behavior

**State:** bounded native matrix; general relocation unresolved.

[`PATH_AND_TIME_SPEC.md`](PATH_AND_TIME_SPEC.md) confirms exact samples for absolute/relative paths, drive-letter case, slash spelling, NFC/NFD, emoji, read-only media, case-only duplicate recognition, hard/symbolic links, localhost-backed UNC/mapping, and a `subst` drive. Six `AddFile` forms failed or returned no track. Those are COM-call observations, not proof that a directly authored ITL value is rejected.

Remote SMB, physical removable media, drive-letter reassignment after import, direct Japanese filesystem paths, portable relocation, and complete opaque location-object updates remain unresolved. Closure requires hardware/remote matrices and independently written ITLs reopened without repair/backup/XML fallback.

### U-09 — non-WAV structural edits and media-format breadth

Closed track structural/index operations require the observed native local-WAV template. Encoded media artifacts prove generation/provenance, not general ITL construction or playback for MP3/AAC/ALAC/AIFF.

Closure requires per-format native templates, field/dependency comparison, construction/import tests, and explicit playback/non-playback gates.

### U-10 — complete sort/rank/cache regeneration

Selected text edits and known pool guards do not define every sort key, rank word, cache, or callback. The Name-refresh bit is a bounded correction, not a general rank reset rule.

The deterministic 2026-09-25 audit (`evidence/research/20260925/sort-rank-audit/`) hashes and structurally parses 37 retained ITLs from nine field-matrix cases and six phase3 chains. It records exact seven-word transitions and Unicode bytes, including a persisted `SortAlbumArtist` counterexample with no first-save zero and zero serialized-empty target atoms. These are 94 repeated track occurrences, not 94 native runs, and they do not yield a safe universal production regeneration rule. U-10 remains open.

Closure requires consumer mapping and native factorials for empty/missing/nonempty names, multiple scripts, normalization, sort fields, and system views.

### U-11 — date/time semantics

**State:** one-field native DST matrix; general model unresolved.

The path/time matrix persisted six `PlayedDate` cases. The tested scalar behaves as whole wall-clock seconds from 1904 without retained offset/fold metadata; an Eastern DST gap normalized from 02:30 to 03:30 and fold identity was not retained. Epoch/epoch+1 setters failed at the Python/COM boundary, which does not prove raw ITL rejection. Existing `date_modified` values shifted by -14,400 seconds after a zone change, but the cause is not isolated.

Closure still requires every date field, raw-writer epoch boundaries, multiple Windows zones/locales, historical DST rules, file timestamps versus ITL values, and cross-version/native round trips.

### U-12 — long strings and UI/COM truncation

A long Comment can exist on disk while the tested COM setter/read path truncates around 255 characters. In the isolated field matrix and corrected fresh WAV follow-ups, the tested Unicode Lyrics and short plain-ASCII Lyrics setters raised COM exceptions after successful initialization/baseline restart. MP3-backed follow-ups now contain 17 exact mutation/restart passes: one Unicode value, the original short ASCII value, and discrete tested ASCII lengths up to 16,777,209. The ceiling cohort establishes an adjacent transition on one deterministic MP3/ID3v2.2/`ULT`/COM/iTunes-12.13.10.3 path: 16,777,209 characters persisted exactly after restart, while 16,777,210 produced a rewritten MP3 and empty immediate COM readback. Requests 16,777,210–16,777,216, 17,000,000, and a repeated 16,777,210 yielded nine native non-exact outcomes and zero harness failures. Formal retained-output analysis proves the mechanism at the adjacent pair: the exact case has a maximum 16,777,215-byte unsigned-24-bit `ULT` payload stored as `0xFFFFFF`; the next payload is 16,777,216 bytes but is stored as wrapped `0x000000`, making the ID3v2.2 tag nonconformant. Three reset-ITL probes on one track followed original, stripped, and conflicting media tags. This is not a universal upper limit, generic Lyrics support, universal storage authority, or generic rejection. Field-specific UI/direct-file limits, broader Unicode behavior, hidden caches, other media/tag shapes, other builds, and independent reproduction remain unknown; U-12 remains open.

Closure requires direct-file and native setter matrices by field and encoding, UI comparisons, broader Unicode around representation boundaries, multiple media/tag shapes and versions, save/reload and disk-vs-COM comparisons, explicit hidden-cache isolation, and independent reproduction. The path-specific adjacent transition cannot substitute for those factorials.

### U-13 — unknown compressed trailers and opaque dependency edits

`Container` preserves bytes after a valid zlib stream, but `Library` refuses semantic writes when such a trailer exists. The fixed-seed 2026-09-25 audit covered 57 baseline/mutation cases, including 19 opaque, concatenated-member, corruption, and AES cap/block-boundary trailer cases. Primary and independent envelope decisions and recovered payload/trailer hashes agreed throughout. `VALIDATOR` reports `scope.compressed_trailer` plus exact byte coverage with `semantically_validated: false`; see [`evidence/research/20260925/trailer-coverage-audit/`](evidence/research/20260925/trailer-coverage-audit/). Unknown sections/records may still contain hidden references.

The [bounded native follow-up](evidence/research/20260925/native-trailer-u13/README.md) tested the exact 17-byte fixed-seed opaque witness against its exact trailer-free one-track control on the signed standalone Windows iTunes 12.13.10.3 executable. Both cases passed two strict isolated save/restart cycles with complete COM identities, normal Quit/process exit 0, and no fallback or unexpected modal. The candidate's first native save stripped the trailer; the restart opened that exact save and the trailer remained absent. Native saves rebuilt the payload for both cases, so this is not a byte-local edit result.

U-13 remains open. The result does not establish trailer meaning or provenance, justify discarding unknown bytes, prove safe semantic editability, generalize to other trailers/profiles/builds, or turn repeated saves and the copied control into independent experiments. Closure still requires trailer/record provenance, a decoder or safe independence proof, broader positive and negative native matrices, additional builds/profiles, and independent reproduction.

### U-14 — full `loved`/disliked/rating-kind semantics

The API exposes a bounded legacy `loved` bit and preserves neighboring bytes. The [2026-09-25 bounded native replacement](evidence/research/20260925/native-rating-kind/README.md) adds one signed standalone Windows iTunes 12.13.10.3 / pinned one-track profile: typelib plus runtime probes classify `Rating` and `AlbumRating` as writable, `RatingKind` and `AlbumRatingKind` as read-only, and `Loved`/`Disliked` as unsupported on that file-track interface. The six-value `Rating` ladder (0, 20, 40, 60, 80, 100) survived a same-value save and a verification restart in 18/18 sessions. Nonzero writes projected `Rating/RatingKind/AlbumRating/AlbumRatingKind` from `0/1/0/1` to `value/0/value/1`; zero remained `0/1/0/1`. The one-track AlbumRating projection is not a general album-derived rule.

`Loved` and `Disliked` were absent from the inspected typelib and both getter/setter attempts raised `AttributeError`, so their mutual interaction was attempted conditionally but blocked rather than inferred. Across 27 targeted analyses of 21 unique snapshots, `mith+0x6d` and the bounded `mith+0x2bf & 0x02` sentinel stayed clear, while nonzero values changed `mith+0x6c` exactly to 0x14/0x28/0x3c/0x50/0x64. Same-value and restart targeted headers were stable, but whole encrypted ITL hashes changed on every save. This does not map all UI Loved/Disliked states, prove general album behavior, or turn structural validation into universal native acceptance. U-14 remains open.

Closure still requires safe UI/direct-state factorials for Loved/Disliked, native adjacent-bit sentinels under those transitions, isolated album-derived behavior, additional track/media shapes and versions, and independent reproduction.

## Validation and operational gaps

### U-15 — audible playback

The bounded silent-playback attempt did not establish playback. Import acceptance, metadata persistence, and a normal process exit are not evidence of successful decoding/output.

Closure requires a deterministic target-playing state plus position advance or target play-count change under a controlled audio configuration, with media hashes and post-test restoration.

### U-16 — native evidence generalization

Four exact template-free reference hashes now pass the strict two-cycle native gate: raw/zlib envelopes at one track and three tracks. The three-track pair preserves deterministic identities, Japanese/emoji/decomposed Unicode names, and ordered master/ordinary membership. A pinned external `itl-rs` no-op output also passed two cycles while preserving the exact expanded payload, but that implementation rejects raw input, reports the track PID as zero, and emitted mutation candidates that failed mandatory preflight. The corrected media-backed field evidence contains three exact WAV mutation failures, 17 exact MP3 mutation/restart passes including one Unicode value and tested ASCII through 16,777,209 characters, nine qualified native non-exact immediate readbacks beginning at the adjacent 16,777,210 request, and three bounded media-tag precedence probes. None qualifies a writer output, a generic field rule, a universal upper length limit, or universal storage authority. Native acceptance remains exact-candidate evidence and structural preservation is not independent semantic interoperability: the repository does not contain a proof that all values, combinations, counts, library sizes, media kinds, dependencies, or unknown bytes within a nominal profile are safe.

Closure requires a deliberately sampled compatibility matrix, retained failures, independent reproduction, and confidence intervals or an explicit finite supported domain.

### U-17 — fuzzing breadth and crash/power-loss behavior

The historical bounded fuzz corpus executed 503 deterministic cases with zero recorded anomalies. The later fixed-seed trailer/length/offset audit adds 57 expectation-checked cases and four plaintext-budget probes with no unexplained envelope differential. A separate [coverage-guided campaign](evidence/research/20260925/coverage-guided-fuzz/README.md) then executed 20,000 deterministic 128-KiB-capped mutations across four parser targets: 9,090 were accepted, 10,910 were explicitly refused, 34 candidates added a previously unseen per-target CPython line transition, and zero anomalies were retained. An independent clean checkout reproduced its pinned report byte for byte.

U-17 remains open. Line-transition guidance is coarse and not branch-complete; these campaigns do not prove parser safety and did not test native iTunes, alternate runtimes, concurrency, process crashes, power loss, symlink races, or hostile directories. Closure still requires broader parser coverage/fault campaigns and explicit filesystem threat-model tests. Those results still would not prove native acceptance.

### U-18 — historical replay tooling

Some static/research scripts retain historical root/tool-layout assumptions; private-source-dependent excerpts and full Ghidra/Unicorn runtime reproduction are not staged.

Closure requires a clean disposable bootstrap, pinned tool versions, synthetic/public inputs, and end-to-end replay receipts without private artifacts.

A 2026-09-25 bounded repair removes one concrete blocker: the delivery manifest no longer lists ignored, regenerated top-level `windows_itl_research.egg-info` files, and both positive and narrow-exclusion negative tests are retained in [`docs/PUBLIC_REPLAY_AUDIT.md`](docs/PUBLIC_REPLAY_AUDIT.md). Historical private/tool-layout replay remains unstaged, so U-18 stays open.

## Completion policy

- These items remain open even when all current tests pass.
- A future change may close one item only with a concrete implementation, negative tests, evidence links, and an updated [`VERSION_MATRIX.md`](VERSION_MATRIX.md)/[`completion-status.yaml`](completion-status.yaml).
- “Implemented” without native qualification must stay distinguishable from “native-qualified.”
- No percentage-complete claim should be derived from the number of resolved rows; the unknown format surface is not a measured denominator.

### Resolved bounded checkpoint — exact template-free fixtures

The one-track hashes `c6c68171…92d74` and `25f8aba0…13ad`, plus the three-track hashes `7d9b2747…406b` and `73dbb405…9e17`, are no longer pending: each passed two isolated iTunes 12.13.10.3 open/save/restart cycles with the required identities, values, membership, and no-fallback gates. The later 27/29 field matrix, three exact WAV-backed mutation failures, 17 exact MP3 mutation/restart passes, nine qualified native non-exact MP3 immediate readbacks, three media-tag precedence probes, one external structural no-op, and native Smart Playlist wrapper observation add bounded positive and negative evidence without closing a declared blocker. The preceding media attempt remains explicitly classified as a pre-mutation harness failure. U-01 through U-18—including U-12 because the exact 16,777,209 / non-exact 16,777,210 transition is limited to one MP3/ID3v2.2/`ULT`/COM/build path and lacks UI, direct-file, broader-Unicode, other-format/version, cache-isolation, and independent-reproduction coverage—full declared-field editing, arbitrary smart semantics, version breadth, unknown/integrity bytes, and independent semantic reimplementation remain open; the complete-analysis/specification gate remains false.
