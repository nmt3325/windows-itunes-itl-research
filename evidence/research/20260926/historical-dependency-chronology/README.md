# Historical dependency chronology bound (2026-09-26)

This U-18 audit narrows chronology without inventing a historical environment.

- The retained Capstone/pefile-dependent static entry points first appear at commit `bd6944ec85a3993d731d65bcea530fa73320276e`, timestamped `2026-09-09T16:07:24Z`.
- That introduction tree contains no exact `capstone==...` or `pefile==...` pin.
- A retained PyPI JSON snapshot shows 36 Capstone releases and 14 pefile releases with at least one file uploaded by the cutoff. By upload time, Capstone `6.0.0a10` was the latest release, Capstone `5.0.9` the latest stable release, and pefile `2024.8.26` the latest release/stable release.
- The current profile's Capstone `5.0.9` and pefile `2024.8.26` therefore existed by the cutoff, but availability does **not** identify what was installed historically.

Files:

- generator: `scripts/research/audit_historical_dependency_chronology_20260926.py`
- compact PyPI chronology snapshot: `pypi-snapshot.json`
- derived report: `report.json`
- tests: `tests/test_historical_dependency_chronology_20260926.py`

Normal report rebuild and tests are offline. Only an explicit `--refresh-snapshot` performs two PyPI JSON requests. The snapshot records source-response SHA-256 values. It does not download packages, read a proprietary binary, invoke Ghidra/Unicorn/iTunes, or perform native acceptance. Exact historical Capstone/pefile versions remain unknown and U-18 remains open.
