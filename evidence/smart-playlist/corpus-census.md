# Smart-playlist corpus census

> Evidence class: **native corpus observed**. The corpus contains only identified built-in/system smart definitions; it does not establish custom-rule semantics.

Regenerate from the repository root:

```powershell
python evidence/smart-playlist/census.py --write
```

## Coverage

| Measure | Value |
|---|---:|
| Tracked `.itl` files | 95 |
| Successfully parsed | 95 |
| Parse errors | 0 |
| Playlist instances with type 101/102/103 | 1235 |
| Unique type-101 payloads | 12 |
| Unique type-102 payloads | 2 |
| Unique type-103 payloads | 1 |

## Observed native invariants

- Version words: 0x00010001.
- Conjunction raw values: [0, 1].
- Rule data lengths: [68] bytes.
- Field IDs: 0x0000003C, 0x00000085, 0x000000A4.
- Action IDs: 0x00000001, 0x00000400, 0x00000800, 0x02000400.
- String-action candidates: 0.
- Nested-group candidates: 0.
- Nonzero `SLst` opaque headers: 0.
- Nonzero rule opaque headers: 0.
- `SLst` payloads with trailing bytes: 0.

## Content-addressed payload groups

| Group | Type | Bytes | Occurrences | Examples |
|---|---:|---:|---:|---|
| `mhoh-101-1c75dcec43f0618e` | 101 | 384 | 95 | Music, Music, Music |
| `mhoh-101-1e3c768a154c2a48` | 101 | 384 | 95 | Movies, Movies, Movies |
| `mhoh-101-4cedbe556f7f2163` | 101 | 508 | 95 | TV & Movies, TV & Movies, TV & Movies |
| `mhoh-101-6479eb50ff83361d` | 101 | 384 | 95 | Music Videos, Music Videos, Music Videos |
| `mhoh-101-678218eef5ae0494` | 101 | 384 | 95 | TV Shows, TV Shows, TV Shows |
| `mhoh-101-6acc96161792f80b` | 101 | 384 | 95 | Audiobooks, Audiobooks, Audiobooks |
| `mhoh-101-717ee12b245c0413` | 101 | 508 | 95 | Downloaded, Downloaded, Downloaded |
| `mhoh-101-905245d98e4a8084` | 101 | 384 | 95 | Home Videos, Home Videos, Home Videos |
| `mhoh-101-a4c8b4b034357287` | 101 | 384 | 95 | Rentals, Rentals, Rentals |
| `mhoh-101-b2dda0db3ca0d121` | 101 | 508 | 95 | Downloaded, Downloaded, Downloaded |
| `mhoh-101-e4e26eebdaecff05` | 101 | 136 | 95 | Genius, Genius, Genius |
| `mhoh-101-faeef2c69eee00dd` | 101 | 508 | 95 | Downloaded, Downloaded, Downloaded |
| `mhoh-102-15f5b9c419659b06` | 102 | 112 | 1045 | Downloaded, Music, Music Videos |
| `mhoh-102-bbb92df6ae83767d` | 102 | 112 | 95 | Genius, Genius, Genius |
| `mhoh-103-3464618c20ed05cd` | 103 | 16 | 95 | Podcasts, Podcasts, Podcasts |

Exact payload hex, lossless AST dumps, all occurrences, every source file hash, and validation results are in `corpus-census.json`.

## Interpretation boundary

The byte framing above is native-corpus evidence. Names such as AND/OR, string operators, dates, ranges, playlist membership, limit unit, selection order, live update, and nesting remain cross-format prior art or unresolved unless separately graded in `SMART_PLAYLIST_SPEC.md`.
