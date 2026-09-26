# Sort/rank/cache regeneration audit (2026-09-25)

## Scope and reproduction

This is a deterministic offline audit of retained evidence. It launched no native application and imported no Windows automation or production `itlkit` code. The structural path is `REFERENCE_PARSER/core.py`; every consumed file, byte length, and SHA-256 is in `input-manifest.json`.

```bash
python3 scripts/research/audit_sort_rank_20260925.py --repo-root . --output-dir evidence/research/20260925/sort-rank-audit
```

Outputs are deterministic: `input-manifest.json`, `census.json`, `audit.json`, and this README. Re-running the command in a second output directory must produce byte-identical files.

## Counting boundary

- The 9 selected field-matrix cases are 9 archived native cases. Each mutation/verification pair is two save stages of one case, not two independent native runs.
- The 6 phase3 chains are 6 archived native acceptance cases. A candidate is a synthetic pre-native input; reload1/reload2 are stages of the same case.
- Summary JSON, COM projections, copied snapshots, and repeated track/text records are derived or repeated occurrences, not additional native runs.
- The census contains 94 raw track occurrences across 37 ITLs; this number is not a native-run count.

## Direct wire observations

The bounded 756-byte `mith` profile contains seven observed little-endian DWORDs at `+0x290/+0x294/+0x298/+0x29c/+0x2a0/+0x2a4/+0x2a8`. Static reader/writer evidence maps those bytes to common-track `+0xe0/+0xe4/+0xe8/+0xec/+0xf0/+0xf4/+0xf8`. Calling them rank/cache-like is bounded terminology; consumer meaning and a universal collation algorithm remain unproved.

| Archived case | mutation vector | verification vector | exact 0→1000 offsets |
|---|---|---|---|
| `name-unicode` | `[0, 1000, 1000, 1000, 1000, 1000, 1000]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | 0x290 |
| `sort-name` | `[0, 1000, 1000, 1000, 1000, 1000, 1000]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | 0x290 |
| `sort-artist` | `[1000, 1000, 0, 1000, 1000, 1000, 0]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | 0x298, 0x2a8 |
| `sort-album` | `[1000, 0, 1000, 1000, 1000, 1000, 1000]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | 0x294 |
| `sort-album-artist` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | none |
| `artist-unicode` | `[1000, 1000, 0, 1000, 1000, 1000, 0]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | 0x298, 0x2a8 |
| `album-unicode` | `[1000, 0, 1000, 1000, 1000, 1000, 1000]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | 0x294 |
| `album-artist-unicode` | `[1000, 1000, 1000, 1000, 1000, 0, 0]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | 0x2a4, 0x2a8 |
| `composer-unicode` | `[1000, 1000, 1000, 1000, 0, 1000, 1000]` | `[1000, 1000, 1000, 1000, 1000, 1000, 1000]` | 0x2a0 |

Observed pairings on the first save are: Name/SortName→`+0x290`; Album/SortAlbum→`+0x294`; Artist/SortArtist→`+0x298` and `+0x2a8`; AlbumArtist→`+0x2a4` and `+0x2a8`; Composer→`+0x2a0`. The verification save restored each observed zero to 1000. `SortAlbumArtist` is the decisive counterexample: its text atom was present and accepted while the vector stayed all-1000 in both saves.

Phase3 independently supplies pre-native→first-save regeneration witnesses and first-save→second-save stability witnesses. It also shows nontrivial values (for example 125/250/500/750 and reordered 1000-step values), so neither global zeroing nor copying text atom IDs is justified.

## Text presence and Unicode

Within the exact audited cohort, target text fields have missing and nonempty serialized states but no empty text atom. Therefore empty-string behavior is a negative result/gap, not something this audit generalizes from missing atoms. The Name witness `Field Matrix 名称 🎵 é` remains decomposed for the final `é` (NFD and not NFC) across both saves, with byte-identical UTF-16LE text payload. Other retained Unicode witnesses include NFC Japanese and supplementary-plane emoji. Encoding choice is observed per atom, not inferred as a normalization rule.

## Result and limits

- **No production edit rule was added.** The evidence establishes exact transitions for this cohort but not a safe universal regeneration algorithm.
- **U-10 remains open.** Missing factorials include serialized empty atoms, missing Name, script/case/compatibility and normalization variants, SortComposer/native-sort-index candidates, multi-track ties/collation, and consumer/system-view mapping.
- Structure, correlation, and archived acceptance do not prove universal semantics or native acceptance for a newly generated rule.
- Existing retained evidence was read and hashed only; it was not overwritten.

See `audit.json` for witnesses/counterexamples and `census.json` for every parsed track, atom state/raw hash, vector, and playlist/system-view record hash.
