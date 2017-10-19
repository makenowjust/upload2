# upload2

Railsで作ったファイルアップローダ

## 仕様

<http://rosylilly.hatenablog.com/entry/2013/10/21/190019>

DBにファイルの内容ごと保存する仕様。

ファイル毎のURLはファイルのIDにHashidsをかけたものにして、多少はプライベートモードが意味を成すようにした。

## Railsの設定

- テンプレートはHaml
- テストはMinitest
- JavaScriptのビルドはWebpacker
  * CSSを書きたくなかったのでMaterialize-CSSを使った
- Turbolinks、Sprocketsその他使わなそうなものは無効

## DBの設計

### `file_infos`

ファイルの情報を持つテーブル。以下のカラムを持つ。

- `name`: ファイル名
- `content_size`: ファイルの大きさ
- `private`: プライベートモードかどうか
- `expiration`: 有効期限。`NULL`の場合は無期限を表す。
- `password_digest`: 削除用のパスワードのハッシュ値

加えて、`id`, `created_at`, `updated_at`も持つ。

`created_at, private, expiration`の複合インデックスが貼られていて、これはファイルの一覧を取得するためのクエリに利用される。

### `file_contents`

ファイルの内容を持つテーブル。以下のカラムを持つ。

- `file_info_id`: 対応する`file_info`の`id`
- `content`: ファイルの内容

加えて、`id`, `created_at`, `updated_at`も持つ。

`file_infos`と`file_contents`を分けたのにそこまで深い意図があるわけではないのだけど、理由としては、

  - 将来的にファイルの中身をS3などに保存することになったときに拡張しやすそう。
  - `select`を書かなくてもパフォーマンス的に問題にならなそう。

くらいのゆるっとした感覚がある。

## テスト

少なくとも手元で動かしたときにカバレッジが100%になる程度には書いた。ただRailsのfixturesの使い方があれでいいのかよく分かっていない。Railsは何も分からない。

System Testも書いたので`bin/rails test:system`とするとブラウザが立ち上がって、ファイルをアップロード→削除までの一連の流れをテストできる。

## 思うところ

`upload2`という名前が表す通り、これはファイルアップローダの仕様を一通り実装し終えたあとに、もう一度作り直したもの。とりあえず満足のいくものになったような気がする。

Webpackerは思ったよりも使いやすかった。Sprocketsでやってるならそれでいいと思うけど、新しくやるなら悪くない選択肢だと思う。大して使ってないから分からないけど。

アップロードのWeb画面で日付しか設定できないのは完全に手抜きで、Materialize-CSSが日付と時刻を一度に設定するダイアログに対応していなかったからというだけの理由。直した方がいいのだけど面倒なのでやっていない。

CIとかは気が向いたら設定する。
