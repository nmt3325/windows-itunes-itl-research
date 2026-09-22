# Short ASCII `Lyrics` on WAV backing

**Disposition: bounded native negative evidence for one exact WAV-backed case. Initialization and baseline restart passed; the exact setter was rejected before save, so no verification restart was attempted.**

This run isolates media kind from string content. On a fresh native `AddFile`-created WAV track, iTunes 12.13.10.3 rejected `Lyrics = "Plain ASCII lyrics line one"` with the same nested HRESULT previously seen for the Unicode WAV case. The result is specific to this value, backing file, COM interface, version, and profile; it is not a generic Lyrics-rejection rule.

## Pinned run

- Run window: `2026-09-22T03:50:22.889917+00:00` through `2026-09-22T03:51:08.467383+00:00`
- Disposable root: `D:\a\_temp\itl-media-lyrics-ascii-20260922`
- Platform: Windows Server 2025 / NT 10.0.26100, Python 3.12.10
- iTunes: standalone Apple desktop x64 `12.13.10.3`
- iTunes executable SHA-256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- Capture harness: [`capture-harness.py`](capture-harness.py), 38,624 bytes, SHA-256 `964e4a6ef7df104867b0211e38b8f0607b014c87f82709dd2d82bbe37b846416`
- Native driver: [`capture-native-driver.py`](capture-native-driver.py), 5,959 bytes, SHA-256 `3b33a0ddb405567d0176e71ca774bcb0077358eefea39d62016e56479b3233eb`
- Case matrix: 164 bytes, SHA-256 `5a0c087912175a270e74506948577b88d6eedc3ae59cea2a115f7b80455e8cc4`
- Aggregate result: `passed=0`, `failed=1`, `status=failed_with_preserved_evidence`

The case used a genuinely fresh profile and the fail-closed initialize → baseline restart → mutate → verification plan. Each successful session required stable complete COM snapshots, exact identities and membership, normal `Quit()`, exit code 0, no fallback artifacts, unchanged media, and an independently parseable/valid saved ITL. A failed mutation prevents verification by design.

## Deterministic WAV and identity

- Tone: 784 Hz
- Shape: mono PCM16, 44,100 Hz, 22,050 frames
- Bytes: 44,144
- `mtime_ns`: `1790049024422504300`
- SHA-256: `63b0a3a40198a07555dc2dc68f254243bc6e69bab32edfcfbe9ea5d1098925fb`

The source-original, initialization copy, baseline copy, mutation-failure copy, and final source all have the same byte count and SHA-256. No WAV byte changed.

The initialization and baseline restart retained:

- COM library / serialized master PID: `C849C53960EE3113`
- Track PID: `C0099FB26781CDAC`
- Outer file PID: `B615ACA680D92133`
- Serialized master membership: exactly `C0099FB26781CDAC`

The unequal outer and master PIDs are separate native identity domains, not fallback.

## Native chain

| Phase | UTC start → finish | Result | ITL bytes | ITL SHA-256 |
| --- | --- | --- | ---: | --- |
| initialize | `03:50:24.444445` → `03:50:42.134147` | stable snapshots; native save; validator `valid=true`; normal exit 0 | 4,480 | `15495d94cde91040e6501c32ec64ee666478865810522e6ce49a0e48ff0140f8` |
| baseline restart | `03:50:42.137746` → `03:50:59.405009` | stable complete reload; identities/membership retained; validator `valid=true`; normal exit 0 | 4,512 | `214114d26e58fac18395d1e8bc5f224ad0ee12abd8684711c8936a8c4bf9de83` |
| mutate | `03:50:59.409034` → `03:51:08.446399` | setter rejected; worker exit 2; no `Quit()` or native mutation save; owned process killed with exit 1 | 4,512 failure copy | `214114d26e58fac18395d1e8bc5f224ad0ee12abd8684711c8936a8c4bf9de83` |
| verify | — | not attempted because mutation failed | — | — |

Requested field/value:

```text
Lyrics = "Plain ASCII lyrics line one"
```

Exact recorded native error:

```text
com_error: (-2147352567, 'Exception occurred.', (0, None, None, None, 0, -2147418113), None)
```

The live ITL retained at failure is byte-identical to the baseline save, and `media-at-failure.wav` is byte-identical to the original source. The profile junction was removed and no iTunes process remained.

## Qualified conclusion and limits

A short plain-ASCII value did not remove the WAV-backed setter rejection. This excludes Unicode alone as the explanation for the exact WAV behavior. It does not establish rejection for MP3, another media kind, UI editing, another track subtype/interface, longer or different strings, or another iTunes version.

The paired deterministic MP3 case in [`../media-field-followup-20260922-mp3-ascii-v3/`](../media-field-followup-20260922-mp3-ascii-v3/) accepted the same property/value and persisted it across restart while rewriting the MP3. Together, the two runs establish media/interface-dependent behavior only; they do not identify generic ITL storage or a universal Lyrics rule.

U-01 through U-18 remain open. U-12 remains open because later MP3 follow-ups establish only an exact accepted lower point through 65,536 characters, not an upper acceptance/rejection or truncation boundary. `status.full_analysis_specification_gate`, `completion.gate_passed`, and `completion.independent_reimplementation_passed` remain false.
