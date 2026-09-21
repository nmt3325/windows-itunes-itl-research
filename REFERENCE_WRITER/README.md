# REFERENCE_WRITER

This boundary is intentionally narrower than the main codec. `convert` accepts a
recognized file only when `--to-version` exactly equals its source version and
then publishes a byte-exact new file. Any cross-version request fails before an
output is created.

```powershell
python -m REFERENCE_WRITER convert input.itl copied.itl --to-version 12.13.10.3
```

`encode_envelope()` exists for deterministic synthetic test generation. A file
built with it is never considered native-accepted merely because the independent
parser can read it.
