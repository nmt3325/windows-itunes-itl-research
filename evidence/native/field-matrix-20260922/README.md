# Native field matrix — 2026-09-22

This directory is the immutable evidence bundle for 29 isolated one-property COM mutation trials against the exact template-free raw candidate `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` on standalone Windows iTunes 12.13.10.3.

## Result

- Overall status: **`failed_with_preserved_evidence`**.
- Started: `2026-09-21T23:25:36.863943+00:00`.
- Finished: `2026-09-21T23:41:30.311260+00:00`.
- Passed: **27**.
- Failed: **2**.
- A 27/29 result is not full-field support.

Each passing case used a fresh profile, performed exactly one property write, required the immediate COM projection to equal the requested value, fixed the complete expected snapshot before restart, reopened the native save, took two stable reads per session, required stable file/master/track/custom-playlist identities, required a normal `Quit`/exit 0, independently parsed and validated the saved ITL, and rejected unexpected modal or fallback artifacts. System-playlist PIDs are newly allocated per profile, so those views were checked by name, `SpecialKind`, count, and membership instead of cross-profile PID equality.

## Passing cases

| Family | Exact passing cases |
| --- | --- |
| Text | `Name`, `Artist`, `Album`, `AlbumArtist`, `Composer`, `Genre`, `Comment`, `Grouping`, `SortName`, `SortArtist`, `SortAlbum`, `SortAlbumArtist` |
| Rating/count/date | `Rating`, `AlbumRating`, `PlayedCount`, `PlayedDate`, `SkippedCount`, `SkippedDate` |
| Numeric/flags | `TrackNumber`, `TrackCount`, `DiscNumber`, `DiscCount`, `Year`, `BPM`, `Compilation`, `VolumeAdjustment`, `Unplayed` |

The exact case inputs are in [`case-matrix.json`](case-matrix.json). The complete aggregate result is [`summary.json`](summary.json); each `cases/<name>/` directory retains worker specifications, COM snapshots, logs, saved ITLs, and the case result.

## Retained failures

### `lyrics-unicode`

The COM setter raised `pywintypes.com_error` with outer code `-2147352567` and nested code `-2147418113`. The worker exited 2, no verification restart was attempted, the owned iTunes process was terminated during cleanup, and the profile junction was removed. This is a negative COM/profile observation, not proof that every Lyrics value or direct-file representation is unsupported.

### `enabled-false`

The setter call did not throw, but the immediate COM projection stayed `true` after requesting `false`. The exact gate failed with `setter projection mismatch for Enabled: True != False`; the worker exited 2 and no verification restart was attempted. This is not persistence support.

## Claim boundary

These results qualify only the named values, exact source hash, iTunes executable hash, locale/profile, and harness gates recorded in the evidence. They do not establish arbitrary values, combinations, long-string limits, hidden dependencies, another track shape, another version, or complete format semantics.
