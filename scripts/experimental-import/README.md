# Experimental ITL cross-library import reproducer

**Experimental; not a general import API, a production writer extension, or native automation.** This tool reproduces the bounded phase3 procedure with explicit paths. It never launches iTunes, COM, UI or Frida, creates audio, rewrites Locations, performs COW, or changes a worktree.

## Deliberately narrow qualification

The CLI currently accepts only these complete synthetic input hashes, in addition to checking the actual structure:

| Role | SHA256 |
| --- | --- |
| Baseline003 | a93cbc94da00eb60d1f5a45ac70af55948d4ecbae2ea735744af04b7b46128e4 |
| Baseline037 | 155e427ebaf820e177123c9787d878e1f6b655a5978db409ba742c8697675f81 |
| Independent donor032 | 7edd4ea85ca937103165bb40a5656ba84cd9c08b73580beb2482d963f5728083 |

An unknown snapshot is refused **even if it has the same version or apparently similar fields**. This is a fixture-qualified portable reproducer, not permission to loosen those gates. Its own outputs and native-resaved snapshots are not automatically qualified as future baselines. Real-world/new-library import, cloud/store records, arbitrary grouped playlists, general sort behavior and COW are blocked rather than implied supported.

## Runtime and usage

Copy this entire `portable` directory, including `vendor/` and `core-manifest.json`. It has no fixed ROOT, fixture directory, Git checkout, test-report, native-oracle or network dependency. Python3.11+ and PyCryptodome are required; the tested runtime is Python3.12.10, PyCryptodome3.23.0 and zlib1.3.1. `requirements.txt` pins the external Python dependency. No installation is performed by the CLI.

The supplied fixtures store Windows absolute WAV Locations. Their media must remain at those exact paths; moving the tool or ITL files is supported, relocating media is not. Use only your own or explicitly authorized **closed** input snapshots and synthetic WAV roots. Do not point the tool at a live iTunes library or third-party private files.

PowerShell, with variables set to your explicit existing paths:

```powershell
python -B .\experimental_import.py --experimental `
  --baseline $baseline --donor $donor `
  --pid E95DD2B085330A12 `
  --output $newOutput --seed crud3-cross-one-003 `
  --media-root $authorizedSyntheticMediaRoot > $newReceipt
```

- Repeat `--pid` for multiple distinct PIDs, preserving the requested append order;1..32 are accepted only from the qualified donor.
- `--seed` is optional, defaulting to `experimental-cross-import-v1`.
- Repeat `--media-root` for separate authorized local directories. This extra explicit allowlist prevents automatically opening media outside approved roots. UNC/network path arguments are refused. The tool is not an OS security sandbox against hostile filesystem races.
- `--experimental` is mandatory. `-O` and `-OO` are refused before dependency/input processing. Research guards are explicit runtime checks, not removable `assert` statements.
- Output must be a **new** `.itl` file with an existing parent directory. An existing file, directory or symlink is refused, even if its bytes match. The receipt is JSON on stdout; choose a new receipt path yourself.

All decoding, identity/reference, atom, preservation and media checks run before publication. The current core writes a same-directory temporary file, flushes/fsyncs/closes it and publishes via an exclusive hard link; there is no overwrite fallback. If filesystem publication or stdout delivery fails ambiguously, inspect the output/hash before retrying. A successful publication is not native acceptance.

## What is validated and preserved

Known12.13.10.3 local-WAV profiles, nonempty destination, exact section layout, fixed opaque-settings digest, strict track/secondary/album/artist/playlist/item identity namespaces, known references, complete Master coverage, system playlist flags/metadata/rules, and compact positive per-pool text IDs. The latest core's `same-lineage` public guard remains unchanged.

Old track and index records, ordinary playlists, old system children, source text and Location payloads, unknown retained sections, seven rank/cache words and wire6d are preserved. Only declared new identities/references, incoming atom IDs, new memberships and required length/count fields change. Shared donor indexes are cloned once per source object. This is **sharing preservation on import**, not general shared-index COW.

## Exact replay and its limits

On the tested runtime:

- Baseline003 + donor track01 + seed `crud3-cross-one-003` reproduces SHA `60c5f1541981ddedd457f3e78ca07c63a8d71e3b8e42f3211b175aad2a8facaa` exactly.
- Baseline037 + ordered track01,track17 + seed `crud3-cross-shared-two-037` reproduces SHA `2bf00425a238492c427e07108638fb7e6317ccdbbc62cadb6c4499b656c08ee1` exactly.
- Track17 PID is `0EA4623DE17EC6F6`.
- Same input bytes, ordered PIDs, seed, pinned core and compression runtime give the same bytes. Output path and tool location do not enter identity allocation. A different seed changes only new membership PID slots in plaintext; encrypted/compressed bytes and the outer physical size may consequently differ. Different zlib implementations may encode equivalent plaintext differently; cross-runtime byte identity is not promised.

Dynamic separately qualified the **one-track phase3 candidate with the exact SHA above** through45/30-second passive observation, two saves/restarts and complete old3+new1 PID/metadata/Location/COM-system gates. Its `first-handoff-1500.json` calls this a partial handoff: invisible serialized raw14 playlist re-audit was still a separate gate, and no phase3 playback or Frida result was included. This CLI replay does not create a new native test result or generalize that acceptance to other selections/seeds/grouped cases.

## Tests and provenance

`test_experimental.py` takes explicit baseline, recipient37, donor, output-dir and media-root arguments. Use a fresh test output directory. Tests cover exact one/two-track replay, deterministic identity allocation, duplicate identities/PIDs, missing references, pool collisions, empty/unknown/opaque/system profiles, opt-in, media allowlists and no-overwrite behavior. Separate process-level checks verify `-O`, `-OO`, default-seed replay and relocated-tool execution.

`core-manifest.json` pins12 unmodified source files from commit `56069f1e2a17d9aea62c1d753b2bd93ed404a000`; every core file hash is checked at startup. The transformation is derived from the preserved phase3 research procedure, with assertions converted to explicit refusals and fixture/CLI guards added. The portable directory needs no phase3 scripts/manifests at runtime. Do not distribute the surrounding lab reports, earlier private candidates or Apple binaries as part of this tool.