# Path/time evidence

This directory records the Windows path/date matrix for Apple desktop x64 iTunes 12.13.10.3. It separates offline lexical calculations, Windows filesystem facts, native UI/COM observations, and decoded native-saved ITLs. See [`PATH_AND_TIME_SPEC.md`](../../PATH_AND_TIME_SPEC.md).

## Result summary

- Native run: `2026-09-21T15:51:58Z` through `16:00:59Z`
- 30 import/seed cases: 24 returned a track; 6 recorded `rejected_or_failed`
- 23 tracks in the final native snapshot (case-only re-import added none)
- 8 `PlayedDate` cases: 6 accepted/persisted; 2 failed at Python/COM boundary
- 39/39 native ITL snapshots parsed; 0 parse errors
- No repair/restore/XML modal text; only the known audio warning
- Time zone restored; share/mapped/subst aliases and profile junction removed

`rejected_or_failed` is not a universal unsupported-format claim. It means the exact COM call returned no usable operation/track and no persistent ID was added.

## Artifact map

| Path | Purpose |
|---|---|
| `offline-matrix.json` | lexical/URL/HFS/zoneinfo calculations; never native acceptance |
| `environment.json` | OS/locale/time-zone and executable signature attestation |
| `installer-provenance.json` | Apple installer URL/hash/version/signature |
| `native-preflight.json` | EULA guard and bounded smoke evidence |
| `native/native-summary.json` | aggregate native result and cleanup |
| `native/input-manifest-final.json` | WAV hashes and alias setup |
| `native/runs/*/` | exact case spec, COM output, log, summary |
| `native/snapshots/*.itl` | seed plus every native-saved state |
| `native/final-live-inventory.json` | final isolated profile inventory |
| `native/post-run-state.json` | cleanup observation |
| `native/path_time_matrix-evidence.py` | exact run harness, SHA-256 `0c75bddf12d181229f4feebb0ba1a4d77304157229e7ce61f02a2653ef2d0bb7` |
| `qa-summary.json` | machine-readable audit |
| `manifest.json` | bytes/SHA-256 for evidence files except itself |

## Non-claims

- `N:` was a local SMB mapping, not a remote server.
- `P:` was `subst`/fixed drive type 3, not physical external media.
- No drive letter was changed after import.
- Japanese occurred only in a failed percent-encoded `file:` input; direct Japanese-path acceptance is untested.
- The original in-run Authenticode command was misquoted. The hash remains exact; installer provenance and `environment.json` independently verify signatures. Source now fixes the bug without altering evidence.
- This is not a no-op/edit/new-writer acceptance test and does not close repository-wide gates.
