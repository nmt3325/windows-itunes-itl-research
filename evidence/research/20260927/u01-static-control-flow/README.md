# U-01 exact-build static control flow and retained-corpus record-layout census

## Scope and decision rule

This follow-up asks whether exact signed standalone Windows iTunes 12.12.10.1 has a concrete record, feature, or layout incompatibility that can justify a predeclared product-facing native negative independently of version labels. It extends the preceding no-launch inventory; it does not reinterpret the never-launched normalized derivative as native-authored or launch-eligible.

A native launch remained forbidden unless static control flow connected the localized newer-version/invalid-library family to a parser decision and the retained corpus supplied a causally defensible incompatibility. Neither condition was met. **This follow-up performed zero iTunes launches and zero native candidate attempts.**

## Locked executable and tool provenance

The analyzed executable remained outside the repository:

- path: `C:\Program Files\iTunes\iTunes.exe`
- size: 39,260,512 bytes
- SHA-256: `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`
- File/Product version: `12.12.10.1`
- Authenticode: `Valid`, Apple Inc., thumbprint `67A9953123BD5F01B1BC0BB98A950D9CA869CD02`

Full headless analysis used Ghidra 12.1.3 from the official release archive:

- URL: `https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_12.1.3_build/ghidra_12.1.3_PUBLIC_20260817.zip`
- archive size: 569,445,154 bytes
- archive SHA-256: `93a5d11a9ad510622acaaf908c556a7b9b764d338e78a7567f3689bf5081fd54`
- JDK: Temurin 21.0.12
- recovered function count: 62,218

The Ghidra project, analysis log, executable, Apple DLLs, and localization files are not retained. `ghidra-localization-flow.json` is 746,438 bytes with SHA-256 `79bb1af0dbe21722e53ec0a8d26831c2f6e88f909a473fb769e5c7858bd2c887`; two independent post-script passes over the saved project produced this byte-identical output. It contains derived addresses, xrefs, symbols, instruction text, counts, and bounded conclusions only. `U01LocalizationFlow.java` rejects any imported executable whose SHA-256 differs from the locked hash.

## Retained-corpus census

`inventory_u01_record_layouts_20260927.py` verifies every `.itl` entry already named by `DELIVERY-MANIFEST.json`, then parses and walks every record with the independent reference parser.

- 431 manifest ITL hashes verified.
- 430 strict parses.
- One expected refusal: the already-declared one-byte-truncated U-01 preflight control.
- Label counts: 6 × 12.12.10.1, 12 × 12.13.9.1, 392 × 12.13.10.3, and 20 × 12.13.11.1.
- Every label has the same 11 section types: `1, 2, 4, 9, 11, 12, 13, 14, 16, 21, 23`.
- Every label has the same 14 tag/header layouts: `mfdh/144`, `mhgh/280`, `mhoh/24`, `miah/88`, `miih/100`, `miph/3500`, `mith/756`, `mlah/92`, `mlih/100`, `mlph/92`, `mlsh/44`, `mlth/92`, `msph/48`, and `mtph/84`.
- 12.13.11.1 has no later-only section type, tag/header layout, or `mhoh` type. Its later-only child-count buckets are `miph` 9/10, `mith` 4, and `mlah`/`mlih`/`mlth` 3. Bucket 10 means ten or more children; these are retained population/metadata counts, not layouts.
- The eight `mhoh` values seen only under retained 12.13.10.3 labels are witnessed by ordinary Genre, Composer, Grouping, sort-field, and related field-matrix files. Absence from six related 12.12.10.1-labelled files is not a version-incompatibility result.

This corpus contains related snapshots, generated fixtures, controls, saves, timeout survivors, and one normalized derivative. It is exhaustive for the retained delivery-manifest ITLs but is not a representative or independent version sample.

## Static path recovered

The exact group-`0x1f42` wrapper begins at VA/RVA `0x1401fb500` / `0x1fb500`. Its descriptor is at VA/RVA `0x1419fd810` / `0x19fd810`; member 3 (newer-version message) is at RVA `0x19fd7c0`, and member 4 (invalid-library message) is at RVA `0x19fd7d0`.

The 19-instruction wrapper:

1. reads the shared registration dictionary at VA/RVA `0x14211aeb8` / `0x211aeb8`;
2. lazily calls through VA/RVA `0x14192f340` / `0x192f340`, resolved as `COREFOUNDATION.DLL::CFDictionaryCreateMutable`, if the dictionary is absent;
3. loads the descriptor into `r8` and places `0x1f42` in `edx`;
4. tail-jumps through VA/RVA `0x14192f5e8` / `0x192f5e8`, resolved as `COREFOUNDATION.DLL::CFDictionaryAddValue`;
5. otherwise returns if dictionary creation fails.

This is a localization-group dictionary registration initializer, not a parser-facing lookup accessor. The earlier raw-scan candidate near VA `0x1419335e8` has zero Ghidra references and is not the wrapper tail target.

Two data references reach the wrapper: `.pdata` RVA `0x215f2bc` and the `.rdata` absolute-pointer slot RVA `0x1949d58`; neither is a call, jump, or executable-source reference. All 17 pointer cells at radius ±8 resolve to executable Ghidra function entries. The descriptor has one analyzed reference from wrapper RVA `0x1fb52c`; the member-3 and member-4 entries have zero recovered references. A whole-program immediate scan found ten `0x1f42` uses and no immediate `0x1f420003` or `0x1f420004` use.

The report therefore identifies no direct parser caller, parser result/status comparison, semantic status code, or branch selecting member 3 versus member 4. Xref absence is not proof that no unresolved runtime-computed path exists; it is a fail-closed boundary on what this static pass recovered.

## Fail-closed result

No retained 12.13.11.1 record layout is absent from 12.12.10.1, and the recovered static path is registration machinery rather than a parser decision. Therefore:

- `concrete_non_label_incompatibility_theory_identified = false`
- `native_launch_authorized = false`
- native launches and candidate attempts remain zero
- no product-facing native negative is established
- no 12.12.10.1 parser/writer profile is admitted
- arbitrary editing, universal ITL support, independent reproduction, and complete analysis remain unqualified
- U-01 remains open

## Reproduction

From the repository root:

```console
python -B scripts/research/inventory_u01_record_layouts_20260927.py --check
python -B -m pytest tests/test_u01_static_control_flow_20260927.py -q -p no:cacheprovider
```

The Ghidra report can be regenerated only with a lawful local copy of the exact executable and the verified Ghidra/JDK toolchain. A representative post-analysis invocation is:

```text
analyzeHeadless <project-dir> U01Static -process iTunes.exe -noanalysis \
  -scriptPath <repo>/scripts/ghidra \
  -postScript U01LocalizationFlow.java <output>/ghidra-localization-flow.json
```

The initial project import must perform full analysis before the `-noanalysis` post-script pass. Do not copy the executable, project, resource binaries, or raw analysis dumps into the repository.
