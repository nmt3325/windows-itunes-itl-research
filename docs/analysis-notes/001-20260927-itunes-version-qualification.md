# 001 — 2026-09-27 iTunes version qualification

## Objective

Test whether the four exact template-free iTunes 12.13.10.3 raw/zlib one-track and three-track fixtures remain acceptable across an adjacent standalone Windows iTunes build, while making executable identity and input/native version expectations fail closed. This is a bounded version-breadth probe for U-01, not an attempt to declare general 12.13.11.1 editing support.

## Environment provisioning

A maximum-lease GHA MCP Windows environment (`windows-itunes-itl-native-20260927`) ran Windows Server 2025 build `10.0.26100`. The repository branch was `research/20260926-autonomous-resume`. Standalone desktop iTunes 12.13.10.3 was first installed from Apple through Chocolatey; the runner was then upgraded to 12.13.11.1 for the adjacent-build qualification. The Windows environment and the existing Linux validation environment were intentionally left alive.

## 12.13.10.3 setup and preflight results

The first strict 12.13.10.3 baseline stopped on the first-launch EULA before COM/native semantic qualification. Candidate bytes remained unchanged, so this was classified as an environment setup failure rather than an ITL rejection.

A controlled disposable first-launch setup then:

- accepted the exact EULA;
- dismissed the known audio warning;
- observed COM version `12.13.10.3`;
- removed the disposable profile junction;
- left no iTunes process.

COM `Quit` timed out during this setup-only operation, so setup used a forced kill. The next strict 12.13.10.3 baseline was blocked before qualification by the exact update-offer modal: `A new version of iTunes (12.13.11) is available. Would you like to download it now?` Candidate bytes again remained unchanged. Existing retained evidence independently qualifies the same exact 12.13.10.3 fixtures; these fresh-runner modal observations do not contradict it.

## Harness version split

Commit `39a02b616e7837f37700d30de67c3cc9a9a62d0a` changed `scripts/windows/reference_generated_native.py` to distinguish:

1. manifest/input ITL version;
2. expected executable file/product version and SHA-256;
3. expected COM/native-saved ITL version.

Candidate preflight continued to require input version `12.13.10.3`, while explicit CLI arguments could require executable and native-save version `12.13.11.1`. The harness now records executable versions, hash, Authenticode evidence, qualification parameters, and invocation. Real wrong-hash and wrong-version controls both exited nonzero before creating a disposable root or evidence directory and left no iTunes process. Five focused version-split tests passed on Linux and Windows.

## 12.13.11.1 provenance

Chocolatey upgraded iTunes with `choco upgrade itunes --version=12.13.11.1 -y --no-progress` from Apple installer URL `https://secure-appldnld.apple.com/itunes12/140-75773-20260908-6e5e0165-99cb-4b30-b541-1b615fccfc1a/iTunes64Setup.exe`. The package-pinned installer SHA-256 was `25b28905a81406a5edbf482f7f3ee4831a8641d32d29dceda5d1eb3e8d534c08`.

`C:\Program Files\iTunes\iTunes.exe` was 38,952,912 bytes, file/product version `12.13.11.1`, and SHA-256 `c69e719cd3f2f9374e71c954a6de87002b6988af65129943983a2f17490dd73c`. Authenticode was valid for Apple Inc.; signer thumbprint was `5ABF5D5265D74C9EAD19246DFAB611AA5DCFE791`.

## Native qualification result

The exact input hashes were:

- raw one-track: `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74`;
- zlib one-track: `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad`;
- raw three-track: `7d9b274765471d2d77440049273b210138e36b998d39d4790fe750d60c32406b`;
- zlib three-track: `73dbb405fbd2b68b62d29913b697a72100f8606cdb2ee704c55908e4de389e17`.

All inputs independently parsed as version `12.13.10.3`. Four of four cases and all eight native cycles passed. Every worker and iTunes process exited 0 after normal COM `Quit`; identity/semantic error lists were empty; no XML, backup, damaged-library, or other forbidden fallback appeared. Every native save independently parsed as version `12.13.11.1`. The three-track cases preserved deterministic identities, Unicode names, and ordered membership.

This establishes only exact-hash upgrade/open/save/restart compatibility for the pinned signed executable. It does not qualify arbitrary 12.13.11.1 editing, close U-01, or establish universal ITL support.

## Integrated evidence

The retained evidence root is `evidence/research/20260927/itunes-12.13.11.1-version-qualification/` and includes complete one-track/three-track native outputs, both setup-modal failures, executable/package provenance, the two executable-identity negative preflights, a human README, and a deterministic `qualification-summary.json`. The summary generator and regression live at:

- `scripts/research/summarize_itunes_version_qualification_20260927.py`;
- `tests/test_itunes_version_qualification_20260927.py`.

The delivery/corpus manifests and retained-trailer census are regenerated as part of integration so the ten newly retained ITLs are represented without guessing their version or envelope distributions.

## Next steps

1. Keep U-01 open and deliberately sample additional signed standalone releases with exact executable identity, positive and negative fixtures, and independent reproduction.
2. Separate upgrade compatibility from per-version semantic-edit support; do not enable 12.13.11.1 production writes until record/layout and field-specific native evidence justify it.
3. Add a deliberately changed scalar and a structural candidate under an adjacent build only after defining version-specific preflight and expected native transformations.
4. Continue closing format gaps with retained failures, exact hashes, no-fallback gates, and normal process-exit evidence rather than extrapolating from repeated saves.
