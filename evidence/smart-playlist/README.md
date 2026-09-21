# Smart-playlist evidence bundle

This directory separates evidence classes so a cross-format analogy cannot be
mistaken for a Windows-native fact.

## Files

- `census.py` — deterministic generator over every tracked `.itl` file.
- `corpus-census.json` — content-addressed payloads, complete occurrences,
  source-file hashes, lossless AST dumps, and validation results.
- `corpus-census.md` — human-readable census summary.
- `prior-art-manifest.json` — pinned public iPod/iTunesDB references with exact
  commits, file SHA-256 values, and claim boundaries.
- `static-evidence.json` — the narrow Windows static-analysis corroboration and
  explicit negative boundary.

The normative interpretation and feature-by-feature confidence table are in
`../../SMART_PLAYLIST_SPEC.md`.

## Regenerate

From the repository root:

```powershell
python evidence/smart-playlist/census.py --write
python -m pytest -q tests/test_smart_playlists.py
```

A clean regeneration currently reports:

- 95 tracked ITL files;
- 95 successfully parsed, zero errors;
- 1,235 playlist instances with type 101/102/103;
- 12 unique type-101 payloads;
- 2 unique type-102 payloads;
- 1 unique type-103 payload;
- fields `0x3C`, `0x85`, `0xA4` only;
- actions `0x00000001`, `0x00000400`, `0x00000800`, and `0x02000400` only;
- no native string, date, range, membership, variable-length, or nested rule.

## Trust boundary

`corpus-census.*` is **native-corpus-observed** evidence for Windows iTunes
12.13.10.3 byte structure. `prior-art-manifest.json` is
**cross-format-prior-art** only. Synthetic fixtures in the test suite establish
parser behavior, not native compatibility.

No corpus record should be edited in place. The included parser is read-only at
the semantic layer and preserves unknown bytes exactly.
