# REFERENCE_WRITER

This boundary is intentionally narrower than the main codec. `convert` accepts a recognized file only when `--to-version` exactly equals its source version and then publishes a byte-exact new file. Any cross-version request fails before an output is created.

```powershell
python -m REFERENCE_WRITER convert input.itl copied.itl --to-version 12.13.10.3
```

`encode_envelope()` provides deterministic raw/zlib/AES envelope construction. Envelope construction alone is not native qualification. [`../TEST_CORPUS/generate.py`](../TEST_CORPUS/generate.py) adds the bounded 12.13.10.3 record profile and constructs two template-free fixtures whose exact hashes passed two isolated native cycles. Other hashes remain unverified; this does not establish arbitrary new-library generation or complete analysis/specification.
