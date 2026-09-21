# Windows iTunes ITL smart-playlist binary specification

- Status: **read-only, evidence-graded research specification**
- Target: Windows iTunes `12.13.10.3` ITL files in this repository
- Implementation: `itlkit/smart.py`

## 1. Scope and non-claims

This document specifies the smart-playlist bytes that can be defended from the
tracked Windows ITL corpus, and records lower-confidence interpretations from
historical iPod iTunesDB implementations. It deliberately does **not** present
cross-format names as established Windows semantics.

The tracked corpus contains 95 parseable ITL files and 1,235 playlist instances
with at least one `mhoh` type 101, 102, or 103 record. It contains built-in or
system playlists only; no user-created custom smart playlist was identified.
Consequently, the corpus is strong evidence for framing and byte preservation,
but weak evidence for editable rule semantics.

The implementation is an inspector, dumper, and structural validator. It does
not evaluate smart rules and does not offer semantic rule editing.

## 2. Evidence classes

| Code | Evidence class | Meaning |
|---|---|---|
| **ND** | Native differential confirmed | Controlled Windows iTunes mutation changed only the stated feature and the binary delta supports the claim. |
| **NC** | Native corpus observed | The bytes recur in tracked Windows ITL files, but cause/effect may not be isolated. |
| **SA** | Static-analysis corroborated | A Windows iTunes binary/string/code reference supports the claim. |
| **PA** | Cross-format prior art | Historical iPod iTunesDB code uses this layout or meaning. It is not proof of Windows ITL semantics. |
| **H** | Hypothesis/unresolved | Plausible interpretation without enough evidence. |
| **T** | Synthetic test only | Parser behavior is tested, but the fixture is not native evidence. |

No custom smart-rule semantic in this document currently reaches **ND**. The
only **SA** result is a metadata string proving that Windows iTunes exposes a
smart-playlist concept; no tracked disassembly was identified as an `SLst`
parser or evaluator.

## 3. Executive confidence matrix

| Feature | Structural statement | Semantic statement | Grade | Windows-native status |
|---|---|---|---|---|
| AND | Root `+0x0C` contains raw value `0` in every nonempty native group. | `0` means all rules must match. | NC + PA | Meaning not differentially verified. |
| OR | Root `+0x0C` contains raw value `1` in the zero-rule Genius group. | `1` means any rule may match. | NC + PA | No nonempty native OR example. |
| Negation | Native rules contain action `0x02000400`. | Action high-byte bit `0x02` negates the test. | NC + PA | Negation behavior not verified in Windows UI. |
| Strings | Length-delimited rule data can be retained exactly. | String-family data is UTF-16BE and `0x010000xx`/`0x030000xx` select string operators. | PA + T | No native corpus string rule. |
| Numbers | Native non-string data is 68 bytes and has a repeatable six-value/five-u32 shape. | Values encode numeric comparisons with `from`/`to` bounds. | NC + PA | Shape is native; comparison meaning is prior art. |
| Date/time | 68-byte data can carry signed 64-bit slots losslessly. | `0x2dae2dae2dae2dae`, signed count, and seconds/unit encode relative dates. | PA + T | No native corpus date rule. |
| Ranges | Two 64-bit value slots are present. | Action `0x00000100` compares an inclusive range. | PA + T | No native corpus range rule. |
| Playlist membership | Any field ID is preserved. | Field `0x28` identifies playlist membership and the first value identifies a playlist. | PA + T | No native corpus field `0x28`; prior art itself warns about extra unknown data. |
| Media kind | Field `0x3C` occurs in named Music/Movies/TV/etc. built-ins. | Field `0x3C` is media/video kind; `0x400` is a bit test and `0x02000400` its negation. | NC + PA | Strong correlation, not a controlled differential. |
| Limit | Type 102 has stable raw offsets and two native payloads. | Bytes 2/3 and values at `+0x08` encode limit enable/unit/value. | NC + PA/H | Candidate only; Windows layout differs from historical type 50. |
| Selection order | Type 102 `u32be(+0x04)` is `2` in both payloads. | `2` means random selection order. | NC + PA/H | Candidate only. |
| Live update | Type 102 byte 0 is `1` for common built-ins and `0` for Genius. | Byte 0 enables live update. | NC + PA/H | Candidate only. |
| Nesting | Parser can retain a rule whose data is another complete `SLst`. | `(field=0, action=1, marker=0x01000000)` denotes a nested group. | PA + T | No native corpus nested group. |
| Unknown operators | Field/action/data/opaque/trailing bytes round-trip exactly and are reported. | Unknown numeric IDs have no assigned meaning. | NC-design + T | Intentionally not guessed. |

## 4. Placement inside a playlist

A playlist is an `miph` node. Its child `mhoh` records use the existing ITL
node framing; this specification begins at each child node's `payload`.

| `mhoh` type | Observed role | Evidence |
|---:|---|---|
| 100 | Playlist title (existing codec behavior) | NC |
| 101 | Smart rules; payload starts with `SLst` | NC |
| 102 | Smart preference/settings candidate; native payload length 112 | NC |
| 103 | System metadata; only Podcasts payload observed | NC |

`Playlist.is_smart` continues to mean “has type 101 or type 102.” Type 103 alone
is ancillary system metadata and is not sufficient for that property.

## 5. Type 101: `SLst` rules container

All multi-byte fields described in this section are big-endian. This endian
choice is directly observed in Windows payloads (**NC**) and matches historical
iPod parsers (**PA**).

### 5.1 Root header

The root is exactly 136 bytes before its first rule.

| Offset | Size | Name | Native observation | Interpretation |
|---:|---:|---|---|---|
| `0x00` | 4 | magic | ASCII `SLst` in all 12 unique payloads | **NC** |
| `0x04` | 4 | version/unknown word | `0x00010001` in all payloads | Value **NC**; purpose **H** |
| `0x08` | 4 | rule count | Matches the number of following rule records | **NC** |
| `0x0C` | 4 | conjunction raw | `0` in every nonempty built-in; `1` in zero-rule Genius | Value **NC**; AND/OR names **PA** |
| `0x10` | 120 | opaque header | All zero in the tracked corpus | **NC**; must be preserved |

After the header, parse exactly `rule_count` variable-length rule records.
Bytes remaining after those records are not discarded; the validator reports
and the AST preserves them.

### 5.2 Rule record

| Rule-relative offset | Size | Name | Evidence |
|---:|---:|---|---|
| `0x00` | 4 | field ID | NC framing; field names PA |
| `0x04` | 4 | action/operator ID | NC framing; operator names PA |
| `0x08` | 44 | opaque rule header | All zero for native leaves; preserve exactly |
| `0x34` | 4 | data length | NC |
| `0x38` | `data_length` | raw operand or nested payload | NC as length-delimited bytes |

There is no observed alignment padding between records. A native non-string
leaf is `56 + 68 = 124` bytes. Observed complete type-101 lengths are 136, 384,
and 508 bytes (0, 2, and 3 fixed-size leaves).

A parser must reject a truncated header or data region, bound counts/lengths,
and never infer an unknown action's data type destructively.

### 5.3 Native 68-byte operand view

Every native leaf in the corpus has `data_length == 68`. Treat this as an
optional structural view, not as proof of every semantic name.

| Data-relative offset | Size | API name | Encoding | Evidence |
|---:|---:|---|---|---|
| `0x00` | 8 | `from_value` | unsigned 64-bit BE | Shape NC; name PA |
| `0x08` | 8 | `from_date` | signed 64-bit BE | Shape NC; name PA |
| `0x10` | 8 | `from_units` | unsigned 64-bit BE | Shape NC; name PA |
| `0x18` | 8 | `to_value` | unsigned 64-bit BE | Shape NC; name PA |
| `0x20` | 8 | `to_date` | signed 64-bit BE | Shape NC; name PA |
| `0x28` | 8 | `to_units` | unsigned 64-bit BE | Shape NC; name PA |
| `0x30` | 20 | five trailing words | five unsigned 32-bit BE values | NC; meanings unknown |

Across native leaves:

- `from_value == to_value`;
- both signed date slots are zero;
- both unit slots are one;
- all five trailing words are zero.

Historical iPod implementations assign comparison/range/date meanings to these
slots. Those meanings remain **PA** for Windows ITL.

### 5.4 String operand candidate

Historical iPod implementations encode string data directly as UTF-16BE, with
no terminator counted beyond the rule's explicit data length. `itlkit` exposes
a decoded view only for prior-art string action families and only if strict
UTF-16BE decoding succeeds. Raw bytes are always retained.

The Windows corpus has no `0x010000xx` or `0x030000xx` action and no
variable-length string operand. Therefore UTF-16BE string semantics are **PA +
T**, not native-confirmed.

### 5.5 Nested group candidate

A nested group is recognized only if every prior-art discriminator matches:

1. field ID is `0`;
2. action ID is `1`;
3. the first four opaque bytes at rule `+0x08` are `0x01000000`;
4. rule data starts with `SLst` and parses as a complete bounded ruleset.

The following 40 opaque wrapper bytes are preserved. A malformed group-shaped
payload remains raw and produces a validation error. Nesting is **PA + T**;
there is no native Windows example.

## 6. Observed type-101 built-in groups

Each unique group occurs in all 95 tracked ITL files. Names and `special_kind`
values identify the surrounding native playlist; they do not by themselves
prove evaluator semantics.

| Playlist | `special_kind` | Group hash prefix | Raw conjunction | Rules as `(field, action, value)` |
|---|---:|---|---:|---|
| Music | `0x0400` | `1c75dcec43f0618e` | 0 | `(0x3C,0x400,1057201)`, `(0x3C,0x02000400,2129924)` |
| Movies | `0x0200` | `1e3c768a154c2a48` | 0 | `(0x3C,0x400,2)`, `(0x3C,0x02000400,2138116)` |
| TV & Movies | `0x4000` | `4cedbe556f7f2163` | 0 | `(0x3C,0x400,66)`, `(0x3C,0x02000400,2195460)`, `(0xA4,1,1)` |
| Music Videos | `0x2F00` | `6479eb50ff83361d` | 0 | `(0x3C,0x400,32)`, `(0x3C,0x02000400,2195460)` |
| TV Shows | `0x0300` | `678218eef5ae0494` | 0 | `(0x3C,0x400,64)`, `(0x3C,0x02000400,2138116)` |
| Audiobooks | `0x0500` | `6acc96161792f80b` | 0 | `(0x3C,0x400,8)`, `(0x3C,0x02000400,2138116)` |
| Downloaded / Music | `0x4100` | `717ee12b245c0413` | 0 | Music rules plus `(0x85,0x400,1)` |
| Home Videos | `0x3000` | `905245d98e4a8084` | 0 | `(0x3C,0x400,1024)`, `(0x3C,0x02000400,2195460)` |
| Rentals | `0x0700` | `a4c8b4b034357287` | 0 | `(0x3C,0x400,66)`, `(0x3C,0x800,32768)` |
| Downloaded / Movies | `0x4200` | `b2dda0db3ca0d121` | 0 | Movies rules plus `(0x85,0x400,1)` |
| Genius | `0x1A00` | `e4e26eebdaecff05` | 1 | no rules |
| Downloaded / TV | `0x4300` | `faeef2c69eee00dd` | 0 | TV rules plus `(0x85,0x400,1)` |

Field `0x3C` is therefore natively correlated with media-category built-ins and
is named video/media kind by prior art. Fields `0x85` and `0xA4` remain unknown.
Actions `0x400`, `0x800`, and `0x02000400` occur natively, but their generic
meanings remain prior-art interpretations.

## 7. Type 102: preference/settings candidate

There are two unique native type-102 payloads, both exactly 112 bytes. The
parser preserves all 112 bytes and exposes only an offset-based structural
view.

| Offset | Size | Native values | API field | Semantic status |
|---:|---:|---|---|---|
| `0x00` | 1 | common `1`, Genius `0` | `byte_00` | live-update candidate, PA/H |
| `0x01` | 1 | common `1`, Genius `0` | `byte_01` | check-rules candidate, PA/H |
| `0x02` | 1 | common `0`, Genius `1` | `byte_02` | limit-enable candidate, PA/H |
| `0x03` | 1 | `3` | `byte_03` | limit-unit candidate, PA/H |
| `0x04` | 4 | BE `2` | `u32be_04` | selection-order candidate, PA/H |
| `0x08` | 4 | BE `25` | `u32be_08` | limit-value candidate, PA/H |
| `0x0C` | 4 | common `0`, Genius `0x100` | `u32be_0c` | unknown |
| `0x10` | 4 | BE `7` | `u32be_10` | unknown |
| `0x14` | 92 | all zero | opaque tail | preserve exactly |

Payload hashes:

- common: `15f5b9c419659b06…`, prefix `01 01 00 03`, values `2,25,0,7`;
- Genius: `bbb92df6ae83767d…`, prefix `00 00 01 03`, values
  `2,25,0x100,7`.

The historical iPod type-50 body is 72 bytes and uses byte-sized fields at
positions that do not exactly match this 112-byte Windows body. The apparent
alignment of the first flags, unit code, sort code, and value is useful prior
art but is not enough to rename unknown Windows bytes as fact. In particular,
`u32be_0c` and `u32be_10` are intentionally not assigned match-checked or
reverse-sort meanings.

## 8. Type 103

One unique native payload occurs on Podcasts:

```text
00000010706563680000000073747274
```

It is retained as ancillary raw data. This work does not assign its `pech` and
`strt` byte sequences a smart-rule meaning.

## 9. Static-analysis result

`evidence/static/pe_inventory.json`, string record 42, RVA `28088784`, contains:

```text
com.apple.itunes.smart-playlist
```

This is **SA** corroboration that Windows iTunes exposes a smart-playlist
metadata concept. Narrow searches of tracked static evidence did not identify
a defensible `SLst` parser, field-ID switch, action-ID switch, or type-102
evaluator. Generic assembly occurrences of constants such as `0x400` and
`0x800` are not counted as smart-playlist evidence.

See `evidence/smart-playlist/static-evidence.json` for the exact source hash and
claim boundary.

## 10. Cross-format prior art

The historical iPod iTunesDB format uses type 50 for preferences and type 51
for `SLst` rules. At the pinned libgpod revision it documents or implements:

- 136-byte `SLst` header and big-endian parsing;
- 56-byte rule prefix and 68-byte non-string body;
- UTF-16BE string bodies;
- raw conjunction `0`/`1` as AND/OR;
- field and action enumerations;
- date identifier `0x2dae2dae2dae2dae`;
- relative-date units in seconds;
- playlist membership field `0x28` (with an explicit warning that it was not
  parsed correctly and uses extra data);
- media/video-kind field `0x3C`;
- historical preference flags, limit units, sort orders, and limit value.

The pinned iOpenPod revision additionally proposes and tests a recursive group
wrapper. It is useful implementation prior art, but it is not independent
Windows evidence.

Exact repository commits, source hashes, and permalinked line ranges are in
`evidence/smart-playlist/prior-art-manifest.json`.

## 11. Parser and validator contract

`itlkit.smart` provides:

- `parse_rules(payload)` -> immutable, lossless `SmartRuleSet`;
- `parse_preferences(payload)` -> immutable, raw-preserving
  `SmartPreferences`;
- `parse_playlist_smart(node)` and `Playlist.smart_definition`;
- `dump_rules` / `dump_preferences` JSON-ready views;
- `validate_rules` / `validate_preferences` structured issues;
- `SmartRuleSet.to_bytes()` and preference/rule `to_bytes()` exact
  reserialization.

The parser:

1. requires `SLst` and a complete 136-byte root header;
2. bounds payload length, rule count, operand length, and nesting depth;
3. treats unknown fields and actions as data, not fatal semantic errors;
4. never rewrites nonzero opaque bytes;
5. decodes UTF-16BE only as an optional candidate view;
6. exposes the numeric view only for exactly 68 bytes;
7. recognizes nesting only with the full prior-art discriminator;
8. preserves trailing bytes and reports them;
9. refuses truncation and length overflow.

Default bounds are 64 MiB per root payload, 4,096 rules, 16 MiB per operand,
and 16 nested levels. These are safety limits, not format maxima.

CLI inspection:

```powershell
python -m itlkit smart-dump evidence/native/snapshots/000-empty.itl
python -m itlkit smart-check evidence/native/snapshots/000-empty.itl
```

Neither command mutates the library.

## 12. Native-unverified items

The following remain unverified by controlled Windows iTunes creation/edit and
reload:

- raw conjunction `0`/`1` semantics on nonempty custom AND and OR groups;
- all user-created string fields and operators;
- numeric comparison semantics outside built-in filters;
- absolute and relative date/time encodings and epoch conversion;
- range inclusivity and bound ordering;
- playlist-membership identifiers and the five trailing words;
- generic negation behavior and every unobserved action;
- exact media-kind bitmask evaluator behavior;
- type-102 live update, check-rules, limit enable, unit, value, selection order,
  checked-only, and reverse-order semantics;
- recursive groups/nesting;
- iTunes acceptance of synthetic or rewritten smart payloads;
- fields `0x85` and `0xA4`;
- semantic role of type 103.

A shared iTunes process appeared in the available Windows environment during
research. To avoid corrupting another workstream's live library, no destructive
or UI-driven custom smart-playlist experiment was performed. These gaps must be
closed in a separately isolated native environment.

## 13. Reproducibility

Regenerate the corpus census:

```powershell
python evidence/smart-playlist/census.py --write
```

Run focused and full tests:

```powershell
python -m pytest -q tests/test_smart_playlists.py
python -m pytest -q
```

The canonical census stores each unique type-101/102/103 payload once, with its
SHA-256, raw hex, parsed dump, occurrence references, and hashes for all 95
source ITL files:

- `evidence/smart-playlist/corpus-census.json`
- `evidence/smart-playlist/corpus-census.md`
- `evidence/smart-playlist/README.md`
