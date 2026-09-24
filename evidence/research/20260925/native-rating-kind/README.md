# Native RatingKind/Loved/Disliked replacement — 2026-09-25

This immutable bundle records a bounded native replacement experiment against the pinned template-free one-track ITL on standalone Windows iTunes 12.13.10.3. It separates type-library declarations, runtime COM attempts, native save/reload observations, raw ITL differences, and parser-only validation.

## Result

- Overall: **passed**.
- Cases: **7/7**.
- Native sessions: **20/20**.
- Rating ladder: `0, 20, 40, 60, 80, 100`.
- Started: `2026-09-24T16:43:50.136796+00:00`; finished: `2026-09-24T16:49:40.737500+00:00`.
- U-14 remains open; this bundle narrows it but does not close the UI, album-derived, Loved/Disliked, cross-version, or independent-reproduction factorials.

## Provenance and safety boundary

- Source report canonical JSON SHA-256 `b6881790a3eed66a07245c3ddddf6b3d7dfa1dfef10d91b65f3043114ed79051` (UTF-8 JSON; ensure_ascii=false; sorted keys; indent=2; LF terminator).
- Official entry: `https://www.apple.com/itunes/download/win64`; resolved HTTP `200` to `https://secure-appldnld.apple.com/itunes12/140-75773-20260908-6e5e0165-99cb-4b30-b541-1b615fccfc1a/iTunes64Setup.exe`.
- Installer: version `12.13.10.3`, 208064480 bytes, SHA-256 `cea2a74cae3f061eadc11358eeaae9b40cfdea9ec1ee037b47da54a64219e182`, Authenticode `Valid` (CN=Apple Inc., O=Apple Inc., L=Cupertino, S=California, C=US; thumbprint `5ABF5D5265D74C9EAD19246DFAB611AA5DCFE791`).
- Installed iTunes: version `12.13.10.3`, 38952912 bytes, SHA-256 `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`, Authenticode `Valid` (CN=Apple Inc., O=Apple Inc., L=Cupertino, S=California, C=US; thumbprint `5ABF5D5265D74C9EAD19246DFAB611AA5DCFE791`).
- Candidate: 10566 bytes, SHA-256 `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74`; target PID `A17E000000000001`.
- OS: `Windows-2025Server-10.0.26100-SP0`; Python `3.12.10`; pywin32 `312`; timezone `Coordinated Universal Time`.
- Every case used a fresh isolated profile junction and disposable case root. The known audio-configuration warning was the only dismissed UI; all other modal/fallback states failed closed.
- User data touched: `false`.

## COM capability result

| Member | Typelib get | Typelib put | Runtime get | Runtime same-value put | Classification |
| --- | --- | --- | --- | --- | --- |
| `Rating` | yes | yes | observed `0` | observed `0` | **`writable`** |
| `RatingKind` | yes | no | observed `1` | blocked `AttributeError`: Property '<unknown>.RatingKind' can not be set. | **`read_only`** |
| `AlbumRating` | yes | yes | observed `0` | observed `0` | **`writable`** |
| `AlbumRatingKind` | yes | no | observed `1` | blocked `AttributeError`: Property '<unknown>.AlbumRatingKind' can not be set. | **`read_only`** |
| `Loved` | no | no | blocked `AttributeError`: <unknown>.Loved | blocked `AttributeError`: Property '<unknown>.Loved' can not be set. | **`unsupported`** |
| `Disliked` | no | no | blocked `AttributeError`: <unknown>.Disliked | blocked `AttributeError`: Property '<unknown>.Disliked' can not be set. | **`unsupported`** |

Loved/Disliked interaction: **`blocked`** — Loved and Disliked did not both expose readable/writable runtime members. No interaction result was inferred from unavailable members.

## Rating save/reload ladder

Each value used a fresh baseline. `mutation` performed the first setter/save, `repeat` set the same value again in a restarted iTunes process, and `restart` reopened that exact save and verified without another rating write before normal Quit.

| Rating | Mutation SHA-256 | Same-value repeat SHA-256 | Restart-verification SHA-256 | Observed ratings |
| ---: | --- | --- | --- | --- |
| 0 | `f611af4ee5b22a5df19af6b740bf8a2b0b788e360200538dbe0eff92c53d38c2` | `fc25d37bf822d8db96e1f30420aacc4f78baaf392412308276f8983268f66f10` | `35b232a59bc882b23eb9a0fefb97b0bdc22612104cc0e40f394637345ab339f0` | `0/0/0` |
| 20 | `ac3bed7583373bd5b2e94ef18b88c84d0ee11d1863471c7d90ef852e8c1f1715` | `51842dfa26bf772fc62f93c05dffd8a44cb3d199da51d63b0729967e330e601d` | `245e630ac9c7135a8fb671f2223766c5a57bd1d187b37330c214507d660d49d7` | `20/20/20` |
| 40 | `50fbb732d2fe91c904da8ccad005930829ec98cbc6946b2e5d604f51557e0e52` | `060545612bc94c290f32e3351851e4181181860443e5ab1c9fc1041a9dc3caa6` | `cc66e054bdade9e9e374de573f6ef18bd8c7a76ccfdd41181f5930ded59dd0b4` | `40/40/40` |
| 60 | `fcfc1402f380d07bef83a259504bea8319f61a713d3d67b3bd97ba2e4c6ea3d1` | `54b6eebda11a6d1eb41538a5ddc98437825b13d4b0eb7c8bb9f3dfd3eccd6e32` | `b733fb302263f09ff677feb65b7eb7902e458341cb90e6f6c6842352d7a0047b` | `60/60/60` |
| 80 | `a9177fb07ad74d98403970b317f7c69b049007704d73a96c32b7366fef0c521d` | `78d4de3c2cb144184ef1d7aa49ede3d934bd6720a3c406057b8445078de5a46e` | `7eee360224e6ba229f8906dca01635b00567a3e451d2f769057ce559fdd55700` | `80/80/80` |
| 100 | `6937ec8e828c255af870990f3934499c8e12cea3958c35b566f70fa3525da48c` | `9482f80305e3d16835f142c53bdf63505434172090d2c629dd026b85dde7ff9d` | `afceb55926aee1d529bc3c4c3cc5ca3f09f34817fdba998d282dd01f26c05c25` | `100/100/100` |

All six cases began from baseline SHA-256 `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74`. For values 20–100, COM projected `Rating/RatingKind/AlbumRating/AlbumRatingKind` from `0/1/0/1` before the write to `value/0/value/1` afterward; that projection was stable through the same-value save and the verification restart. Rating 0 remained `0/1/0/1`. This is a one-track derived-album observation, not a general album rule.

## Byte and record observations

| Rating | Baseline→mutation raw/header changed bytes | Mutation→repeat raw/header | Repeat→restart raw/header |
| ---: | ---: | ---: | ---: |
| 0 | 10415/11 | 3980/0 | 3525/0 |
| 20 | 10420/12 | 3987/0 | 3616/0 |
| 40 | 10404/12 | 3980/0 | 3854/0 |
| 60 | 10413/12 | 3988/0 | 3688/0 |
| 80 | 10412/12 | 3986/0 | 3899/0 |
| 100 | 10417/12 | 3969/0 | 3897/0 |

For nonzero mutations the targeted 756-byte `mith` header added exactly one rating-byte change at `mith+0x6c`: `00→14/28/3c/50/64`. The other 11 baseline-to-first-save header changes are native canonicalization/bookkeeping shared with the zero/probe controls. Every mutation→repeat and repeat→restart targeted header diff was zero bytes. Whole encrypted ITL hashes still changed on each save, so this is semantic/target-header repeat stability, not whole-file byte idempotence.

Across all analyzed snapshots, `mith+0x6d` (`name_refresh_flag_raw`) remained 0 and the bounded legacy byte at `mith+0x2bf` remained 0 with bit `0x02` clear. Those unchanged sentinels do not establish Loved/Disliked semantics.

## Validation and gates

- `27` targeted analyses covering `21` unique snapshot hashes; `27` passed the primary targeted parser, independent reference parser, and VALIDATOR, and `27` reported validator-valid.
- High-level `Library` outcomes: `{"blocked": 7, "observed": 20}`. The raw baseline was blocked by the high-level semantic model, while bounded low-level targeted parsing and independent validation passed; no universal/native acceptance is inferred from structure alone.
- Saved snapshot validations: `20/20`.
- All 20 workers and iTunes processes exited 0, all sessions requested normal Quit, all before/after samples were stable, all identity gates passed, and zero forbidden fallback artifacts were observed.

## Evidence layout

- `report.json`: complete aggregate provenance, operations, samples, raw/record diffs, and gates.
- `oracle.json`: compact machine-readable conclusion derived from `report.json`.
- `cases/<case>/case-result.json`: per-case aggregate.
- `cases/<case>/<phase>/`: worker specification/result, operation/UI log, and immutable native-saved ITL.
- `pinned-baseline.itl` and `cases-input.json`: exact input and requested matrix.

## Claim boundary

- This is one standalone Windows iTunes 12.13.10.3 build and one pinned one-track ITL profile.
- RatingKind and AlbumRatingKind were observed as read-only COM projections, not writable controls.
- Loved and Disliked were absent from the inspected file-track typelib and unavailable at runtime, so their interaction sequence was blocked.
- Raw ITL bytes changed between semantically equal saves; targeted record-header stability is not whole-file byte idempotence.
- Targeted structural validation does not establish universal native acceptance or complete opaque-byte semantics.
- UI factorials, direct Loved/Disliked transitions, album-derived factorials, additional media/track shapes, other versions, and independent reproduction remain open.
