# Media-backed field follow-up — first attempt

**Disposition: harness-only failure before field mutation. This capture is not native rejection evidence for either `Lyrics` or `Enabled`.**

This preserved run was the first attempt to revisit the two failures from `../field-matrix-20260922/` with native `AddFile`-created, deterministic WAV-backed tracks. It ran from 2026-09-22 01:58:14.549710 UTC through 01:58:49.527016 UTC on Windows Server 2025 / iTunes 12.13.10.3. The case matrix was 259 bytes with SHA-256 `ab0eff3478d5ae0ee180c833221e64e9a52f6df18e13ef73ff6233623466190b`.

## What actually happened

Both fresh-profile initialization sessions succeeded in the product-facing steps: iTunes created a fresh library, `LibraryPlaylist.AddFile` created exactly one media-backed track, two COM reads were stable, the deterministic WAV remained unchanged, `Quit()` was requested, iTunes exited 0, and the saved ITL independently parsed and validated. The harness then applied an invalid identity assertion: it required the serialized outer `hdfm` file Persistent ID to equal the COM `LibraryPlaylist`/serialized master-playlist Persistent ID.

Fresh native libraries demonstrated that these are distinct identity domains. The serialized playlist whose PID matched the COM library/master PID contained the exact COM track PID. The mismatch below is therefore a harness defect, not native fallback and not a field-setter result.

| Case | WAV SHA-256 | COM/master PID | Track PID | Serialized outer file PID | Native save SHA-256 | Outcome |
| --- | --- | --- | --- | --- | --- | --- |
| `lyrics-unicode-media-backed` | `622b224306c5bd22e2a1cd575f6a84dc680748c3a2d8a82d3963372dbc2db93a` | `6771ADDABB752118` | `735378225E7C005F` | `86BC1B235A5F55AC` | `e367145faeffe3c06d17788648c58117fbf97ff9facbe04124604fce7b5794a9` | Harness identity gate failed after normal native save/exit |
| `enabled-false-media-backed` | `694135c6cb6d09e78e710aa78296719ab3a645ae0042914864e31475f97de1b2` | `111989BEC5E0658D` | `6BB2A21BBF8F0AD2` | `1FF7D307548535BE` | `9e129243e6daa5393eebe6f51bb8c0c2dbda137bdcd7d9a8a75ff5812db17efb` | Harness identity gate failed after normal native save/exit |

The two source WAVs were each 44,144 bytes, mono PCM16 at 44.1 kHz with 22,050 frames. No mutation session started, no `Lyrics` or `Enabled` setter was called, and no mutation-save or verification restart was attempted. The summary's `0 passed / 2 failed` therefore describes the broken harness gate only.

## Correction and canonical follow-up

The corrected harness:

1. requires the outer file PID only to be a nonzero 16-hex identity;
2. locates the serialized master playlist by the COM `LibraryPlaylist` PID;
3. requires that master playlist to contain the exact COM track PID; and
4. tracks outer-file-PID stability separately across sessions.

The corrected canonical run is [`../media-field-followup-20260922-v2/`](../media-field-followup-20260922-v2/). It passed initialization and a separate baseline restart for both cases before producing two field-specific native negative results.

## Replay limitation

The exact pre-correction source file was not copied into this evidence directory before the harness was corrected in place. The rejected identity values, full independent summaries, traceback, native saves, COM snapshots, worker specifications, timestamps, and cleanup receipts are preserved here, but bit-for-bit replay of the first harness revision is not claimed. The checked-in harness is the corrected revision. This historical-source gap remains part of U-18 rather than being hidden or reconstructed after the fact.
