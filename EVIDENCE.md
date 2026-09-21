# Evidence and implementation traceability

This index links each material specification claim to concrete implementation, tests, and archived evidence. Evidence is bounded by the exact profile and fixture described at its source.

## Evidence grades

| Grade | Meaning |
| --- | --- |
| N2 | Exact candidate passed two real-iTunes save/reload cycles with identity/value gates. |
| N1 | Real-iTunes observation, setter control, trace, or one bounded native control. |
| O | Offline regression, independent reconstruction, or archived-fixture audit. |
| S | Static analysis/decompilation evidence. |
| R | Research-only result not exposed as a general supported API. |
| F | Retained failure/negative control. |

## Claim matrix

| Claim | Grade | Implementation | Tests | Primary evidence |
| --- | --- | --- | --- | --- |
| `hdfm` header, encryption flags 0/1/2, cap handling, compression flag, plaintext budget | N1/O/S | [`itlkit/container.py`](itlkit/container.py) | [`tests/test_core_container.py`](tests/test_core_container.py); [`tests/test_core_compatibility.py`](tests/test_core_compatibility.py) | [`evidence/static/codec-compatibility-review.json`](evidence/static/codec-compatibility-review.json); [`evidence/static/asm/01085270.asm`](evidence/static/asm/01085270.asm); [`docs/dynamic.md`](docs/dynamic.md) phase-2 v4 |
| Real native inflate/deflate buffers match independently decoded ITL streams | N1/O | [`scripts/windows/analyze_trace.py`](scripts/windows/analyze_trace.py); [`itlkit/container.py`](itlkit/container.py) | [`scripts/windows/harness_selftest.py`](scripts/windows/harness_selftest.py) | [`evidence/native/research/024-empty-trace-correlation-matched-only.json`](evidence/native/research/024-empty-trace-correlation-matched-only.json); [`evidence/native/research/041-native-deflate-correlation-matched-only.json`](evidence/native/research/041-native-deflate-correlation-matched-only.json); [`evidence/delivery/CLOSURE-SUMMARY-v2.json`](evidence/delivery/CLOSURE-SUMMARY-v2.json) |
| Unchanged container/library is byte-exact; forced rebuild is structurally valid | O/N2 for selected hashes | [`itlkit/container.py`](itlkit/container.py); [`itlkit/library.py`](itlkit/library.py) | [`tests/test_core_container.py::test_container_exact_and_forced`](tests/test_core_container.py); [`tests/test_codec_native_profiles.py::test_native_byte_exact_roundtrip`](tests/test_codec_native_profiles.py); [`tests/test_codec_native_profiles.py::test_native_byte_exact_and_com_values`](tests/test_codec_native_profiles.py) | [`evidence/native/research/acceptance/050-codec-forced/result.json`](evidence/native/research/acceptance/050-codec-forced/result.json); [`evidence/tests/final-core-976.log`](evidence/tests/final-core-976.log) |
| Section parsing is boundary-driven; unknown bodies are opaque and not tag-scanned | O | [`itlkit/model.py`](itlkit/model.py) | [`tests/test_model_structure.py`](tests/test_model_structure.py) | [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md); [`evidence/research/final-review/report.json`](evidence/research/final-review/report.json) |
| Counts, identities, and modeled references are validated before/after rebuild | O/N2 for accepted candidates | [`itlkit/library.py`](itlkit/library.py); [`itlkit/references.py`](itlkit/references.py) | [`tests/test_model_structure.py::test_duplicate_ids_and_dangling_refs_rejected`](tests/test_model_structure.py); [`tests/test_codec_review_hardening.py::test_modeled_identity_namespaces_reject_zero_and_duplicates`](tests/test_codec_review_hardening.py); review-hardening tests | [`evidence/native/research/056-all-candidate-audit.json`](evidence/native/research/056-all-candidate-audit.json); [`evidence/native/phase3/parent-independent-audit.json`](evidence/native/phase3/parent-independent-audit.json) |
| Track field offsets and selected COM values match the frozen cohort | N1/O | [`itlkit/library.py`](itlkit/library.py) | [`tests/test_codec_native_profiles.py::test_rating_is_one_byte_and_counters_are_not_forced_mirrors`](tests/test_codec_native_profiles.py); [`tests/test_codec_native_profiles.py::test_native_byte_exact_and_com_values`](tests/test_codec_native_profiles.py) | [`evidence/native/research/045-native-matrix-final-gates.json`](evidence/native/research/045-native-matrix-final-gates.json); [`evidence/static/mith-field-stores.json`](evidence/static/mith-field-stores.json) |
| Changed nonempty Name on 12.13.10.3 requires clearing only `mith+0x6d` bit 0 in the admitted family | N2/O | `Track.set` in [`itlkit/library.py`](itlkit/library.py) | [`tests/test_codec_fresh_state.py::test_changed_nonempty_name_clears_only_refresh_low_bit`](tests/test_codec_fresh_state.py); no-op and sentinel companions | [`docs/dynamic.md`](docs/dynamic.md) factorial/A-only cases; [`evidence/native/phase3/cases/p4-fresh-api/result.json`](evidence/native/phase3/cases/p4-fresh-api/result.json) |
| Unplayed is independent from play count and maps to `mith+0xee` low bit on the qualified profile | N1/O | `Track.get/set` in [`itlkit/library.py`](itlkit/library.py) | [`tests/test_codec_fresh_state.py::test_unplayed_is_explicit_independent_state_and_preserves_other_bits`](tests/test_codec_fresh_state.py); invalid/legacy tests | [`docs/dynamic.md`](docs/dynamic.md) native controls; [`evidence/native/oracles/116-native-unplayed-control/com.json`](evidence/native/oracles/116-native-unplayed-control/com.json) |
| Encoding 3 is Latin-1-equivalent byte zero-extension; encoding 2 is only a provisional ASCII URL subset | S/O | `read_text`/`set_text` in [`itlkit/library.py`](itlkit/library.py) | encoding tests in [`tests/test_core_compatibility.py`](tests/test_core_compatibility.py); URL tests in [`tests/test_codec_semantics.py`](tests/test_codec_semantics.py) | [`evidence/static/codec-compatibility-review.json`](evidence/static/codec-compatibility-review.json); [`evidence/static/phase2/native-url-census.json`](evidence/static/phase2/native-url-census.json) |
| Ordinary playlist rename/create/delete/member replacement works only for the strict flat profile | N2/O | [`itlkit/operations.py`](itlkit/operations.py); `Playlist` in [`itlkit/library.py`](itlkit/library.py) | [`tests/test_codec_playlists.py`](tests/test_codec_playlists.py); playlist review-hardening tests | [`evidence/native/research/acceptance/070-codec-playlist-rename/result.json`](evidence/native/research/acceptance/070-codec-playlist-rename/result.json) through [`evidence/native/research/acceptance/074-codec-playlist-create-from-master/result.json`](evidence/native/research/acceptance/074-codec-playlist-create-from-master/result.json) |
| Same-lineage native-WAV restore and guarded deletion are implemented; cross-lineage public restore refuses | N2/O | [`itlkit/trackops.py`](itlkit/trackops.py) | [`tests/test_codec_tracks.py`](tests/test_codec_tracks.py); [`tests/test_codec_phase5_guards.py::test_unmatched_ordinary_policy_and_same_lineage_guard_remain`](tests/test_codec_phase5_guards.py) | [`evidence/native/research/acceptance/110-codec-track-restore/result.json`](evidence/native/research/acceptance/110-codec-track-restore/result.json); [`evidence/native/research/acceptance/111-codec-track-delete/result.json`](evidence/native/research/acceptance/111-codec-track-delete/result.json); [`evidence/research/final-review/report.json`](evidence/research/final-review/report.json) |
| Selected album/artist/album-artist dependency maintenance works in the closed local-WAV profile | N2/O | `set_indexed_fields` in [`itlkit/trackops.py`](itlkit/trackops.py); [`itlkit/atoms.py`](itlkit/atoms.py) | indexed-edit/COW tests in [`tests/test_codec_tracks.py`](tests/test_codec_tracks.py) and [`tests/test_codec_fresh_state.py`](tests/test_codec_fresh_state.py) | [`evidence/native/research/acceptance/112-codec-track-indexed/result.json`](evidence/native/research/acceptance/112-codec-track-indexed/result.json) |
| Nested/extended playlist items and mismatched system definitions fail closed before mutation | O | [`itlkit/trackops.py`](itlkit/trackops.py); [`itlkit/operations.py`](itlkit/operations.py) | all tests in [`tests/test_codec_phase5_guards.py`](tests/test_codec_phase5_guards.py) | [`evidence/research/codec-phase5-report.json`](evidence/research/codec-phase5-report.json); [`evidence/research/final-review/report.json`](evidence/research/final-review/report.json) |
| Output publication is new-file-only and race-safe within the tested local-filesystem model | O | [`itlkit/io.py`](itlkit/io.py) | [`tests/test_codec_output_atomic.py`](tests/test_codec_output_atomic.py); CLI overwrite test | [`evidence/research/final-review/report.json`](evidence/research/final-review/report.json); [`evidence/research/bounded-fuzz/report.json`](evidence/research/bounded-fuzz/report.json) |
| High-level JSON refuses raw rebasing/tampering and applies allowed operations transactionally | O | `Library.to_dict/from_dict/apply_operations` | [`tests/test_codec_json_guards.py`](tests/test_codec_json_guards.py); semantic/validation JSON tests | [`evidence/research/final-review/report.json`](evidence/research/final-review/report.json) |
| Bounded deterministic fuzz corpus completed without recorded anomaly | O | historical fuzz script | not part of core pytest invocation | [`evidence/research/bounded-fuzz/report.json`](evidence/research/bounded-fuzz/report.json): 503 executed, 124 accepted, 379 refused, 0 anomalies, 0 native operations |
| Six phase-3 independent candidates survived 12 native cycles and archived raw-reference audits | N2/R | research builders/harnesses; not general `Library` API | archived harness self-tests | [`evidence/native/phase3/parent-independent-audit.json`](evidence/native/phase3/parent-independent-audit.json); cases/runs/snapshots under [`evidence/native/phase3/`](evidence/native/phase3/) |
| Following native AddFile allocation passed for one constructed candidate | N1/R | native control harness | control self-tests | [`evidence/native/phase3/controls/post-acceptance-allocation/result.json`](evidence/native/phase3/controls/post-acceptance-allocation/result.json) and two reload controls |
| Audible/silent playback was not established | F | [`scripts/windows/silent_playback.py`](scripts/windows/silent_playback.py) predicate | [`evidence/tests/playback-predicate.log`](evidence/tests/playback-predicate.log) | [`evidence/native/phase3/controls/post-acceptance-silent-playback/result.json`](evidence/native/phase3/controls/post-acceptance-silent-playback/result.json) |
| Delivery file set and hashes are reproducibly verifiable | O | [`scripts/research/verify_delivery.py`](scripts/research/verify_delivery.py) | [`proposals/test_verify_delivery_strict.py`](proposals/test_verify_delivery_strict.py) | [`DELIVERY-MANIFEST.json`](DELIVERY-MANIFEST.json); [`evidence/delivery/CLOSURE-SUMMARY-v2.json`](evidence/delivery/CLOSURE-SUMMARY-v2.json) |
| Required deliverables, local links, test selectors, canonicalization, and non-universal status are mechanically consistent | O | [`scripts/research/verify_spec_deliverables.py`](scripts/research/verify_spec_deliverables.py) | direct offline verifier | current branch validation |

## Native qualification inventory

### Historical codec-produced candidates

[`evidence/native/research/057-final-qa.json`](evidence/native/research/057-final-qa.json) rechecks ten accepted inputs, each with two cycles:

- `050-codec-forced`
- `051-codec-modified`
- `070-codec-playlist-rename`
- `071-codec-playlist-members`
- `072-codec-playlist-create`
- `073-codec-playlist-delete`
- `074-codec-playlist-create-from-master`
- `110-codec-track-restore`
- `111-codec-track-delete`
- `112-codec-track-indexed`

`113-codec-fresh-modified` is retained as a failure: the extra Unplayed expectation failed and the requested Name later reverted. It is not counted as accepted.

### Phase-3 independent cases

[`evidence/native/phase3/parent-independent-audit.json`](evidence/native/phase3/parent-independent-audit.json) records six passed cases and twelve cycles. Five add or construct tracks; all are exact synthetic fixtures. The audit itself launched no new native action and does not broaden the public API.

### Frozen offline cohort

The final archived core result is 976 passed / 5 skipped. The cohort contains 55 structural native fixtures and 50 complete COM after-state records; the five missing COM cases remain explicit skips while their structural checks still run.

## Evidence caveats

1. Files under [`evidence/`](evidence/) may describe historical source commits. A historical `COMPLETE` or `DONE` means that evidence task completed, not that current universal support is complete.
2. [`evidence/static/codec-compatibility-review.json`](evidence/static/codec-compatibility-review.json) records gaps found against an earlier implementation snapshot. Current code and tests reflect the listed envelope/endian/encoding corrections; use the report as provenance, not as a claim that those old defects remain.
3. Archived COM observations cover selected fields and visible playlists. Opaque/system bytes outside those assertions are not thereby semantically certified.
4. Offline audits do not become additional native launches.
5. Binary fixtures retain historical synthetic locations and are not portable live libraries.
6. Synthetic media encoding/provenance does not qualify every media format for ITL construction or playback.

## Reproduction entry points

```powershell
$env:PYTHONDONTWRITEBYTECODE='1'
$env:PYTHONIOENCODING='utf-8'
$env:ITLKIT_NATIVE_ROOT=(Resolve-Path '.\evidence\native\snapshots').Path
$env:ITLKIT_NATIVE_REPORTS=(Resolve-Path '.\evidence\native\oracles').Path
python -B -m pytest tests -q -rs -p no:cacheprovider --basetemp "$env:TEMP\itl-spec-audit-tests"
python -B scripts/research/verify_spec_deliverables.py
python -B scripts/research/verify_delivery.py
```

Use a fresh temporary path outside the repository. These commands are offline; they do not launch iTunes.

## 2026-09-21 integration supplement

| Claim | Grade | Implementation/tests | Evidence and boundary |
| --- | --- | --- | --- |
| A fresh isolated 12.13.10.3 library progressed through empty, one track, three tracks, one traced Name edit, and two repeated saves with equal logical state | N1/O | existing parser plus manifest QA | [`evidence/native/fresh-20260921/`](evidence/native/fresh-20260921/); iTunes created the library, so this is not reference-writer acceptance |
| `SLst` framing, counts, rule boundaries, opaque bytes, and unknown operators can be parsed and serialized losslessly | NC/O/T | [`itlkit/smart.py`](itlkit/smart.py); [`tests/test_smart_playlists.py`](tests/test_smart_playlists.py) | [`SMART_PLAYLIST_SPEC.md`](SMART_PLAYLIST_SPEC.md); [`evidence/smart-playlist/corpus-census.json`](evidence/smart-playlist/corpus-census.json); semantic names beyond native correlations remain PA/H |
| 95/95 retained ITLs yielded 1,235 type-101/102/103 playlist instances without parser errors | NC/O | census and tests | [`evidence/smart-playlist/`](evidence/smart-playlist/); built-in/system corpus only, no custom editable rules |
| 24/30 path calls returned tracks; 23 new tracks survived sequential native saves/reopens; 39/39 snapshots parse | N1/O | [`scripts/windows/path_time_matrix.py`](scripts/windows/path_time_matrix.py); [`tests/test_path_time_matrix.py`](tests/test_path_time_matrix.py) | [`PATH_AND_TIME_SPEC.md`](PATH_AND_TIME_SPEC.md); [`evidence/path-time/qa-summary.json`](evidence/path-time/qa-summary.json); six failures are COM-boundary observations, not universal format rejection |
| Six of eight `PlayedDate` setter cases persisted; fold identity was lost and a DST gap normalized | N1/O | path/time harness and codec tests | [`evidence/path-time/native/native-summary.json`](evidence/path-time/native/native-summary.json); only the tested field/zone/build is qualified |
| All retained ITLs and subordinate corpus analyses are hash-addressed by one root inventory | O | [`scripts/research/build_manifests.py`](scripts/research/build_manifests.py) | [`corpus-manifest.json`](corpus-manifest.json); presence does not imply native acceptance |

The integrated offline regression is 1024 passed / 5 skipped when run with the frozen native fixture roots documented below. This count is not a native-interoperability percentage.
