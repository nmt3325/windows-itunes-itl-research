# 2026-09-26 autonomous resume plan

## Baseline

- Runner: `linux-de3gz60d` (`windows-itunes-itl-research-main-20260926`, Linux, bash, work dir `/home/runner/work/_temp/gha-mcp/linux-de3gz60d/work`).
- Baseline branch: `origin/research/20260925-final-integration`.
- Baseline commit: `009a429213192b9450e865f75b61cac9be48bf25`.
- Current integration branch: `research/20260926-autonomous-resume`.
- Verified carry-over status: `universal_itl_support=false`, `percentage_complete=null`, `independent_reimplementation_passed=false` remain required. Native acceptance must not be generalized from parser return, structural replay, no-op replay, repeated saves, copied controls, or the same runtime/filesystem/process.

## Repository state read on resume

- `completion-status.yaml` reports a complete deliverable set but `partial_guarded_research`, `full_analysis_specification_gate=false`, and open blockers.
- `UNRESOLVED.md` keeps U-13, U-17, and U-18 open.
- U-13: one exact 17-byte opaque trailer candidate and trailer-free control passed two native cycles; native save stripped the trailer. This is exact-candidate trailer-fate evidence only.
- U-17: parser fuzzing, Linux/Windows filesystem publication, and process-termination scenarios are bounded and contain zero power-loss operations. Hostile-directory, network filesystem, alternate-runtime, and universal durability remain unproved.
- U-18: deterministic public/static replay preflight exists, but historical Ghidra/Unicorn/static replay is unavailable; dependency pins, lawful public/synthetic inputs, and coherent provenance are missing.

## Immediate task split

The next work should add evidence without changing the guarded claims above.

### T1 — U-18 public replay bootstrap survey and executable next step

Owned paths: `reports/u18-public-replay-survey.md` initially. If implementation is clearly low-risk, propose or create repository changes under `docs/`, `scripts/static/`, `tests/test_public_static_replay_bootstrap_20260925.py`, and `evidence/research/20260926/public-replay-*` only after reporting the exact plan.

Acceptance:
- Identify the five historical static launch/extraction scripts and two timing-dependent outputs currently blocking U-18.
- Identify dependency pins and public/synthetic inputs already present vs missing.
- Recommend one bounded deterministic artifact that can be added on Linux without proprietary binaries and without claiming historical replay.

### T2 — U-13 trailer provenance/negative-matrix survey

Owned paths: `reports/u13-trailer-next-matrix.md` initially. If implementation is low-risk, propose repository changes under `docs/`, `scripts/research/`, `tests/test_trailer_coverage_audit.py`, and `evidence/research/20260926/trailer-*` only after reporting the exact plan.

Acceptance:
- Reconcile existing trailer coverage, native stripped-trailer evidence, and validator fail-closed behavior.
- Identify trailer classes already covered vs still high-value (multi-member zlib, non-zlib tail, length/offset edge, cap/opaque collision, public-prior-art analogues).
- Recommend a deterministic offline matrix that does not claim safe semantic editability or native acceptance.

### T3 — U-17 filesystem/process-crash next-matrix survey

Owned paths: `reports/u17-filesystem-next-matrix.md` initially. If implementation is low-risk, propose repository changes under `docs/`, `scripts/research/`, `tests/test_*filesystem*20260925.py`, and `evidence/research/20260926/filesystem-*` only after reporting the exact plan.

Acceptance:
- Summarize current Linux/Windows process-termination and publication evidence boundaries.
- Identify one GHA-feasible extension with real added evidence value (for example alternate Python runtime, cross-device/hard-link-failure behavior, tmpfs/ext4 contrast if available, or richer crash schedules) while explicitly excluding power-loss unless real power-control exists.
- Recommend concrete commands and expected report fields.

## Parent responsibilities

- Parent performs integration edits, shared docs, commits, pushes, and final validation.
- Children must not create/destroy/extend GHA environments, create/remove worktrees, push, or edit outside their owned report unless explicitly instructed later.
- Parent keeps TODO non-empty and commits useful progress before runner expiry.
