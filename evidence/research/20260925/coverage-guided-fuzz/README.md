# Bounded coverage-guided parser campaign — 2026-09-25

## Scope

This is a deterministic, single-process, offline robustness campaign against four separate `itlkit` entry points:

- encrypted/compressed `hdfm` container parsing and exact reconstruction;
- structural model parsing and JSON projection;
- smart-playlist rule parsing; and
- smart-playlist preference parsing.

The campaign targets production source at commit `7d2382cfba9c5093f3fd734f5ada1bf66cff2217`. The retained report also pins the generator, every imported `itlkit/*.py` file, every repository ITL seed, and the CPython/crypto/zlib runtime by version or SHA-256. It performs no native iTunes operation and publishes no file other than the explicitly selected report path.

Queue admission is per target. A candidate is admitted only when its SHA-256 is new for that target and CPython tracing observes at least one previously unseen transition between source lines under `itlkit/`. The four edge sets remain separate; their reported sum is not a union or a coverage percentage.

## Reproduce

From the repository root with project dependencies installed:

```bash
PYTHONDONTWRITEBYTECODE=1 python -B \
  scripts/research/run_coverage_guided_fuzz_20260925.py \
  --iterations 20000 \
  --output /tmp/coverage-guided-fuzz-report.json
cmp evidence/research/20260925/coverage-guided-fuzz/report.json \
  /tmp/coverage-guided-fuzz-report.json
sha256sum /tmp/coverage-guided-fuzz-report.json
```

The retained [`report.json`](report.json) is 63006 bytes and has SHA-256 `cbf33f4d8f0ea9d6ea3aae968bb081a6b59d64314f0d51dbb74caf7c51a2af37`. It contains no timestamps or absolute runner paths. A rerun is expected to be byte-identical only with the pinned source, seeds, generator, and compatible recorded runtime; CPython trace semantics are part of the evidence boundary.

## Bounds and results

- Fixed xorshift64* seed: `0x20260925c0f17e`.
- Maximum candidate and decoded-plaintext size: 131,072 bytes each.
- 35 seed controls and 20,000 mutations (5,000 per target).
- 9,090 accepted mutations, 10,910 explicit parser refusals, and zero retained anomalies.
- 34 coverage admissions: 15 container, 5 model, 12 smart-rule, and 2 smart-preference candidates.
- Per-target final transition counts: 336, 128, 292, and 93 respectively; the reported sum of 849 is explicitly not a union.
- Every accepted path checks byte-exact no-op serialization. Container reconstruction additionally checks decoded payload, opaque trailer, and non-size header state; library/model JSON projections are checked where applicable.

Only `ITLError` (the documented invalid-input/unsupported-operation hierarchy) counts as an expected refusal. Raw `ValueError`, `TypeError`, `UnicodeError`, assertion failures, and other ordinary exceptions are retained as anomalies. The tracer keys live frame objects and clears them after each action, preventing frame-ID reuse from joining unrelated exceptional paths.

## Independent review

A separate clean checkout independently reran the complete campaign, source/seed/admission arithmetic, adversarial JSON-budget matrix, exact-root test suite, and hygiene checks. See [`INDEPENDENT-REVIEW.md`](INDEPENDENT-REVIEW.md).

## Claim boundaries

This run found no anomaly in the exact bounded campaign. It is not branch-complete, a proof of parser safety, or evidence of native iTunes acceptance. Line transitions are a coarse guidance signal. The campaign does not test concurrency, power loss, hostile filesystem behavior, or unbounded inputs.

`max_plain_bytes` bounds decoded payload reconstruction, including a retained original baseline. It does not bound the already-loaded JSON document, base64 text, header text, or opaque trailer text; callers handling hostile JSON must separately cap input/document size.

Structural acceptance, exact parser replay, and envelope reconstruction do not establish semantic validity, safe editability, or native acceptance. U-17 and all other unresolved items remain open unless their documented native closure criteria are separately met.
