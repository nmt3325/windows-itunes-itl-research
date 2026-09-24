# Smart Playlist pinned prior-art audit (2026-09-25)

## 結論

U-06 は **未解決のまま**である。今回の独立調査で、Windows native ITL と Music.app/iTunes XML `Smart Criteria` が同一バイト列を異なる境界から解釈できる **three-byte phase overlay** を再現可能に確認した。一方、field/operator の意味、Windows の非空文字列 byte order、評価結果、編集、二回保存の永続性は証明していない。

本調査では Windows 実機への書込みを一切行っていない。保持済み native v24 ITL、既存 native corpus census、指定された二つの pinned prior-art repository のみを使用した。

機械可読な全結果は `evidence/research/20260925/smart-prior-art/audit.json`、入力 provenance と retained snapshot の hash は `source-manifest.json` にある。

## Evidence policy

| class | この調査で許される主張 | 許されない昇格 |
|---|---|---|
| `Windows-native-v24` | 保持済み Windows iTunes 12.13.10.3 ITL に実在する byte、offset、length、round-trip | 単一観測から field/operator semantics や string encoding を断定 |
| `Windows-native-corpus` | 95 ITL / 1,235 playlist instances の観測分布 | 名前や意味を prior art から移植 |
| `pinned-Music-XML-prior-art` | 指定 commit の source/fixture が実装・保持する XML Smart Criteria layout | Windows native proof として扱う |
| `mechanical-overlay` | 同じ byte を二つの parser でどう分割できるか | 両 format の provenance・意味・保存挙動が同一と断定 |

## Pinned inputs

- `kynoptic/smart-playlist-io` @ `31acf7f058278f120b9d054459134416e76d1d8e`
  - `golden_criteria.bin`: 1,463 bytes, SHA-256 `884ec390daabf84aae0ed19983f1c27b8d244b3b481476b46c36771b3a0f9b1e`
  - `golden_info.bin`: 112 bytes, SHA-256 `101dde6edd686b478b3f6c036c413018dd229ca96c18789d971ceda8d6fd252f`
- `cvzi/itunes_smartplaylist` @ `9a36e82d5bfaad9154b50166fee0489f5d9306e2`
  - `library_minimal.xml`: SHA-256 `b66575ed3f15393d7645bf2120b72b5d4e991252bce0acfe5a2071a45cbb7d2f`
  - retained `Smart Criteria`: 862 bytes, SHA-256 `db4f8d35373abf79e68091fa435c71b81dbbbfe7e855bd7a70ee1a63154ca01c`
- Windows native v24 `native-created.itl`
  - 4,402 bytes, SHA-256 `58ad4d6fedc65f43e627b35075218c6c19b16d767570c41d6f8c2f2fe7376696`
  - playlist persistent ID `9081AD2B1ABE848F`
  - extracted type-101: 824 bytes, SHA-256 `cd1fb6489e3ba11c1022512b0ecd99a7e3d45477fe6301f4de6d095b6f769862`

`smart-playlist-io` の golden は同 project encoder から再生成される regression fixture であり、独立した Windows native capture ではない。`itunes_smartplaylist` も XML の base64 `Smart Criteria` / `Smart Info` を対象とし、Windows ITL parser ではない。

## Third-party licensing and provenance

保持した4つの snapshot は、両 pinned repository の MIT License に基づく。`smart-playlist-io` の `LICENSE` と `NOTICE`、`itunes_smartplaylist` の `LICENSE` を hash 検証対象に含め、完全な notice text と各 snapshot の元 path を `evidence/research/20260925/smart-prior-art/THIRD_PARTY_NOTICES.md` および `source-manifest.json` に保持する。これにより snapshot の再配布条件と byte provenance を同じ再生成手順で検証できる。

## Reproducible structural results

### 1. Windows native v24 framing

Native type-101 は current `itlkit.smart.parse_rules` で byte-exact round-trip する。

| node | `SLst` | children / wrapper | field/action | data | end |
|---|---:|---:|---|---:|---:|
| root | 0 | first wrapper 136 | group candidate | 192 | 576 |
| media nested | 192 | leaves 328, 452 | `0x0000003C` / `0x00000001` | 384, 508 | 576 |
| root second wrapper | — | 576 | group candidate | 632 | 824 |
| custom nested | 632 | leaf 768 | `0x00000004` / `0x01000002` | 824 | 824 |

Native-only structural facts:

- `SLST_HEADER_SIZE = 136`
- `RULE_HEADER_SIZE = 56`
- field/action/length are big-endian `uint32`
- nested `SLst` begins at wrapper-relative `+56`
- custom Artist-candidate operand length is **zero**
- native `SLst` offsets are `[0, 192, 632]`

The final point means this v24 capture cannot establish UTF-16BE, UTF-16LE, a terminator rule, or even that a non-empty operand was persisted.

### 2. Music XML framing

The pinned Music XML view has different conceptual boundaries:

- root children begin at absolute `139`
- nested subexpression header is `192` bytes
- embedded `SLst` begins at subexpression-relative `+53`
- nested children begin at subexpression-relative `+192`
- fixed integer/enum rule size is `124` bytes
- string header size is `54` bytes
- string byte length is one byte at relative `+52`
- string bytes begin at relative `+54` and the golden `Rock` / `Jazz` witnesses are UTF-16LE
- integer values are big-endian `uint32` at relative `+57` and `+81`

The 579-byte fixed prefix in `smart-playlist-io` consists of outer `SLst` bytes `0..138`, MediaKind subexpression `139..330`, and two 124-byte MediaKind leaves `331..578`. Its outer count is two; the source deliberately omits the native Music.app identity child. This is an encoder design choice and not Windows semantic evidence.

### 3. New invariant: exact common prefix, bounded divergence

The Windows native v24 type-101 and pinned `smart-playlist-io` golden are byte-identical for `[0, 630)`—a 630-byte common prefix. In particular, native bytes `[0, 579)` equal the complete retained 579-byte prior-art boilerplate. The first difference is the user-group length field:

- native offsets `630..631`: `00 c0` (nested data length 192)
- golden offsets `630..631`: `03 3f` (nested data length 831)

Across the 824-byte overlap there are only seven differing byte positions: `630`, `631`, `643`, `771`, `772`, `775`, and `823`. This proves strong physical byte correspondence. It does **not** prove common provenance, semantic field names, evaluator behavior, or Windows write compatibility.

### 4. New mismatch: 192-byte overlay has different partitions

The same nested magic at absolute 192 can be expressed two ways:

| view | child/wrapper start | bytes before nested `SLst` | nested `SLst` |
|---|---:|---:|---:|
| Windows ITL | 136 | 56 | 192 |
| Music XML | 139 | 53 | 192 |

Likewise, the next shared nested magic at 632 is reached from a Windows wrapper at 576 (`576 + 56`) and a Music subexpression at 579 (`579 + 53`). Thus “192 bytes” does not establish layout equivalence: it is an overlapping interpretation with a three-byte phase difference.

### 5. New mismatch: checked-in golden has mixed skip-base profiles

A uniform “skip-base = 139 for every subexpression” does not describe the pinned golden bytes:

| subexpression | start | children bytes | stored skip | observed `skip - children` | `(start + skip + 56) - parsed_end` |
|---|---:|---:|---:|---:|---:|
| fixed MediaKind boilerplate | 139 | 248 | 384 | **136** | 0 |
| generated user root | 579 | 692 | 831 | **139** | +3 |
| generated nested OR | 1083 | 188 | 327 | **139** | +3 |

Therefore:

- `139 + children_bytes` is demonstrated for subexpressions generated by the current upstream encoder.
- the fixed 579-byte historical boilerplate retains `136 + children_bytes`.
- when the `139` nodes are viewed as Windows nested `SLst`, they retain three trailing bytes.

This is a precise byte-level inconsistency/boundary, not a claim that either project’s runtime semantics are wrong.

### 6. New explanation: field-width and string-endian phase overlay

A Music one-byte field at `x + 3` is the low byte of a Windows big-endian `uint32` field at `x`:

- Windows MediaKind leaf: offset 328, bytes `00 00 00 3c`
- Music MediaKind leaf: offset 331, byte `3c`

The same phase shift explains why ASCII strings look valid under opposite byte orders. In the golden Artist rule:

| view | rule start | data start | bytes | decode |
|---|---:|---:|---|---|
| Windows overlay | 892 | 948 | `00 52 00 6f 00 63 00 6b` | UTF-16BE → `Rock` |
| Music XML | 895 | 949 | `52 00 6f 00 63 00 6b 00` | UTF-16LE → `Rock` |

This does **not** make the cross-format overlay an independent Windows UTF-16BE witness. The only retained custom Windows-native string candidate has zero data bytes. A controlled non-empty native string is still required.

The pinned `itunes_smartplaylist` minimal XML fixture adds another caution: its final string ends after the final ASCII low byte, one byte short of the declared complete UTF-16LE window. Its parser’s every-other-byte projection still reconstructs the ASCII text, but that implementation is not a full Unicode decoder.

### 7. Field IDs 0x9A / 0x86 / 0x85 / 0x3C

Both pinned prior-art projects associate:

| field ID | prior-art name | observed in existing Windows corpus |
|---|---|---|
| `0x9A` | Love | no |
| `0x86` | iCloudStatus | no |
| `0x85` | Location | yes, numeric ID only |
| `0x3C` | MediaKind | yes, numeric ID only |

Existing Windows census observations are limited to `0x0000003C`, `0x00000085`, and `0x000000A4`; all 2,470 retained leaves have 68-byte operands and there are zero string-candidate rules. Numeric overlap with XML/prior-art names is useful correspondence, but does not prove Windows semantics.

## Why U-06 remains open

The audit establishes a lossless structural AST and a precise cross-format overlay. It does not establish:

1. non-empty Windows string storage or byte order;
2. controlled Windows meaning for custom field/operator IDs;
3. evaluator membership results for custom and nested predicates;
4. safe semantic editing;
5. next-sibling accounting for a non-final native nested group;
6. two-cycle persistence after reopening and a no-op second save.

No cross-format claim in this report should be used to remove those requirements.

## Strict next native experiments (proposal only)

No experiment below was executed in this turn.

1. **N-01 — string endianness**
   - isolated disposable Windows profile;
   - one Artist-contains rule with an asymmetric Unicode sentinel such as `A\u1234éZ`;
   - retain pre-save, first-save, reopen, and second-save ITLs;
   - accept only if a non-empty operand is isolated and exact bytes survive both saves.
2. **N-02 — non-final nested group**
   - nested OR group followed by a normal sibling;
   - alter one nested child per capture;
   - use the next sibling to resolve whether native accounting ever includes a three-byte adjustment.
3. **N-03 — controlled field/operator matrix**
   - isolated one-rule captures for candidate IDs `0x9A`, `0x86`, `0x85`, `0x3C`;
   - one operator/value transition per save;
   - include tracks that should match and not match; use membership as the semantic oracle.
4. **N-04 — two-cycle persistence**
   - reopen iTunes and perform a no-op second save for every candidate;
   - require stable AST, relevant payload bytes, and membership outcome before closing U-06.

## Verification results

- audit-specific + existing Smart Playlist tests: **24 passed**
- complete local project suite: **950 passed, 4 skipped**
- pinned `smart-playlist-io` encode/decode tests: **144 passed**
- pinned `itunes_smartplaylist` suite: **18 passed**
- `py_compile`: passed
- `git diff --check`: passed
- generator double-run: byte-identical outputs / no diff

The upstream `smart-playlist-io` default pytest configuration requested `pytest-cov`, which is not installed in this retained GHA environment. The source tests were therefore run with `-o addopts=`; this disables only the coverage plugin arguments, not tests.

## Reproduction

From the dedicated worktree with both external repositories at the pinned commits:

```bash
python scripts/research/audit_smart_prior_art_20260925.py
python -m pytest -q tests/test_smart_prior_art_20260925.py
python -m pytest -q tests/test_smart_playlists.py
```

The generator validates each pinned HEAD and source/fixture SHA-256 before replacing the retained snapshots and JSON reports. Running it twice must leave no diff.
