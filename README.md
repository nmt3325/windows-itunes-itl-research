# Windows iTunes ITL research

Windows版の**Apple公式スタンドアロンEXE版 iTunes 12.13.10.3**を対象とした、ITLバイナリ解析・Python実装・実機検証の研究成果です。Microsoft Store版は使用していません。

**全面的な読み書き対応は未完成です。** 無変更のバイト保存、対応済みフィールド・操作、限定条件の曲追加実験を区別しています。実際のライブラリには必ずバックアップを取り、iTunesを終了してから別コピーで扱ってください。未対応形状は推測で書き換えず拒否します。

仕様監査の入口は [`SCOPE.md`](SCOPE.md) です。正規フォーマット仕様は [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md)、データモデルは [`ITL_DATA_MODEL.md`](ITL_DATA_MODEL.md)、レコード一覧は [`ITL_RECORD_TYPES.md`](ITL_RECORD_TYPES.md)、スマートプレイリストは [`SMART_PLAYLIST_SPEC.md`](SMART_PLAYLIST_SPEC.md)、Windowsパス／日時は [`PATH_AND_TIME_SPEC.md`](PATH_AND_TIME_SPEC.md)、対応版は [`VERSION_MATRIX.md`](VERSION_MATRIX.md)、全ITLコーパスは [`corpus-manifest.json`](corpus-manifest.json)、証拠対応表は [`EVIDENCE.md`](EVIDENCE.md)、未解決事項は [`UNRESOLVED.md`](UNRESOLVED.md)、機械可読な判定は [`completion-status.yaml`](completion-status.yaml) にあります。旧 [`docs/format.md`](docs/format.md) は互換リンクです。

## 今回確認したこと

- 回帰テスト：**1069 passed / 5 skipped**（独立リファレンスツール27件を含む）。合成テストに加え、固定55個のネイティブITL構造と50個の対応COM記録を検査しました。5件はCOM記録がない明示的スキップで、ネイティブ操作の回数ではありません。
- 日時の負の端数が1904年エポックの0へ化ける問題を修正。保持される入れ子・未知のプレイリスト項目、復元元と不一致のシステム定義は変更前に拒否します。
- テンプレートを使わず構築した1曲／3曲・raw/zlibの4つの参照ITLは、隔離したiTunesで各2回のopen/save/restartに合格しました。合格は4つの正確なSHA-256だけに限定され、任意件数・任意入力や完全仕様を意味しません。
- 下記6候補を**実iTunesで選択して開き、各2回保存・終了・再起動**。最初45秒、次30秒の観察後にも期待値を確認しました。

| 実験 | 既存曲 | 追加曲 | 結果 |
|---|---:|---:|---|
| 公開APIでの新規Name/カウンター編集 | 3 | 0 | 2サイクル成功 |
| 独立した別ライブラリから1曲追加 | 3 | 1 | 2サイクル成功 |
| 共有インデックスを持つ2曲追加 | 3 | 2 | 2サイクル成功 |
| 2曲追加＋限定したAlbumArtist COW | 3 | 2 | 2サイクル成功 |
| 新しく生成したWAVのレコード構築・追加（003） | 3 | 1 | 2サイクル成功 |
| 新しく生成したWAVのレコード構築・追加（037） | 3 | 1 | 2サイクル成功 |

独立したオフライン監査でも、候補→保存1→保存2のハッシュ連鎖、全曲の一意なPID、旧曲と新曲のメタデータ・Location、7/8個の可視プレイリスト、**14/15個すべての保存されたプレイリスト参照**を照合しました。監査入力61ファイルは不変でした。監査自体を追加の実機試験とは数えていません。

詳しい候補別ハッシュと結果は [`evidence/native/phase3/parent-independent-audit.json`](evidence/native/phase3/parent-independent-audit.json)、入力・COM期待値・保存結果は同ディレクトリの `candidates/`、`runs/`、`snapshots/` にあります。音声設定の警告がある環境で実施したため、取り込み成功から可聴再生成功は推定しません。

## 実装の範囲

- [`itlkit/`](itlkit/)：コンテナ復号・展開・再構築、レコード解析、無変更のbyte-exact roundtrip、対応済みメタデータとプレイリスト操作、同一ライブラリ系列での限定的な曲復元・削除、参照整合性チェックと既存出力の保護。
- `Library.add_track_from`／通常の `import-track` は**同一系列の復元用**です。別ライブラリ追加の研究結果を理由に、この制限を解除していません。
- 別ライブラリ追加・新規WAV構築・COWは別の研究用コードです。成功した合成入力・出力に限った実証であり、任意の新ライブラリ・任意の曲・クラウド曲等への保証ではありません。
- 長いCommentは保存ITL上で全文を確認できましたが、COM取得は255文字に切り詰められる場合があります。ディスク上の検証とCOM表示を区別してください。

## 独立リファレンスツール群

既存 `itlkit` を呼び出さない比較用の小実装を `REFERENCE_PARSER/`、`REFERENCE_WRITER/`、`VALIDATOR/`、`SEMANTIC_DIFF/`、`TEST_CORPUS/` に分離しています。ASTテストでも5ディレクトリからの `itlkit` importを拒否します。

- parser：観測済み12.13.10.3／12.13.9.1のversion detector、境界付きrecord dump、限定semantic summary。
- validator：既知の構造、件数、ID一意性、曲・プレイリスト・album/artist参照を検査。未知領域は走査したことにせず警告します。
- writer：同一versionのbyte-exact copyのみ対応。実変換の対応表がないcross-versionは出力前にfail-closedです。
- semantic diff：Persistent IDを安定キーに既知フィールドを比較し、未モデル化変更はsection SHA-256差分として残します。
- test corpus：ゼロから構築した1曲／3曲のraw/zlib fixture、生成provenance、SHA-256付き `corpus-manifest.json` を収録します。チェックイン済み4ハッシュだけは実機2サイクルで `verified`、値を変えた生成物とtemplate-envelope生成物は `unverified` です。

```powershell
python -B -m REFERENCE_PARSER detect file.itl
python -B -m REFERENCE_PARSER dump file.itl
python -B -m REFERENCE_WRITER convert input.itl output.itl --to-version 12.13.10.3
python -B -m VALIDATOR file.itl
python -B -m SEMANTIC_DIFF before.itl after.itl --fail-on-change
python -B -m TEST_CORPUS generate output.itl
python -B -m TEST_CORPUS manifest --check
```
## Smart/path final evidence

- [`SMART_PLAYLIST_SPEC.md`](SMART_PLAYLIST_SPEC.md) and [`itlkit/smart.py`](itlkit/smart.py) provide a lossless `SLst` AST/parser/serializer and type-102 structural view. The census parsed 95/95 retained ITLs, covering 1,235 smart/system playlist instances. User-created rule semantics, evaluation, and arbitrary editing remain unresolved.
- [`PATH_AND_TIME_SPEC.md`](PATH_AND_TIME_SPEC.md) records 30 path cases and 8 `PlayedDate` mutations on isolated Windows iTunes 12.13.10.3. It retains 39 native-saved snapshots, all parseable; physical external media, remote SMB, drive reassignment, and a direct Japanese filesystem path remain unresolved.
- [`evidence/native/fresh-20260921/`](evidence/native/fresh-20260921/) records a genuinely fresh iTunes-created library through empty/one/three-track, traced edit, and repeated saves. Because iTunes created it, this cohort alone is not reference-writer evidence.
- [`evidence/native/reference-generated-20260922-passed/`](evidence/native/reference-generated-20260922-passed/) records the two exact one-track hashes; [`evidence/native/reference-multi-track-20260922-v2/`](evidence/native/reference-multi-track-20260922-v2/) records two exact three-track hashes with Japanese, emoji, and decomposed Unicode names. All four passed two strict cycles with exact identities and ordered membership, no XML/backup fallback, normal quit, and independent validation after each save. The preceding [`reference-multi-track-20260922/`](evidence/native/reference-multi-track-20260922/) attempt failed in UTF-8 preflight before iTunes launch and is retained as harness evidence, not native rejection.
- [`corpus-manifest.json`](corpus-manifest.json) hashes all 356 retained ITLs and links the nested reference, fresh-native, path/time, smart-playlist, reference-generation, media-field, Lyrics-authority, boundary, and frame-size-ceiling analyses. The four checked-in one-track/three-track reference fixtures are `verified` only for their pinned hashes.

## 2026-09-22 retained closure probes

- The isolated native field matrix passed 27 of 29 one-property mutation/restart cases. Lyrics raised a COM error and `Enabled=false` projected back as `true`; both failures are retained and no full-field claim is made. See [`evidence/native/field-matrix-20260922/README.md`](evidence/native/field-matrix-20260922/README.md).
- A media-backed follow-up passed fresh native `AddFile` initialization and a separate baseline restart for both failed fields, then reproduced the exact Unicode `Lyrics` COM exception and `Enabled=false`→`true` immediate readback on WAV. Its first run remains a pre-mutation harness-identity failure, not native rejection; see [`evidence/native/media-field-followup-20260922-v2/README.md`](evidence/native/media-field-followup-20260922-v2/README.md).
- A same-value media-kind pair rejected short plain-ASCII Lyrics on deterministic WAV but accepted and restart-persisted it on one deterministic MP3. Strict ID3 analysis proves that the exact short rewrite added one ID3v2.2 `ULT` prefix and preserved the complete MPEG audio tail byte for byte. See [`evidence/native/media-lyrics-ascii-20260922/README.md`](evidence/native/media-lyrics-ascii-20260922/README.md) and [`evidence/native/media-field-followup-20260922-mp3-ascii-v3/README.md`](evidence/native/media-field-followup-20260922-mp3-ascii-v3/README.md).
- Eleven earlier fresh MP3 cases passed all four sessions: one Unicode value and ASCII lengths 255, 256, 1,024, 4,096, 8,192, 16,384, 32,767, 32,768, 65,535, and 65,536. See [`evidence/native/media-lyrics-boundary-20260922/README.md`](evidence/native/media-lyrics-boundary-20260922/README.md) and [`evidence/native/media-lyrics-extended-boundary-20260922/README.md`](evidence/native/media-lyrics-extended-boundary-20260922/README.md).
- A separate 14-case ceiling cohort added exact restart-persistent ASCII points at 131,072, 1,048,576, 8,388,608, 16,777,208, and 16,777,209 characters, then nine qualified native non-exact immediate readbacks at 16,777,210–16,777,216, 17,000,000, and a repeated 16,777,210. Zero cases were harness failures. Formal adjacent reports prove that a 16,777,215-byte `ULT` payload is stored exactly as `0xFFFFFF`, while the next 16,777,216-byte payload is nonconformantly stored as `0x000000` modulo 2^24. This is a bounded MP3/ID3v2.2/`ULT`/COM/build transition, not a universal `Lyrics` limit. See [`evidence/native/media-lyrics-ceiling-20260922/README.md`](evidence/native/media-lyrics-ceiling-20260922/README.md).
- In three reset-ITL probes on the retained track, COM Lyrics followed the exact MP3 tag input: original `ULT`, stripped tag, and equal-length conflicting `ULT`. This is bounded precedence evidence and does not exclude hidden caches or establish generic storage authority. See [`evidence/native/lyrics-authority-20260922/README.md`](evidence/native/lyrics-authority-20260922/README.md).
- External `quinnjr/itl-rs` at pinned commit `49f3ad3…` preserved the exact expanded payload of the zlib/AES reference and its 755-byte output passed two strict native cycles. The same implementation rejected raw input, reported the track PID as zero, and emitted mutation candidates that failed mandatory conformance checks. This is exact-hash structural interoperability, not a correct independent semantic implementation. See [`evidence/independent/itl-rs-20260922/README.md`](evidence/independent/itl-rs-20260922/README.md).
- Twenty-four native Smart Playlist attempts are retained. v24 created native nested wrapper framing and an Artist/contains string-family leaf, but the operand serialized empty and membership remained empty. The series is negative evidence, not semantic editing support. See [`evidence/native/smart-playlist-default-20260922/README.md`](evidence/native/smart-playlist-default-20260922/README.md).
- A 2026-09-25 U-13 pair tested one exact fixed-seed 17-byte opaque compressed trailer against its exact trailer-free control on signed standalone iTunes 12.13.10.3. Both passed two strict isolated cycles; the first native save stripped the candidate trailer and the restart kept it absent. This is exact-candidate load/save evidence, not trailer semantics or safe editability, and U-13 remains open. See [`evidence/research/20260925/native-trailer-u13/README.md`](evidence/research/20260925/native-trailer-u13/README.md) and [`docs/native-trailer-u13-20260925.md`](docs/native-trailer-u13-20260925.md).
- The strict complete-analysis/specification gate remains **false**. U-01 through U-18 remain blockers; successful parsing, refusal, structural preservation, finite native-accepted cases, or a measured lower bound are not counted as complete interoperability.

## 基本的な実行

Python 3.12以降を使用します。確認した環境は Python 3.12.10 / PyCryptodome 3.23.0 / pytest 9.1.1 です。

```powershell
python -m pip install pycryptodome==3.23.0 pytest==9.1.1 tzdata==2026.4
python -m pip install -e .
python -B -m itlkit --help
python -B -m itlkit check 'copy.itl'
python -B -m itlkit roundtrip 'copy.itl' 'new-roundtrip.itl'
python -B -m itlkit import-track --help
```

出力は既存ファイルを指定せず、新しいパスを使ってください。操作ごとの正確な引数は `--help` と [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md)、実機ハーネスは [`docs/dynamic.md`](docs/dynamic.md) を参照してください。研究ハーネスを個人の常用環境で無確認に実行しないでください。

### 回帰テスト

リポジトリルートで、配送された固定コホートを指定します。

```powershell
$env:PYTHONDONTWRITEBYTECODE='1'
$env:PYTHONIOENCODING='utf-8'
$env:ITLKIT_NATIVE_ROOT=(Resolve-Path '.\evidence\native\snapshots').Path
$env:ITLKIT_NATIVE_REPORTS=(Resolve-Path '.\evidence\native\oracles').Path
python -B -m pytest tests -q -rs -p no:cacheprovider --basetemp "$env:TEMP\itl-research-tests-new"
```

このテストは保存済みの合成ITL・COM記録を使うオフライン回帰です。iTunesを新規起動する実機受入試験の代わりではありません。試験用一時ディレクトリは新しいものを指定してください。

### 配送ファイルの整合性

```powershell
python -B scripts/research/verify_delivery.py
```

SHA-256、サイズ、ファイル集合の一致を検証し、余分なファイルやパスの大文字小文字による衝突等を拒否します。除外はルートの `.git`、マニフェスト自身、および editable install が生成するトップレベルの `windows_itl_research.egg-info` だけです。その他または入れ子の `*.egg-info` は除外しません。テストの生成物はリポジトリ外へ保存してください。

## 証拠と再現上の注意

逆コンパイルC、ASM、エミュレーション用コード、元の10成功候補×2保存と失敗候補、対応するinflate/deflateの限定トレースを収録しています。歴史的な26回のネイティブ制御実験は、10候補×2保存とは別の集計です。古い708/873/912テストの記録は、その時点のソース・条件の記録として残しています。

テキストは改行と実験環境名を正規化し、原SHAと配送SHAの対応を [`evidence/delivery/`](evidence/delivery/) に記録しています。バイナリの合成ITLは原バイトを保持しています。そのため内部Locationは当時の実験パスのままで、別PCでそのまま開ける移植済みライブラリではありません。歴史的な静的解析スクリプトには実験時のツール配置依存が残っています。

AppleのEXE/MSI/DLL、他社実行ファイル、提供された個人のITL・音源・アートワーク・元アーカイブ、認証情報、内部の会話・運用履歴は収録していません。

## 残る制約

未知の文字列プール・参照専用表現、一般的な共有オブジェクトCOW、smart/systemプレイリストのlossless ASTを超える任意編集・評価、空Nameのnative挙動、完全なソート再構築、タイムゾーン/DSTの一般化、他バージョン・クラウド/Store形式は未解決です。実験用のrawレコード操作を、汎用で安全な編集APIと見なさないでください。

## 曲追加の限定再現ツール

[`scripts/experimental-import/README.md`](scripts/experimental-import/README.md) に、既知3入力SHAだけを受け入れる明示的opt-in CLIがあります。公開APIとは別物で、媒体のLocation移動や任意のITLへの追加は拒否します。新規WAV構築の歴史的builderは [`evidence/research/constructor/`](evidence/research/constructor/)、既知クロスライブラリ手順は [`evidence/research/cross-library/`](evidence/research/cross-library/) にあります。これらの歴史的資料のnative-pending表記は作成時点の状態で、最新結果は [`evidence/native/phase3/parent-independent-audit.json`](evidence/native/phase3/parent-independent-audit.json) を参照してください。

## Final qualification supplement

[`evidence/final-supplement.json`](evidence/final-supplement.json) records the final source and offline checks. It adds the independent final review, bounded historical fuzz results, encoded-media generation/provenance (not native-qualified formats), original generated WAV prerequisites, and native allocation/playback/restoration controls. The follow-up native AddFile allocation passed; the silent playback attempt did not establish playback. The original selected library bytes and volume were restored and iTunes exited normally. These controls are not extra independent writer candidates.
