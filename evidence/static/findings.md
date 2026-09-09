# iTunes 12.13.10.3 ITL — static explorer findings

## 実施結果と範囲

Apple standalone EXE/MSI版の実物 `C:\Program Files\iTunes\iTunes.exe` を静的解析した。Ghidra 12.1.3で47関数の実際の逆コンパイルに成功し、各関数の元の機械語ASMとCを保存した。さらに元の命令列をUnicornでオフライン実行し、AES既知解、末尾処理、読取暗号区間、文字列出力の計41テストが成功した。

**これは静的解析担当の完了であり、完全ITL read/writeや実アプリ受入の完了ではない。** iTunesプロセスの起動・停止・attach、COM、UI、Apple ID、DRM、クラウド、端末操作は一切行っていない。production source編集、commit/push/PRも行っていない。

- 実行ファイル: 12.13.10.3 / image base `0x140000000`
- SHA256: `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`
- 契約HEAD: `cd744f774663e2a01f3aead25ff990f82fc3c5fb`
- 最終C: `decompiled/<8桁RVA>.c`、47/47成功: `decompiled/summary.tsv`
- 元ASM・範囲・Cハッシュ: `asm/`、`function-atlas.json`
- オフライン検証: `offline-emulation.json` / `offline-emulation.log`
- 以下のアドレスはすべて **iTunes.exe+RVA**。別バージョンにそのまま適用しない。

## codecへ最優先で渡す規則

### 1. コンテナと暗号化

外側ヘッダはbig-endianの `hdfm`。読取 `+0x1085040` は `0x90` bytesを要求し、正規化したmagicが `hdfm` または `hdgm` かを検査する。`BE32(+8)` を実際の64-bitファイル長と比較し、不一致またはmagic不一致は `-208`。`hdgm` のmagic認識は、その全バリアントの互換性を意味しない。

| 外側オフセット | 型・用途 | 根拠 |
|---|---|---|
| +0x04 | BE32 ヘッダ長 H、現行writerは0x90 | +0x106a430 / +0x1085040 |
| +0x08 | BE32 最終的な物理ファイル長 | +0x1085040 / +0x1076780 |
| +0x0c / +0x0e | BE16 format version/subversion、現行0x43/1 | +0x106a430 / +0x1085270 |
| +0x10 / +0x11 | 1-byte長＋バージョン文字列 | +0x106a430 |
| +0x30 | BE32 top-level msdh section数 | +0x1085270 / +0x1075810 |
| +0x34 | BE64 model+0x88からコピーするDB識別子 | +0x106a430 |
| +0x41 | 1-byte暗号フラグ: 0=なし、1=全body、2=上限あり | +0x1085270 |
| +0x43 | 1-byte圧縮フラグ: 非zeroならzlib inflate | +0x1085270 |
| +0x44 / +0x4c / +0x54 | BE32 track/album/artist出力件数 | +0x1075810 |
| +0x52 | 内側のbyte order: 非zero=little、0=big | 多数のrecord read/write |
| +0x5c | BE32 暗号区間の上限、現行writer 0x19000 | +0x106a430 |
| +0x70 | BE32 CFAbsoluteTime＋1904 epoch差から作る時刻 | +0x106a430 |

外側ヘッダのbyte-swap leafは `+0x1068f90`。32-bitだけでなく+0x0c/+0x0eは16-bit、識別子等は64-bitとして個別に交換する。**+0x106a520はbyte-swapではなくstream cursor/cache更新**である。

通常の完全body取得について、実装規則は次のとおり。これは原命令のAES/reader区間テストでも照合した。

```python
B = file[H:]
if encryption_flag == 0:
    interval = 0
elif encryption_flag == 1:
    interval = len(B)
elif encryption_flag == 2:
    interval = min(len(B), cap)
else:
    reject_unsupported()
E = interval & ~15
D = AES128_ECB_decrypt(B[:E], b'BHUILuilfghuila3') + B[E:]
P = zlib_decompress(D) if compression_flag != 0 else D
```

- **flag=2、cap=0は暗号化なし。cap=0を無条件で「全body暗号化」と解釈しない。** generic save-copy helperでは0 length=無制限という別の内部意味があるが、ヘッダ読取とは区別する。
- AESは128-bit ECB。16-byte完全ブロックだけを変換し、残り0〜15 bytesはそのままコピーする。PKCS#7 paddingは追加・除去しない。
- key literalは `+0x1b63af0`。context初期化 `+0xbfbe20`、key schedule `+0xbf9a90`、encrypt block `+0xbfa2a0`、decrypt block `+0xbfb050`、変換wrapper `+0xbfc580`。
- context +4=algorithm 1、+8=mode 1、+0xc=direction 1 encrypt / 2 decrypt。+0x10 key pointer、+0x18 key length16、+0x20 schedule pointer。
- reader `+0x10770a0` は暗号区間内のseekを区間開始から相対16-byte境界へ戻してbufferを充填する。
- `H <= actual_length`、各算術のoverflow、レコードの親境界はcodec側で別途検査する。悪性入力に対するnative実装の全挙動を模倣する必要はない。

### 2. 圧縮と二つのヘッダを混同しない

`+0x1075580` は `deflateInit_(..., 1, "1.2.11", 0x58)` を使う。**level 1 / zlib framing**。通常`deflate(...,0)`、最後は`deflate(...,4)`。入力1MiB、出力2MiBの作業buffer。reader `+0x1084190` は通常の`inflateInit_`と`inflate(...,0)`を呼び、0/1以外のstatusを`-208`にする。

- 全体保存順: `+0x1075810` plaintext serialization → `+0x1076780` compression/header update → `+0xba0ac0` prefix encryption/copy。
- plaintext先頭の `msdh` type16 はheader長`0x60`、total長`0xf0`。そのpayloadが`0x90` bytesの内側ヘッダ。`+0x106cba0`が作る。
- 内側は選択されたbyte order。little-endian時の物理magicは **`mfdh` (6d 66 64 68)** であり、`mdfh`ではない。
- 内側`+8`は **len(P)+0x90**、外側`+8`は **len(最終ファイル)**。内側のcompression byteはwriter初期値0のまま、外側は後で1になる。**圧縮後の外側ヘッダを無条件で内側へコピーしてはいけない。**
- unchanged roundtripのbyte-exact要件には元の暗号化・圧縮済みbytesを保持する。同じlevelでも別zlibビルドで再圧縮すれば同一bytesとは限らない。

zlib1.dll SHA256: `768f2f27015e7244a20952fa423b7aa1adc32ca3e04167886bd1cb5ed9a7b3f8`。version literal `1.2.11` はEXEの `+0x1ac7f4c` に存在する。

### 3. mhoh encoding 3はUTF-8ではない

原命令writer `+0x106ac80` とreader `+0x10773d0`、オフライン出力テストで確認した。

- common header: 24 bytes。+4=header length、+8=total length、+0x0c=payload type、+0x10=string-table等の識別子、+0x14=reserved。
- 通常text payload: +0x18=encoding、+0x1c=byte length、+0x20/+0x24=reserved、+0x28=data。
- encoding1=16-bit Unicode。内側がlittleならUTF-16LE、bigならUTF-16BE。
- encoding1の入力が511 bytes未満かつ全UTF-16 code unit<=255なら、native writerは1-byte値へ縮小しencoding3を出す。**Latin-1相当**で、readerは各unsigned byteをUTF-16 unitへzero-extendする。
- 例: `Café` → encoding3 / bytes `43 61 66 e9`。日本語・絵文字はencoding1を維持。255文字のéはencoding3、256文字ではencoding1だった。
- encoding0にはlegacy/native-codepage変換経路がある。encoding2の意味は未確定。資料の「2=ASCII、3=UTF-8」を仕様扱いしない。
- type **1、0x13、0x42** はこのwriterで16-byte text prefixを使わず、payloadが+0x18から始まる。3種類とも原命令テスト済み。未知typeを文字列として再解釈しない。

### 4. レコード境界・件数・参照

下表はこのwriterの現行サイズ。readerは短いheaderのzero-extension、長いheaderのskipを行うため、過去・将来版に固定サイズを強制する根拠ではない。

| 物理tag (little) | header長 | 主な長さ・件数 |
|---|---:|---|
| msdh | 0x60 | +8=section total、+0x0c=section type |
| mfdh | 0x90 | nested header。+8はplaintext全体+0x90 |
| mlth | 0x5c | **+8=track件数。total lengthではない** |
| mith | 0x2f4 (756) | +8=自身＋mhoh total、+0x0c=mhoh件数 |
| mhoh | 0x18 | +8=total。text prefixの有無はtype依存 |
| miph | **0xdac (3500)** | +8=playlist total、+0x0c=mhoh数、+0x10=mtph数 |
| mtph | 0x54 (84) | +8=自身＋mhoh total、+0x0c=mhoh数 |

- top-level type1/13→track reader `+0x107b460`、2/14→playlist reader `+0x107ee90`、9→album reader `+0x1078140`、11→artist reader `+0x1078bb0`、16→nested header。9/11のdispatchは確認したが両reader全体は今回逆コンパイル対象外。
- track section writer `+0x1070370` は各成功したmith出力で件数を増やし、最後にmsdh totalとmlth countをseek-backしてpatchする。汎用patch helper `+0x106aba0` は元のcursorを保存・復帰する。
- playlist writer `+0x1071260` はitems出力後にmiph totalを計算してheaderをpatchする。mtph writer `+0x1070770` はgroupを再帰処理し、親playlistの+0x10件数を各出力entryで増やす。group子entryは別のmtphレコードとして並び、当該mtph自身のtotalだけで全subtreeを囲むわけではない。
- 通常mtphの **+0x18=32-bit track reference** は、mith+0x10と同じnative track objectの+8から保存される。+0x14にはgroup親entry ID、+0x1cにはgroup判定byte、+0x10にはentry IDを保存する。**track削除時に全playlist/group内参照の更新が必要。** +0x44の64-bit値等の完全な意味は未確定なので保持する。
- 追加・削除では当該mith/miph/mhohの長さだけでなく、msdh total、list件数、外側/内側の集計、参照整合まで更新する。fourCCの文字列検索で境界を推測しない。
- 未知sectionをnative main readerは宣言totalでskipする。ただしnativeがskipすることと、第三者writerが未知bytesを破棄してよいことは別。codecはopaque bytesと順序を保存する。

### 5. 値の幅を誤らない

`mith-field-stores.json` にwriterから抽出したfield offset/型/式/C行番号を保存した。

- mith+0x10は32-bit track ID、+0x80は64-bit persistent ID。
- **+0x6cは1 byte**の値。周囲3 bytesを含む32-bit書換は別flagを壊す。
- +0x4cと+0x60は別のnative fieldsからコピーされる。+0xd8と+0x118も別fields。資料だけで重複counterだと断定して同時に上書きしない。どれがUIのplay/skip操作に対応するかはcontrolled dynamic diffが必要。
- **+0x2bcと+0x2bfはそれぞれ独立した1-byte store**。前者はobject flagからbit抽出、後者は別object+0x107からコピーされる。「+0x2bcの32-bit flagsをゼロにする」操作は+0x2bf等を破壊する。loved/dislikedの意味と値域は動的検証で確定する。
- +0x14の種別はreaderで1→FILE、2→HTTP、3→SHRDに分岐する。異種trackを単純cloneするwriterの安全性は未証明。

## validation / checksumの確度

- outer magic/physical length、format version、暗号flag、zero section数、record magic、複数のpayload/read上限を実際に確認した。
- format version>=0x44、または未知暗号flagは`-876`の経路。0x43/1が現行。古いversionには追加の移行・override条件があり、全旧版対応とはしない。
- 見える`0xa00000`制限は局所的なread/payload用であり、ライブラリ全体10MiB上限ではない。
- zlibの完全streamに伴うAdler-32検証はある。**独立したITL全体checksumの有無・すべての参照整合ルールは未確定**。EXEにcrc32 importがあるだけではITL checksumの証明にならない。
- inflate EOF時に必ずZ_STREAM_ENDを要求する検査はこのCからは明確でない。codecではtruncation、trailing data、decompression budgetを明示的に扱う。
- `+0x179b8e0`はMSVC security-cookie検査で、ITLファイルchecksumではない。原ASMを確認し、Ghidra同梱の`security_check_cookie` fixupを適用した。

## dynamic担当向けhook案（未実行）

合成fixtureに限定し、汎用crypto helperはITL read/saveからのcall stackだけを対象にする。その他の暗号処理・DRM・ユーザーの実ライブラリは採取対象にしない。

| RVA | 観測したい点 |
|---|---|
| +0x1085040 | arg2のouter header、戻り値-208等。物理長不一致を区別 |
| +0x1085270 | top-level load戻り値。fallback/空ライブラリとの区別 |
| +0x10770a0 | RCX=reader context, RDX=out, R8=length。成功時のplaintext境界 |
| +0xbfc580 | RCX=context,RDX=in,R8D=bytes,R9=out,第5引数=count pointer。mode/directionとprefix/tail |
| +0x106ac80 | 7引数のtext writer。type/encoding/lengthのnative正規化 |
| +0x1075580 / +0x1076780 | 圧縮前後の長さとouter +8/+0x43更新 |

受入はアプリが起動できただけでは足りない。編集内容・件数・playlist membership確認、破損/空fallbackなし、native再保存、再起動後再読取まで親/dynamic担当で確認する。

## 手法・再現性・限界

- PE .pdata 77,675 entriesをchained unwindで49,294 logical functionsへ集約。全体auto-analysisはせず47関数を選択し、headlessは同時1プロセス、CPU1、heap3GiB、各関数60秒上限。
- `decompiled1` 21関数、`decompiled2` 17関数を経て、security-cookie fixupと追加crypto pathを含む`decompiled`47関数へ統合。
- Cは実逆コンパイル結果だが、未解析calleeのprototype/引数個数には推論誤りが残る。機械語、呼出規約、オフライン既知解を優先する。Cをそのまま再ビルド可能なsourceと誤解しない。
- オフライン41 tests: FIPS197 encrypt/decrypt2、ITL keyの13長さでencrypt/decrypt roundtrip、同一block比較1、zero-length wrapper拒否1、reader区間13、Unicode/endian/閾値8、direct payload type3。
- AES/core命令とsecurity-cookie命令は元のまま。raw PEで未解決のVCRUNTIME140!memmoveと、readerテストのread/seekだけを純メモリmodelへ置換した。モデル化した境界と各testはJSONに明記。**実アプリ受入ではない。**
- 再実行: `reproduce.md`。ツール/元ファイルはこの環境内で保持し、外部公開していない。

### 実行上の例外を隠さない

1. 最初のGhidra importは成功したがscript lookupは失敗した（launcher exit0でも成功扱いしなかった）。script専用directoryへ隔離し、既存projectを処理して解決。ログ保持。
2. 最初のimportでGhidraがrunnerの `C:\Users\runneradmin\AppData\Roaming\ghidra\ghidra_12.1.3_PUBLIC\symbols\win64` に自動export cacheを作った。**許可された書込root外への副作用**として記録する。以後APPDATA/LOCALAPPDATAもtools/static/homeへ隔離した。共有cacheの削除等はしていない。原本・production sourceの改変はない。
3. 最初のオフライン実験はFIPS encrypt/decrypt成功後、未解決memmove importで停止した。PE importを確認して純メモリmodelを追加し、41 tests成功。失敗ログも保存。
4. 親へのメッセージ送信は配送エラーだったため、この指定report directoryを引継面とする。自己conversation UUIDは確証を得られず、keep-me-awakeは設定していない。推測IDで設定していない。

未完了: 全世代/全record種の意味、未知byteの完全仕様、スマートplaylist等の依存関係、native追加/削除・全UI fieldのcontrolled diff、全体checksumの不存在証明、実アプリでのsave/reload受入。これらを未証明のまま「完全対応」とはしない。
