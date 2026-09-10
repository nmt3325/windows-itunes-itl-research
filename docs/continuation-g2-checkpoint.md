# G2 継続解析・中間チェックポイント

対象ソースは **`47820efb5fd28001556b32fe21d76774dd987c39`**。2026-09-10の固定点の公開案であり、動き続けるブランチの最新状態や、最終的な完全read/writeを表すものではありません。完全なSHA・サイズ・Git同一性・一次記録のSHAは[証跡JSON](../evidence/20260910/g2-source-checkpoint.json)に記録しています。

**資格区分：discovery / offline checks。独立writerのnative acceptanceではありません。G2の新規native実行は0、playback未検証です。** 本監査は固定Git bytes、保存済みJUnit／log、入力の同一性を照合しました。下記のproduction pytestやfuzzを再実行して件数を作ったものではありません。

## 世代・母集団を分けた結果

| 記録 | 通常ケース | 別枠subtests | 判定・範囲 |
|---|---:|---:|---|
| G1・旧ローカル `3627f4e…` | 1,387 pass / 6 skip | 36 | 過去の親報告。G2結果への流用なし |
| G2・固定 `47820ef…` | 1,393 collected = 1,387 pass + 6 skip | 36 | 親の新しい実走記録。failure/error 0 |
| G2・C976担当内差分 | 132 → 181（180 pass / 1 skip） | 合算しない | **49新規ケース**。旧ケース欠落0 |
| G2・新CLI | 22 expected-red → 22 green | なし | 読取診断と拒否規則のみ |
| G2・media初回 | 1,212 = 1,161 pass + 51 skip | 26 | 入力環境不足の記録を保持 |
| 同じmediaソース・入力環境補充後 | 1,212 = 1,207 pass + 5 skip | 36 | 既存10 snapshotを指定。ソース変更・媒体生成なし |

- **同じ1,387／6でもG1とG2は別の実行です。** JUnitの通常case行は1,393。suite属性の1,429は別枠36を含むため、1,429ケース合格とは数えません。
- 親の旧G2 1,212ケースは欠落0。C976の49は担当内132→181の差で、親の1,212→1,393との差181とは別です。49ケースが親の集合に含まれることも照合しました。
- 現在の6 skipは、歴史的COM after-oracle不足5件と、実依存実装が存在するため適用外になった「依存欠落」テスト1件です。skipを成功に含めません。
- CLI redとgreenの記録はいずれもbase `dff7198…`。redは未実装コマンドのexit 2による22失敗、greenは**未commitのCLIパッチ適用後**です。green時点のCLI／test SHAが今回の固定Git bytesと一致します。単にbase commit名だけでgreenを再現できるとはしていません。
- mediaの51→5は `ITLKIT_FRESH_SNAPSHOT_DIR` に既存の10 snapshotを指定した訂正です。初回の記録を消去・上書きしたり、統合を再実行したものではありません。

## ソース・入力の同一性

C976 `c976b964ae9eb01690c6e554cc75ac98a8e29178` の親レビュー済み7ファイルは、親固定Git blobとサイズ／SHAが全一致。`itlkit/library.py` は `f70f5f51…` を維持しています。codec `66bdf7c…`、CRUD `7028695…`、playlist `ca68e72…`、media `f842e26…` は固定点へのGit ancestryを確認しました。これは各実装の全意味論を包括的に認定するものではありません。

固定cohortは **116ファイル＝歴史的snapshot 55＋保存済みoracle文書51＋既公開discovery snapshot 10**。全116のbytesが固定Gitと一致し、G2の入力pinに対してSHA／サイズ／mtimeが保持されています。51文書は51個の利用可能なafter-stateを意味しません。

**このmtime保持はG2試験・照合区間の話です。Git checkoutのmtimeをG1原実行の保全と呼びません。** 過去のLocation、Unicode名、literal `&`／`%26`も「移植性を得た」ことにするための書換えを行っていません。

## 回収・新規再構成・欠落

- 初回package partial recoveryは、元SHA一致の原文3点（verifier・dates validator・PCM4 action intent）と新しい限定再構成の組合せです。13ファイルの既封印bundle、README、manifestは変更せず全件再照合しました。
- 当時の61 verifier controls／76 scalar numeric checksは新規G2検証です。旧192ケースの完全回収でも、今回のpytestの追加合格数でもありません。
- C976の7ファイルは新しいG2開発です。現在のblobの完全一致を「G1原文そのままの回収」と混同しません。
- **本package回収範囲では**元G1 bundle全体・元README／manifest・verifier旧test、旧dates全入力／出力、PCM4／folderのproducer・期待状態・oracle・保存chain、新static-stage1のC／ASM／replay閉包は未回収／未閉包です。他担当の全回収物の総数とはしていません。identity／graph旧test 2点・codec旧test 3点の欠落はC976担当報告の区分です。

## 未解決事項

指定されたfuzz一次報告のSHAは **`c5578ead20fa708eff7cc72910441ffbcdf5cf53b4b340c7b14f2e2cd66a5fe2`**。対象 `209fb892…` で **434実行＝238 accepted＋188 safe refusal＋8予期しないAttributeError**、未実行0です。section／trackのkindにNone・int・list・dictを入れた新しい類似合成ケースであり、旧634ケースのreplayではありません。8件の入力modelは不変でも、例外の安全な拒否への変換は未合格です。`complete`は実験終了であって合格ではありません。影響する`raw.py`／`planning.py`は固定47820でも同じbytesです。

後続codec resource拡張、constructor予算fix、native production guardsは**この固定点には未採用**。修正進行中の成果を先取りしません。任意cross-library書換え、foreign-history mutation、smart／opaque／補助recordを含む完全意味論は未対応／未認定です。旧6 candidateの45秒＋30秒passive cycleは歴史的証拠で、G2新規nativeや現在のwriter合格ではありません。

## 再現コマンド（既存合成入力のみ・offline）

Windows、Python **3.12.10**、pytest **9.1.1**、PyCryptodome **3.23.0**が観測環境です。別の固定47820 checkoutのルートで実行し、既存の入力を編集しないでください。文書を公開した後のcommitと、試験対象のsource commitは区別します。以下は親のargv／環境指定と照合した再現手順で、本package監査の新しいproduction実走記録ではありません。clean installや他OSの合格も未検証です。

```powershell
$ErrorActionPreference = 'Stop'
$Pin = '47820efb5fd28001556b32fe21d76774dd987c39'
$Repo = (Get-Location).Path
if ((git rev-parse HEAD).Trim() -ne $Pin) { throw 'Wrong source checkpoint' }
git diff --quiet HEAD -- itlkit tests pyproject.toml evidence
if ($LASTEXITCODE -ne 0) { throw 'Tracked inputs or source changed' }
$InputTrees = @{
  'evidence/native/snapshots' = '7fa05ffbf9cfcf7567c61e2add91f2534e13da91'
  'evidence/native/oracles' = '6fea25d670ceb59fba00453a7c7b179cbfbd236a'
  'evidence/20260910/checkpoint-01/native-snapshots' = 'b8b0baf0009389f983569216d998adf1558d8f48'
}
foreach ($Rel in $InputTrees.Keys) {
  $Tree = git rev-parse ($Pin + ':' + $Rel)
  if ($LASTEXITCODE -ne 0 -or $Tree.Trim() -ne $InputTrees[$Rel]) { throw 'Input tree pin mismatch' }
  $Expected = @(git -c core.quotepath=false ls-tree -r --name-only $Pin -- $Rel)
  if ($LASTEXITCODE -ne 0) { throw 'Cannot enumerate pinned inputs' }
  $Items = @(Get-ChildItem -LiteralPath (Join-Path $Repo $Rel) -Force -Recurse)
  if (@($Items | Where-Object { $_.Attributes -band [IO.FileAttributes]::ReparsePoint }).Count) { throw 'Reparse input refused' }
  $Actual = @($Items | Where-Object { -not $_.PSIsContainer } | ForEach-Object { [IO.Path]::GetRelativePath($Repo, $_.FullName).Replace([char]92,[char]47) })
  if (Compare-Object $Expected $Actual) { throw 'Input file set differs' }
}
$Out = Join-Path ([IO.Path]::GetTempPath()) ('itl-offline-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $Out | Out-Null
$env:PYTHONDONTWRITEBYTECODE = '1'
$env:PYTHONUTF8 = '1'
$env:PYTHONIOENCODING = 'utf-8'
$env:PYTHONOPTIMIZE = '0'
$env:ITLKIT_NATIVE_ROOT = Join-Path $Repo 'evidence/native/snapshots'
$env:ITLKIT_NATIVE_REPORTS = Join-Path $Repo 'evidence/native/oracles'
$env:ITLKIT_FRESH_SNAPSHOT_DIR = Join-Path $Repo 'evidence/20260910/checkpoint-01/native-snapshots'
python -B -m pytest tests/test_inspection_cli_v2.py -q -p no:cacheprovider --basetemp "$Out/cli-tmp" --junitxml "$Out/cli.xml"
if ($LASTEXITCODE -ne 0) { throw 'CLI checks failed' }
python -B -m pytest tests -q -rs -p no:cacheprovider --basetemp "$Out/full-tmp" --junitxml "$Out/full.xml"
if ($LASTEXITCODE -ne 0) { throw 'Offline suite failed' }
```

cohortの正確なGit集合は証跡JSONの3つのtree pinで確認できます。上記環境指定を省いたり、追加の未追跡入力を混ぜると、件数は同じ条件ではなくなります。名前に`native`を含むfixtureも、ここでは保存済みファイルのoffline照合に使うだけです。

同じ準備後、既存の閉じた合成snapshotを読む例：

```powershell
$InputFile = Join-Path $env:ITLKIT_FRESH_SNAPSHOT_DIR 'fresh-000-empty.itl'
python -B -m itlkit inspect-coverage "$InputFile" --output "$Out/coverage.json"
if ($LASTEXITCODE -ne 0) { throw 'Coverage diagnostic failed' }
python -B -m itlkit inspect-playlists "$InputFile" --output "$Out/playlists.json"
if ($LASTEXITCODE -ne 0) { throw 'Playlist diagnostic failed' }
```

診断exit 0はJSON生成を意味するだけです。完全decode、意味的妥当性、修復、media import、独立writer受入れを意味しません。出力は新規パス限定です。今回の公開案はこの文書と証跡JSONの2点だけで、原ライブラリ、実行ファイル、個人データ、運用台帳は含みません。
