# Bounded `Lyrics` media-tag authority probe

**Disposition: bounded native precedence evidence for one retained MP3 track, absolute path, ITL state, and iTunes build. This is not a generic storage-authority result.**

The same verified ITL was reset before each of three probes while only the MP3's ID3v2.2 `ULT` content changed. On standalone Windows x64 iTunes 12.13.10.3, the stable COM `Lyrics` value followed the exact media input in all three cases: the original tag text, no tag, and an equal-length conflicting tag. The media did not change during any probe.

## Pinned run

- Run window: `2026-09-22T04:24:49.001678+00:00` through `2026-09-22T04:26:10.684876+00:00`
- Platform: Windows Server 2025 / NT 10.0.26100, Python 3.12.10
- iTunes: standalone Apple desktop x64 `12.13.10.3`
- iTunes executable SHA-256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- Verified ITL input: 4,541 bytes, SHA-256 `312740b3aeddf94624b34f7ee6d90ca5c21046ef528a03a303ff1dab9193e176`
- Capture harness: 28,251 bytes, SHA-256 `8733e2736db4c758d845c49fdbf31f0e95e78556e55bf8b3fa9f4d0194eea477`
- Native driver: 5,959 bytes, SHA-256 `3b33a0ddb405567d0176e71ca774bcb0077358eefea39d62016e56479b3233eb`
- Captured summary: [`summary.json`](summary.json), 226,336 bytes, SHA-256 `7d627e647690231399809e0b4a420c028519b5c0aa5bf8b78da305e3b6d9bb03`
- Aggregate status: `captured`; all 3 probes captured; final exact-root restoration passed and the temporary backup was removed

## Method and gates

For every probe the harness restored the same absolute disposable root and byte-identical verified ITL, replaced only the MP3 with the selected variant, and launched a fresh native session. The worker recorded ten complete COM snapshots. Reads 8–10 had to agree on the full allowed state and media hash.

The harness locked the iTunes version, outer file PID, COM/master playlist PID, track PID, location, exact master membership, and every captured track field except `Lyrics`, `Size`, and `ModificationDate`. It required normal `Quit()`, process exit 0, no fallback artifacts, and an independently parsed and validated native-saved ITL. The retained source root was restored byte for byte after the series.

## Exact observations

| Probe | Input MP3 bytes | Input/after SHA-256 | Stable COM `Lyrics` | Media changed |
| --- | ---: | --- | --- | --- |
| `tagged-control` | 19,066 | `d49051b7f7629b6cb6bc68fd08dabf7f9a001331a026a799ee3b3329f8b9535c` | `Plain ASCII lyrics line one` | no |
| `tag-stripped` | 8,777 | `5033b6d0540cfc68b0e169c6f7da3dd028f4fc88769b5b2d2b81a43119ddee12` | empty string | no |
| `tag-conflict` | 19,066 | `1c54d25685d362e2bbae0b558ba033da0ad6ab857815b0b836698c54b8b5a7db` | `Other ASCII lyrics line two` | no |

The conflict string has the same character and byte length as the control string, so the conflict variant changed only the retained `ULT` text bytes rather than the frame length or overall MP3 size. Each worker and iTunes process exited normally with status 0.

## Qualified conclusion and limits

For this one retained track, absolute path, MP3 shape, reset ITL, and iTunes build, the ITL did not override removal of the only `ULT` frame or an equal-length conflicting `ULT` value. COM `Lyrics` followed the supplied media tag in all three exact inputs.

This does **not** exclude hidden caches, prove that every authoritative bit lives in the MP3, establish behavior for another track/path/tag layout/media kind/version, or establish UI, Unicode, length, or direct-ITL mutation semantics. Unknown authority combinations must remain fail-closed.

U-01 through U-18 remain open. `status.full_analysis_specification_gate`, `completion.gate_passed`, and `completion.independent_reimplementation_passed` remain false.
