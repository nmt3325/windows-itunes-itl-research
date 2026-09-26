# Public replay gap inventory (2026-09-26)

This deterministic U-18 inventory makes the retained public/static replay blockers machine-checkable without claiming historical replay.

- Generator: `scripts/static/public_replay_gap_inventory.py`
- Report: `evidence/research/20260926/public-replay-gap-inventory/report.json`
- Focused tests: `tests/test_public_replay_gap_inventory_20260926.py`

The inventory reads only repository-local public files, performs zero network operations, reads zero proprietary binaries, performs zero Ghidra/Unicorn/iTunes invocations, and records no host absolute paths or timestamps. It keeps `u18_closed=false`, `historical_binary_analysis_reproduced=false`, `ghidra_end_to_end_reproduced=false`, `unicorn_original_machine_code_reproduced=false`, `native_application_acceptance=false`, `independent_reimplementation_passed=false`, `universal_itl_support=false`, and `percentage_complete=null`.

It inventories:

- five machine-bound historical launch/extraction scripts;
- two timing-dependent historical outputs;
- missing exact historical `capstone`, `pefile`, and PyCryptodome versions;
- unstaged proprietary `iTunes.exe`, Ghidra distribution/project cache, and missing public/synthetic PE/Ghidra fixtures;
- the retained `0/47` public atlas C-hash mismatch.

U-18 remains open. Closure still requires lawful inputs, exact dependency pins, staged/recreated Ghidra state, coherent provenance, and end-to-end Ghidra/Unicorn replay receipts.
