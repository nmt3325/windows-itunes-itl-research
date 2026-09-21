# TEST_CORPUS

Deterministic one-track/one-playlist synthetic ITLs generated without `itlkit`.
Each `.itl` has a JSON sidecar that makes these facts machine-readable:

- whether an existing template header was reused;
- the template SHA-256 when reuse occurred;
- the generated file SHA-256 and size;
- independent structural-validation status;
- native acceptance status, which is always `unverified` unless separate real
  iTunes launch/save/reload evidence is added by a future process.

```powershell
python -m TEST_CORPUS generate output.itl
python -m TEST_CORPUS generate template-derived.itl --template known.itl
python -m TEST_CORPUS manifest --check
```

The checked-in `corpus-manifest.json` hashes every file under `generated/`.
