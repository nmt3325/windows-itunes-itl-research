# Three-track template-free native qualification

This directory retains the strict two-cycle qualification of two exact three-track outputs from the independent template-free generator. It extends the finite fixture set; it does not establish arbitrary multi-track generation or complete ITL analysis.

## Environment

- iTunes: standalone desktop x64 `12.13.10.3`
- iTunes executable SHA-256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- Windows: Server 2025 build `10.0.26100`, `en-US`, UTC
- Harness: `scripts/windows/reference_generated_native.py`
- Manifest: `scripts/windows/reference_generated_multi_track_cases.json`

## Exact results

| Fixture | Initial SHA-256 | Cycle 1 native save | Cycle 2 native save | Result |
| --- | --- | --- | --- | --- |
| `reference-three-track-raw` | `7d9b274765471d2d77440049273b210138e36b998d39d4790fe750d60c32406b` | `091f606e730ae0e6befb5cb3403decad74beda9454e2eb82e3fccff78fd67c99` | `6c2604775a87a8558a492f326c56af3b7b95b5220686f38611186061c73cfad5` | 2/2 passed |
| `reference-three-track-zlib` | `73dbb405fbd2b68b62d29913b697a72100f8606cdb2ee704c55908e4de389e17` | `09cd4f08145a4b2d914f20489d1213f71685344b87722d59d0f02041fb84f834` | `3c31307ff0e2ef5e7255068c679741c23d7f6d4a4c63ee41681cf4ca9ad99547` | 2/2 passed |

Both candidates use deterministic local track IDs `1..3`, track PIDs `A17E100000000001..3`, one album local ID `5`, one artist local ID `6`, master/ordinary playlist local IDs `7/8`, and ordered master plus ordinary membership `[1, 2, 3]`. The names cover Japanese text, emoji, and one decomposed `e` + U+0301 sequence.

Each cycle required exact file, track, and ordinary-playlist persistent identities; exact Unicode names; ordered membership; two stable COM samples; normal iTunes `Quit` with exit code 0; no fallback artifacts; and successful independent parsing/validation of the native save. Cycle 2 started from the exact cycle-1 save.

## Isolation gates

- The initial isolated profile contained only the candidate `iTunes Library.itl`.
- XML, `Previous iTunes Libraries`, damaged-library artifacts, identity fallback, and unknown modal dialogs were forbidden.
- Only the known one-button audio-configuration warning could be dismissed.
- No forbidden artifact appeared before or after any cycle.

## Boundary

Qualification attaches only to the two initial hashes above. Together with the earlier one-track cohort, four exact template-free hashes now pass two cycles each. This does not qualify arbitrary counts up to 16, arbitrary identities or strings, media/location construction, other versions or editions, unknown fields, audible playback, or a genuinely independent interoperable semantic implementation. U-01 through U-18 and the strict complete-analysis/specification gate remain open.
