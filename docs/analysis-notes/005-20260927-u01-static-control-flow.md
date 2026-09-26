# 005 — U-01 static control flow and retained-corpus record-layout census

## Objective and execution boundary

This continuation pursued the same narrow U-01 prerequisite as note 004: identify a concrete, non-version-label record, feature, or layout incompatibility that exact signed Windows iTunes 12.12.10.1 plausibly rejects, then—and only then—prepare a new pre-outcome native plan. Priority went to static recovery from localization group `0x1f42` toward a parser/result branch selecting member 3 (newer-version library) versus member 4 (invalid library).

The theory gate did not pass. **No iTunes process was launched, no candidate was copied into a live library root, and no native attempt occurred.** The existing 3,006-byte normalized derivative remains ineligible for native execution.

## Exhaustive retained-corpus layout census

A new deterministic generator, `scripts/research/inventory_u01_record_layouts_20260927.py`, verifies every `.itl` entry in `DELIVERY-MANIFEST.json` and walks every strictly parsed record with the independent reference parser. It verified 431 hashes, parsed 430 files, and retained the one expected refusal for the deliberately one-byte-truncated U-01 control.

The parsed labels comprise six 12.12.10.1 files, twelve 12.13.9.1 files, 392 12.13.10.3 files, and twenty 12.13.11.1 files. All four labels share:

- section types `1, 2, 4, 9, 11, 12, 13, 14, 16, 21, 23`;
- fourteen tag/header layouts: `mfdh/144`, `mhgh/280`, `mhoh/24`, `miah/88`, `miih/100`, `miph/3500`, `mith/756`, `mlah/92`, `mlih/100`, `mlph/92`, `mlsh/44`, `mlth/92`, `msph/48`, and `mtph/84`.

Relative to 12.12.10.1, the 12.13.11.1 files add no section type, tag/header layout, or `mhoh` type. Their later-only observations are capped child-count buckets (`miph` 9/10, `mith` 4, and `mlah`/`mlih`/`mlth` 3) caused by retained multi-track/candidate populations. Bucket 10 means ten or more children; it is not a layout. The eight `mhoh` values found only under retained 12.13.10.3 labels have ordinary Genre, Composer, Grouping, and sort-field witnesses, so absence from six related 12.12-labelled files is not a defensible version gate.

The census is exhaustive for the retained delivery corpus but not representative of all native libraries or versions. It cannot by itself prove semantic compatibility or native acceptance.

## Exact-build full static analysis

The executable remained `C:\Program Files\iTunes\iTunes.exe`, 39,260,512 bytes, SHA-256 `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`, File/Product version 12.12.10.1, with valid Apple Inc. Authenticode signature and thumbprint `67A9953123BD5F01B1BC0BB98A950D9CA869CD02`.

Official Ghidra 12.1.3 (archive SHA-256 `93a5d11a9ad510622acaaf908c556a7b9b764d338e78a7567f3689bf5081fd54`) performed full headless analysis under Temurin JDK 21.0.12. The project recovered 62,218 functions. The hash-gated `scripts/ghidra/U01LocalizationFlow.java` post-script was then run twice with analysis disabled; both 746,438-byte reports were byte-identical at SHA-256 `79bb1af0dbe21722e53ec0a8d26831c2f6e88f909a473fb769e5c7858bd2c887`. The Apple executable, resources, Ghidra project, and raw logs remain outside the repository.

### Recovered wrapper semantics

The group wrapper is a 19-instruction function at VA/RVA `0x1401fb500` / `0x1fb500`. Full-analysis symbols and instruction xrefs establish this bounded path:

1. read the shared registration dictionary at VA/RVA `0x14211aeb8` / `0x211aeb8`;
2. if absent, call through VA/RVA `0x14192f340` / `0x192f340`, resolved as `COREFOUNDATION.DLL::CFDictionaryCreateMutable`, then store the result in the shared global;
3. load descriptor VA/RVA `0x1419fd810` / `0x19fd810` into `r8` and group ID `0x1f42` into `edx`;
4. tail-jump through VA/RVA `0x14192f5e8` / `0x192f5e8`, resolved as `COREFOUNDATION.DLL::CFDictionaryAddValue`.

Thus the wrapper registers the group descriptor in a shared CoreFoundation dictionary. It is not a recovered parser-facing message lookup. The earlier raw-scan candidate near VA `0x1419335e8` had zero Ghidra references and is not the wrapper's tail target; retaining it as a “lookup slot” would have been incorrect.

The xref inventory further bounds the result:

- the wrapper has two data references only—one from `.pdata` and one from the `.rdata` absolute-pointer table—and zero call, jump, or executable-source references;
- all 17 pointer cells at radius ±8 resolve to executable Ghidra function entries, supporting a generated wrapper table classification;
- the descriptor has one analyzed data reference from wrapper RVA `0x1fb52c`;
- member 3 at RVA `0x19fd7c0` and member 4 at RVA `0x19fd7d0` each have zero recovered references;
- the registration dictionary has 223 executable-source references (112 reads and 111 writes), the create slot has 795, and the add-value slot has 714;
- a whole-program scalar-immediate scan found ten uses of `0x1f42`, including wrapper RVA `0x1fb533`, and no immediate use of `0x1f420003` or `0x1f420004`.

Absence of a Ghidra xref does not prove that no runtime-computed or otherwise unresolved path exists. It does mean this analysis recovered no direct parser caller, parser result/status comparison, member-3/member-4 selection branch, or semantic status code.

## Decision and claim limits

No concrete non-label incompatibility theory survived either route:

1. the retained 12.13.11.1 population contains no new section, record tag/header layout, or `mhoh` type relative to retained 12.12.10.1; and
2. the exact-build static path is a generated localization-group dictionary registration initializer, not the parser branch that chooses the product message.

Accordingly, launch authorization remains false and no new pre-outcome native plan was created. The missing product-facing negative cannot be replaced by a malformed preflight refusal, a force-terminated timeout survivor, the normalized derivative, or static resource adjacency.

This work does not admit a 12.12.10.1 parser/writer profile, arbitrary edits, universal ITL support, independent semantic reproduction, or complete analysis. U-01 remains open.

## Reproducibility and validation

The committed evidence directory contains:

- `record-layout-census.json`, regenerated byte-exactly by its Python generator;
- `ghidra-localization-flow.json`, deterministic derived metadata from the exact hash-gated Ghidra project;
- a provenance/method/boundary README;
- focused regressions in `tests/test_u01_static_control_flow_20260927.py`.

Final generator, focused-test, authoritative-suite, manifest, YAML, delivery, forbidden-binary, and clean-worktree results are recorded in `completion-status.yaml` and the delivery commit. They validate reproducibility and packaging; they do not change the causal no-launch outcome.

## Next work

A successor should search upstream for a parser error/result object or comparison whose alternatives can be tied to a specific record, feature, or layout. Re-scanning the same localization member table or registration wrappers cannot provide that causal bridge. Any future candidate must still pass independent structural/semantic preflight and receive a complete committed-and-pushed two-attempt native plan before launch. Without that bridge, the correct result remains zero launch and U-01 open.
