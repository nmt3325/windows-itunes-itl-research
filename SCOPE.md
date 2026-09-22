# Project scope and completion boundary

This document defines what this repository can claim at integrated evidence base commit `9a5f30f6b9c1d1d8efea4b8c141f9d30a350bc39` and what “complete” means for the specification deliverables.

## Status summary

- **Specification deliverables:** complete when the files listed in [`completion-status.yaml`](completion-status.yaml) exist, are mutually linked, pass the documented checks, and remain evidence-bounded.
- **Implementation:** a guarded research implementation with substantial verified behavior.
- **Universal ITL support:** **not complete and not claimed**.
- **Template-free generation:** two exact 12.13.10.3 fixture hashes are native-qualified for two isolated cycles each; arbitrary generated libraries and independent reimplementation remain unqualified.
- **Field matrix:** 27 exact one-property cases passed; Lyrics and Enabled are retained failures.
- **External implementation:** one compressed structural no-op output passed two native cycles, but PID semantics and mutation/preflight gates failed; independent reimplementation remains false.
- **Smart Playlist:** native nested-wrapper framing is now observed, but the string operand and membership gates failed; semantic editing/evaluation remains unsupported.
- **Primary native target:** official standalone Windows x64 iTunes `12.13.10.3`.
- **Secondary observed profile:** standalone Windows iTunes `12.13.9.1`; semantic code admits this profile for bounded scalar work, but the packaged native qualification is centered on `12.13.10.3`.

## Evidence states

Every specification statement should fit one of these states:

| State | Meaning |
| --- | --- |
| Native-qualified | An exact hash-pinned candidate passed the stated real-iTunes identity/value/save/reload gate. |
| Offline-verified | Repeatable tests passed against synthetic or archived native fixtures without launching iTunes. |
| Implemented, guarded | Code exists only for an admitted profile and fails closed on unknown dependencies. |
| Observed | Bounded static/dynamic evidence supports the statement; no general writer is implied. |
| Opaque/preserved | Bytes are retained, but their semantics are not claimed. |
| Unresolved | Evidence or implementation is insufficient. |

A stronger state never automatically generalizes to another version, library lineage, media kind, record shape, or field combination.

## In scope

1. The `hdfm` envelope observed in the named standalone Windows iTunes profiles:
   - header framing and declared size;
   - encryption flags 0/1/2 and the selected AES-128-ECB interval;
   - compression flag behavior and zlib validation;
   - exact no-op byte preservation and forced reconstruction;
   - bounded decompression.
2. Little-endian `msdh` section framing and a boundary-driven record tree.
3. The record and section types cataloged in [`ITL_RECORD_TYPES.md`](ITL_RECORD_TYPES.md), with unknown bodies preserved rather than tag-scanned.
4. The exact track fields, text encodings, identity domains, playlist fields, and reference checks described in [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md) and [`ITL_DATA_MODEL.md`](ITL_DATA_MODEL.md).
5. Guarded operations implemented in [`itlkit/`](itlkit/):
   - scalar and selected text edits;
   - selected album/artist dependency maintenance for the closed local-WAV profile;
   - ordinary playlist rename/create/delete/member replacement;
   - same-lineage native-WAV track restoration and guarded deletion;
   - transactional JSON operations;
   - new-file-only output publication.
6. Archived native evidence, static analysis, offline regression tests, bounded fuzzing, and delivery-integrity checks linked from [`EVIDENCE.md`](EVIDENCE.md).

7. The evidence-graded smart-playlist `SLst` AST, lossless serializer, structural validator, and retained-corpus census in [`SMART_PLAYLIST_SPEC.md`](SMART_PLAYLIST_SPEC.md). Semantic rule editing/evaluation is excluded.
8. The bounded Windows path/time native matrix in [`PATH_AND_TIME_SPEC.md`](PATH_AND_TIME_SPEC.md), with offline, Windows-only, native COM/UI, and serialized-ITL evidence kept distinct.
9. The aggregate hash inventory in [`corpus-manifest.json`](corpus-manifest.json), including explicit provenance and native-acceptance boundaries.

## Out of scope or explicitly unsupported

- Complete documentation of every historical ITL generation.
- Microsoft Store iTunes, Apple Music databases, macOS databases, cloud/store/DRM semantics, device sync, purchases, or Apple ID behavior.
- General big-endian semantic parsing or editing. `Container` may preserve/rebuild opaque bytes; `Library` rejects big-endian payload semantics.
- Arbitrary cross-library import, arbitrary new-track construction, arbitrary media kinds, or portable relocation of media paths.
- General shared-object copy-on-write, complete string/index allocator semantics, or complete sort/rank regeneration.
- Recursive/grouped playlist items, arbitrary smart-playlist rule evaluation, or editing arbitrary system/master playlists.
- General timezone/DST/fold reconstruction from HFS wall-time values.
- Audible playback. The retained silent-playback control did not establish playback success.
- Treating raw research builders or one-off accepted candidates as a supported production API.

## Claim gates

### Gate A — byte preservation

A no-op `Container` or `Library` round trip must return the exact input bytes. Passing this gate proves preservation, not semantic understanding.

Implementation: [`itlkit/container.py`](itlkit/container.py), [`itlkit/library.py`](itlkit/library.py).
Tests: [`tests/test_core_container.py`](tests/test_core_container.py), [`tests/test_codec_native_profiles.py`](tests/test_codec_native_profiles.py).

### Gate B — structural reconstruction

A freshly encoded output must independently decode to the intended payload and satisfy envelope sizes, section boundaries, modeled counts, identity uniqueness, and modeled references. This is still an offline structural claim.

Implementation: [`itlkit/container.py`](itlkit/container.py), [`itlkit/model.py`](itlkit/model.py), [`itlkit/library.py`](itlkit/library.py).
Tests: [`tests/test_core_compatibility.py`](tests/test_core_compatibility.py), [`tests/test_model_structure.py`](tests/test_model_structure.py), [`tests/test_core_support.py`](tests/test_core_support.py).

### Gate C — semantic edit support

An operation is supported only when its profile preconditions pass, all modeled dependencies remain valid, unknown dependencies are absent or conservatively preserved, and the transaction refuses without partial mutation on failure.

Implementation: [`itlkit/atoms.py`](itlkit/atoms.py), [`itlkit/operations.py`](itlkit/operations.py), [`itlkit/trackops.py`](itlkit/trackops.py), [`itlkit/references.py`](itlkit/references.py).
Tests: the `test_codec_*` files linked in [`EVIDENCE.md`](EVIDENCE.md).

### Gate D — native acceptance

Native qualification requires an exact candidate hash, the intended library selection, stable file/master/track/playlist persistent identities, exact requested values, complete modeled playlist membership/order checks, normal native exit, and reopen/save validation. The strongest historical writer evidence uses two actual save/reload cycles per candidate. Empty-library fallback is failure.

Evidence: [`docs/dynamic.md`](docs/dynamic.md), [`evidence/native/research/`](evidence/native/research/), [`evidence/native/phase3/`](evidence/native/phase3/), and the exact template-free qualification in [`evidence/native/reference-generated-20260922-passed/`](evidence/native/reference-generated-20260922-passed/).

Native qualification attaches to the exact candidate and stated operation, not to the whole format.

### Gate E — delivery integrity

The exact file set, sizes, and SHA-256 values must match [`DELIVERY-MANIFEST.json`](DELIVERY-MANIFEST.json); tests must write outside the repository. The manifest excludes only itself and `.git`.

Implementation: [`scripts/research/verify_delivery.py`](scripts/research/verify_delivery.py).
Tests: [`proposals/test_verify_delivery_strict.py`](proposals/test_verify_delivery_strict.py).
Specification consistency: [`scripts/research/verify_spec_deliverables.py`](scripts/research/verify_spec_deliverables.py).

## Completion definition for this branch

The specification-deliverables task is complete only when all of the following are true:

1. All 15 requested artifacts exist: [`SCOPE.md`](SCOPE.md), [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md), [`ITL_DATA_MODEL.md`](ITL_DATA_MODEL.md), [`ITL_RECORD_TYPES.md`](ITL_RECORD_TYPES.md), [`SMART_PLAYLIST_SPEC.md`](SMART_PLAYLIST_SPEC.md), [`PATH_AND_TIME_SPEC.md`](PATH_AND_TIME_SPEC.md), [`VERSION_MATRIX.md`](VERSION_MATRIX.md), `REFERENCE_PARSER/`, `REFERENCE_WRITER/`, `VALIDATOR/`, `SEMANTIC_DIFF/`, `TEST_CORPUS/`, [`corpus-manifest.json`](corpus-manifest.json), [`EVIDENCE.md`](EVIDENCE.md), and [`UNRESOLVED.md`](UNRESOLVED.md).
2. [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md) is the canonical format document; [`docs/format.md`](docs/format.md) is only a compatibility pointer.
3. Claims link to concrete implementation, tests, or evidence paths and carry a bounded status.
4. Current offline tests pass with the frozen native fixture roots; explicit missing-COM cases remain skips rather than fabricated successes.
5. Delivery-manifest verification passes after all edits.
6. [`completion-status.yaml`](completion-status.yaml) records the documentation result separately from implementation completeness and sets universal support to false.
7. The branch is committed and pushed without modifying unrelated branches.

Passing these seven gates means **the audit deliverables are complete**. It does not mean the private ITL format has been fully reverse engineered.

The separate strict complete-analysis/specification gate remains false until every U-01–U-18 closure criterion is met, arbitrary declared-scope generation is native-qualified, and a genuinely independent semantic implementation interoperates. Parser acceptance, fail-closed refusal, byte preservation, or one exact native pass cannot substitute for that gate.

## Document map and precedence

1. [`SCOPE.md`](SCOPE.md) — claim and completion boundary.
2. [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md) — canonical binary-format and supported-codec specification.
3. [`ITL_RECORD_TYPES.md`](ITL_RECORD_TYPES.md) — compact record/section/type-code catalog.
4. [`ITL_DATA_MODEL.md`](ITL_DATA_MODEL.md) — implementation object model, identities, invariants, and transactions.
5. [`SMART_PLAYLIST_SPEC.md`](SMART_PLAYLIST_SPEC.md) — evidence-graded smart-rule framing and AST.
6. [`PATH_AND_TIME_SPEC.md`](PATH_AND_TIME_SPEC.md) — bounded Windows path/time behavior.
7. [`VERSION_MATRIX.md`](VERSION_MATRIX.md) — version/profile qualification.
8. [`EVIDENCE.md`](EVIDENCE.md) — claim-to-code/test/evidence traceability.
9. [`UNRESOLVED.md`](UNRESOLVED.md) — open gaps and closure criteria.
10. [`completion-status.yaml`](completion-status.yaml) — machine-readable status snapshot.

If prose conflicts with executable behavior, treat the implementation and passing tests as the behavior of the current build, then treat native evidence as the upper bound on the claim. Record the mismatch as unresolved rather than silently broadening support.
