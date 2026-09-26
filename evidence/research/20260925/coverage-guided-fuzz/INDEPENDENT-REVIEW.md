# Independent review receipt

## Immutable source

A separate clean Linux checkout reviewed remote branch `research/20260925-coverage-guided` at exact commit `a64669e85e97f9c2c045474abe4054d7d8d801fc`, with parent `7d2382cfba9c5093f3fd734f5ada1bf66cff2217` and grandparent `dc92e454a3717224fff099cfa254c7a38a29b636`. The reviewer did not modify or push the branch.

## Reproduction results

- Retained report: 63,006 bytes; SHA-256 `cbf33f4d8f0ea9d6ea3aae968bb081a6b59d64314f0d51dbb74caf7c51a2af37`.
- Generator SHA-256: `64eaf3ab979b61b52af05bcc073ea295277a417f5614a624ec34340efbe17e66`.
- Runtime matched the report: CPython 3.12.3, PyCryptodome 3.23.0, zlib compile/runtime 1.3.
- All 13 production-source hashes and all eight seed file/size/payload hashes matched.
- All summary, admission, lineage, queue, module, edge, and final-line arithmetic passed.
- The complete 20,000-mutation rerun was byte-identical to the retained report.
- Dedicated hardening/campaign regression: **139 passed**.
- Full exact-root regression at the reviewed source commit: **1,114 passed, 7 skipped**.

The reviewer independently exercised positive non-Boolean budget validation, exact compressed and uncompressed limits, ASCII and Unicode whitespace, odd/invalid hex, over-limit projected payloads, an oversized decompressed retained baseline with a small projected payload, default compatibility, strict exception classification, and tracer cleanup after accepted/refused/anomalous paths. The native-rating reanalysis refresh differed only by the expected `itlkit/library.py` source hash; its semantics and Markdown were otherwise identical.

Changed-file and repository hygiene checks found no NUL/BOM/CRLF text, runner-specific absolute path, high-confidence credential, unexpected binary, symlink, submodule, executable mode, tracked cache, or whitespace error.

## Recommendation and boundary

**Accepted for bounded integration.** The result supports the explicit 128-KiB, single-process, fixed-runtime offline campaign and decoded-plaintext hardening. It does not establish native iTunes acceptance, universal parser safety, branch completeness, unbounded-input safety, concurrency safety, crash/power-loss behavior, or hostile-filesystem safety. `max_plain_bytes` does not bound an already-loaded JSON document or its base64/header/trailer text; hostile-input callers must impose a separate document-size limit.
