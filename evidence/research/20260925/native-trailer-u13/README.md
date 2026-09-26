# U-13 bounded native compressed-trailer probe (2026-09-25)

## Result

A fixed-seed 17-byte opaque compressed trailer was accepted by the signed standalone Windows iTunes 12.13.10.3 environment for this exact one-track candidate. The first normal native save **stripped the trailer**. A restart from that exact saved ITL completed normally and the trailer remained absent. The exact trailer-free control also completed two normal native save/restart cycles.

This is bounded positive native load/save evidence and a bounded trailer-fate observation. **U-13 remains open.** It does not assign meaning or provenance to the bytes, prove that discarding trailers is safe, establish semantic editability, or generalize to another trailer, payload, profile, iTunes build, Store edition, or platform.

## Exact pair

Both inputs contain the same expanded semantic payload, SHA-256 `666c74d34556f413a76a31691be9b20f1eec8f2a9459f15b7b98f2ea0dcfa797`.

| Role | Bytes | Input SHA-256 | Trailer |
| --- | ---: | --- | --- |
| Exact trailer-free control | 775 | `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad` | 0 bytes |
| Fixed-seed `trailer-opaque-17` candidate | 792 | `10b17fbdd783ad17e6fa3b488ee6421f43a417b9350de547754d24d4369e4e34` | 17 bytes; SHA-256 `103ea80001690bf2fccc5b4fb924760bf817e9c0b798c085e5359f68b10616ab` |

The pair was regenerated from the existing 57-case audit with seed `0x20260925`; the trailer recipe was not reimplemented. Primary and independent envelope decoders agree on payload and trailer bytes. The validator accepts the record/envelope structure but reports `scope.compressed_trailer` and `semantically_validated: false`. Parser, validator, no-op, and envelope agreement are not counted as native acceptance.

## Native phase chain

The existing strict isolated harness was used without weakening its gates. Each case received a fresh disposable profile and two cycles; cycle 2 opened the exact bytes saved by cycle 1.

| Case | Candidate input | Cycle 1 native save | Cycle 2 native save | Trailer fate |
| --- | --- | --- | --- | --- |
| `u13-control-no-trailer` | `25f8aba0…13ad` | `71ab2bb823498fda216008461591677a8e20ec5dabff7ece2d3631e31ddf58d8` | `04c92369c988e36daf4e7f8ea3b57ca6c2cc541ee0b19ef7783825b51ed06364` | absent → absent → absent |
| `u13-opaque-trailer-17` | `10b17fbd…e34` | `76155badb29a2b30ca64aeb0769dabf6bf2d928b877d236fd8bda12ca079d928` | `7bb3dc35fda5e1f04d06b6d1e4b29c459a47c71c202edff95a045634ef8a304f` | 17 bytes → stripped → remained absent |

All six retained phase files are recognized by the independent detector, structurally valid within the validator's stated scope, and independently rehashed by `analysis.json`.

## Native gates

All four native cycles recorded:

- COM version `12.13.10.3`, library PID `5245464552454E43`, track PID/name `A17E000000000001` / `Reference Track Zlib`, and ordinary playlist PID/name/member `A17E000000000002` / `Reference Playlist Zlib` / the same track;
- two stable full COM samples with no errors;
- worker accepted, normal `Quit` requested, worker exit 0, and iTunes process exit 0;
- no XML, previous-library, backup, damaged-library, or fallback artifact before or after the cycle;
- only the already-known audio-configuration warning was dismissed; no damaged-library or unexpected modal was authorized;
- successful profile-junction removal and a stopped-process gate at case completion.

The signed environment was freshly rechecked immediately before execution: installer SHA-256 `cea2a74cae3f061eadc11358eeaae9b40cfdea9ec1ee037b47da54a64219e182`, installed `iTunes.exe` SHA-256 `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`, both Authenticode `Valid` with Apple certificate thumbprint `5ABF5D5265D74C9EAD19246DFAB611AA5DCFE791`. URL resolution and initial installation remain explicitly labeled as reused facts from the preceding retained run; hashes, signatures, process/profile state, OS, culture, and timezone are fresh observations.

## Interpretation and limits

The narrow observation is: **this exact opaque suffix did not prevent native load/save, and iTunes omitted it when writing a new ITL**. The native save also rebuilt a much larger payload, as it did for the exact control, so this is not a byte-local rewrite or evidence that the suffix alone caused every other output difference.

Repeated saves are one phase chain, not independent experiments. The copied control is a deterministic comparator, not an independent library. No production codec behavior changed. Unknown trailer provenance, a decoder or safe independence proof, broader trailer classes, negative native cases, additional profiles/builds, and independent reproduction are still required.

## Retained evidence

- `generation.json`: deterministic pair, audit provenance, parser/reference/validator facts, and claim boundaries.
- `native-cases.json`: hash-pinned strict native manifest.
- `environment-provenance.json`: reused facts separated from fresh pre-experiment observations.
- `native-run/summary.json` and `native-run/cases/**`: sanitized full harness, COM, inventory, process, UI, and saved-ITL evidence.
- `analysis.json`: exact phase hashes, payload/trailer analyses, restart chains, and trailer-fate classification.
- `candidates/**`: the exact two input ITLs.
- [`docs/native-trailer-u13-20260925.md`](../../../../docs/native-trailer-u13-20260925.md): concise project-level summary.

Offline verification:

```powershell
python -B scripts/research/native_trailer_u13_20260925.py verify-retained `
  --native-evidence evidence/research/20260925/native-trailer-u13/native-run
python -B -m pytest tests/test_native_trailer_u13_research.py -q -p no:cacheprovider `
  --basetemp "$env:TEMP/u13-tests-fresh"
```

Do not run the native harness against a normal user profile. A native rerun requires a fresh external root, a fresh evidence directory, exclusive iTunes ownership, and the explicit disposable-profile confirmation used by the strict harness.
