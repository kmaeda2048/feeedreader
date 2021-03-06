# FeeedReader

ニュースサイトやブログなどが配信する、RSSやAtomなどのフィードを購読するアプリです。

URL: https://feeedreader.herokuapp.com/

![GIF](https://user-images.githubusercontent.com/48312376/66178668-1e100400-e6a1-11e9-9332-39117ebbb61c.gif)

## 機能一覧

* フィードの登録・未読記事一覧表示・編集・削除
* 登録したフィードの一覧表示
* 全フィードの未読記事の一覧表示
* 記事サムネイルの遅延ロード
* 記事が画面の上に消えた時に記事を既読
* 記事にスターをつける・外す
* スター付き記事の一覧表示
* フィードの検索
* 記事の検索
* フィードのソート
* ショートカットキー
* 定期処理による記事フェッチ

## 使用技術

* 言語: Ruby 2.6.2
* フレームワーク: Rails 5.2.3
* テスト: RSpec
* 本番環境: Heroku
* データベース: PostgreSQL
* HTTPクライアント: HTTParty
* フィードパーサー: Feedjira
* OGPスクレイピング: Nokogiri
* 検索: Ransack
* テンプレートエンジン: Slim
* CSSプリプロセッサ: Sass(SCSS)
* CSSフレームワーク: bootstrap
* アイコン: Font Awesome
* JavaScript
  * ES6
  * Fetch API
  * Intersection Observer API

## ショートカットキー

| ショートカットキー | 説明                     |
| ------------------ | ------------------------ |
| `j`                | 次のカードへ             |
| `k`                | 前のカードへ             |
| `o`                | 記事を開く               |
| `s`                | スターのトグル           |
| `/`                | 検索フォームにフォーカス |
| `g` → `a`          | 未読記事一覧へ           |
| `g` → `s`          | スター付き記事一覧へ     |
| `g` → `n`          | 新規フィード登録へ       |
| `g` → `c`          | フィード一覧へ           |
| `g` → `h`          | ショートカットキー一覧へ |
