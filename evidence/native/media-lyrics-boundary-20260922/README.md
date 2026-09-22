# MP3-backed `Lyrics` Unicode and ASCII persistence matrix

**Disposition: bounded native positive evidence for seven exact MP3/property/value cases. It establishes exact persistence for the tested values, not a universal limit or generic `Lyrics` support.**

Standalone Windows x64 iTunes 12.13.10.3 accepted one Unicode `Lyrics` value and six ASCII values from 255 through 16,384 characters on fresh deterministic MP3-backed tracks. Every initialize, baseline restart, mutation, and verification-restart session passed with exact values and stable identities.

## Pinned run

- Run window: `2026-09-22T04:28:24.307298+00:00` through `2026-09-22T04:36:28.695615+00:00`
- Platform: Windows Server 2025 / NT 10.0.26100, Python 3.12.10
- iTunes: standalone Apple desktop x64 `12.13.10.3`
- iTunes executable SHA-256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- Capture harness: 38,863 bytes, SHA-256 `fe8c1b14093424f4a201d50558df6273bebeed84251a5643707389dc6fc244cf`
- Native driver: 5,959 bytes, SHA-256 `3b33a0ddb405567d0176e71ca774bcb0077358eefea39d62016e56479b3233eb`
- Case matrix: 31,164 bytes, SHA-256 `5bf6203f40776dc833f8e9981f5e696885ef82a87bc54a966026a2d992faeb2f`
- Captured summary: [`summary.json`](summary.json), 1,791,723 bytes, SHA-256 `0c3d829bf5304839629338b9540bd55198bda0c6ebbff8d4c82b40ffd8ac8526`
- Aggregate result: `passed=7`, `failed=0`, `status=passed`
- MP3 encoder: `lameenc==1.8.1`; wheel SHA-256 `715e0e72ed5429f00042379e48a7903e54ee5dc01069db34338536f3595059c3`; loaded module SHA-256 `ff9f47ecfc0b167e2e3e4edacaeb23aa0b10422ef4cc180d52ae3b86ff7636dc`

## Exact cases

| Case | Characters | UTF-8 bytes | Value SHA-256 | Rewritten MP3 bytes | Rewritten MP3 SHA-256 |
| --- | ---: | ---: | --- | ---: | --- |
| `lyrics-unicode-mp3` (`Line one — 第二行 🎤`) | 16 | 27 | `aafc769292af6a484412c674a2d2dc913e34336ee75a5a4db9d20f7297a998fb` | 19,079 | `2fa3178772a312a426289c5264436eb0997b287f659e514f31d19fa0d03c5803` |
| `lyrics-ascii-00255-mp3` | 255 | 255 | `30d2fe575e97c8934158a39a68f7e396d69ebbdf15003a6292cca8a0ae66fbc5` | 19,294 | `67a18b1034bbaf407adcec528dc58ffd0a85ba4818e7241c29dc45ea8e33da45` |
| `lyrics-ascii-00256-mp3` | 256 | 256 | `3b0dbdf2cb0fd6469ca690141f9533e5e27ccdffc247b2eb2a75d2dff63925d1` | 19,295 | `679c6c77ce251808ad6d319d0808f9906f63ddd142fa662840e021f0f3c2bfd5` |
| `lyrics-ascii-01024-mp3` | 1,024 | 1,024 | `b7733cd8cd8d0b32c440a3a9bd73a9e9ff9d8392a55c57003ddba18f8a443783` | 20,063 | `6623ca7cc2c63e77dd3da258a37389734a118256009666c236666eb5f5ca390c` |
| `lyrics-ascii-04096-mp3` | 4,096 | 4,096 | `e645110fd1e3930f11599b0b311e839090ace065ab34eb118d6f27bee0f33403` | 23,135 | `dcfd640427b515af6e3fe7ff170f145646fa2ac3e20d5baa0944e83ff420f190` |
| `lyrics-ascii-08192-mp3` | 8,192 | 8,192 | `baf33a297796911a5721d29f9e3c75045809d9d1b53d212fba27198709369634` | 27,231 | `4d1fb77b00d8a068f23abca2d44938ec05cefc26771f87f13d0e3480d7bccb94` |
| `lyrics-ascii-16384-mp3` | 16,384 | 16,384 | `cfac56946cf95e4dfba739e16c6d563413a4f0963d53fface191d8e0a4d7b097` | 35,423 | `4ad720729a90c06eb2a336c83891bee2f82177b5724578bbabcae2260390379d` |

Each case used a fresh native profile and fresh deterministic MP3. The four sessions required complete stable COM snapshots, exact library/master/track identities and membership, normal `Quit()`, process exit 0, no fallback artifacts, and independently parseable/valid native-saved ITLs. Media changes were allowed only during mutation. All seven cases converged on post-mutation read 3 using equal adjacent reads 2 and 3 and then returned the exact value after a separate restart.

## Exact Unicode tag analysis

[`unicode-id3-rewrite-analysis.json`](unicode-id3-rewrite-analysis.json) is a strict, fail-closed parse of the retained Unicode case and has SHA-256 `31f5523f0b20bbd88eefc82776fef01dd26d27a19b85c88ec4e062ff096ea19c`.

- Native output begins with ID3v2.2 (`ID3 02 00 00`) and has one `ULT` frame.
- Encoding byte is 1 (`UTF-16 with BOM`), language is `eng`, and the descriptor is empty.
- Descriptor storage is UTF-16LE BOM plus aligned terminator; text storage has its own UTF-16LE BOM and trailing UTF-16 NUL.
- The frame payload is 46 bytes; decoded text is exactly 16 code points / 27 UTF-8 bytes.
- The tag retains 10,240 zero-padding bytes.
- The rewritten tail at offset 10,302 is exactly 8,777 bytes and byte-identical to the complete original MP3, SHA-256 `65b52508d41ce3afa44a2edb92861d6d66dd0d428d22e99d61dfd51b3a298e44`.

## Qualified conclusion and limits

The 255/256 transition did not truncate, and the tested Unicode string persisted exactly. This cohort establishes a lower accepted point of 16,384 ASCII characters for this exact MP3-backed COM/restart path. The companion extended cohort raises that lower point to 65,536 characters.

No failing upper case was measured. These cases do not establish an acceptance/rejection ceiling, arbitrary Unicode coverage, UI behavior, other field/media/tag shapes, direct ITL writing, hidden-cache absence, or cross-version behavior. The WAV failures remain valid negative evidence for their exact inputs.

U-12 therefore remains open. U-01 through U-18 remain open, and all strict completion gates remain false.
