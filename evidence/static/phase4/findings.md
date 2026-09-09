# Phase4 — new-track import: native static evidence

## 結論
8関数の既存Phase4出力を確認し、重複Ghidraを起動せず検証した。12 ASMファイル・1,153命令行のbytesを原EXEと照合、既存402ファイルと入力11件のSHA一致。32曲×2保存snapshotの64 location照合を完了。nativeアプリ実行・候補生成・production編集は0。

最も重要な点は、**path13(decimal)=0x0d と direct0x13(decimal19)は別**、**local IDはprocess-global allocator由来でheader+3c/+58をmax値と推定しない**、**曲の保存にはplaylist membership依存がある**、の3点。

## Field / dependency table
| Field | Width | Meaning | Evidence |
|---|---|---|---|
| `mith+0x10` | u32 LE | C+0x08 common-track local ID | f92b80 C54-59; writer106daf0 C69; atomic f92c6b |
| `mith+0x1f4` | u32 LE | F+0x28 file-instance local ID, NOT a mirror of +0x10 | fa5b70 C19-28; writer106daf0 C70; atomic fa5bbf |
| `mith+0x80` | u64 LE | C+0 persistent identity, separate from local IDs | f92b80 C64-67; eb8020/ba5880 factory only when input PID is0 |
| `miah+0x10 / mith+0xdc` | u32 LE | Album local ID / matching track reference | f690b0 C66-70; writer106daf0 C337-339; reader1078140 |
| `miih+0x10 / mith+0x1e0` | u32 LE | Artist local ID / matching track reference | f6e110 C19-23; writer106daf0 C340-342; reader1078bb0 |
| `miah/miih+0x14` | u64 LE | Album/artist persistent identities | f690b0 C71-74; f6e110 C24-28; reader constructors |
| `mtph+0x18` | u32 LE | Common-track reference, targets mith+0x10 | 1070770 C63-65,148-149;107ee90 C1206-1243 |
| `mhoh13 decimal =0x0d` | text prefix | FILE path; encoding argument1 may become3 Latin-1 | 106daf0 C1499-1513;107b460 C1239-1243 |
| `mhoh11 decimal =0x0b` | text prefix/raw URL | FILE URL encoding2/mode5; external ID argument0 | 106daf0 C1511-1534;107b460 C1207-1232 |
| `mhoh0x13 =19 decimal` | direct payload | Different from path13: raw bytes registered at L+0x568 to *(C+0x68)+0x20 | 107b460 C1324-1334; business semantics not established |
| `mhoh1` | opaque/direct | No case1 in examined track-mhoh switch; default skips. No donor32 occurrences. | 107b460 C1135-1141; not permission to delete legacy opaque data |
| `hdfm/mfdh+0x3c` | u32 BE outer/LE inner | Constant0x6f in this writer, NOT inferred local-ID high-water | 106a430 C52 |
| `hdfm/mfdh+0x58` | u32 BE outer/LE inner | Saved L+0x94; loaded only if nonzero. Exact meaning unresolved. | 106a430 C42;1085270 C365-367 |
| `hdfm/mfdh+0x44/+0x4c/+0x54` | counts | Main tracks / album records / artist records, not allocator maxima | 1075810 C96-105; donor0->32/16/4 |
| `mith+0x6d bit0 / +0x290` | state / u32 | Name refresh bit and independent Name/sort reset cache | Preserved phase3 report: common9a bit4 and common+e0; do not conflate with Unplayed/rating/IDs |

## 詳細の確度と境界

### P4-L1
32 FILE tracks in each of imported/reloaded donors contain path13(decimal0xd) and URL11(decimal0xb), no type1 or direct19. All64 raw paths equal manifest Location; URLs match ASCII file://localhost/ form and files exist.
Confidence: high for fixed donor subset
32 repeated tracks, not64 independent import or playback tests.

### P4-L2
F+2c8 is selected from50 library pools, L+958+0x48*(++global20fe7e0 %0x32). URL/path registration uses externalID0. File-local access does not mean one unique pool per track.
Confidence: high C/ASM


### P4-I1
Four constructors use LOCK XADD against global RVA1fe9130, returning the old value then incrementing it. Destinations are common C+8, file F+28, album A+18, artist R+3c.
Confidence: high C/ASM/byte matches


### P4-I2
Header+3c is constant0x6f. Header+58 copies L+94 and is loaded when nonzero. Both stay111/100 despite donor local IDs extending to451 and renumbering on reload; neither may be guessed as current local-ID max.
Confidence: high mapping; counter semantics bounded


### P4-I3
Nonzero incoming track/album/artist PIDs are retained. eb8020 returns0 for invalid library, uses postincrement L+1b90 for selected runtime library kinds, otherwise tail-calls ba5880. This does not prove which kind the donor used or implement universal PID generation.
Confidence: high control flow, incomplete PID factory semantics


### P4-S1
f930a0 links common track into L+c8/d0, increments L+a4, updates change state/maps and invalidates runtime caches. fa5530 attaches file instance and increments L+a8. Album1087800 links L+e0/e8 and increments L+ac.
Confidence: high code path; complete application side effects unproved


### P4-S2
Section writer106b450 requires C+60 membership and selects principal F for section1, nonprincipal for13. Playlist reader links membership to C+60; mtph+18 stores C+8, not F+28.
Confidence: high reader/writer relationship


### P4-S3
Donor import changes sections1,2,9,11,12,16; sections4,13,14,21,23 remain byte-identical. Reload renumbers local object IDs while preserving32 track PIDs and shared16 album/4 artist graph.
Confidence: high measured changes, limited causal semantics
No cross-library candidate acceptance inferred.

## Candidate buildersへの条件
- Prefer the pinned donor032-reloaded template for the bounded synthetic FILE/WAV experiment. All32 native tracks use path13 and URL11 without opaque1/direct19. This avoids, but does not solve, unknown location objects.
- Keep recipient hdfm file PID and master-playlist PID. Their identity domains are distinct from track/album/artist PIDs. Pin media paths/hashes and expected metadata in the producer manifest.
- Allocate small nonzero collision-free local IDs for common track, file instance, required album/artist objects and affected playlist entries. Remap only known references. Never blindly rewrite every equal integer.
- Native common/file/album/artist allocation shares process-global atomic counter iTunes.exe+0x1fe9130, not a header high-water field. Runtime reallocation on reload is expected; preserve identity via PIDs and references, not exact local numbers.
- For a conservative fresh candidate, use distinct small new IDs outside the union of known affected local IDs, while still validating each actual reader-map namespace. Global uniqueness of every serialized integer is NOT asserted.
- Preserve or deliberately allocate nonzero unique PIDs with collision checks; constructors retain supplied nonzero PIDs. Do not implement the unresolved native entropy factory or assume all library kinds use sequential PIDs.
- Preserve string sharing and use scoped COW/compact IDs only after all domain consumers are covered. L+208 and L+17f8 shared consumers remain as in phase3; album/artist object COW is a separate graph operation.
- Path13 and URL11 readers explicitly use externalID0. Their wire IDs are not global keys. F+2c8 selects one of50 library shards at L+958+72*(counter mod50); it is not necessarily a unique allocation per track.
- For this ASCII FILE subset, serialize exact Windows path13 plus matching file://localhost/ URL11, with correct byte lengths and encoding. Do not extrapolate percent encoding, Unicode relocation, HTTP, or opaque1 replacement.
- Update main-track list/count and all necessary destination playlist references. Native serialization requires a C+60 membership link; a bare mith append is not a sufficient native-persistence claim.
- Preserve secondary section13 when adding only a principal FILE instance. Native gate106b450 emits principal instance in section1 and nonprincipal instances in section13; they are not duplicate track lists.
- Update lengths/counts bottom-up (mhoh,mith,miph,lists,msdh,inner mfdh logical length,outer hdfm physical size). Header track/album/artist counts follow emitted records; do not edit +3c/+58 as guessed maxima.
- Preserve recipient opaque/global state. Section12 changed during donor import, but that does not prove which settings bytes are mandatory or authorize copying donor library settings. Sections4/13/14/21/23 stayed byte-identical only in this cohort.
- Keep prior Name6d/common9a bit4 and290 reset evidence. Use the codec-owned validated Name policy; this static phase changes neither production Name behavior nor rank-generation rules.
- Native acceptance remains dynamic-owned: complete old+new track enumeration, correct recipient identities, metadata and existing location, intended memberships, no fallback, two saved restarts and passive re-observation. Playback/file hashes need their own evidence.

## Section観測
| Section | Empty→import changed | Import→reload changed | Body bytes: empty/import/reload |
|---:|---|---|---|
| 1 | True | True | [92, 55452, 55452] |
| 2 | True | True | [95088, 103267, 103268] |
| 4 | False | False | [120, 120, 120] |
| 9 | True | True | [92, 4380, 4380] |
| 11 | True | True | [100, 744, 744] |
| 12 | True | False | [446, 446, 446] |
| 13 | False | False | [92, 92, 92] |
| 14 | False | False | [92, 92, 92] |
| 16 | True | True | [144, 144, 144] |
| 21 | False | False | [1011, 1011, 1011] |
| 23 | False | False | [96, 96, 96] |

## 実行provenance
再開時点で8C・2組のGhidra成功log・donor解析が存在したため保持・再検証した。元decompileのcommand ID/exit/eofは現在のrecent-command windowから回収できていない。成功logとsummaryをcommandの終了状態と混同せず、欠落はreportに明記。再開後の全commandは終了・EOFまで回収した。byte照合は命令実行テストではない。

## 保全・未確定
過去phaseは不変。Phase4 Ghidra project/cacheはphase4内に隔離済み。type1の完全解釈、L+94の業務意味、PID factory全体、全system/smart依存、任意media/Unicode移動は未確定。Name6d/common9a bit4と290 resetの既知結果はphase3に保持し、更新していない。native受入をSTATICの成果として主張しない。
