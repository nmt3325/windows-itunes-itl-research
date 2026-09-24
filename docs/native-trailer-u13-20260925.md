# U-13 native compressed-trailer result (2026-09-25)

A two-case, hash-pinned experiment used the existing strict isolated harness on signed standalone Windows iTunes 12.13.10.3.

- Exact control: one-track zlib ITL SHA-256 `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad`, with no trailer.
- Exact candidate: the same expanded payload plus the fixed-seed 17-byte `trailer-opaque-17` witness, file SHA-256 `10b17fbdd783ad17e6fa3b488ee6421f43a417b9350de547754d24d4369e4e34`, trailer SHA-256 `103ea80001690bf2fccc5b4fb924760bf817e9c0b798c085e5359f68b10616ab`.

Both cases passed two native save/restart cycles in fresh isolated profiles. Every cycle retained full COM identity/state samples, allowed only the known audio warning, found no XML/backup/previous-library/damaged-library/fallback artifact, requested normal Quit, and observed worker and iTunes exit code 0.

The candidate's first native save contained a zero-byte trailer: iTunes **stripped the exact 17-byte opaque suffix**. Cycle 2 reopened the exact cycle-1 save and the trailer remained absent. The control remained trailer-free throughout. Native saves rebuilt the payload for both cases, so no byte-local rewrite is claimed.

This is exact-candidate load/save and trailer-fate evidence only. It does not establish the trailer's meaning or provenance, justify discarding unknown bytes, prove safe semantic editability, generalize to other trailers/profiles/builds/platforms, or make repeated saves and the copied control independent experiments. No production semantics changed. **U-13 remains open.**

See [`evidence/research/20260925/native-trailer-u13/README.md`](../evidence/research/20260925/native-trailer-u13/README.md) for hashes, signed-environment provenance, phase files, machine-readable analysis, and verification commands.
