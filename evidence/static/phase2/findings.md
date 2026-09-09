# ITL static phase2 — URL encoding / ID namespaces

## 結論と実行範囲

**encoding2を一律拒否してはいけない。** Windows iTunes12.13.10.3自身がFILE型のURLをencoding2で書く。HTTP型ではencoding0を指定する。URL専用dispatchはあるが、低レベル読取関数は通常textと共通で、modeとpoolが異なる。

追加逆コンパイルは4関数だけ（上限6、未使用2）。1 headless process / CPU1 / heap3G / 60秒-per-function / noanalysisで完了。既存47関数、元ASM、主報告とcodec監査を含む103ファイルのSHA不変を確認した。production変更、iTunes/COM/UI操作、ライブattach、外部公開なし。

EXE SHA256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`。

## URLの実経路

| 対象 | writer wire encoding | reader destination mode | pool / 出力 |
|---|---:|---:|---|
| FILE、mith+0x14=1、mhoh0x0b | 2 | 5 | *(track+0x2c8) / track+0x2c0 |
| HTTP、mith+0x14=2、mhoh0x0b | 0 | 0 | *(track+0x2c8) / track+0x2b8 |
| 通常text | 主に1/3 | 1 | 種別で選ぶlibrary共通pool |

Writer `+0x106daf0` → `+0x106b030` → `+0x106ac80`。helper第5引数がwire encodingまで渡る。FILE=2は単なる未解釈modeではない。

Reader `+0x107b460` → `+0x10773d0`。URLではexternal-ID引数を明示的に0にする。wire mhoh+0x10のIDはこの枝では使わない。options bit0が0のencoding2はraw-byte insertionへ進み、ASCII検証・UTF8変換・Latin1変換はこの枝に確認できない。通常mode1のencoding3はunsigned Latin1 byte→UTF16展開。encoding2の普遍charsetは未確定。

根拠: `url-and-field-evidence.txt`、`../decompiled/0106b030.c:31-33`、`../decompiled/0106ac80.c:74-83`、`../decompiled/010773d0.c:70-94,452-462`、`../asm/0106daf0.asm`の`+0x1070153..0x10701bd`。

## Native snapshot分布

`snapshot-manifest.json`に固定した52ファイルをbounds付き構造walkで解析。URLあり51ファイル、延べ145件が全てFILE/encoding2/ASCII/NULなし。byte lengthは89または90、SHAで重複排除すると3種類だけ。HTTP・非ASCII・percent escapeの実例は0。

初回46ファイル/131件の後、dynamic担当の110/111/112ケースのreload1/2が到着したため52/145へ拡張して固定した。追加6ファイルのSHAは担当のacceptance結果と一致し、その3ケースのstatusはpassed。ただしこの担当がnative受入を実行したという意味ではない。候補入力とnative再保存物を混同していない。

52の独立ライブラリでも145の独立URLでもない。censusには完全URLやmedia pathを出力せず、offset・ID・長さ・hashを保存した。詳細は`native-url-census.json`と`native-v3-snapshot-provenance.json`。

## 安全なdecode/write条件

1. encoding2だけを理由にファイル全体を拒否しない。bytes・encoding・type・kind・reserved fieldsをlosslessに保持する。
2. FILE-kind1 + mhoh0x0b + encoding2でstrict ASCIIを満たす既存値のASCII viewは妥当。ただしreader mode5とwire encoding2を混同しない。
3. 非ASCII/NUL/control等を勝手にUTF8/Latin1へ変換・置換・切捨てしない。raw/opaqueで読み、解釈が必要なその編集だけを止める。無関係なlossless操作まで一律拒否にしない。
4. 未変更値はexact bytesを維持する。FILEは2、HTTPはnative writerが0で、全URLへの2強制も誤り。ASCII viewをpercent-decodingやOS-path正規化と同一視しない。
5. URL移動/new pathはpayload書換えだけでは安全未確認。type1等のlocation binary metadata、参照、native再保存との整合性を別に検証する。

NUL/controlチェックはsemantic edit用の保守的gateであり、native低レベルreaderが必ず拒否するとの観測ではない。長さはbyte countとしてenclosing record bounds内で検証する（native上限0xa00000）。encoding2へUTF16 byte swapを適用しない。これらはwire/preservation条件であって任意URL編集のnative受入保証ではない。

## mhoh atom IDはpool単位

`L = *(reader + 0x1e00270)`。次はC/ASMで確認した部分表。

| pool | mhoh利用箇所 |
|---|---|
| L+0x178 | track2 |
| L+0x1c0 | track3、album300 |
| L+0x208 | track4/12/27、album301/302、artist400 |
| L+0x640 | album304（通常album名と意味を同一視しない） |
| L+0x5b0 | album303/305/307。303/305はmode0/options1、307はmode0/options0 |
| L+0x17f8 | artist401 |
| per-track *(track+0x2c8) | FILE/HTTP URL、external-ID引数0 |

Album reader `+0x1078140`: mlah header0x5c、miah0x58、mhoh type300..307 dispatch。Artist reader `+0x1078bb0`: mlih/miih0x64、400/401 text、402は別payload helper。どちらも通常textでmhoh+0x10をexternal-IDへ渡す。Trackの通常textはASM `+0x107d188`でmhoh+0x10をR9Dに読み、そのままcallへ保持する。Cで省略された引数はASMで補った。

確認済3poolで433回のnonempty positive-ID利用、83のcross-record共有group、同一pool・同一IDのdecoded UTF16LE hash衝突は0。003 snapshotのURLは3本ともwire ID2だがpayloadは3種類なので、global uniqueness制約では正常ファイルを誤判定する。

015 snapshotではalbum300はtrack3と一致し、album301/302とartist400はtrack27と一致した。album301を常にtrack4と同一視する等の機械的な業務上の意味付けは避ける。型・poolの一致と役割は別。

## 登録の副作用とID-zero化の危険

追加C `+0xbfe500`: external IDは正のint。byte length0はlookup前に成功しoutput ID0のまま。空本文はreference-onlyではない。pool flag bit0有効時、既存external→internal mappingがあれば旧internal IDを返しrefcountを増やすが、入力bytesを比較・置換しない。**先に登録した値が残る。** Mappingは最大external IDに応じたdense4-byte配列なので巨大なPID/乱数をIDに流用しない。

追加C `+0xbfe1f0`: unkeyedでは長さとmemcmpで同一bytesを探せる。ただしnonempty入力でpool+0x28のexternal-map容量が非zeroなら-50。**mhoh IDの一律zero化は安全な回避策ではない。**

pool内の利用箇所と読取順を扱う必要がある。今回のnative section順はalbum/artistがtrackより前で、同じIDを残してtrackのbytesだけ変えると先のmappingに吸収され得る。

## Object ID・persistent ID・rankを分離

| wire field | 経路 |
|---|---|
| miah+0x10 | reader+0x1e002c0 album-object mapへ登録 |
| miih+0x10 | reader+0x1e002d8 artist-object mapへ登録 |
| mith+0xdc | album lookup。writer: common-track+0x28 → album-object+0x18 |
| mith+0x1e0 | artist lookup。writer: common-track+0x40 → artist-object+0x3c |
| miah/miih+0x14 | 別の64-bit値を読んでconstructorへ渡す。local IDとは別 |
| mith+0x290/294/298/29c/2a0/2a4/2a8 | common-track+0xe0/e4/e8/ec/f0/f4/f8の各32-bit値 |

145 track occurrencesのalbum/artist参照は各145件ともtargetあり、positive local-ID重複0。strc atom poolとobject mapsは別物。

rank-like7fieldはtext atom member（+0xb0等）と別。003のtitle atoms1/2/3に対し+0x290は1000/2000/3000。012ではatom4のtrackがrank0になる。再生成/collation/tie処理は未確定なので、atom再採番で置換したり一律zeroにしない。

## Shared album/artist更新の境界

同じlocal-object IDを参照すれば同じlookup結果を受け取る。1曲だけの変更では元共有objectを保持し、適切な新object（または意味的に一致する既存object）と衝突しないstring IDsへ必要な参照だけを移すcopy-on-write制約が導かれる。削除は残存参照を考慮し、unknown bytes/order/countを維持する。

ただし52-file synthetic cohortには、**複数trackが同一album/artist local-object IDを共有するケースは0**。83のstring共有groupとは別。多所有者COWのnative受入や完全な重複排除規則は未検証。CRUD担当のprivate入力の知見を、自分が再検証したデータと合算していない。

## 成果物と限界

`report.json`、追加4関数の`decompiled/`と`asm/`、`native-url-census.json`、`snapshot-manifest.json`、`namespace-census.json`、`object-reference-census.json`、`safe-decode-write-policy.json`、`reproduce.md`、`execution-ledger.json`、`final-qa.json`、`artifact-manifest.json`。

未確定: 非ASCII encoding2の普遍charset、percent処理、HTTP実例、移動時metadata、rank再生成、全album種類、artist402、multi-owner COW受入、全version/namespace。Artist Cのtype-propagation warningを保持し重要引数はASM照合した。

以前のcodec監査は変更せず、本phase2はencoding2のscopeを追加根拠で限定する追補とした。以前のnative受入済みケースを取り消すものではない。
