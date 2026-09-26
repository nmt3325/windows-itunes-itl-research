# 006 — U-01 exact-parser status-to-resource bridge

## Objective and execution boundary

Analysis note 005 established that the group-`0x1f42` path then recovered was generated localization registration machinery, not the missing parser selector. This continuation followed the exact Windows iTunes 12.12.10.1 parser upstream through its return-value consumer, status comparison, error construction, descriptor lookup, and resource entry.

The requested static causal bridge was recovered for a concrete non-version-label feature: outer-header encryption mode `>=3`. However, that same feature class is outside the independent parser's supported structural/semantic domain. It therefore fails mandatory preflight and cannot authorize a native attempt. **No iTunes process was launched, no candidate was installed in a live library root, and no native attempt occurred.**

## Exact-build method and provenance

The analyzed executable remained 39,260,512-byte signed standalone iTunes 12.12.10.1, SHA-256 `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`, with the previously recorded valid Apple Inc. signature and thumbprint `67A9953123BD5F01B1BC0BB98A950D9CA869CD02`.

The saved full-analysis Ghidra 12.1.3 project has 62,218 recovered functions. Hash-gated post-script `scripts/ghidra/U01ParserStatusFlow.java` was run twice with `-noanalysis`; both 49,898-byte reports were byte-identical at SHA-256 `40dd9a15a6b8a5b5e4974952b73085bd75a5ab2e3b9006c1a9cfd5293e613e35`. Only the bounded report was retained. Apple binaries/resources, the Ghidra project and logs, and broad/raw exploratory or decompiler dumps remain outside the repository.

## Exact parser, caller, and upstream result handling

The exact parser is `FUN_1410ad0b0` at RVA `0x10ad0b0`, with 4,920 body addresses. Its sole direct call reference is RVA `0x53db44` in `FUN_14053d500` at RVA `0x53d500`, whose body has 6,694 addresses. Upstream `FUN_14053f4e0` at RVA `0x53f4e0` calls the direct caller at RVA `0x53f62c`, preserves its return in `esi`, tests it, and sets its success byte only when the return is zero.

Within the exact parser:

- RVA `0x10ad257` reads a 16-bit parsed-header field at offset `+0x0c`;
- RVA `0x10ad25c` compares that field with `0x43`;
- a value above `0x43` reaches status `0xfffffc94` / signed `-876` at RVA `0x10ad262`;
- RVA `0x10ad2b2` compares unsigned byte `[r14+0x41]` with 3;
- RVA `0x10ad2b7` admits values below 3 by the carry branch;
- values `>=3` receive the same `-876` status at RVA `0x10ad2b9` and jump to parser cleanup/return.

The repository's independent envelope parser identifies outer-header byte `0x41` as the encryption mode/flag. This gate does not read either version-label field. Alternate parser `FUN_1410f4b90` at RVA `0x10f4b90` corroborates the exact same `byte +0x41 < 3` condition and `-876` failure at RVA `0x10f4d48`.

After the direct parser call, RVA `0x53db49` preserves `eax` in `r14d`, RVA `0x53db57` tests zero, and RVA `0x53db8d` explicitly compares `r14d` with `0xfffffc94`. Equality branches to RVA `0x53e30f`. The resulting error path places group ID `0x1f43` in `ecx` at RVA `0x53e387`, copies the preserved status to `r8d` at RVA `0x53e38c`, and calls `FUN_140ebbf20` at RVA `0x53e394`. That formatter forwards group/status into the error-container path and ultimately to descriptor mapper `FUN_140bfac90`.

## Descriptor and resource mapping

`FUN_140bfac90` reads the shared registration dictionary through `CFDictionaryGetValue`, obtains the group descriptor, walks 16-byte entries, reads fields at entry offsets `+0`, `+4`, `+8`, and `+0xc`, and compares the first word with the supplied status.

The group-`0x1f43` registration wrapper begins at RVA `0x1fb550`; it loads descriptor RVA `0x19fd7e8` at RVA `0x1fb57c` and group ID `0x1f43` at RVA `0x1fb583`. The descriptor links message group `0x1f42`, reports three entries, and points to RVA `0x19fd7b8`:

1. `-876` / `0xfffffc94`, metadata `0x2af80002`, primary resource `0x1f420003`, secondary `0`;
2. `-208` / `0xffffff30`, metadata `0x2af80002`, primary resource `0x1f420004`, secondary `0`;
3. `-9` / `0xfffffff7`, metadata `0`, primary resource `0x1f420002`, secondary `0`.

Prior exact-build localization evidence maps `0x1f420003` to the newer-version message and `0x1f420004` to the invalid-library message. The bounded static chain is therefore:

`outer-header encryption mode >=3` → exact parser `-876` → direct caller's explicit `-876` branch → group `0x1f43` → descriptor entry for `-876` → resource `0x1f420003` → newer-version message resource.

A whole-program immediate scan found exactly eight instructions using `0xfffffc94`: RVAs `0x53db8d`, `0x5aef49`, `0x108a422`, `0x10ad262`, `0x10ad2b9`, `0x10f4d17`, `0x10f4d28`, and `0x10f4d48`. Group immediate `0x1f43` appears at RVAs `0x1fb583`, `0x53e387`, and `0x7e48df`.

## Decision and claim limits

The independent implementation reads the same byte `0x41` and intentionally supports only encryption modes 0, 1, and 2. Mode 3 or greater raises `UnsupportedError`; hence a candidate exercising this native feature gate cannot pass the required independent structural/semantic preflight. No exact candidate was locked, no two-attempt plan was created for this ineligible candidate, and launch authorization remains false.

This static result resolves the requested parser/status/non-label resource bridge, but it is not observation of a modal and not a product-facing native negative. It does not admit a 12.12.10.1 parser/writer profile, arbitrary editing, universal ITL support, independent semantic reproduction, or complete analysis. The normalized derivative remains launch-ineligible, and U-01 remains open.

## Reproducibility and next work

The committed evidence bundle contains the deterministic Ghidra report, provenance/method/boundary README, hash-gated post-script, and focused regression `tests/test_u01_parser_status_bridge_20260927.py`. The regression locks function metadata, instruction windows, caller forwarding, descriptor words, immediate inventories, the independent mode-3 refusal, zero launches, and fail-closed claims.

A successor should seek a different concrete parser gate whose exact candidate can pass independent structural and semantic preflight. Only then may it prepare, commit, and push the complete two-attempt pre-outcome plan before any native launch. The present mode-`>=3` path must not be used to bypass that gate.
