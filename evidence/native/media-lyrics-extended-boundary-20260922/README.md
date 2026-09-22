# Extended MP3-backed `Lyrics` ASCII persistence matrix

**Disposition: bounded native positive evidence through one exact 65,536-character ASCII value. This is a measured lower acceptance bound, not an upper boundary.**

Standalone Windows x64 iTunes 12.13.10.3 accepted and restart-persisted exact ASCII `Lyrics` values at 32,767, 32,768, 65,535, and 65,536 characters on fresh deterministic MP3-backed tracks. All sixteen native sessions passed.

## Pinned run

- Run window: `2026-09-22T04:37:39.093294+00:00` through `2026-09-22T04:42:15.359838+00:00`
- Platform: Windows Server 2025 / NT 10.0.26100, Python 3.12.10
- iTunes: standalone Apple desktop x64 `12.13.10.3`
- iTunes executable SHA-256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- Capture harness: 38,863 bytes, SHA-256 `fe8c1b14093424f4a201d50558df6273bebeed84251a5643707389dc6fc244cf`
- Native driver: 5,959 bytes, SHA-256 `3b33a0ddb405567d0176e71ca774bcb0077358eefea39d62016e56479b3233eb`
- Case matrix: 197,145 bytes, SHA-256 `433a573ee668d9cd80736f0bff0068c09ce2936bb85bf094a36684d61cf9a102`
- Captured summary: [`summary.json`](summary.json), 4,077,706 bytes, SHA-256 `18500297b2f50bd0abd6c65acfce16742edcbaec100e15a9ef8b4c47d590d05d`
- Aggregate result: `passed=4`, `failed=0`, `status=passed`
- MP3 encoder: `lameenc==1.8.1`; wheel SHA-256 `715e0e72ed5429f00042379e48a7903e54ee5dc01069db34338536f3595059c3`; loaded module SHA-256 `ff9f47ecfc0b167e2e3e4edacaeb23aa0b10422ef4cc180d52ae3b86ff7636dc`

## Exact cases

| Case | Characters / UTF-8 bytes | Value SHA-256 | Rewritten MP3 bytes | Rewritten MP3 SHA-256 |
| --- | ---: | --- | ---: | --- |
| `lyrics-ascii-032767-mp3` | 32,767 | `fbd16d329b4dcd2db62505f65b31e4686f0a57ddd474cd49fe19071c466da082` | 51,806 | `5bfd4829dbe193213f38d5a526f0e9b892f0d73e8c54937eafac39de24c26eae` |
| `lyrics-ascii-032768-mp3` | 32,768 | `cf21ba8078e1bfad7514510aafdc89cf27fe711782292fbd3e41366b72ac6a3d` | 51,807 | `22996cf5f8410e8f20e43c654dcb6e89b452ec595ab088942f722d67c96bf7a3` |
| `lyrics-ascii-065535-mp3` | 65,535 | `aa079770da9b53d4ef51f329cb8527e07f02573d7a297402c3d35db943fbb632` | 84,574 | `f31c2394d8e9e4eadf68df0118a3b058e00b28541ea5e6b21e1d07a9c548648d` |
| `lyrics-ascii-065536-mp3` | 65,536 | `4380ed69803f6831900006a230157a02346a53a01d2706cb70d07564302f3a93` | 84,575 | `b8f8313c191728989a4b69d1eadbf681a6125ddd444f048091c3cd309e7faf40` |

Every case used a fresh native profile and fresh deterministic MP3. Initialize, baseline restart, mutation, and verification restart each required complete stable COM snapshots, exact library/master/track identities and membership, normal `Quit()`, exit 0, no fallback artifacts, and independent parse/validation. The exact requested value survived the mutation and a separate restart in all four cases.

## Exact 65,536-character tag analysis

[`ascii-065536-id3-rewrite-analysis.json`](ascii-065536-id3-rewrite-analysis.json) strictly parses the largest retained case and has SHA-256 `43ca039f2dd4c3efc59b57168f12c3c3a4f10b60f76f5f30b249d0c186ad9671`.

- Native output is ID3v2.2 with one `ULT` frame, encoding 0 (`ISO-8859-1`), language `eng`, and an empty descriptor.
- The exact text is 65,536 bytes plus one trailing NUL; the `ULT` payload is 65,542 bytes.
- The tag payload is 75,788 bytes and retains 10,240 zero-padding bytes; the audio offset is 75,798.
- The final MP3 is 84,575 bytes.
- The rewritten tail is exactly 8,777 bytes and byte-identical to the complete original MP3, SHA-256 `b9068ba5e9dc2228e5da2102a0f65a02aa790c50472de7901d7cc6922c3bd5e4`.

## Qualified conclusion and limits

The 32,767/32,768 and 65,535/65,536 transitions did not truncate on this exact COM/media/restart path. Combined with the preceding cohort, the measured exact ASCII acceptance lower bound is 65,536 characters.

No failing case above 65,536 was run, so this is not an upper limit, rejection boundary, or proof of unbounded support. It does not establish generic `Lyrics` support, arbitrary Unicode behavior, UI limits, another media/tag shape, another version, or an ITL-only write rule. Unknown conversions and larger values must remain fail-closed.

U-12 remains open because the upper acceptance/rejection and truncation boundary is unknown. U-01 through U-18 remain open, and `status.full_analysis_specification_gate`, `completion.gate_passed`, and `completion.independent_reimplementation_passed` remain false.
