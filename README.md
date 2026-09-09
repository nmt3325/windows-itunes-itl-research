# Windows iTunes ITL research

Windows版の**Apple公式スタンドアロンEXE版 iTunes 12.13.10.3**を対象とした、ITLバイナリ解析・Python実装・実機検証の研究成果です。Microsoft Store版は使用していません。

**全面的な読み書き対応は未完成です。** 無変更のバイト保存、対応済みフィールド・操作、限定条件の曲追加実験を区別しています。実際のライブラリには必ずバックアップを取り、iTunesを終了してから別コピーで扱ってください。未対応形状は推測で書き換えず拒否します。

## 今回確認したこと

- コア回帰テスト：**976 passed / 5 skipped**。合成テストに加え、固定55個のネイティブITL構造と50個の対応COM記録を検査しました。5件はCOM記録がない明示的スキップで、ネイティブ操作の回数ではありません。
- 日時の負の端数が1904年エポックの0へ化ける問題を修正。保持される入れ子・未知のプレイリスト項目、復元元と不一致のシステム定義は変更前に拒否します。
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

詳しい候補別ハッシュと結果は `evidence/native/phase3/parent-independent-audit.json`、入力・COM期待値・保存結果は同ディレクトリの `candidates/`、`runs/`、`snapshots/` にあります。音声設定の警告がある環境で実施したため、取り込み成功から可聴再生成功は推定しません。

## 実装の範囲

- `itlkit/`：コンテナ復号・展開・再構築、レコード解析、無変更のbyte-exact roundtrip、対応済みメタデータとプレイリスト操作、同一ライブラリ系列での限定的な曲復元・削除、参照整合性チェックと既存出力の保護。
- `Library.add_track_from`／通常の `import-track` は**同一系列の復元用**です。別ライブラリ追加の研究結果を理由に、この制限を解除していません。
- 別ライブラリ追加・新規WAV構築・COWは別の研究用コードです。成功した合成入力・出力に限った実証であり、任意の新ライブラリ・任意の曲・クラウド曲等への保証ではありません。
- 長いCommentは保存ITL上で全文を確認できましたが、COM取得は255文字に切り詰められる場合があります。ディスク上の検証とCOM表示を区別してください。

## 基本的な実行

Python 3.12以降を使用します。確認した環境は Python 3.12.10 / PyCryptodome 3.23.0 / pytest 9.1.1 です。

```powershell
python -m pip install pycryptodome==3.23.0 pytest==9.1.1
python -m pip install -e .
python -B -m itlkit --help
python -B -m itlkit check 'copy.itl'
python -B -m itlkit roundtrip 'copy.itl' 'new-roundtrip.itl'
python -B -m itlkit import-track --help
```

出力は既存ファイルを指定せず、新しいパスを使ってください。操作ごとの正確な引数は `--help` と `docs/format.md`、実機ハーネスは `docs/dynamic.md` を参照してください。研究ハーネスを個人の常用環境で無確認に実行しないでください。

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

SHA-256、サイズ、ファイル集合の一致を検証し、余分なファイルやパスの大文字小文字による衝突等を拒否します。除外はルートの `.git` とマニフェスト自身のみです。テストの生成物はリポジトリ外へ保存してください。

## 証拠と再現上の注意

逆コンパイルC、ASM、エミュレーション用コード、元の10成功候補×2保存と失敗候補、対応するinflate/deflateの限定トレースを収録しています。歴史的な26回のネイティブ制御実験は、10候補×2保存とは別の集計です。古い708/873/912テストの記録は、その時点のソース・条件の記録として残しています。

テキストは改行と実験環境名を正規化し、原SHAと配送SHAの対応を `evidence/delivery/` に記録しています。バイナリの合成ITLは原バイトを保持しています。そのため内部Locationは当時の実験パスのままで、別PCでそのまま開ける移植済みライブラリではありません。歴史的な静的解析スクリプトには実験時のツール配置依存が残っています。

AppleのEXE/MSI/DLL、他社実行ファイル、提供された個人のITL・音源・アートワーク・元アーカイブ、認証情報、内部の会話・運用履歴は収録していません。

## 残る制約

未知の文字列プール・参照専用表現、一般的な共有オブジェクトCOW、入れ子・任意のsmart/systemプレイリスト、空Nameのnative挙動、完全なソート再構築、タイムゾーン/DSTの一般化、他バージョン・クラウド/Store形式は未解決です。実験用のrawレコード操作を、汎用で安全な編集APIと見なさないでください。

## 曲追加の限定再現ツール

`scripts/experimental-import/README.md` に、既知3入力SHAだけを受け入れる明示的opt-in CLIがあります。公開APIとは別物で、媒体のLocation移動や任意のITLへの追加は拒否します。新規WAV構築の歴史的builderは `evidence/research/constructor/`、既知クロスライブラリ手順は `evidence/research/cross-library/` にあります。これらの歴史的資料のnative-pending表記は作成時点の状態で、最新結果は `evidence/native/phase3/parent-independent-audit.json` を参照してください。
