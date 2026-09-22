# Media-backed `Lyrics` / `Enabled` follow-up

**Disposition: canonical bounded native negative evidence — 0 exact mutations passed, 2 failed after successful initialization and baseline restart.**

This run tested one materially different hypothesis left by the isolated field matrix: whether the exact failed `Lyrics` and `Enabled=false` COM writes would succeed on fresh native `AddFile`-created file tracks backed by deterministic WAV media. They did not in the pinned environment. This does not establish universal rejection for other values, media types, track subtypes, playlist-member interfaces, UI editing paths, iTunes versions, locales, or profiles.

## Pinned run

- Run window: `2026-09-22T02:01:37.214097+00:00` through `2026-09-22T02:03:04.136616+00:00`
- Disposable root: `D:\a\_temp\media-field-followup-root-20260922-v2`
- Platform: Windows Server 2025 / NT 10.0.26100, Python 3.12.10
- iTunes: standalone Apple desktop x64 `12.13.10.3`
- iTunes executable SHA-256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- Capture-time corrected harness: [`capture-harness.py`](capture-harness.py), 31,431 bytes, SHA-256 `5d4bf2c235363c0764e1726171fe0948fbfc9e2f597185e11a9b5612ff7efa1a`
- Case-matrix SHA-256: `ab0eff3478d5ae0ee180c833221e64e9a52f6df18e13ef73ff6233623466190b`
- Aggregate result: `passed_cases=0`, `failed_cases=2`, `all_passed=false`, `status=failed_with_preserved_evidence`

The executable under `scripts/windows/` was subsequently refactored to expose the same identity checks as a pure regression helper. The exact source that produced this capture is frozen above; replay provenance does not depend on reconstructing the later refactor.

Each case used a fresh native profile and a four-session fail-closed plan: initialize with `AddFile`, restart and stabilize the baseline, perform exactly one mutation, then restart and verify the complete state. A failed mutation intentionally prevented the fourth session. Successful sessions required two stable COM reads, unchanged media, normal `Quit()`, exit code 0, no forbidden fallback artifacts, and an independently parseable/valid saved ITL. A failed worker did not call `Quit()`; the owned iTunes process was killed and the failure state retained.

## Deterministic media

| Case | Tone | WAV shape | Bytes | `mtime_ns` | SHA-256 |
| --- | ---: | --- | ---: | ---: | --- |
| `lyrics-unicode-media-backed` | 523 Hz | mono PCM16, 44,100 Hz, 22,050 frames | 44,144 | `1790042497372422400` | `622b224306c5bd22e2a1cd575f6a84dc680748c3a2d8a82d3963372dbc2db93a` |
| `enabled-false-media-backed` | 659 Hz | mono PCM16, 44,100 Hz, 22,050 frames | 44,144 | `1790042540782181100` | `694135c6cb6d09e78e710aa78296719ab3a645ae0042914864e31475f97de1b2` |

Every completed stable sample resolved the COM `Location` below the disposable case root, found the file, and matched the pinned source hash. Each case's final source hash was unchanged.

## Separate identity domains

The corrected gate deliberately does **not** equate the serialized outer `hdfm` file PID with the COM library/master-playlist PID. It independently requires a nonzero outer PID, finds exactly the serialized master playlist having the COM PID, and requires exact membership of the COM track PID.

| Case | COM library / serialized master PID | Track PID | Outer file PID | Master membership |
| --- | --- | --- | --- | --- |
| `lyrics-unicode-media-backed` | `EBFFA4764B541115` | `B68C724502F6CB6F` | `C1F2FE9E32D3570C` | exactly `B68C724502F6CB6F` |
| `enabled-false-media-backed` | `2D147C97113DC1E4` | `53864ADF26F96286` | `D598201C733C4716` | exactly `53864ADF26F96286` |

For each case these identities and the location survived the initialization-to-baseline restart. The outer PID remained stable across both independently validated saves. The outer and master values being different is expected native evidence, not fallback.

## Native save chain

| Case / phase | UTC start → finish | Bytes | `mtime_ns` | SHA-256 | Independent result |
| --- | --- | ---: | ---: | --- | --- |
| Lyrics / initialize | `02:01:37.383260` → `02:01:54.589600` | 4,491 | `1790042510516011000` | `148bcc740199f6a74c6f67289263c7b274fd1c768c60fde900d0b3d47e549a41` | parsed; validator `valid=true`; identity gate passed; normal exit 0 |
| Lyrics / baseline restart | `02:01:54.591376` → `02:02:11.844040` | 4,520 | `1790042526480017800` | `6ab176567e26f6e6f6a916fbc94e883b7cd2696b77395af3f85fd45dc83f31ba` | parsed; validator `valid=true`; identity gate passed; normal exit 0 |
| Lyrics / mutation failure copy | `02:02:11.848090` → `02:02:20.754063` | 4,520 | `1790042526480017800` | `6ab176567e26f6e6f6a916fbc94e883b7cd2696b77395af3f85fd45dc83f31ba` | worker failed before save; live bytes equal baseline; owned process killed (`1`) |
| Enabled / initialize | `02:02:20.783570` → `02:02:37.978399` | 4,471 | `1790042553896860800` | `ce9ea8b907a393fdce0220e5555560835a47765f0942cfc728846913b7bd93e7` | parsed; validator `valid=true`; identity gate passed; normal exit 0 |
| Enabled / baseline restart | `02:02:37.980942` → `02:02:55.205381` | 4,494 | `1790042569878943000` | `e7c0b55cf2f424ba5c170c67dbfb776391aadc630d167b8ba88c58ca27b3ec74` | parsed; validator `valid=true`; identity gate passed; normal exit 0 |
| Enabled / mutation failure copy | `02:02:55.207400` → `02:03:04.114058` | 4,494 | `1790042569878943000` | `e7c0b55cf2f424ba5c170c67dbfb776391aadc630d167b8ba88c58ca27b3ec74` | worker failed before save; live bytes equal baseline; owned process killed (`1`) |

The mutation failure copies are evidence of the pre-save state, not native mutation saves. Independent parsing/validation was required and passed for initialization and baseline saves; it was not represented as having run after a failed worker.

## Exact mutation outcomes

### `lyrics-unicode-media-backed`

- Requested field/value: `Lyrics = "Line one — 第二行 🎤"`
- Initialization and baseline restart: passed
- Setter result: COM exception
- Exact recorded error: `com_error: (-2147352567, 'Exception occurred.', (0, None, None, None, 0, -2147418113), None)`
- Worker exit: 2
- `Quit()` requested by worker: false
- Verification restart: not attempted

### `enabled-false-media-backed`

- Requested field/value: `Enabled = false`
- Initialization and baseline restart: passed
- Setter call: returned without an exception
- Immediate exact gate: requested `false`, expected `false`, observed `true`, `exact=false`
- Exact recorded error: `RuntimeError: setter projection mismatch for Enabled: True != False`
- Worker exit: 2
- `Quit()` requested by worker: false
- Verification restart: not attempted

No iTunes process or per-user `Music\iTunes` junction remained after either case.

## Qualified conclusion and limits

The earlier no-location field-matrix failures are not explained merely by the absence of media backing: the same exact requests also failed on fresh native, WAV-backed file tracks after a successful native save and separate restart. That is the full positive scope of this negative experiment.

It does **not** prove that every lyrics string or `Enabled` transition is rejected, that UI editing behaves like COM, that another track subtype or interface has the same behavior, or that another iTunes version/profile does. It does not qualify direct ITL-byte mutations for these fields. Neither case reached a mutation save or verification restart, so no persistence claim—positive or negative—is made beyond the recorded pre-save behavior. The original pre-field harness failure remains separately preserved in [`../media-field-followup-20260922/`](../media-field-followup-20260922/).

U-01 through U-18 remain open. `status.full_analysis_specification_gate`, `completion.gate_passed`, and `completion.independent_reimplementation_passed` remain false.
