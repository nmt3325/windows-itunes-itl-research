# G2 offline self-checks

`g2_action_selftest.py` is NEW G2 test code. It is not the recovered
`action_selftest.py`, not a substitute for its missing final 8061-byte body,
and not a production acceptance engine.

## Execution and isolation

Use the parent-approved Python interpreter, `-B -X utf8`, the assigned
worktree as cwd, and a NEW child directory under `ROOT/reports/dynamic`:

```text
PYNATIVE2 -B -X utf8 scripts/windows/continuation20260910/g2_action_selftest.py --suite new --out ROOT/reports/dynamic/NEW_RUN/new
```

Replace the two symbolic paths with absolute assigned paths. Each invocation
refuses an existing output directory. Other suite names are `oracle`,
`legacy-harness`, `legacy-phase2`, `legacy-import`, `legacy-raw` and
`legacy-playback`; give each a separate new output directory.

- Five recovered originals, seven legacy helpers and seven additional test
  dependencies are SHA-pinned and checked before and after execution.
- Actual COM/pywin32 modules are NOT imported. Explicit fail-closed module
  doubles replace them before loading the fixed discovery code.
- Subprocess, shell, network and native UI entry points are blocked in the
  test process. Individual tests replace only the needed mock boundary.
- An audit hook refuses file writes outside the new report directory.
- `oracle` uses an explicitly synthetic three-track state, not a native
  baseline. Its original test body is unchanged.
- Legacy tests retain their original bodies and their own result groups.
  Playback selftest checks predicates only; it does not play audio.
- `scope.json`, `result.json` and `unittest.log` identify all generated data
  as mock-only. Parser fixtures and simulated saved files are NOT native
  observations, candidates, acceptance results, or engine witnesses.

## What the new tests cover

Fixed-source shape/comparison, action capability and identity guards,
requested-value readback, mocked worker/controller failures, chooser guards,
raw capture, and hidden record membership/order. A separate TEST-ONLY
contract model exercises old/new ID partitions, immutable intent, media
inventory, two saves, normal exits, complete observations and save chaining.
Its successful consistency result always has `native_acceptance=false` and
`engine_witness=false`. It must not be used as an engine witness.

## Unresolved stronger-contract probes

Expected failures are recorded separately, NOT counted as passing guarantees:

1. Equal omitted metadata can evade a comparison of two incomplete states.
2. A header-only delta does not compare hidden record children/order.
3. The legacy raw audit verifies membership multisets, not physical order.
4. Discovery shape checking does not require unique manual order tokens.
5. Discovery shape checking alone permits an unavailable Name observation.
6. Discovery shape checking permits omitted reported enumeration counts.
7. The controller trusts worker exit zero without independently requiring
   the COM result's `ok` and `quit_returned` flags.

These characterize the fixed discovery helpers versus a stronger acceptance
contract; they do not rewrite the helpers or claim their intended discovery
behavior is a complete writer-admission gate. A completed discovery setter
can also report `requested_value_matched=false`; completion is not matching.

Consult the separate run reports for actual counts, source hashes, exit
receipts and gap tracebacks. A passing offline suite does not authorize
COM/UI/iTunes activation. Native acquisition and an explicit parent handoff
remain prerequisites. G1 jobs and native cases must not be replayed.
