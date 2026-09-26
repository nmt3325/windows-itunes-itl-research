# Public replay gap inventory (2026-09-26)

This deterministic U-18 inventory makes current public/static replay portability and the remaining blockers machine-checkable without claiming historical replay.

- Generator: `scripts/static/public_replay_gap_inventory.py`
- Report: `evidence/research/20260926/public-replay-gap-inventory/report.json`
- Tests: `tests/test_public_replay_gap_inventory_20260926.py`
- Scope: public repository files only

Current portability result:

- all five formerly machine-bound Python/PowerShell launch and extraction scripts now accept repository-relative or explicit input/tool/output paths;
- current machine-bound script count is `0`, compared with the preserved pre-parameterization baseline of `5`;
- the two timing-dependent output surfaces were removed, so the current timing-dependent count is `0` versus baseline `2`; and
- Python replay entry points expose `--help` before optional analysis dependencies are imported.

Remaining blockers:

- exact historical `capstone`, `pefile`, and PyCryptodome versions are unknown;
- proprietary `iTunes.exe`, the Ghidra distribution/project cache, and public/synthetic PE/Ghidra fixtures are unstaged; and
- the retained public atlas C hashes remain incoherent (`0/47` matches).

The inventory and tests perform zero network, proprietary-binary, Ghidra, Unicorn, iTunes, or native-acceptance operations. U-18 remains open. Closure still requires lawful inputs, exact historical dependency pins, staged/recreated Ghidra state, coherent provenance, and end-to-end Ghidra/Unicorn replay receipts.
