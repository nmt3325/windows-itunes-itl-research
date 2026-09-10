# G2 検証済み範囲と未対応項目

2026-09-10 16:33 JSTの固定コード `0a7dcda20b8222bf5b23184ef3752d29a6f75d66` に対する記録です。**完全な意味的読み書きには未対応です。** この後の変更や実機試験の結果を先取りしません。

## 今回統合・検証したもの

- ITL入力と外部media resourceの分離、固定bytes・factsの照合、apply時の再probeと変更検出。
- 不正なin-memory Node.kindの制御された拒否。元の8反例を含む新しい検査を追加しました。旧434件のfuzzを「全件成功」に書き換えたものではありません。
- プレイリスト診断の展開前メモリ制限。10,372 Bの予算で530,377 Bまで展開していた反例は、上限1,023 Bと検出用1 Bで拒否されます。
- 現在のモデルを変更せず、主マスター一覧が全曲を過不足なく一度ずつ含むかを検査する `require_complete_master`。**これはopt-inの必要条件検査であり、旧APIへ自動適用したり書き込みを認可したりしません。**

## 親側の統合後検証

通常テスト **2,024件 = 2,018 passed + 6 skipped**、failure/error 0。**36 subtestsは別計数**です。直前の1,800ケースはすべて保持しています。

固定された116入力のSHA・サイズ・mtimeを保持。既存coreのSHA `f70f5f51b534d08c6dd55c721e10732a0df5a49df88bf5442fbab1c0583899ba` は不変です。これらはG2試験区間の保全であり、Git checkoutが原実験のmtimeやLocationを再現したという意味ではありません。

## 未完了・未認定

- shared schema全体の展開前・読取前予算とJSON keyの早期制限は、この固定点にはまだ修正が入っていません。
- 新曲constructorのmedia facade接続、実予約、Name/Kind等のpool登録、未知参照とsystem roleの整合性は未閉鎖です。media resourceのno-op成功は新曲ITLの完成ではありません。
- legacy APIのmasterless mutationはまだ可能です。新helperの存在を全書込入口の安全化と解釈しないでください。
- smart/opaque/補助レコード、foreign-history mutationなどの完全な意味論は未対応・未認定です。
- 実機検証ハーネスの未知header保全漏れを修正中です。G2の独立writer候補のnative受入れとplaybackは未確認です。
- 欠落した旧版テストの原文を、新しく作ったテストで回収済みとは扱いません。

保存済みnative fixtureの読取検査と、新しいiTunes実行は別です。ここで報告した統合試験のnative操作は0です。メモリ制限は保守的な計算上の制限であり、OS全体のRSS保証ではありません。

[機械可読の記録](../evidence/20260910/g2-hardening-status.json) / [旧47820固定点の監査案](continuation-g2-checkpoint.md)

旧監査案は当時の内容をバイト同一で保存した履歴です。そこで未修正とされたNode.kind等については、この新しい固定点の記録と区別してください。
