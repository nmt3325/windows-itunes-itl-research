# Bounded public/static replay bootstrap — 2026-09-25

## Scope

[`scripts/static/public_replay_preflight.py`](../../../../scripts/static/public_replay_preflight.py) is a standard-library-only preflight for the public retained static-analysis surface. It resolves the repository root relative to its own location, verifies 108 repository-relative files against [`public-replay-lock.json`](../../../../scripts/static/public-replay-lock.json), checks retained target/summary/atlas relationships, runs eight deterministic in-memory controls, and emits a timestamp-free receipt.

The preflight does not search for, download, read, reconstruct, or execute iTunes or any other proprietary binary. It does not invoke Ghidra, Unicorn, a native application, or the network.

## Replay

```bash
python -B scripts/static/public_replay_preflight.py \
  --check-report evidence/research/20260925/public-static-replay-bootstrap/report.json
python -m pytest -q tests/test_public_static_replay_bootstrap_20260925.py
```

The focused test assembles the locked public surface under two fresh repository-external roots, launches the copied preflight from an unrelated working directory, and requires both outputs to equal the retained [`report.json`](report.json) byte for byte. The two roots are repetitions of one deterministic replay, not independent binary-analysis experiments. The eight in-memory controls are six rejection cases and two positive cases, not independent experiments.

## Findings

The public lock verifies the current bytes of 47 retained decompiler outputs, 47 retained assembly outputs, the six historical launch/extraction scripts, the portable preflight, and seven retained metadata anchors. Target order, the 47-row decompiler summary, and the 47-row function atlas agree; all 47 assembly identity headers retain the pinned module hash; and all 41 retained offline-emulation test records say `pass: true`.

The preflight also preserves the blockers instead of relabeling them as success:

- all five historical static launch/extraction scripts outside the Ghidra Java post-script retain machine-specific absolute paths;
- two historical generators retain timing-dependent report fields;
- historical `capstone`, `pefile`, and PyCryptodome versions are not pinned;
- neither the proprietary module nor the Ghidra distribution/project cache is staged; and
- 0 of 47 `function-atlas.json` C hashes match the current public C file bytes, despite the retained historical final-QA declaration that all final C was hashed.

The lock establishes byte identity for the public files; it does not repair or authenticate the historical mismatch. Resolving it requires provenance or a lawful, pinned regeneration, not silently rewriting historical evidence.

## Claim boundary

A clean preflight and byte-identical receipt are not a Ghidra replay, a Unicorn original-machine-code replay, historical binary-analysis reproduction, native application acceptance, or independent reimplementation. U-18 remains open. U-13 and U-17 remain open. Universal ITL support remains false, completion percentage remains null, and independent reimplementation remains false.
