# Template-free reference fixture native qualification

This directory is the retained strict two-cycle qualification for the two exact generator outputs. It is hash-bounded evidence, not a claim of complete Windows ITL analysis.

## Environment

- iTunes: standalone desktop x64 `12.13.10.3`
- iTunes executable SHA-256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- Windows: Server 2025 build `10.0.26100`, `en-US`, UTC
- Harness: `scripts/windows/reference_generated_native.py` with a three-second post-readiness modal settling gate

## Exact results

| Fixture | Initial SHA-256 | Cycle 1 native save | Cycle 2 native save | Result |
| --- | --- | --- | --- | --- |
| `reference-one-track-raw` | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` | `ee6023fd4eca0a8beaa249863e090c7fccee9644f6d512c43ccbde377aaad108` | `9c0e792fd09c23e1561a2b47275154901f1e4926edc7c535eecc5c01b2e7f00e` | 2/2 passed |
| `reference-one-track-zlib` | `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad` | `e764e9c84c26771afcd5139c2bea368421dcad3e0915b5a63168eaebdd220f3f` | `9cdfeeab09ae3437a351977daff2bac1803fe502720a831960bb8021dacf3476` | 2/2 passed |

Each cycle required exact library/track/playlist identities, two stable COM samples, normal iTunes `Quit`, exit code 0, and successful independent parsing/validation of the saved ITL. Cycle 2 began from the exact cycle-1 save.

## Isolation gates

- The initial live profile inventory contained only the candidate `iTunes Library.itl`.
- XML was absent and forbidden.
- `Previous iTunes Libraries` was absent and forbidden.
- Repair, rebuild, migration, damaged-library, and all unknown modal dialogs were forbidden.
- Only the exact known one-button audio-configuration warning could be dismissed.
- No forbidden artifacts were observed before or after any cycle.

## Boundary

The exact raw and zlib hashes above are native-qualified template-free generation fixtures. Arbitrary field combinations, arbitrary counts, other media kinds, other versions/editions, full smart-playlist semantics, all unknown bytes, and independent reimplementation remain unresolved. The repository therefore remains an evidence-bounded research checkpoint and compatible editor, not “complete analysis/specification.”
