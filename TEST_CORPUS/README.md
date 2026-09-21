# TEST_CORPUS

Deterministic one-track synthetic ITLs generated without `itlkit` or native template bytes. The current profile includes one master playlist, one ordinary playlist, one album record, and one artist record.

Each `.itl` has a JSON sidecar recording template use, output SHA-256 and size, structural validation, and exact-hash native qualification. Two checked-in outputs are native-qualified:

| File | Envelope | SHA-256 | Native evidence |
| --- | --- | --- | --- |
| `generated/reference-one-track-raw.itl` | raw, unencrypted | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` | 2/2 cycles passed |
| `generated/reference-one-track-zlib.itl` | zlib, AES flag 2, cap 102400 | `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad` | 2/2 cycles passed |

The retained evidence is under [`../evidence/native/reference-generated-20260922-passed/`](../evidence/native/reference-generated-20260922-passed/). Qualification is exact-output only. Changing a name, path, count, record, flag, version, or template makes the output `unverified` until separately tested.

```powershell
python -m TEST_CORPUS generate output.itl
python -m TEST_CORPUS generate template-derived.itl --template known.itl
python -m TEST_CORPUS manifest --check
```

The checked-in `corpus-manifest.json` hashes every file under `generated/`. Cross-version generation fails closed.
