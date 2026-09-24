# TEST_CORPUS

Deterministic one-to-sixteen-track synthetic ITLs generated without `itlkit` or native template bytes. The bounded 12.13.10.3 profile includes one master playlist, one ordinary playlist, one album record, and one artist record; invalid counts and empty/NUL-containing names fail closed.

Each `.itl` has a JSON sidecar recording template use, output SHA-256 and size, structural validation, and exact-hash native qualification. Four checked-in outputs are native-qualified:

| File | Envelope / tracks | SHA-256 | Native evidence |
| --- | --- | --- | --- |
| `generated/reference-one-track-raw.itl` | raw, unencrypted / 1 | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` | 2/2 cycles passed |
| `generated/reference-one-track-zlib.itl` | zlib, AES flag 2, cap 102400 / 1 | `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad` | 2/2 cycles passed |
| `generated/reference-three-track-raw.itl` | raw, unencrypted / 3 | `7d9b274765471d2d77440049273b210138e36b998d39d4790fe750d60c32406b` | 2/2 cycles passed |
| `generated/reference-three-track-zlib.itl` | zlib, AES flag 2, cap 102400 / 3 | `73dbb405fbd2b68b62d29913b697a72100f8606cdb2ee704c55908e4de389e17` | 2/2 cycles passed |

One-track evidence is under [`../evidence/native/reference-generated-20260922-passed/`](../evidence/native/reference-generated-20260922-passed/); three-track evidence is under [`../evidence/native/reference-multi-track-20260922-v2/`](../evidence/native/reference-multi-track-20260922-v2/). The preceding multi-track attempt failed during Unicode preflight before iTunes launch and is retained separately as harness evidence.

Qualification is exact-output only. Changing a name, path, identity, count, record, flag, version, template, or compression backend makes the output `unverified` until separately tested. The checked-in compressed hashes use the classic zlib backend. Python builds linked to zlib-ng can emit different, structurally valid compressed bytes; they do not inherit the retained hashes' native acceptance, and byte-exact evidence replay fails closed on that backend. Raw-output generation and semantic validation remain available. The 1–16 bound defines what the generator will construct, not what native evidence has qualified.

```powershell
python -m TEST_CORPUS generate output.itl
python -m TEST_CORPUS generate template-derived.itl --template known.itl
python -m TEST_CORPUS manifest --check
```

The checked-in `corpus-manifest.json` hashes every file under `generated/`. Cross-version generation fails closed.
