# iTunes 12.13.11.1 exact-hash upgrade qualification

This directory retains a bounded Windows-native qualification of four exact iTunes 12.13.10.3 ITL fixture hashes opened and saved by one exact signed standalone iTunes 12.13.11.1 executable. It is an adjacent-build upgrade/open/save/restart result, not a new general editing profile.

## Executable provenance

- Platform: Windows Server 2025, build `10.0.26100`, x64.
- Upgrade command: `choco upgrade itunes --version=12.13.11.1 -y --no-progress`.
- Apple installer URL: `https://secure-appldnld.apple.com/itunes12/140-75773-20260908-6e5e0165-99cb-4b30-b541-1b615fccfc1a/iTunes64Setup.exe`.
- Chocolatey-pinned installer SHA-256: `25b28905a81406a5edbf482f7f3ee4831a8641d32d29dceda5d1eb3e8d534c08`.
- Installed executable: `C:\Program Files\iTunes\iTunes.exe`, 38,952,912 bytes.
- Installed executable SHA-256: `c69e719cd3f2f9374e71c954a6de87002b6988af65129943983a2f17490dd73c`.
- File/product version: `12.13.11.1` / `12.13.11.1`.
- Authenticode: `Valid`, signer `Apple Inc.`, thumbprint `5ABF5D5265D74C9EAD19246DFAB611AA5DCFE791`.

The retained Chocolatey package metadata, package archive, install script, installer metadata, and normalized executable report are under [`provenance/`](provenance/).

## 12.13.10.3 setup/preflight observations

Two fresh-runner baseline attempts stopped before native semantic qualification:

1. The initial attempt encountered the exact first-launch EULA modal.
2. After a controlled disposable setup accepted that EULA and dismissed the known audio warning, the next attempt encountered the exact `12.13.11` update-offer modal.

In both attempts the candidate hash remained unchanged and no native cycle completed. These are classified as environment/setup failures, **not** ITL rejections. The controlled setup observed COM version `12.13.10.3`; its COM `Quit` timed out, so a forced process kill was used only for setup. The disposable profile junction was removed and no iTunes process remained. Existing repository evidence separately qualifies the exact 12.13.10.3 fixture hashes.

## Fail-closed cross-version harness

Harness commit `39a02b616e7837f37700d30de67c3cc9a9a62d0a` separates:

- manifest/input ITL version (`12.13.10.3`);
- expected executable file/product version and executable SHA-256 (`12.13.11.1`, exact hash above);
- expected COM/native-saved ITL version (`12.13.11.1`).

Actual wrong-hash and wrong-version preflights each exited nonzero before creating the disposable library root or evidence directory, with no iTunes process left behind. See [`negative-executable-identity-preflights.json`](negative-executable-identity-preflights.json).

## Exact inputs and native result

| Case | Tracks | Envelope | Input SHA-256 |
| --- | ---: | --- | --- |
| `reference-one-track-raw` | 1 | raw | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| `reference-one-track-zlib` | 1 | zlib/AES | `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad` |
| `reference-three-track-raw` | 3 | raw | `7d9b274765471d2d77440049273b210138e36b998d39d4790fe750d60c32406b` |
| `reference-three-track-zlib` | 3 | zlib/AES | `73dbb405fbd2b68b62d29913b697a72100f8606cdb2ee704c55908e4de389e17` |

All four inputs independently parsed as version `12.13.10.3`. Each exact hash passed two isolated open/save/restart cycles on the pinned executable: 4/4 cases and 8/8 cycles passed. Every cycle had worker exit 0, normal COM `Quit`, iTunes process exit 0, empty identity/semantic error lists, and no XML, `Previous iTunes Libraries`, damaged-library artifact, or other forbidden fallback. Every native save independently parsed as version `12.13.11.1`. The three-track cases retained deterministic identities, Unicode names, and ordered membership.

The normalized machine-readable result is [`qualification-summary.json`](qualification-summary.json). Complete native evidence is under [`native/one-track/`](native/one-track/) and [`native/three-track/`](native/three-track/); the setup-modal observations are under [`preflight/`](preflight/).

## Claim limits

- This pass applies only to the exact signed executable hash and the four pinned input hashes above.
- Two cycles per case are one controlled sequence, not independent reproductions or a population-level estimate.
- Upgrade/open/save/restart acceptance does not qualify arbitrary fields, values, counts, media, opaque records, other builds, or arbitrary 12.13.11.1 editing.
- The production semantic-write profile remains primarily 12.13.10.3-specific.
- U-01 remains open; universal ITL support, full analysis/specification, and independent semantic reimplementation remain false.

Rebuild the normalized summary and run its focused regression:

```bash
python -B scripts/research/summarize_itunes_version_qualification_20260927.py
python -B -m pytest -q -p no:cacheprovider tests/test_itunes_version_qualification_20260927.py
```
