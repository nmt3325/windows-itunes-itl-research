# U-01 structural candidate inventory and no-launch decision

## Scope

This is a deterministic offline follow-up to the failed predeclared iTunes 12.12.10.1 product-negative experiment. It inventories exact retained native files, decodes candidate structural differences, records derived localization metadata from the installed exact executable, and builds one version-normalized derivative. **It launched no iTunes process and establishes neither native acceptance nor native rejection.** U-01 remains open.

The target executable remains the signed standalone iTunes 12.12.10.1 binary at SHA-256 `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`. No Apple executable, DLL, installer, or localization resource bytes are retained here.

## Reproduction

```bash
python -B scripts/research/inventory_u01_structural_candidates_20260927.py --check
python -B -m pytest -q -p no:cacheprovider \
  tests/test_u01_structural_candidate_inventory_20260927.py \
  tests/test_u01_distinct_build_20260927.py \
  tests/test_reference_native_version_split.py
```

`--check` rebuilds the derivative and the normalized inventory in memory and requires byte-exact equality with the checked-in files.

## Retained artifacts

- `native-structure-inventory.json` — deterministic census and decision record; 50,620 bytes; SHA-256 `e728f8a193786afa91e097b6e8f48d4012a0ccf8e6ce94af66e7f610a40893a7`.
- `static-localization-evidence.json` — derived exact-build resource IDs, offsets, and wrapper metadata; SHA-256 `c4288a4bb1a3afd95ec4c1bb23459a15274a29b902ba57f600265a419ba7104d`.
- `predeclared-no-launch-plan.json` — fail-closed candidate decision and future launch gates; SHA-256 `bb8b4f8d609a98f89cb31f1ddef80b466bc83723cab4d63d6f91ddca6ce382f8`.
- `candidates/native-12.13.11.1-normalized-to-12.12.10.1.itl` — 3,006-byte offline derivative; SHA-256 `e9ea49521b72e8d166ec852531927069ca6fb8dc6a37ea9e59ae3bbda8916f47`; never launched and not native-authored after normalization.

## Corrected findings

- `mhgh+0xE5 = 4` is not newer-only: both clean normally quit 12.12.10.1 positive saves contain it.
- Section type 21 is not a newer-only feature: clean 12.12.10.1 emits it, while the matched newer one-track files do not.
- `mhoh` type 109 is XML plist playlist-view state. The shared object contains `lastViewedPlaylist=81`, `lastViewedPlaylistViewMode=7`, and `tabViewMode=4`; the additional newer object is optional Podcasts view state. A second object does not establish a compatibility gate.
- Force-terminated timeout survivors remain observations only. They are not clean acceptance cycles or product-facing rejection.
- The exact-build resources contain distinct newer-version and invalid-library messages at IDs `0x1f420003` and `0x1f420004`. Their generated group wrapper was localized, but no parser branch, member-selection call site, or semantic status code was established.

## Why the derivative was not launched

The source is the clean iTunes 12.13.11.1 cycle-2 save at SHA-256 `744c379586231ab6e28c75d805d7ad8696e8325e83e74b1b39568f009e89bdad`. The generator normalizes both outer and inner Pascal labels to `12.12.10.1`; after restoring the inner label for comparison, the decoded payload is otherwise byte-identical. File identity, selected track and playlist semantics, topology, type census, and both type-109 plists are retained.

Those retained differences are optional UI state, not a defensible newer-only record, feature, or layout. Therefore the theory gate failed, `launch_authorized` is false, and zero attempts were authorized. Launching it would test label normalization plus optional UI state rather than the required structural incompatibility.

A future native attempt requires a new committed and pushed predeclaration with a concrete non-label incompatibility theory, exact candidate/control and executable identities, two fresh-copy attempts where feasible, exact newer-version-versus-invalid modal classification, normal dismissal and exit, complete cleanup, forbidden-fallback checks, separate outer/COM identity checks, and independent-parser semantic checks. No post-hoc candidate replacement is permitted.
