# U-13 trailer negative matrix (2026-09-26)

This research-only offline audit extends the 2026-09-25 compressed-trailer coverage with a deterministic negative/control matrix. It uses repository-local synthetic mutations of the exact native-qualified `reference-one-track-zlib.itl` fixture and reuses [`scripts/research/audit_trailer_coverage.py`](../../../../scripts/research/audit_trailer_coverage.py) as the comparison/evaluation driver.

## Retained result

- Report: [`report.json`](report.json)
- Report SHA-256: `080d2729d3aee2112e402fc863c35e23ee5b7cf1ccba934a32b99017ce26e1af`
- Generator: [`scripts/research/audit_trailer_negative_matrix_20260926.py`](../../../../scripts/research/audit_trailer_negative_matrix_20260926.py)
- Generator SHA-256: `5596fc21198d2f449df7b82018ef7d8063ad3d1fe0d34cb07a32033d2d711f2d`
- Regression test: [`tests/test_trailer_negative_matrix_20260926.py`](../../../../tests/test_trailer_negative_matrix_20260926.py)

## Matrix

The retained matrix has 17 offline case scenarios:

- 3 multi-member zlib cases
- 4 reference-looking opaque tail cases
- 3 outer-size/trailer-boundary collision cases
- 4 AES cap / `unused_data` intersection cases
- 3 public-prior-art analogue tail cases

Fourteen cases are structurally valid compressed-trailer candidates. Each one retains an exact trailer hash, emits `scope.compressed_trailer`, and refuses the semantic write gate. Three outer-size collision cases intentionally set the declared outer file size to the trailer-free length; strict envelope readers reject while the relaxed container can still observe the hidden boundary.

## Boundary

This is not native acceptance and not trailer closure. The matrix performs zero native iTunes operations, zero proprietary binary reads, zero network operations, zero power-loss operations, and zero production code changes. Reference-looking and public-prior-art-themed tails are byte-pattern controls only; they do not prove historical replay, native meaning, or semantic independence. U-13 remains open.

Focused verification used:

```bash
python -B -m pytest tests/test_trailer_negative_matrix_20260926.py -q -rs -p no:cacheprovider --basetemp /tmp/itl-u13-neg-tests
```

Result: `3 passed`.
