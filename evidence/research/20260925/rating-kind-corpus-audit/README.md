# RatingKind / AlbumRatingKind retained-corpus audit (2026-09-25)

## Result

In this frozen corpus, non-zero values coexist with both raw kind codes. The exact album-rating-explicit witness has Rating=60/RatingKind=1 and AlbumRating=60/AlbumRatingKind=0; the rating-explicit witness has Rating=80/RatingKind=0 and AlbumRating=80/AlbumRatingKind=1. Therefore neither kind can be inferred from zero/non-zero value alone.

This is a deterministic census of frozen JSON evidence. It did not launch iTunes or modify native evidence. Raw occurrences are reproducibility counts, not independent runs.

| Rating | RatingKind | AlbumRating | AlbumRatingKind | raw occurrences | first witness |
|---:|---:|---:|---:|---:|---|
| 0 | 1 | 0 | 1 | 1171 | `evidence/independent/itl-rs-20260922/native-accepted/cases/itl-rs-zlib-roundtrip/cycle-1/com.json#/samples/0/state/tracks/0` |
| 60 | 1 | 60 | 0 | 21 | `evidence/native/field-matrix-20260922/cases/album-rating-explicit/expected-reload-state.json#/tracks/0` |
| 80 | 0 | 0 | 1 | 36 | `evidence/native/oracles/115-fresh-diagnostic-reload/com.json#/after/tracks/0` |
| 80 | 0 | 80 | 1 | 78 | `evidence/native/field-matrix-20260922/cases/rating-explicit/expected-reload-state.json#/tracks/0` |

## Evidence boundary

- JSON files: **344**
- raw matching objects: **1306**
- distinct joint states: **4**
- input file-set SHA-256: `c4a60795026f58d5ee7a4b71ac63bad7efb2af4ddceb068d543af138ad221404`
- repeated summary/result copies are explicitly not counted as independent experiments

The retained `album-rating-explicit` state is the decisive counterexample to a zero/non-zero shortcut: a non-zero track Rating of 60 has raw RatingKind 1 while the explicit AlbumRating 60 has raw AlbumRatingKind 0. Conversely, `rating-explicit` retains AlbumRating 80 with raw AlbumRatingKind 1. Value and kind must therefore remain separate fields.

Historical iTunes COM documentation at https://documentation.help/iTunesCOM/documentation.pdf names codes 0/1 as user/computed and documents `RatingKind` as read-only. That naming is prior art; the state table and witnesses come from repository evidence.

## What remains open

This audit does not cover Loved/Disliked transitions, does not attempt kind setters, does not map COM state to an ITL byte, and does not generalize beyond the fixed retained corpus. **U-14 remains open.**

## Reproduce

```bash
python scripts/research/audit_rating_kind_corpus_20260925.py
python -m pytest -q -p no:cacheprovider tests/test_rating_kind_corpus_20260925.py
```
