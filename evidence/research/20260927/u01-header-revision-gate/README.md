# U-01 outer-header revision-major gate

This bundle records a concrete **non-version-label** incompatibility in the exact signed Apple standalone Windows x64 iTunes 12.12.10.1 executable and locks one independently parseable native candidate before any launch. The executable identity is 39,260,512 bytes, SHA-256 `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`, with the previously verified valid Apple signature. No Apple installer, executable, DLL, MUI, resource, Ghidra project, log, broad decompiler dump, or raw binary dump is retained.

## Static causal result

The bounded Ghidra 12.1.3 report establishes the following exact-build path:

1. Parser `FUN_1410ad0b0` allocates its parsed object and calls header reader `FUN_1410ace80` at RVA `0x10ad216`.
2. The reader zeroes and reads exactly `0x90` bytes, then invokes endian normalizer `FUN_14108de90` at RVA `0x10acff8` before validating the header.
3. The normalizer independently byte-swaps the 16-bit words at parsed-header offsets `+0x0c` and `+0x0e`. Raw `00 43 00 01` therefore becomes `(67,1)`, while raw `00 44 00 01` becomes `(68,1)`.
4. The exact parser reads normalized u16 `+0x0c` at RVA `0x10ad257`, compares it with `0x43` at `0x10ad25c`, and returns `-876` at `0x10ad262` when it is above the ceiling. Alternate parser `FUN_1410f4b90` corroborates the same ceiling at `0x10f4d21`/`0x10f4d28`.
5. The direct caller explicitly compares the parser status with `-876` at `0x53db8d`, routes it through group `0x1f43`, and selects descriptor resource `0x1f420003`, whose role is the newer-version message in prior exact-build localization evidence.
6. Writer constructor `FUN_1410917e0` directly stores dword `0x00010043` at object offset `+0x0c` (RVA `0x1091888`), establishing current normalized tuple `(67,1)`. Serializer `FUN_141094c80` copies the complete `0x90`-byte header, applies the same endian helper when required, and writes exactly `0x90` bytes. Writer pipeline `FUN_14109eaf0` calls the constructor and serializer.

The field is therefore bounded as an outer-header format compatibility major/minor revision tuple. No native symbol name was recovered, so the repository does not claim an authoritative native field name. This gate does not inspect or mutate the embedded `12.12.10.1` version label.

The deterministic report is 83,065 bytes at SHA-256 `2242e7fe1db95d95bb412df594143c2783eb84683e56188fd361b2e3276923c2`. Hash-gated script `scripts/ghidra/U01HeaderRevisionGate.java` is SHA-256 `c23f9b48ecd6b5c5121d8c5c0b166c0a2bbf41055b84fc84ae23de7b84b8b5dc`. Two `-noanalysis` runs against the saved 62,218-function project produced byte-identical reports; only the bounded JSON is retained.

## Exact candidate and independent preflight

The candidate derives from the exact clean native cycle-2 save `9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772` and changes exactly one byte:

- file offset `0x0d`: `0x43` → `0x44`;
- raw tuple: `00 43 00 01` → `00 44 00 01`;
- normalized tuple: `(67,1)` → `(68,1)`;
- candidate: 4,904 bytes, SHA-256 `287a9b91315be1a4917cc1a2530013c076bab824e2099885ac89d8e7ccebe59a`.

`REFERENCE_PARSER/core.py::ReferenceLibrary.from_bytes` and envelope decoding both succeed on source and candidate. Both retain encryption mode 2, compression mode 1, version label `12.12.10.1`, persistent ID `C4CF98746C40D802`, declared/actual size 4,904, decoded payload length 106,776, payload SHA-256 `826863edfd2c6f44c7835b0cfebf7aa821e364490090bcdf49d82f29f458e4e9`, one track, fifteen playlists, and equal full normalized semantic summaries after excluding only the top-level file SHA. The pinned baseline tree contains 431 tracked ITLs; an exhaustive census found raw tuple `00430001` in all 431.

Generator `scripts/research/build_u01_header_revision_candidate_20260927.py` deterministically writes/checks the candidate, manifest, and preflight. Its SHA-256 is `6418daa2dfe9c268e75c1dfff2f30869439ad9e89d467b660a087a936559d067`.

## Pre-outcome native boundary

`native-two-attempt-plan.json` fixes the exact candidate/source/executable identities, static prediction, mandatory commit/push/remote gate, two sequential fresh-copy attempts, isolated profile junctions, 90-second observation limits, strict newer-version/invalid/ambiguous classification, one visible enabled OK dismissal, normal exit or bounded `WM_CLOSE`, exit code zero, zero remaining processes, input identity/semantic preservation, forbidden fallback audit, and cleanup. Timeout or forced cleanup is explicitly not modal success, and post-hoc candidate substitution is forbidden.

The locked native wrapper is `scripts/windows/u01_header_revision_gate_20260927.py`, SHA-256 `fd43735bd0cebdd58ad1729f2fe4973d3165df5727b294714e0b4131486e3464`. It reuses the mature exact-build harness only after re-locking the candidate's full normalized semantics and executable identity.

At this pre-outcome checkpoint:

- candidate launches: **0**;
- product modal observations: **0**;
- native outcomes: **0**;
- native authorization: **false until this complete bundle is committed, pushed, and local/remote hashes are equal**;
- U-01: **open**.

Static resource selection is not itself modal observation. Even a repeated exact modal result would remain a bounded observation of one candidate on one executable; it would not admit a writer profile, arbitrary editing, universal compatibility, independent semantic reproduction, or complete analysis.
