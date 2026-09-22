# MP3-backed `Lyrics` ID3v2.2 frame-size ceiling cohort

**Disposition: bounded mixed native evidence for one deterministic ASCII MP3/ID3v2.2 `ULT`/COM path on one pinned iTunes build. The exact-to-non-exact adjacency is path-specific, not a universal `Lyrics` upper limit.**

Standalone Windows x64 iTunes 12.13.10.3 restart-persisted five exact generated-ASCII `Lyrics` requests through 16,777,209 characters. The next adjacent request, 16,777,210 characters, produced a media rewrite but an empty immediate COM readback. Seven dense neighboring requests (16,777,210–16,777,216), one 17,000,000-character probe, and an independent 16,777,210 repeat were also native non-exact. The completed cohort contains five `exact_restart_persisted`, nine `native_nonexact_immediate_readback`, and zero `harness_failure` outcomes.

## Pinned run

- Run window: `2026-09-22T05:27:42.309955+00:00` through `2026-09-22T05:41:52.657595+00:00`
- Platform: Windows Server 2025 / NT 10.0.26100, Python 3.12.10
- iTunes: standalone Apple desktop x64 `12.13.10.3`
- iTunes executable: 38,952,912 bytes, SHA-256 `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- Capture harness: 49,617 bytes, SHA-256 `755b18a00a41bcca61eeb57293224619953638e6cffc412935d2083ba552623a`
- Native driver: 5,959 bytes, SHA-256 `3b33a0ddb405567d0176e71ca774bcb0077358eefea39d62016e56479b3233eb`
- Case matrix: [`case-matrix.json`](case-matrix.json), 3,798 bytes, SHA-256 `6c7d34561497ddab6cd2b4dfa61937f47eb5bb9679dd2311a971a6ec4ca5699f`
- Captured summary: [`summary.json`](summary.json), 1,975,278 bytes, SHA-256 `f36e6fee1baf44bff6e97894fdab41edc2da2f8add2b1df15eecfe41d32764d9`
- Aggregate status: `failed_with_preserved_evidence`; `capture_complete=true`; exact=5, native non-exact=9, harness failures=0
- MP3 encoder: `lameenc==1.8.1`; wheel SHA-256 `715e0e72ed5429f00042379e48a7903e54ee5dc01069db34338536f3595059c3`; loaded module SHA-256 `ff9f47ecfc0b167e2e3e4edacaeb23aa0b10422ef4cc180d52ae3b86ff7636dc`

## Exact restart-persisted cases

| Requested characters / UTF-8 bytes | Requested SHA-256 | Rewritten MP3 bytes | Rewritten MP3 SHA-256 |
| ---: | --- | ---: | --- |
| 131,072 | `9f0a12f927d53c42082c32ca660464b2d2be8d4b6dc8f2619656e6dbffa6fc3d` | 150,111 | `e61bba36a310551592886f1f2cdb37e8ac6ff75313e273562aec87d3d5750d91` |
| 1,048,576 | `631554337d26b71d8b2168b9edf52f70964e067d8c8dbe37c087556f1e4a2dd8` | 1,067,615 | `aa5988ed0de0a4e9e40335afede4dfe02c2659544e194d3f58bbb977f51abfac` |
| 8,388,608 | `61606d30f9390b47ec1a4bc9bf7ed4d4386ea649cb79f71b3b903fee89ca9c35` | 8,407,647 | `f576f584754a74026cb8b0ade14b670ac8a84987c96aa7598bc0c22d8ad46f1f` |
| 16,777,208 | `a6f50b681bb03173b1267436505c368150f435a39881a05b4b0d90a4761954ec` | 16,796,247 | `192980f801309a5c6afebdb8f3c1e77c910efde086800a83d559410eade722d3` |
| 16,777,209 | `e014850d61cb17e7b2c644971184c3ebabdfc49bbfc69246d24984d5eee5f090` | 16,796,248 | `4887e299082b666e5a345787509f2ab3176144620637ff5e0ff70b4d58695804` |

Each exact case used a fresh native profile and fresh deterministic MP3. Initialize, baseline restart, mutation, and verification restart passed complete stable COM snapshots, exact identity and membership gates, normal `Quit()`, process exit 0, no fallback artifacts, and independent ITL parse/validation. The full requested string was compared in memory; large snapshots retain deterministic fingerprints rather than embedding multi-megabyte values.

## Qualified native non-exact cases

| Request | Immediate COM readback | Qualification |
| ---: | --- | --- |
| 16,777,210–16,777,215 | empty string | Six adjacent requests; each setter rewrote the MP3 and failed the exact immediate-readback gate |
| 16,777,216 | one character, `L` | First request whose wrapped stored `ULT` size is one |
| 17,000,000 | 222,785 characters; SHA-256 `720bd6cb1deea1e731b09281969cb6a6a1f847852a9f22d6aed621fd881ba405` | Readback length is consistent with the modulo-2^24 frame-size remainder after the non-text `ULT` prefix |
| 16,777,210 repeat | empty string | Independent repeat at MP3 frequency 954 |

For all nine non-exact cases, initialization and baseline restart passed before the setter. The setter produced a media rewrite, immediate readback differed from the exact request, and the exact gate therefore withheld verification restart. The worker still requested normal `Quit()`; iTunes exited 0 without being killed; no fallback artifact appeared; and profile/process cleanup passed. Those conditions distinguish native non-exact behavior from infrastructure or harness failure. The aggregate retains zero `harness_failure` classifications.

## Exact adjacent frame-size mechanism

The two retained adjacent MP3s were analyzed by the generated-ASCII boundary mode in [`scripts/research/analyze_mp3_rewrite.py`](../../../scripts/research/analyze_mp3_rewrite.py):

- [`lyrics-016777209-frame-analysis.json`](lyrics-016777209-frame-analysis.json), 3,829 bytes, SHA-256 `829839b5a2a14c8943e246705038c7871ea45ef4ee8228cfca104dcaecae4a1e`, proves a byte-exact 16,777,209-byte text. Its `ULT` payload is 16,777,215 bytes, the maximum unsigned 24-bit value, stored exactly as `0xFFFFFF`; classification: `conforming_id3v22_frame_size` / `maximum_representable_unsigned_24bit_payload`.
- [`lyrics-016777210-frame-analysis.json`](lyrics-016777210-frame-analysis.json), 3,796 bytes, SHA-256 `b8ec37cf18c221184fbaf3932cbef2e3d18b6bba3d826734ac695ced2c8e5b3b`, proves a byte-exact 16,777,210-byte text. Its actual `ULT` payload is 16,777,216 bytes, but the stored 24-bit size is `0x000000`, exactly modulo 2^24; classification: `frame_size_wrap_nonconformant_id3v22_tag` / `first_nonrepresentable_unsigned_24bit_payload`. The ordinary strict parser rejected it with `zero-length ID3v2.2 frame is unsupported`.
- Both outputs contain one encoding-0 `ULT` frame with language `eng`, an empty descriptor, one text terminator, and 10,240 fixed zero-padding bytes. Both preserve the complete 8,777-byte original MPEG tail byte for byte.
- The exact case preserves original/tail SHA-256 `01274f7e2137703d9cefae6fece05ed5f01ce045f3f019c1dbe5d6c57161589b`; the first-overflow case preserves `332051203114a0f8550582f621196170237456e13c38b215a5964c771da50da8`.

This establishes the serialized 24-bit frame-size transition for the two adjacent retained outputs. It does not by itself prove every internal cause of COM projection, and it must not be generalized beyond this pinned media/tag/interface/build path.

## Retained boundary media

- Exact 16,777,209 output: [`cases/lyrics-ascii-016777209-ceiling-mp3/source-final.mp3`](cases/lyrics-ascii-016777209-ceiling-mp3/source-final.mp3), 16,796,248 bytes, SHA-256 `4887e299082b666e5a345787509f2ab3176144620637ff5e0ff70b4d58695804`
- First non-exact 16,777,210 output: [`cases/lyrics-ascii-016777210-ceiling-mp3/source-final.mp3`](cases/lyrics-ascii-016777210-ceiling-mp3/source-final.mp3), 16,796,249 bytes, SHA-256 `e7385ae886a18a109e46730615790e1d0272667244581973bfeae1eb1e4b2fbc`

The other large rewritten media files were fingerprinted in `summary.json` and deliberately not retained.

## Limits and gate status

This cohort establishes an adjacent exact-to-native-non-exact transition only for deterministic ASCII generated by this harness, fresh LAME MP3s, iTunes ID3v2.2 encoding-0 `ULT` rewrites, the COM `Lyrics` setter/readback path, and standalone x64 iTunes 12.13.10.3 on this Windows build. It is not a universal character limit, generic `Lyrics` support rule, UI limit, direct-file rule, arbitrary Unicode result, other-ID3-version rule, other-media result, or cross-version guarantee. Hidden caches and dependencies are not excluded. No independent implementation reproduced the behavior.

U-12 therefore remains open. U-01 through U-18 remain open, and `status.full_analysis_specification_gate`, `completion.gate_passed`, and `completion.independent_reimplementation_passed` remain false. Unknown conversions and unsupported paths must fail closed.
