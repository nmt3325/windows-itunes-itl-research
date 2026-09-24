# Allocator, shared-object COW, and sort/rank/cache audit

Date: 2026-09-25
Branch: `research/20260925-allocator`
Base: `9dc9be906c30172fc8d0ac9550d28cb137e63e42`
Status: completed offline audit; **no new native qualification**

## Executive result

| Question | Bounded result | Status after this audit |
| --- | --- | --- |
| U-03: identity/string-pool allocation | The current allocator is one global modeled-local high-water followed by a conservative four-byte raw collision scan. Across 356 checked-in paths it would over-approximate at least one non-maximal domain in 352 paths and skip 143 raw-colliding candidate values in 127 paths. Known string pools showed sharing but no conflicting decoded binding in this corpus. | Still unresolved as a native/general allocator. The audit documents current code and snapshots only. |
| U-05: shared-object COW | The exact accepted `crud3-cross-shared-COW-037` pair is internally consistent: two tracks first share album/artist locals `169/170`; the COW candidate moves only PID `E95DD2B085330A12` to fresh locals `184/185`, while PID `0EA4623DE17EC6F6` remains on `169/170`. The candidate survived two archived native cycles. | Exact bounded case confirmed. Production still intentionally refuses a changed shared album/artist object, and string-pool COW remains unimplemented. General COW remains unresolved. |
| U-10: sort/rank/cache | Four native field cases passed their requested COM value gates. Offline snapshot inspection shows field-specific first-save rank vectors, followed by all-`1000` verification vectors; atom ID remained `1` and `wire6d` remained `0`. | Useful bounded evidence, not a complete rank/cache model. Collation, tie handling, missing/empty values, normalization, callback ownership, and general regeneration remain unresolved. |

A concrete repository mismatch is now regression-tested: all four generated `TEST_CORPUS` reference fixtures are container/record-tree parseable but are rejected by `Library.from_bytes` because their 756-byte tracks leave secondary ID `mith+0x1f4` at zero. `TEST_CORPUS/generate.py:94-116` never writes that field, while `itlkit/library.py:419-421` requires it to be nonzero and unique. The new test preserves this boundary rather than weakening validation or inventing a value.

## Scope and method

The new read-only auditor is `scripts/research/audit_allocation_graph_20260925.py`. With no positional input it scans path-sorted, de-duplicated discovery results from:

- `TEST_CORPUS/**/*.itl`
- `evidence/**/*.itl`

It records both path-level and SHA-256 information. Observations are scoped to one file snapshot; IDs are never compared as though separate libraries shared a namespace.

Three layers are kept separate:

1. `Container.from_bytes`: outer header, bounded decrypt/decompress, and payload extraction.
2. `parse_sections`: boundary-driven section/record structure, including opaque unknown sections.
3. `Library.from_bytes`: stricter current-model count, shape, identity, and reference invariants.

This separation matters because `Library.__init__` parses and validates immediately (`itlkit/library.py:312-321`), while the record parser is deliberately boundary-driven (`itlkit/model.py:108-163`). A high-level refusal is therefore not relabeled as a container or record-boundary failure.

The auditor extracts fields only when the record header is long enough. It reports known `(owner tag, mhoh type) -> pool` entries copied from `itlkit/atoms.py:9-18`; every other owner/type pair is counted as an **unmapped mhoh occurrence**, not asserted to be a pool. Rank words, sort atom IDs, and `wire6d` are independent output dimensions.

## Mechanical coverage inventory

### Corpus coverage

| Metric | Path view | SHA-deduplicated view |
| --- | ---: | ---: |
| ITL files / snapshots | 356 | 333 |
| Bytes | 2,562,311 | not summed separately |
| Duplicate paths beyond first hash occurrence | 23 | 0 |
| Duplicate SHA groups | 9 | 0 |
| Container parse success | 356 | 333 |
| Record-tree parse success | 356 | 333 |
| Audit model success | 356 | 333 |
| `Library.from_bytes` success | 336 | 326 |
| High-level refusal | 20 | 7 |

High-level refusal classes:

- 19 paths / 6 unique byte snapshots: `zero or duplicate secondary track ID`.
- 1 path / 1 unique byte snapshot: `mfdh logical size differs from payload + outer header at 0x60` (`evidence/independent/itl-rs-20260922/candidate-zlib-mutated.itl`).

### Audited record volume

| Record/observation | Path view | SHA-deduplicated view |
| --- | ---: | ---: |
| Tracks | 1,113 | 1,091 |
| Albums (`miah`) | 1,066 | 1,044 |
| Artists (`miih`) | 1,042 | 1,020 |
| Playlists | 4,826 | 4,658 |
| Playlist items | 3,488 | 3,434 |
| Known-pool mhoh occurrences | 2,176 | 2,151 |
| Shared positive known-pool binding groups | 235 | 234 |
| Conflicting same-pool/same-ID decoded groups | 0 | 0 |
| Zero-ID, nonempty known-pool occurrences | 25 | 12 |
| Positive-ID, empty known-pool occurrences | 0 | 0 |
| Known-pool decode failures | 0 | 0 |
| Unmapped owner/type mhoh occurrences | 2,999 | 2,975 |
| Shared album/artist reference groups | 58 | 58 |
| Missing album/artist target groups | 0 | 0 |
| Ambiguous album/artist target groups | 0 | 0 |

The unmapped count is deliberately not interpreted as 2,999 unknown pools. It includes owner/type occurrences outside the implemented map and may include different wire semantics.

## Code and evidence map

| Area | Path and lines | What is established | What is not established |
| --- | --- | --- | --- |
| U-03 contract | `UNRESOLVED.md:23-29` | Conservative guards and bounded generator allocations exist. | Complete allocation, compaction, collision, callbacks, and unknown consumers. |
| U-05 contract | `UNRESOLVED.md:39-45` | Closed-profile indexed maintenance exists. | General multi-owner COW. |
| U-10 contract | `UNRESOLVED.md:79-83` | Name-refresh is bounded and not a rank rule. | Complete sort/rank/cache regeneration. |
| Identity domains | `ITL_DATA_MODEL.md:57-79` | Local, persistent, playlist-item, and reference domains are distinct. | Cross-domain numeric equality does not prove aliasing or collision. |
| Parser boundary | `itlkit/model.py:108-163` | Length/boundary parse and depth cap; unknown sections remain opaque. | High-level semantic validity. |
| High-level validation | `itlkit/library.py:394-446` | Current count/identity/reference invariants, including item IDs scoped within each playlist. | A universal native validity predicate. |
| Local/PID allocator | `itlkit/operations.py:70-111` | Current implementation takes one max over modeled local fields, raw-scans LE candidates, and scans byte/text forms for PIDs. | Native high-water domains or native random/monotonic policy. |
| New playlist/item allocation | `itlkit/operations.py:120-126,141-192` | Call sites and current item/local/PID allocation order. | Native allocation equivalence. |
| Track restore allocation | `itlkit/trackops.py:236-266` | Current restore assigns aux, track, secondary, and item identities through the same allocator. | Cross-lineage/general import. |
| Known text pools | `itlkit/atoms.py:9-18,34-90` | Implemented pool map, conflict guard, shared-user refusal, unkeyed-populated refusal. | Allocation, compaction, and unknown pool consumers. |
| Opaque PID guard | `itlkit/references.py:11-60` | Conservative four-representation byte scan outside ignored self slots. | Semantic decoding of unknown references. |
| Bounded experimental importer | `scripts/experimental-import/experimental_import.py:272-365` | Exact profiles allocate aux/track/secondary/item identities and per-pool atom IDs under strong guards. | A production/general algorithm. |
| Static pool/object evidence | `evidence/static/phase2/findings.md:43-90` | 433 nonempty mapped uses, 83 shared string groups, no decoded conflict in the 52-file cohort; object IDs/ranks are separate. | Shared-object native acceptance in that static cohort or complete pool map. |
| Exact COW evidence | `docs/dynamic.md:251-270`; `evidence/native/phase3/parent-independent-audit.json:109-195`; `evidence/native/phase3/cases/crud3-cross-shared-COW-037/result.json:3-6,186,381` | Exact shared-two and COW candidates, hashes, and two passed native cycles. | Other text combinations, object kinds, libraries, versions, or deletion/compaction policy. |
| Native allocation control | `docs/dynamic.md:266-270`; `evidence/native/phase3/controls/post-acceptance-allocation/result.json:85-90,135-136,430-822` | One AddFile PID and two persistent reload controls on a separate candidate copy. | Universal native high-water or production-writer equivalence. |
| Sort fields | `ITL_RECORD_TYPES.md:90,120,139`; `itlkit/library.py:15-18,194-200` | Sort atom type mapping and bounded Name-refresh-bit behavior. | Rank reset or atom-renumber rule. |
| Sort native gates | each `evidence/native/field-matrix-20260922/cases/sort-*/mutation/result.json:641-645,842-846,1201-1203`; verification files `:430-434,504-508,863-865` | Requested COM values persisted for four exact cases and snapshot hashes are pinned. | General collation/cache semantics. |
| New auditor | `scripts/research/audit_allocation_graph_20260925.py:27-49,112-234,237-508,517-731` | Deterministic, read-only per-file identity/ref/pool/rank census with explicit limits. | Native qualification or mutation safety. |
| New regressions | `tests/test_allocation_graph_20260925.py:101-214` | Namespace scope, raw guard, pool sharing/conflict, fanout, rank separation, parse failure, and fixture/model boundary. | Native behavior. |

## U-03 — identity and string-pool allocation

### Modeled namespace inventory

| Domain | Wire field | Audit uniqueness scope | Current write-path use |
| --- | --- | --- | --- |
| Track local | `mith+0x10`, u32 LE | file track set | global local allocator input |
| Secondary track | `mith+0x1f4`, u32 LE | observed 756-byte tracks | global local allocator input |
| Album local | `miah+0x10`, u32 LE | album section | global local allocator input; referenced by `mith+0xdc` |
| Artist local | `miih+0x10`, u32 LE | artist section | global local allocator input; referenced by `mith+0x1e0` |
| Playlist local | `miph+0xd40`, u32 LE | modeled primary playlists | global local allocator input |
| Item local | `mtph+0x10`, u32 LE | within one playlist | global local allocator input despite scoped validation |
| Item order token | `mtph+0x20`, u32 LE | observation only | global local allocator input; no equality invariant |
| Track PID | `mith+0x80`, u64 LE | tracks | collision-scanned/random or requested |
| Album/artist PID | `miah/miih+0x14`, u64 LE | each modeled record family | collision-scanned/random or retained import PID |
| Playlist PID | `miph+0x1b8`, u64 LE | modeled primary playlists | collision-scanned/random or requested |
| Item PID | `mtph+0x44`, u64 LE | within one playlist | collision-scanned/random |

No path snapshot had a positive duplicate in the file-scoped modeled local domains, a positive duplicate in the file-scoped modeled persistent domains, or a zero/duplicate item local/PID within one playlist. There were 24 path-level modeled-local zero values (11 after SHA de-duplication), dominated by the secondary-ID fixture mismatch. Numeric overlap between different domains is reported, not treated as a global collision.

### Current high-water behavior

`Allocator.__init__` collects local fields across track, album, artist, item, secondary-track, order-token, and playlist domains, then sets `next_id = max(values) + 1`. `local()` skips any candidate whose four little-endian bytes appear anywhere in the current serialized model. This is explicitly conservative (`itlkit/operations.py:70-94`).

Observed consequences:

- At least one domain is below the global maximum in 352/356 paths (330/333 unique snapshots). This is expected from combining independent namespaces; it demonstrates over-approximation, not corruption.
- The raw guard skips candidates in 127/356 paths (124/333 unique snapshots), totalling 143 path-level skipped values (140 de-duplicated). A four-byte occurrence may be semantically unrelated; the behavior is refusal/spacing conservatism, not a decoded reference rule.
- The three-track generated fixtures provide a minimal checked-in example: global max `8`, candidates `9..14` occur as raw four-byte sequences, and the first current-allocator return is `15`.

### Native allocation control does not match a stable global max+1 model

For independent candidate `a813f8ad...`, the offline current-allocator projection is max `176`, naïve next `177`, and first raw-guard-free `178`. The candidate's constructed track uses local/secondary `171/173` and aux locals `169/170`.

After the separate native AddFile control, native iTunes had renumbered existing locals and assigned the new PID `F20377F9F2DAF23E` track local/secondary `172/173` with new aux locals `174/175`; after the first reload the same persistent identities were represented by track local/secondary `87/88` and aux locals `73/78`, unchanged in reload two. The control passed old-PID and ordinary-playlist preservation and both reloads (`result.json:85-90,135-136,430-822`).

This is useful evidence that persistent identity, not stable session/local numbering, anchors the case. It does **not** reveal the native allocator algorithm: only one AddFile operation, one exact version/profile, and no controlled collision/deletion/repetition factorial were exercised.

### String-pool boundary

The current map contains eight named pool labels across 17 owner/type entries. Path-level audit found 2,176 mapped occurrences and 235 shared positive binding groups with no conflicting decoded text. The SHA-deduplicated figures are 2,151 occurrences and 234 shared groups. Twelve de-duplicated occurrences have nonempty text with atom ID zero. Those are observed and left unkeyed; the auditor does not invent IDs.

The 2,975 de-duplicated unmapped owner/type occurrences demonstrate why the current map cannot be treated as an exhaustive mhoh namespace census. Static evidence also names album types 303/304/305/307 and other behavior outside the production map (`evidence/static/phase2/findings.md:47-57`).

### Reproducible fixture/model mismatch

`TEST_CORPUS/generate.py:94-116` constructs 756-byte `mith` records but does not set `+0x1f4`. The four checked-in generated fixtures therefore structurally parse but fail the current high-level invariant at `itlkit/library.py:419-421`. The minimal persisted regression is `test_reference_fixture_distinguishes_structure_from_high_level_identity` (`tests/test_allocation_graph_20260925.py:206-214`).

No source invariant was changed because the evidence does not choose between these remedies:

1. change generated source fixtures to encode a justified secondary ID;
2. explicitly classify them as structure/native-input fixtures outside the high-level model; or
3. change validation only with independent evidence that zero is admissible for this exact shape/stage.

## U-05 — shared-object copy-on-write

### Reference graph census

The auditor resolves `mith+0xdc -> miah+0x10` and `mith+0x1e0 -> miih+0x10` independently. Across all 356 paths it found:

- 58 shared-reference groups in 22 path snapshots;
- zero missing-target groups;
- zero ambiguous-target groups;
- 11 SHA-unique snapshots with at least one shared group.

The shared snapshots include generated/reference three-track families, donor32, and the phase3 shared-two candidate/reloads. This is a snapshot graph census; it does not prove safe mutation.

### Exact accepted COW pair

| Snapshot | PID `E95DD2B085330A12` | PID `0EA4623DE17EC6F6` | Auxiliary state |
| --- | --- | --- | --- |
| shared-two `2bf00425...` | album/artist refs `169/170`; AlbumArtist `Synthetic Ensemble 00` | album/artist refs `169/170`; AlbumArtist `Synthetic Ensemble 00` | one shared album object PID `FD5BC77BE158CD5E`, one shared artist object PID `066838E7EF03C6AF` |
| COW `f6f2a221...` | moved to refs `184/185`; AlbumArtist `Synthetic Phase3 COW Ensemble` | remains on refs `169/170`; AlbumArtist `Synthetic Ensemble 00` | old objects retained; fresh album PID `5ECBDDD8C66BDEA8` and artist PID `B67DCD64D3FD050D` added for the changed track |

The candidate is classified `shared_group_cow`, accepted, and both cycles accepted (`evidence/native/phase3/cases/crud3-cross-shared-COW-037/result.json:3-6,186,381`); the independent audit pins candidate and both cycle hashes (`parent-independent-audit.json:160-195`). This is strong bounded evidence for that exact synthetic operation.

Production remains deliberately narrower. `set_indexed_fields` detects any peer track still referencing the old changed aux object and raises `shared album/artist object COW is not native-verified` (`itlkit/trackops.py:131-176`). Known string bindings also refuse partial shared changes and differing replacements (`itlkit/atoms.py:48-90`). The exact research result is therefore not silently promoted into the public API.

### Remaining COW blockers

- No matrix over blank/nonblank album, artist, and album-artist combinations.
- No proof for deduplication versus always-clone choice when an equal destination object exists.
- No complete consumer map for unmapped mhoh types or opaque references.
- No deletion/orphan-compaction/repeated-COW collision factorial.
- No version, media family, large-library, or non-synthetic diversity.
- No production implementation whose full dependency rewrite has native acceptance.

## U-10 — sort/rank/cache

### Exact field snapshots

All four mutation and verification result files report a passed requested-value gate and a passed overall status. The checked-in binary snapshots produce:

| Field | Mutation snapshot / observed vector | Verification snapshot / observed vector | Sort atom | `wire6d` |
| --- | --- | --- | --- | ---: |
| SortName | `7e02e91f...` / `[0,1000,1000,1000,1000,1000,1000]` | `31f2ed93...` / all `1000` | type 30, ID 1 | 0 |
| SortAlbum | `dc630320...` / `[1000,0,1000,1000,1000,1000,1000]` | `0b7c0571...` / all `1000` | type 31, ID 1 | 0 |
| SortArtist | `a6d7f064...` / `[1000,1000,0,1000,1000,1000,0]` | `ac44785f...` / all `1000` | type 32, ID 1 | 0 |
| SortAlbumArtist | `9a1fe07e...` / all `1000` | `4828f10a...` / all `1000` | type 33, ID 1 | 0 |

The mutation snapshot therefore shows field-specific first-save rank invalidation for three fields, but not SortAlbumArtist in this exact case; a subsequent save has regenerated all seven words to `1000`. Atom ID staying `1` and `wire6d` staying `0` are independent observations, not proof of causal independence.

Across 333 unique byte snapshots, the audit observed 68 distinct seven-word vectors. The most common were all `1000` (218 tracks), title-like `[2000,1000,...]` (125), `[3000,1000,...]` (123), and all zero (93). `wire6d` was `0` on 187 and `1` on 904 de-duplicated track occurrences. These distributions refute any useful assumption that one constant or one text atom ID defines rank state.

Current production code intentionally does not reset all ranks. A changed nonempty Name on the admitted version only clears `mith+0x6d` bit 0 and explicitly warns against rank reset or atom renumbering (`itlkit/library.py:194-200`).

### Remaining sort/rank/cache blockers

- Empty, absent, and duplicate sort fields.
- Ties, duplicate strings, punctuation, case, normalization, locale, and multiple scripts.
- Mapping and lifecycle of all seven rank words across views and callbacks.
- SortAlbumArtist behavior and type 34/401 consumers.
- Cache regeneration timing beyond the observed two-save sequences.
- Interaction with Name-refresh, system playlists/views, deletion, and compaction.

## Added audit and regression assets

`audit_allocation_graph_20260925.py` is deterministic for a fixed checkout and input set: no timestamp, relative path labels, path sorting, sorted JSON keys, and no writes except an explicitly requested output file. Default CLI failure is limited to unreadable/container/record/audit-model failures; stricter `Library` refusals remain recorded observations. `--strict-library` is available when that distinction should become a gate.

The seven new tests cover:

1. playlist-scoped item local/PID overlap versus within-playlist duplicates;
2. global high-water over-approximation and opaque raw four-byte collision skips;
3. same-value sharing, conflicting same-ID text, and zero-ID nonempty text;
4. two-track shared aux fanout;
5. separate sort-atom and rank-word observations;
6. parse failure as data rather than an uncaught exception;
7. the checked-in reference fixture's structure/high-level-validation split.

## Validation

| Command | Result | Log |
| --- | --- | --- |
| `python -m pytest -q tests/test_allocation_graph_20260925.py` | exit 0; 7 passed | `/home/runner/work/_temp/gha-mcp/linux-ytedy5cd/work/itl-analysis/reports/allocator-test-dedicated.log` |
| `python -m pytest -q tests/test_codec_fresh_state.py tests/test_codec_tracks.py tests/test_codec_review_hardening.py tests/test_codec_playlists.py tests/test_model_structure.py tests/test_reference_tools.py` | exit 0; 198 passed | `/home/runner/work/_temp/gha-mcp/linux-ytedy5cd/work/itl-analysis/reports/allocator-test-related.log` |
| `python -m compileall -q itlkit scripts/research/audit_allocation_graph_20260925.py tests/test_allocation_graph_20260925.py` | exit 0 | `/home/runner/work/_temp/gha-mcp/linux-ytedy5cd/work/itl-analysis/reports/allocator-compileall.log` |
| `python scripts/research/audit_allocation_graph_20260925.py --root . --output /home/runner/work/_temp/gha-mcp/linux-ytedy5cd/work/itl-analysis/reports/allocator-audit.json` | exit 0; 356/356 structural and audit-model success | `/home/runner/work/_temp/gha-mcp/linux-ytedy5cd/work/itl-analysis/reports/allocator-audit.log` |

The detailed external audit JSON is 3,529,480 bytes with SHA-256 `640449682fbf34d1a0c356ff45d8a06bb5607edfe0cea75247d3335e8cd12316`.

## Final disposition

- U-03 remains open. The present allocator is a conservative implementation policy, not a recovered native policy.
- U-05 remains open generally. One exact aux-object COW candidate has strong two-cycle evidence; production refusal remains appropriate outside that exact research profile.
- U-10 remains open. The new sort snapshots establish field-specific first-save effects and later regeneration, not full collation/cache semantics.
- The generated-reference/high-level-model mismatch is now explicit and regression-tested.
- No production semantic path was broadened, and this work makes no native-qualified claim.
