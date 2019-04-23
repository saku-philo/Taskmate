# README

## データベース

* ユーザーテーブル
  * ユーザー名
  * メールアドレス
  * パスワード

* タスクテーブル
  * タスク名
  * 説明分
  * 終了期限
  * ステータス
  * ユーザーID（外部キー）

* ラベルテーブル
  * ラベル種類
  * ユーザーID（外部キー）
  * タスクID（外部キー）

[ER図](https://drive.google.com/file/d/1pslaLK7L_QetCtlR8v3zaZg8NuNzlH46/view?usp=sharing)

...

### herokuデプロイ手順
* herokuにログインする
`$ heroku login`

* herokuにてアプリ作成
`$ heroku create app名`

* git add, git commitしてからpushしてデプロイする
`$ git push heroku master`

* heroku上でDBの作成、マイグレーションを実行
`$ heroku run rails db:create`
`$ heroku run rails db:migrate`

...