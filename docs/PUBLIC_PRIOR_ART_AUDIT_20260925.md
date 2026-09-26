# Public prior-art audit — 2026-09-25

## Scope and claim boundary

This audit pins six public repositories and compares their declared scope with the evidence in this repository. It also exercises this repository's parsers against the 14 historical `.itl` fixtures in `josephw/titl` **without copying those fixture bytes into this repository**.

The results establish only source provenance, upstream build/test status, and bounded offline parser behaviour. They do **not** establish native Windows iTunes acceptance, semantic compatibility across historical versions, big-endian editing support, or closure of U-01/U-02/U-06.

## Pinned sources

| Source | Commit | Relevant scope |
|---|---|---|
| [`pitetb/AppMusicLibParser`](https://github.com/pitetb/AppMusicLibParser) | `423b0a87dce9bda8950ba8fe48cc8e75396fad36` | macOS Apple Music `Library.musicdb`; not Windows ITL |
| [`josephw/titl`](https://github.com/josephw/titl) | `e7060370973d624d5c7b18f82303407b76421501` | historical Java ITL reader and 14 public fixtures |
| [`jeanthom/libitlp`](https://github.com/jeanthom/libitlp) | `55174a0064fc299a5771b92ed6abcb746964cf7d` | incomplete read-only C ITL parser |
| [`kynoptic/smart-playlist-io`](https://github.com/kynoptic/smart-playlist-io) | `31acf7f058278f120b9d054459134416e76d1d8e` | Music.app XML Smart Criteria; cross-format prior art |
| [`cvzi/itunes_smartplaylist`](https://github.com/cvzi/itunes_smartplaylist) | `9a36e82d5bfaad9154b50166fee0489f5d9306e2` | iTunes XML Smart Info/Criteria; cross-format prior art |
| [`quinnjr/itl-rs`](https://github.com/quinnjr/itl-rs) | `49f3ad3beaf2cdd4af2b16ee2297ec22e939dbab` | Rust ITL implementation already covered by separate native evidence |

Every checkout was at the pinned commit with no tracked modification when [`audit.json`](../evidence/research/20260925/public-prior-art/audit.json) was generated.

## Upstream checks

- `smart-playlist-io`: after installing the missing `pytest-cov` test dependency, **144 passed** with **98.43%** coverage. The first invocation exited 4 because the repository's configured `--cov` arguments were unavailable, not because a test failed.
- `itunes_smartplaylist`: **18 passed**.
- `AppMusicLibParser`: its .NET 8 test assembly reported **1 passed**. Its format remains macOS `Library.musicdb`.
- `libitlp`: CMake configuration succeeded. Modern GCC initially rejected ignored `fread` results because upstream enables warnings as errors; rebuilding with only `-Wno-error=unused-result` produced `libitlp.so`. This is build portability evidence, not parser qualification.
- `titl`: Maven did not reach tests on the installed modern JDK because the upstream POM fixes Java source/target 6. Both attempts failed with `Source option 6 is no longer supported`. This is a toolchain-age limitation and is not counted as parser failure or success.

Machine-readable exit statuses and interpretations are in [`external-test-status.json`](../evidence/research/20260925/public-prior-art/external-test-status.json).

## Historical fixture experiment

The `titl` cohort contains 14 fixtures labelled from iTunes 8.0 through 11.1.5:

| Observation | Result |
|---|---:|
| `itlkit.Container` decoded | 14 / 14 |
| exact no-op byte preservation | 14 / 14 |
| forced rebuild reparsed with identical expanded payload | 14 / 14 |
| forced rebuild reparsed with identical trailer | 14 / 14 |
| big-endian expanded payload | 13 / 14 |
| little-endian expanded payload | 1 / 14 |
| `itlkit.Library` semantic parse | 0 / 14 |
| independent `ReferenceLibrary` structural/semantic parse | 1 / 14 |
| independent detector marked recognized | 0 / 14 |
| independent detector marked unsupported | 14 / 14 |

The one `ReferenceLibrary` success is the little-endian empty OS X iTunes 11.1.5 fixture. The other 13 are big-endian payloads and remain outside the semantic parser's supported profile. `Container` success means bounded envelope decode/preservation only. A rebuilt envelope was not submitted to any native iTunes build.

The fixture-level report stores source-relative path, byte length, SHA-256, envelope fields, exact-preservation result, forced-rebuild result, and bounded parser outcomes. It intentionally omits third-party bytes.

## Reproduction

Prepare the six checkouts under one directory using the checkout names recorded in `SOURCES`, detach each at the pinned commit, and install this project's normal Python dependencies. Then run:

```bash
python -B scripts/research/audit_public_prior_art_20260925.py \
  --external-root /path/to/pinned/checkouts \
  --out /tmp/public-prior-art-audit.json
python -m pytest -q tests/test_public_prior_art_audit_20260925.py
```

Compare the generated JSON with [`audit.json`](../evidence/research/20260925/public-prior-art/audit.json). Paths in the report are relative to the pinned `titl` checkout so the result is independent of runner location.

## Consequences

1. Historical envelope handling is broader than the repository's semantic/native support matrix.
2. Big-endian envelope preservation is evidence for opaque replay, not evidence for editable big-endian semantics.
3. The public projects do not supply a drop-in proof of arbitrary Windows iTunes 12.13 construction or Smart Playlist membership semantics.
4. U-01, U-02, and U-06 therefore remain open; future work needs version-specific native oracles and independently checked semantic fixtures.
