# Deterministic trailer and coverage audit — 2026-09-25

## Scope

This evidence is a fixed-seed, reproducible differential mutation audit for the observed Windows iTunes `12.13.10.3` corpus. It compares:

- primary `itlkit.Container` in strict and forensic (`strict_size=False`) modes;
- primary semantic `itlkit.Library`;
- independent `REFERENCE_PARSER` envelope, semantic parser, and detector;
- independent `REFERENCE_WRITER` envelope reconstruction; and
- `VALIDATOR` structural/profile validation.

The seed is `0x20260925`. The matrix has **57 cases**, including **19 compressed-trailer cases**, plus four exact/one-below plaintext-budget probes and 14 writer cross-check configurations. Every generated fixture and native-evidence input is hash-pinned in [`report.json`](report.json). The audit reads but never modifies those inputs.

## Reproduce

From the repository root with the project dependencies installed:

```bash
python -B scripts/research/audit_trailer_coverage.py \
  --output /tmp/itl-trailer-coverage-report.json
cmp evidence/research/20260925/report.json \
  /tmp/itl-trailer-coverage-report.json
```

List or materialize an exact witness outside the repository:

```bash
python -B scripts/research/audit_trailer_coverage.py --list-cases
python -B scripts/research/audit_trailer_coverage.py \
  --case trailer-concatenated-zlib-member \
  --write-repro /tmp/trailer-concatenated-zlib-member.itl
```

`report.json` is intentionally free of timestamps, absolute repository paths, and environment-specific raw exception messages so independent regenerations are byte-identical.

## Results

- The primary and independent envelope decoders made the same accept/reject decision for all 57 cases. Whenever both accepted, the semantic-payload and trailer lengths and SHA-256 hashes matched.
- Opaque trailers of 1, 15, 16, 17, 31, 32, and 33 bytes survived exactly. The same held at AES flag/cap/block boundaries and after a one-bit trailer mutation.
- A complete concatenated second zlib member remains `unused_data`: neither decoder merges it into the first member's semantic payload.
- `VALIDATOR` now emits `scope.compressed_trailer` and reports exact trailer byte coverage with `semantically_validated: false`; a structurally valid trailer remains `valid: true`.
- Corrected-size zlib truncations and checksum corruption were rejected by both envelope decoders. Section/list/record length and offset mutations were rejected at semantic boundaries.
- The two outer declared-size mismatches produced one intentional differential only: `itlkit.Container(strict_size=False)` accepted them for forensic inspection, while all strict/high-level/reference paths rejected them.
- All four exact native-qualified generated hashes now parse and no-op round-trip through primary `Library`. Their zero secondary IDs at `mith+0x1f4` are preserved on read/no-op; duplicate nonzero values are still rejected, and semantic/structural edits still require nonzero secondary IDs.

## Negative and null findings

- No unexplained primary/reference envelope differential was found in this matrix.
- No trailer decoder, provenance, or independent semantic meaning was established.
- No mutated trailer, truncation, or corruption witness was run in native iTunes.
- No universal claim is made beyond the exact listed corpus/profile and mutations.

`U-13` therefore remains open. This evidence bounds the opaque trailer and makes the validator limitation explicit; it does not prove that any trailer is safely editable or natively accepted. `U-17` also remains open because this is a finite deterministic boundary matrix, not coverage-guided fuzzing or crash/power-loss testing.
