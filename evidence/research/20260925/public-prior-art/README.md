# Public prior-art evidence — 2026-09-25

This directory records a pinned, offline audit of six public repositories and a 14-fixture historical ITL interoperability experiment.

- `audit.json`: pinned source facts, SHA-256/size metadata for the external `titl` fixtures, and bounded results from `Container`, `Library`, version detection, and `ReferenceLibrary`.
- `external-test-status.json`: upstream build/test commands at the outcome level, including setup-only failures and retries.
- [`../../../../docs/PUBLIC_PRIOR_ART_AUDIT_20260925.md`](../../../../docs/PUBLIC_PRIOR_ART_AUDIT_20260925.md): interpretation and reproduction procedure.
- [`../../../../scripts/research/audit_public_prior_art_20260925.py`](../../../../scripts/research/audit_public_prior_art_20260925.py): deterministic audit implementation.

No third-party fixture bytes are stored here. `Container` decode, exact no-op preservation, and payload-equivalent forced rebuild are structural results only. No generated historical file was submitted to native iTunes, and no result closes U-01, U-02, or U-06.
