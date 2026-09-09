# Windows iTunes ITL Research

Windows の **Apple 公式スタンドアロン EXE 版 iTunes 12.13.10.3** を対象にした、ITL 解析・Python reader/writer・実機検証プロジェクトです。Microsoft Store 版ではありません。

> **開発・検証中です。任意の ITL を完全に意味編集できるという保証ではありません。必ず iTunes を終了し、原本のコピーで作業してください。**

## このリポジトリに保存する成果

- `itlkit/`: コンテナの復号・展開・再構成、バイト一致 roundtrip、検証付きの限定的な意味編集、CLI。
- `tests/`: 合成データによる回帰テスト。
- `scripts/windows/`: iTunes の COM/UI 操作、native save/reload gate、Frida による実測トレース用スクリプト。
- `docs/`: フォーマット・操作方法・実機検証手順。
- `evidence/`: 選択した逆コンパイル結果、検証記録、合成ライブラリ。元の音楽・個人ライブラリ・認証情報は収録しません。

## 検証状況 — 初回アップロード時点

- 親側統合コードの固定コホートで **708 tests passed**（合成テスト653件＋native ITL 55件。50件には対応する COM 記録あり）。これは708種類の実機操作を意味しません。
- iTunes 自身の操作による26ケースと、独立 writer の10候補について各2回の保存・再起動を確認。
- 実際の inflate / deflate バッファと、独立した AES / zlib 処理の一致を確認。
- 初期47関数＋追加4関数を実バイナリから逆コンパイル。別に41件の元命令エミュレーションを実施。
- 暗号・圧縮フラグ、cap境界、Latin-1、共有索引、大規模ライブラリの追加実験は継続中です。

**既知の制約・修正中の事項:** fresh状態の曲名が後から戻る問題、opaque suffixを伴う索引クリア、stale handle、補助PIDの衝突、外側section-count、未知header参照、COM oracleの厳密性、Windowsの早期HFS日時。原本は変更せず、失敗記録と補正候補を分離しています。

## 最小の使い方

Python 3.12 以上:

```sh
python -m pip install -e . pytest
python -m pytest -q
python -m itlkit --help
python -m itlkit check "library-copy.itl"
python -m itlkit roundtrip "library-copy.itl" "roundtrip.itl"
python -m itlkit roundtrip --rebuild "library-copy.itl" "rebuilt.itl"
python -m itlkit patch "library-copy.itl" operations.json "modified.itl"
```

既存ファイルへの上書きは拒否します。`operations.json` の仕様とサポート範囲は `docs/format.md` を参照してください。未知の構造は保全を優先し、安全性を確認できない編集は拒否します。

解析元の作業履歴には非公開の参照情報が含まれるため、ここには内容を選別した独立の配送履歴を保存します。解析用コミットと配送用コミットは別です。

## 配布ファイルと固定コホートの検証

```sh
python scripts/research/verify_delivery.py
```

PowerShell で55ファイルの固定コホートも含める場合:

```powershell
$env:ITLKIT_NATIVE_ROOT = (Resolve-Path evidence/native/snapshots).Path
$env:ITLKIT_NATIVE_REPORTS = (Resolve-Path evidence/native/oracles).Path
python -m pytest -q -p no:cacheprovider
```

テキストは配送用にパスと改行を正規化しています。元の解析記録内のハッシュは元の解析出力を指し、配送されたファイルのSHA-256は `DELIVERY-MANIFEST.json` を参照してください。ITLバイナリは変更していません。COM記録は51ファイルあり、50ファイルに対応する非空のafter-stateがあります。
