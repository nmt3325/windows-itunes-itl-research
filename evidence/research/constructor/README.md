# Fresh WAV constructor — bounded experimental handoff

**Offline complete; native acceptance is NOT claimed.**

## Frozen candidates

- `candidates/fresh-003-v1.itl`: three original tracks plus new `62F368A925010BFC`, input native003.
- `candidates/fresh-037-v1.itl`: three original tracks plus new `412ABAD099FB1F36`, input native037. This retains alpha's edited metadata and the existing ordinary playlist.
- `media/fresh-constructor-003.wav` and `media/fresh-constructor-037.wav`: new deterministic one-second mono 16-bit/44.1 kHz PCM, each 88,244 bytes, own synthesis rather than source audio copies. Explicit mtime 2026-09-09T14:00:00Z matches both new ITL time fields.
- `native-requests.json`: immutable descriptive request, **not** a native harness API. Contains full old/new track raw fields, passive COM expectations, all raw playlist PIDs/members, baseline native oracles, input/output/media hashes, and acceptance/failure criteria.

## What was constructed

Native003 alpha is the SHA-pinned header/text template. It has mhoh2/6/13/11 and **no opaque type1 location object**. The new records do not retain alpha's track PID/local/secondary identity, file path, URL, Name atom, album/artist object identities or playlist-item identities.

Each case gets fresh track, blank album and blank artist objects, plus fresh items in master, downloaded-music and Music lists. All three old tracks, old auxiliary objects, original playlist metadata/items, the ordinary playlist and opaque sections remain byte-identical. All counts and enclosing sizes are rebuilt and independently checked. Name uses a fresh compact pool atom, clears only6d bit0 and resets290; the remaining blank-metadata rank words are preserved. The global hdfm identity and the distinct COM/master identity are preserved independently.

This is not `add_track_from`/same-lineage restoration. The independent native donor32 is a negative provenance control only, never the new track/media source.

## Reproduction (assigned Windows worktree only)

```powershell
$R='D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl'
Set-Location "$R\wt\add-constructor"
$env:PYTHONDONTWRITEBYTECODE='1'
& "$R\tools\py\Scripts\python.exe" -B "$R\reports\add-constructor\builder.py" --verify-existing
& "$R\tools\py\Scripts\python.exe" -B "$R\reports\add-constructor\verify.py"
```

For initial construction, `builder.py` without `--verify-existing` creates missing owned outputs exclusively and refuses different existing bytes. The builder is intentionally fixed to the two native input SHAs and exact template; it is not a general-purpose import API. `tests.py` runs 45 positive/negative checks and saves `offline-tests.json` exclusively. Preserve the existing evidence rather than overwriting it on reruns. `preflight.py` adds fresh-identity, UTC/media and full input/oracle hash checks and also writes exclusively.

## Independent checks

`verify.py` has its own AES/zlib decoding and length-driven parser and never imports itlkit. It checks section/list/header sizes and counts; old bytes; pool-scoped unequal-text collisions; track/album/artist and item references; per-namespace unique identities; media bytes and metadata dimensions. `preflight.py` additionally compares six fresh object/item PIDs and seven fresh local/secondary/item IDs against the old namespaces, independently computes UTC HFS seconds and validates old COM expectation conservation. Negative controls cover bad counts, duplicate IDs, dangling refs, occupied Name atoms, type1 location data, unsupported waveform/state/extension, registered paths and writes outside owned reports.

## Native handoff to dynamic only

Use candidate **copies**, not these frozen producer files; do not native-import the WAV to repair the test. Compare four unique track PIDs and every stated passive field/location. Reject damaged, empty or newly-created fallback libraries. Distinguish file PID `D2F61BE0A69CA302` from COM/master PID `9751B29CECF5340B`. Re-observe after passive waits and after **two completed clean save/exit/restart cycles**. Master/Music membership is exact-multiset; the existing ordinary playlist order is unchanged. Downloaded is also checked in saved bytes because not every serialized system list is COM-visible.

Only after passive observations may dynamic safely open/play at volume zero if the audio subsystem permits. An audio-subsystem refusal is separate from library acceptance. These explorers ran no iTunes/COM/UI/Frida operations.

## Deliberate limits

The probe does not generalize to nonblank new album/artist metadata, arbitrary WAV dimensions, non-ASCII/escaped/moved locations, opaque type1 location objects, cloud/store/media-history state or other versions. Unknown inherited fixed flags are constrained by exact template hash, not reverse-engineered constructors. High-water semantics at58 and native rank/identity normalization remain unresolved;3c is a constant, not a guessed allocator. Old input identities/text/opaque bytes are not rewritten to make references look consistent.

The only remote changes are this report directory. No production modifications, commits, pushes, new environments/worktrees, dependency changes or permission changes.
