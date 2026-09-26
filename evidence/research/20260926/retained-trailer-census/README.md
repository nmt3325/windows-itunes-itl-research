# Retained ITL compressed-trailer census

This bounded offline audit parses every `.itl` entry currently listed in `DELIVERY-MANIFEST.json`, first verifying each retained byte length and SHA-256. All 390 files parsed strictly and round-tripped byte-exactly through `Container`: 367 use compression flag 1 and 23 use flag 0; all report version `12.13.10.3`.

Exactly one retained file has nonempty compressed `unused_data`: the already documented, intentionally constructed 17-byte U-13 native-trailer candidate. Its trailer SHA-256 is `103ea800…16ab`. The other 389 retained files have no compressed trailer.

This is a census of a curated delivery corpus containing related snapshots, controls, generated files, and research candidates—not a representative sample. It does **not** show that trailers are rare in real libraries, recover trailer meaning or provenance, justify discarding them, prove semantic independence, or establish native acceptance. No iTunes or proprietary binary was read or launched. U-13 remains open, universal ITL support remains false, and semantic writes with opaque trailers remain refused.

Rebuild and verify:

```bash
python -B scripts/research/audit_retained_trailer_census_20260926.py
python -B -m pytest -q -p no:cacheprovider tests/test_retained_trailer_census_20260926.py
```
