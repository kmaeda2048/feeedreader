# FeeedReader

ニュースサイトやブログなどが配信する、RSSやAtomなどのフィードを購読するアプリです。

URL: https://feeedreader.herokuapp.com/

<!-- テストユーザー:  -->
<!-- 実際のアプリの画像 -->
<!-- 使い方のGIF -->

## 機能一覧

* フィードの登録・編集・削除
* フィードの一覧表示
* フィードの未読記事一覧表示
* 全フィードの未読記事の一覧表示
* 記事のサムネイルの表示
* 記事にスターをつける・外す
* スター付き記事一覧表示
* フィード検索
* 記事検索
* ショートカットキー
* レスポンシブ
<!-- * ログイン
* 遅延ロード
* 記事フェッチ -->

## 使用技術

* 言語: Ruby 2.6.2
* フレームワーク: Rails 5.2.3
* テスト: RSpec
* 本番環境: Heroku
* データベース: PostgreSQL
<!-- * ユーザー管理: Devise -->
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
  * DOM API
  * EventTarget
  * Fetch API
  * Intersection Observer API

## ショートカットキー

| Command | Description              |
| ------- | ------------------------ |
| j       | 次のカードへ             |
| k       | 前のカードへ             |
| o       | 現在のタブで記事を開く   |
| t       | 新しいタブで記事を開く   |
| s       | スターのトグル           |
| /       | 検索フォームにフォーカス |
| g → a   | 未読記事一覧へ           |
| g → s   | スター付き記事一覧へ     |
| g → n   | 新規フィード登録へ       |
| g → c   | フィード一覧へ           |
| g → h   | ショートカットキー一覧へ |

<!-- ## 動作環境
chrome, firefox, ieとか(pc, スマホ) -->
