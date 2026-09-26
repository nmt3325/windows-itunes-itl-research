# 002 — 2026-09-27 U-01 sampled multi-version matrix and separate-runner reproduction

## Objective

Advance U-01 with a deliberately bounded positive/negative matrix rather than infer compatibility from a version string. The work tested six exact iTunes 12.13.10.3 input hashes against signed standalone Windows iTunes 12.13.9.1 and 12.13.11.1, retained two native open/save/restart cycles per positive input/build, replayed one historical failure, and added a deterministic structural negative. This note does not claim U-01 closure, arbitrary editing, general backward compatibility, or universal format support.

## Environment and provenance

A maximum-lease Windows GHA MCP environment, `win-p0qfbqby` (`windows-itunes-itl-u01-reproduction-20260927`, run `36258961725`), used Windows Server 2025 build 10.0.26100. iTunes 12.13.9.1 was installed first through the retained Chocolatey package and Apple installer. Its executable was 38,840,784 bytes, SHA-256 `6805f52ca3a3a55b31418e302acd8862023078e2f726e44880ab53df48ad2bc5`, and carried a valid Apple signature with thumbprint `EB32ED01B82E90A4B8FC1601CE22B0FD6E05C52F`.

Controlled first launch accepted the EULA, dismissed the known audio warning, declined the update with “do not ask again,” observed COM version 12.13.9.1, requested normal COM `Quit`, exited 0, removed the profile junction, and left zero iTunes processes.

The same runner was then upgraded in place to iTunes 12.13.11.1. Its executable was 38,952,912 bytes, SHA-256 `c69e719cd3f2f9374e71c954a6de87002b6988af65129943983a2f17490dd73c`, with a valid Apple signature and thumbprint `5ABF5D5265D74C9EAD19246DFAB611AA5DCFE791`. This runtime was separate from the earlier 12.13.11.1 experiment on `win-7h5jwzza`, but shared fixture hashes, harness/repository code, and the exact executable hash. It was not an independently implemented harness or independently sourced executable.

## Harness correction

Commit `87f20c9` separated the outer `hdfm` file persistent ID from the COM master-playlist/library persistent ID. Native-lineage candidates 112 and 113 use outer file ID `D2F61BE0A69CA302` and COM ID `9751B29CECF5340B`; treating these as one identity would have produced a false failure. Seven focused regressions cover the split and preserve the old fallback for fixtures where both IDs are identical.

Commit `6c912be` added a deterministic one-byte-truncated zlib control. Commits `1aab2d8`, `734e3f0`, and `d433116` retained the 12.13.9.1 evidence, enforced byte-exact evidence treatment, and retained the separate-runner 12.13.11.1 evidence.

## Positive matrix

The six exact inputs per build were:

- raw one-track `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74`;
- zlib one-track `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad`;
- raw three-track `7d9b274765471d2d77440049273b210138e36b998d39d4790fe750d60c32406b`;
- zlib three-track `73dbb405fbd2b68b62d29913b697a72100f8606cdb2ee704c55908e4de389e17`;
- candidate 112 `1a84651212b08f6b7aaf37b40764c195d827d95868d0b51950e1f035c2527721`;
- historical candidate 113 `34e4b4348ee4db611d59c1da23791700558c3c91bc44504e4d89a8e5c228ec0f`.

All 12 cycles on 12.13.9.1 and all 12 cycles on 12.13.11.1 passed. Every cycle had worker/iTunes exit 0, normal COM `Quit`, empty worker and independent-parser errors, no forbidden fallback artifacts, correct outer and COM identities, and a saved ITL independently reporting the installed native version. The first cycle used the exact candidate; the second reopened the exact first native save.

Candidate 112 retained across both cycles/builds:

- `Codec Artist Ω`, `Codec Album 新規`, `Codec Album Artist 🎼`;
- `One-field comment — 測定`;
- Rating 80, play count 7, skip count 3, track number 2, year 2024;
- ordinary playlist `Synthetic 調査 🎼` with the selected two-member order.

Candidate 113 retained `Codec Fresh 🧪`, Rating 80, play count 7, skip count 2, track number 9, and year 2032. Its historical 12.13.10.3 zero-cycle failure did not reproduce on either tested build, so it cannot serve as a stable negative.

## Structural negative

The 878-byte truncated zlib input has SHA-256 `883cf0d4f6c0e751de87e11e9a14d9e844c8d044eb6864e4ffa06eb05c3747f5`. On both installed builds, independent parser preflight rejected it because the declared outer file size did not equal the actual size. Harness exit was 1; no native cycle or profile began; process counts were zero before and after. This proves fail-closed structural preflight for this malformed byte sequence, not iTunes rejection.

## Integration

[`scripts/research/summarize_u01_sampled_version_matrix_20260927.py`](../../scripts/research/summarize_u01_sampled_version_matrix_20260927.py) pins executable identities/signatures, input and native-save hashes, cycle/process/error/fallback gates, the outer/COM identity split, candidate 112/113 selected semantics, negative classification, and reproduction limitations. It generates [`matrix-summary.json`](../../evidence/research/20260927/u01-sampled-version-matrix/matrix-summary.json), with byte-exact regeneration covered by [`tests/test_u01_sampled_version_matrix_20260927.py`](../../tests/test_u01_sampled_version_matrix_20260927.py).

## Bounded conclusion and next task

The retained evidence establishes exact-hash downgrade/open/save/restart compatibility on 12.13.9.1 and exact-hash upgrade/open/save/restart compatibility on a separate 12.13.11.1 runner for the six pinned inputs. It adds one selected semantic candidate across both builds and shows that the historical candidate-113 failure is unstable. It does not admit arbitrary 12.13.9.1 or 12.13.11.1 editing, prove independently implemented reproduction, or close U-01.

The next U-01 task should add a genuinely distinct version-pinned build and a predeclared product-facing native negative that passes structural preflight but fails a native semantic gate, while retaining lawful installer/executable provenance and avoiding post-hoc negative selection. Independent harness implementation or independently sourced executable provenance also remains absent.
