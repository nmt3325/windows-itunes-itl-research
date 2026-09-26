# Integrated parser reanalysis

This addendum reanalyzes the retained native-rating snapshots without launching iTunes. The immutable execution-time report remains `report.json`; this file makes its parser provenance and later integration drift explicit.

## Provenance

- Frozen producer commit: `e1392568c77fbd3a49c72d3e80f802999b7aac6a` (parent `9dc9be906c30172fc8d0ac9550d28cb137e63e42`).
- Frozen report canonical JSON SHA-256: `b6881790a3eed66a07245c3ddddf6b3d7dfa1dfef10d91b65f3043114ed79051`.
- Integrated source hashes:
  - `itlkit/library.py`: `e75403812ab758bdcec8e2ab7849e204daa033f8cfbd1c1617744ca28c39b9ba`
  - `REFERENCE_PARSER/core.py`: `096eba595724c30e24360b527a9756ee8044e0e5fa12a860e000245cbbe67bde`
  - `scripts/windows/native_rating_kind_20260925.py`: `b25df8811296e1ff1e6715956ad97a3af1d70c6f5ba07f43e50b13a5f92fbb48`

## Result

- Retained snapshot occurrences: **27**; unique snapshot SHA-256 values: **21**.
- Frozen high-level outcomes: `{"blocked": 7, "observed": 20}`.
- Integrated high-level outcomes: `{"observed": 27}`.
- Outcome differences: **7 occurrences / 1 unique hash**. All seven differences are repeated copies of the pinned raw baseline, not independent native runs.
- Integrated targeted primary parser, independent parser, and VALIDATOR checks: **27/27 passed**.

## Interpretation

The seven frozen blocked outcomes were repeated analyses of the same raw baseline hash, not seven independent native experiments.  The integrated Library now accepts that exact native-qualified zero-secondary-ID fixture on its read/no-op path, so all 27 retained snapshot occurrences are observed by the integrated high-level parser.  Targeted fields, the independent parser, VALIDATOR results, native operations, and bounded U-14 conclusions are unchanged.

## Claim boundary

- This is offline parser reanalysis, not a new native iTunes run.
- Snapshot occurrences and repeated baseline copies are not independent experiments.
- High-level parser acceptance does not establish universal ITL support or native acceptance.
- The frozen report remains the execution-time record; this file records later parser drift.
