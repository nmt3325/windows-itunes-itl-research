# Retained ITL compressed-trailer census

This bounded offline audit checks every `.itl` entry currently listed in `DELIVERY-MANIFEST.json`, first verifying each retained byte length and SHA-256. All 430 manifest hashes verify. Of those files, 429 strictly parse and round-trip byte-exactly through `Container`; the one expected parse failure is the deliberately one-byte-truncated U-01 structural-negative input.

Across the 429 parsed files, 404 use compression flag 1 and 25 use flag 0. The parsed version distribution is 5 files reporting `12.12.10.1`, 392 reporting `12.13.10.3`, 12 native saves reporting `12.13.9.1`, and 20 native saves reporting `12.13.11.1`. The five 12.12.10.1 files are one same-build native-authored input, two normally-quit positive saves, and two force-terminated timeout survivors; they are retained occurrences, not five accepted cycles. The malformed negative is excluded from those parsed-file distributions.

Exactly one parsed retained file has nonempty compressed `unused_data`: the already documented, intentionally constructed 17-byte U-13 native-trailer candidate. Its trailer SHA-256 is `103ea800…16ab`. The other 428 parsed files have no compressed trailer.

This is a census of a curated delivery corpus containing related snapshots, controls, generated files, and research candidates—not a representative sample. It does **not** show that trailers are rare in real libraries, recover trailer meaning or provenance, justify discarding them, prove semantic independence, or establish native acceptance. The expected malformed-file refusal is structural/preflight evidence and not native iTunes rejection. No iTunes or proprietary binary was read or launched by this census. U-13 remains open, universal ITL support remains false, and semantic writes with opaque trailers remain refused.

Rebuild and verify:

```bash
python -B scripts/research/audit_retained_trailer_census_20260926.py
python -B -m pytest -q -p no:cacheprovider tests/test_retained_trailer_census_20260926.py
```
