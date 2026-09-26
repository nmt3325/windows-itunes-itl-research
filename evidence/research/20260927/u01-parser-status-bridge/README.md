# U-01 exact-parser status and resource bridge

## Scope and decision rule

This static-only continuation follows upstream from the exact Windows iTunes 12.12.10.1 ITL parser toward the status comparison and error-descriptor machinery that selects a product resource. It extends the registration-only result in analysis note 005; it does not rewrite that earlier bounded finding.

A native launch was permitted only after both conditions held: (1) a concrete non-version-label incompatibility was identified, and (2) an exact candidate passed independent structural and semantic preflight under a complete two-attempt plan committed and pushed before launch. Static analysis established the first condition for an outer-header feature gate, but the candidate class necessarily fails the second. **This continuation performed zero iTunes launches and zero native candidate attempts.**

## Locked provenance

The analyzed executable remained outside the repository:

- product/path: standalone Windows iTunes, `C:\Program Files\iTunes\iTunes.exe`
- size: 39,260,512 bytes
- SHA-256: `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`
- File/Product version: `12.12.10.1`
- Authenticode: `Valid`, Apple Inc., thumbprint `67A9953123BD5F01B1BC0BB98A950D9CA869CD02`

Official Ghidra 12.1.3 was used from archive SHA-256 `93a5d11a9ad510622acaaf908c556a7b9b764d338e78a7567f3689bf5081fd54` under Temurin JDK 21.0.12. The previously completed saved project contains 62,218 recovered functions. `scripts/ghidra/U01ParserStatusFlow.java` hash-gates the imported program before emitting any report.

The post-script was run twice with analysis disabled. Both 49,898-byte outputs were byte-identical at SHA-256 `40dd9a15a6b8a5b5e4974952b73085bd75a5ab2e3b9006c1a9cfd5293e613e35`. The repository retains only bounded derived metadata: function/RVA metadata, selected instruction windows, descriptor words, references, immediate-use inventories, and fail-closed conclusions. The executable, Apple DLLs/resources, Ghidra project, logs, and raw exploratory/decompiler output remain excluded.

## Parser and status path

The exact parser is `FUN_1410ad0b0` at RVA `0x10ad0b0` (4,920 body addresses). Its sole direct call reference is RVA `0x53db44` in `FUN_14053d500` at RVA `0x53d500` (6,694 body addresses). The upstream wrapper `FUN_14053f4e0` at RVA `0x53f4e0` calls that function at RVA `0x53f62c`, stores the result in `esi`, and marks success only when the result is zero.

The parser produces status `0xfffffc94` (signed `-876`) at multiple bounded gates. Two are relevant here:

1. RVA `0x10ad257` reads the 16-bit parsed-header field at offset `+0x0c`; RVA `0x10ad25c` compares it with `0x43`, and a value greater than `0x43` reaches the `-876` assignment at RVA `0x10ad262`.
2. RVA `0x10ad2b2` compares unsigned outer-header byte `+0x41` with `3`; the carry branch at RVA `0x10ad2b7` admits values below 3, while values `>=3` reach the `-876` assignment at RVA `0x10ad2b9` and cleanup/return.

Repository parser evidence independently identifies exact outer-header byte `0x41` as the encryption mode/flag. Thus the second gate is a concrete feature check rather than a comparison of the Pascal version label. An alternate parser, `FUN_1410f4b90` at RVA `0x10f4b90`, independently repeats the same `byte +0x41 < 3` gate and returns `-876` at RVA `0x10f4d48` for values `>=3`.

The direct caller preserves the parser return with `MOV R14D,EAX` at RVA `0x53db49`, tests zero at RVA `0x53db57`, and explicitly compares `r14d` with `0xfffffc94` at RVA `0x53db8d`. Equality branches to RVA `0x53e30f`. That path places group ID `0x1f43` in `ecx` at RVA `0x53e387`, copies the preserved parser status to `r8d` at RVA `0x53e38c`, and calls `FUN_140ebbf20` at RVA `0x53e394`. The formatter forwards the group/status pair through `FUN_140ebbc00` to descriptor mapper `FUN_140bfac90` at RVA `0xbfac90`.

## Status-to-resource descriptor mapping

The mapper obtains a group descriptor from the shared CoreFoundation dictionary through `CFDictionaryGetValue`, then indexes 16-byte entries. The selected instruction window reads the entry fields at offsets `+0`, `+4`, `+8`, and `+0xc` and compares the first `uint32` with the supplied status.

Group `0x1f43` is registered by `FUN_1401fb550`. Its wrapper loads descriptor RVA `0x19fd7e8` and the group ID. The descriptor links message group `0x1f42`, contains three entries, and points to RVA `0x19fd7b8`:

| Status | Metadata | Primary resource | Secondary resource | Prior exact-build resource role |
| --- | --- | --- | --- | --- |
| `0xfffffc94` / `-876` | `0x2af80002` | `0x1f420003` | `0` | newer-version message |
| `0xffffff30` / `-208` | `0x2af80002` | `0x1f420004` | `0` | invalid-library message |
| `0xfffffff7` / `-9` | `0` | `0x1f420002` | `0` | fallback library-error member 2 |

Prior exact-build localization evidence identifies resource `0x1f420003` as “The file “^FILENAME” cannot be read because it was created by a newer version of iTunes.” The recovered static causal bridge is therefore:

`outer-header encryption mode >= 3` → parser status `-876` → caller comparison/error group `0x1f43` → descriptor status entry → resource `0x1f420003` → newer-version message resource.

This establishes parser/status/resource selection statically. It does **not** establish that a modal was displayed or that a real library with this feature was accepted far enough to reach a product-facing result.

## Independent-preflight boundary and no-launch decision

`REFERENCE_PARSER/core.py` independently reads byte `0x41` and supports only encryption values 0, 1, and 2; it intentionally raises `UnsupportedError` for mode 3 or greater. Therefore every candidate that exercises this exact feature gate fails the mandatory independent structural/semantic preflight. No exact candidate was locked, no native plan was authorized, and no pre-outcome plan was created for an ineligible candidate.

Consequently:

- native iTunes launches: 0
- product-facing native negative established: false
- exact 12.12.10.1 parser/writer profile admitted: false
- arbitrary editing or universal ITL support established: false
- independent semantic reproduction established: false
- complete-analysis gate: false
- U-01: open

The missing native negative cannot be replaced by this static mapping, a malformed-preflight refusal, the never-launched normalized derivative, or the earlier force-terminated timeout survivors.

## Reproduction

From the repository root, the retained assertions run with:

```console
python -B -m pytest tests/test_u01_parser_status_bridge_20260927.py -q -p no:cacheprovider
```

With a lawful local copy of the exact hash-gated executable and the already fully analyzed project, a representative report invocation is:

```text
analyzeHeadless <project-dir> U01Upstream -process iTunes.exe -noanalysis \
  -max-cpu 1 -scriptPath <repo>/scripts/ghidra \
  -postScript U01ParserStatusFlow.java <output>/ghidra-parser-status-flow.json
```

Run the post-script twice and compare the complete outputs byte for byte. Do not commit the executable, Apple resources/DLLs, Ghidra project, analysis logs, or raw exploratory dumps.
