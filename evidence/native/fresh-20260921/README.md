# Fresh native iTunes 12.13.10.3 evidence (2026-09-21 UTC)

## Exact scope

This evidence set covers one **newly created** Windows iTunes library only:

- iTunes `12.13.10.3`, Apple standalone desktop distribution, x64
- Windows build `10.0.26100`, x64
- display culture and system locale `en-US`
- time zone `UTC`
- isolated library root: `D:\a\_temp\gha-mcp\win-f564d1rb\work\native-fresh\live`
- synthetic WAV media only

Machine-readable details and executable/installer hashes are in `environment.json`.

## Isolation and lifecycle

The library was created with iTunes' native Shift-launch **Create Library** flow. Before the first normal quit, iTunes created `iTunes Library.itl`, Extras/Genius `.itdb` files, `sentinel`, `Album Artwork`, and `iTunes Media`. `companion-manifest.json` records the final inventory and confirms that neither `Previous iTunes Libraries` nor an XML export was present. Thus these runs cannot be explained by backup or XML restoration.

Native lifecycle fixtures:

1. `000-fresh-empty.itl` — native fresh empty library after a normal COM snapshot and quit.
2. `001-one-track.itl` — one synthetic WAV imported through iTunes COM.
3. `002-three-tracks.itl` — three synthetic WAVs imported through iTunes COM.
4. `003-traced-name-save.itl` — first track renamed to `TraceProbe-20260921`; save observed with bounded Frida hooks.
5. `004-repeat-save-1.itl` — first subsequent open/snapshot/save cycle.
6. `005-repeat-save-2.itl` — second subsequent open/snapshot/save cycle.

Every native driver result is `passed`, iTunes exited with code 0, and the COM state gates reported zero expectation or snapshot-stability errors. `analysis.json` independently parses every fixture. The three post-edit fixtures have different physical SHA-256 values but the same parsed logical SHA-256, confirming stable logical state over two additional native open/save cycles.

## Trace result

`runs/traced/trace/events.jsonl` and the captured buffers record the bounded save trace. Native `zlib1.dll` activity and opens of the live ITL were observed. The hook did **not** observe a `WriteFile` event or a rename sequence, so this set does not claim to prove iTunes' full atomic replacement algorithm; see `trace-summary.json`.

## What this proves

- A fresh isolated iTunes 12.13.10.3 library can be created without backup/XML fallback.
- Empty, one-track, and three-track native ITLs are parsed by the current reader.
- A native track-name edit remains stable through two later iTunes open/save cycles.
- The file envelope remains `hdfm`, compressed, encrypted, and little-endian in all six samples.
- Extras/Genius `.itdb` files and artwork/media directories are companion artifacts, while no direct dependency on XML or `Previous iTunes Libraries` was exercised.

## What this does not prove

This evidence does **not** establish template-free ITL generation by the project writer, full smart/system playlist semantics, arbitrary media/cloud/store/DRM support, old-version compatibility, audible playback, complete path/time-zone matrices, or the atomic-save implementation. It therefore supports a bounded compatibility-reader/editor claim only, not “complete analysis/specification.”

## Reproduction

The reusable commands are implemented by:

- `scripts/windows/native_driver.py`
- `scripts/windows/native_worker.py`
- `scripts/windows/native_traced_save.py`
- `scripts/windows/trace_itunes.py`

Use a disposable library root and synthetic media. Do not point the harness at a personal iTunes library.
