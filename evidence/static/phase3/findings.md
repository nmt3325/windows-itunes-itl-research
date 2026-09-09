# Phase3: text pools / Name refresh / 0x290

## 結論
追加逆コンパイル4関数を完了。既存47+4関数を含む150ファイルと原資料9件はSHA一致。iTunes・COM・UI・live attach・production変更・2^3候補生成/実行なし。

`mith+0x6d` はcommon track `C+0x9a bit4` の保存表現。readerはwire bit0のみを読み、writerは0/1。Rating (`C+0x104`) とは別。

このbitはmissing Nameのpath由来fallbackで立ち、bit有効時のpath-derived Name更新で検査され、特定の非空Name更新で落とされる。候補名は **path-derived/default-title refresh enabled**。RatingKind/Unplayedとは断定しない。Fresh巻き戻りと整合するが当該実行の原因は親の2^3試験待ち。

Name/SortName変更処理は `C+e0` (= `mith+290`) を明示的に0へresetする。Name ID (`C+b0`) とは別。**全rank再生成や全zero化の根拠にはしない。**

## 全公開候補13項目
対象はcaptured library.py TEXT_FIELDS15件からkind/purchaser_name(read-only)を除いた13候補。編集gateや全file/profile互換性は別問題。C=common track, F=file instance, L=library; memberの数値はhex。

| Field | mhoh type | Pool | Member |
|---|---:|---|---|
| name | 2 | `L+0x178` | `C+b0` |
| album | 3 | `L+0x1c0` | `C+bc` |
| artist | 4 | `L+0x208` | `C+b4` |
| genre | 5 | `L+0x328` | `C+c8` |
| comment | 8 | `L+0x400` | `C+d4` |
| composer | 12 | `L+0x208` | `C+c4` |
| album_artist | 27 | `L+0x208` | `C+b8` |
| sort_name | 30 | `L+0x1768` | `C+160` |
| sort_album | 31 | `L+0x17b0` | `C+164` |
| sort_artist | 32 | `L+0x17f8` | `C+168` |
| sort_album_artist | 33 | `L+0x17f8` | `C+16c` |
| url | 11 | `*(F+0x2c8)` | `FILE F+2c0 / HTTP F+2b8` |
| path | 13 | `*(F+0x2c8)` | `F+2b8` |

通常11項目はmode1/options0でmhoh+10を登録へ渡す。writer encoding引数1は短いLatin-1のencoding3へcompactされ得る。URL11はFILE mode5/encoding2、HTTP mode0/encoding0。path13はFILEの通常text。URL/pathはexternalID0でfile-local poolへ登録され、wire IDをglobal keyにしない。

## 共有domain / 関連record
- L+208: mith4/12/27、miah301/302、miih400。
- L+1c0: mith3、miah300。
- L+17f8: mith32/33/**34**、miih401。公開対象外のSortComposer34も同domain。
- Name L+178 とSortName L+1768、Album L+1c0 とSortAlbum L+17b0は別domain。
- native sort index5 (type35): L+1840、base L+640 (mith24/miah304), *(C+70)+28。Showという名前は推定。index7はwire type0のruntime fallback、writerは0..5のみ。
- kind6=L+370、purchaser_name60=L+910(type62も同domain)、どちらもread-only。
- miah301/302の業務役割、未確認counterpartを推測しない。miah306を勝手にSortAlbumへ対応させない。Playlist Name100のlocal pool P+130をName L+178と混ぜない。

## COW / compact ID 条件
- Preserve unchanged bytes/IDs on no-op and lossless paths; do not renumber merely on read.
- Key string allocation by library instance AND exact pool. Artist/Composer/AlbumArtist share L+208; sort artist/album artist/composer and miih401 share L+17f8.
- For a changed occurrence, choose a small unused positive external ID in the confirmed domain; preserve the old ID/payload for unaffected users. Observed ID4 is not a required constant.
- Only compact a domain after complete consumer coverage and an atomic rewrite of all its users. Unknown/opaque consumers mean preserve original numbering or refuse compaction.
- Native bfe500 first-ID-wins is conditional on pool flag bit0 and does not replace/compare payloads. Do not alias unequal text under an occupied ID.
- Do not blanket-zero IDs. bfe1f0 unkeyed registration can reject a pool with an existing explicit-ID map; empty payloads are not reference-only strings.
- String COW is not album/artist object COW. Keep miah/miih local IDs, mith+dc/+1e0 object links, persistent IDs and seven rank/cache words separate.
- When indexed object semantics change, clone/reuse/repoint transactionally and preserve all unaffected references; shared-object native acceptance is not established here.
- Base and sort pools are separate. Do not deduplicate normalization-sensitive text by raw SHA alone or invent unresolved native normalization.
- Wire6d bit0 maps to common9a bit4, not Rating. A selected nonempty native Name-update branch clears it, supporting an experiment but not blanket production zeroing.
- Name/sort processing explicitly resets C+e0 / mith+290. This is not a whole-rank regeneration rule and is independent of title-ID reassignment.
- The parent owns the 2^3 experiment for6d/titleID/290. Static generated/executed no factorial candidates and did not establish Fresh rollback causality.
- FILE URL11 encoding2 is legitimate native output; HTTP uses encoding0. URL/path registration is externalID0 in the file-instance pool, not a global wire-ID reference.
- Preserve unknown raw URL bytes. Strict ASCII viewing is supported by the synthetic cohort, not a universal encoding2 charset. Relocation must account for opaque type1 location data.

## Native保存差分
003→010のalphaではheaderのtotalフィールド+8、6d:1→0、290:1000→0だけが変化。Name ID1→4、encoding3/5bytes→encoding1/44bytes。mhoh6/11/13の全体SHA、他2trackのheader/mhohは不変。因果分離ではなく同時変化の確認。入力SHAと差分はnative-name-diff.json。

## 根拠 / 検証
- ec75b0 C56–107: bit検査とpath由来Name書換。
- eb9b10 C42–55,102–132: missing Name fallbackとbit設定。
- ec8180 C98–120 / ec82c2,ec82d6: Name適用とbit clear（complete COM setterとは主張しない）。
- ec7b80 C43–57 / ec7c08,ec7c0c: a1/e0 resetとName/SortName descriptor。
- ed6940 ASM ed69d2,ed69fb,ed6a22: Name/sort change-maskからresetへ。
- reader107b460 C471–483 /107b9e5..107ba03 とwriter106daf0 C79 /106dbed..106dbfd: wire6d。
- sort helper eb8130: 正しいcode/table境界とoriginal leaf10ケースでpool対応を補強。
原命令の隔離実行は26チェック (leaf10 + writer slice8 + reader slice8)、iTunes process/native受入ではない。別の65,536件は転記したPython bit-modelでありnative件数へ混ぜない。4関数のC全体、raw ASM、SHA付き抜粋を保存。

## 未確定
- Fresh later-observation is parent-supplied; no live trace/factorial acceptance was performed here.
- Complete COM call graph, path virtual method and ae48a0 normalization unresolved.
- Collation/tie handling/regeneration/all uses of seven rank/cache words unresolved; no blanket-zero algorithm.
- Coverage is all13 captured track fields, not all consumers/record families/versions.
- miah301/302 roles, unknown sort counterparts and native shared-object COW acceptance incomplete.
- Non-ASCII encoding2 URL charset and relocation with opaque location records remain unproved.
- Ghidra omits some register-carried arguments; ASM is authoritative. Exact12.13.10.3 binary only.

## 保全と実行
一重Ghidra、CPU1、heap3G、60秒/関数、noanalysis。既存phase2/main report更新なし。owned project/cacheは分析に伴い更新される。準備時のunwind-less eb8130 KeyError、転送CRC失敗は復旧済みで記録を保存。原EXE hashはreport.json参照。
