# Independent bounded fuzz — selected corpus only

Target commit: `56069f1e2a17d9aea62c1d753b2bd93ed404a000`; seed `539363593` (`0x20260909`).

**503 executions completed**:7 unchanged controls and496 selected mutation/publication cases.124 accepted,379 refused,0 unexpected exceptions/assertion failures. These are executions, not a claim of503 unique adversarial byte strings. Unexecuted cases are not counted as successes. The2000 limit was a ceiling, not a promised coverage target.

All116 accepted non-publication cases had exact no-op bytes;8 new-file publication controls wrote complete expected bytes.16 existing-target refusal cases preserved the exact sentinel bytes,16 injected write/link failures left the destination absent and cleaned sibling temps, and8 in-memory transactional refusals preserved the original library bytes. None uses concurrent/racy execution.

The batch took1.716s in the harness (5.633s executor runtime), maximum measured case29.249ms. Peak Python working set 37.48MiB;512MiB limit. Resource method is Windows GetProcessMemoryInfo on the current process after each case (OS-maintained peaks), plus disk sums. It does not measure the whole shared environment.

## Boundaries and limitations

Binary ingress always passes explicit `max_plain_bytes` (at most4MiB); expansion tests use smaller explicit limits and fail promptly above them. Hostile declared record/header lengths include0x7fffffff/0xffffffff but do not allocate that amount. JSON tests are small and use only the prevalidated immutable synthetic baseline or invalid base64. `Library.from_dict` has no max_plain_bytes argument, so adversarial compressed original-file JSON was **not executed** through that API. Internal reconstruction only rereads already bounded generated data. This limitation is not a pass or a general resource-safety claim.

Rejected counts refer to the exercised pipeline, not exclusively initial parsing. Supported identity/reference/count checks were evaluated where the independent parser supports the layout; unavailable scopes and observations outside the raw-read contract are counted separately in checks/closing-qa.json. Container-only acceptance is opaque-byte preservation, not semantic validity.

No native iTunes, COM/UI, repeated native/import operations, network or new dependency installation. Only files below this phase directory were written. All42 previously completed identity artifacts, including the original IDENTITIES_DONE and report, remain hash-identical; all7 source ITLs and exported source hashes remain unchanged.

## Evidence / reproduction

- report.json: actual counts, resources, seed, scope and preservation.
- source-input-manifest.json and source-git-tree.txt: exact Git object/source/input/archive/harness pins.
- case-plan.json and logs/cases.jsonl: every attempted case and exact field-level recipe/outcome/time.
- repros/minimal-refusals.json: representative one-bit/one-field/boundary witnesses with observed exceptions. No unexpected failure witness was found. Not a claim of global minimization.
- checks/closing-qa.json and logs/execution-ledger.json: independent tally, preserved targets and drained command receipts.

For a read-only binary/JSON witness, run the supplied harness with `--replay INDEX`, using the same absolute identities cwd, read-only Python with `-B`, `PYTHONDONTWRITEBYTECODE=1` and UTF8. The case plan fixes its individual seed. Do not replay atomic cases into existing evidence paths; choose a fresh owned temp namespace first. Full batch output creation is exclusive and refuses accidental reruns into existing results.

An optional nonexistent README path caused the first archive setup command to exit1 before any cases ran. It was corrected using the verified existing itlkit and pyproject paths; the zero-byte failed archive is retained as setup evidence and is not the source used for the run.
