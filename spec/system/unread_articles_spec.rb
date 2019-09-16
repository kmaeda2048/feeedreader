require 'rails_helper'

describe '未読記事一覧', type: :system do
  describe '一覧表示機能' do
    before do
      feed_a = FactoryBot.create(:feed, feed_url: 'https://github.blog/feed/', name: 'The GitHub Blog', url: 'https://github.blog', favicon_url: 'https://www.google.com/s2/favicons?domain_url=https://github.blog')
      FactoryBot.create(:article, title: 'GitHub Pages builds now use the Checks API', url: 'https://github.blog/2019-09-13-github-pages-builds-now-use-the-checks-api/', published: '2019-09-13 16:25:41', unread: true, starred: false, thumbnail_url: 'https://github.blog/wp-content/uploads/2019/03/editor-tools-social-1.png?fit=1201%2C630', feed: feed_a)
    end

    context 'articles/unreadにアクセスしたとき' do
      before do
        visit unread_articles_path
      end

      it 'フィードAの記事が表示される' do
        expect(page).to have_content 'GitHub Pages builds now use the Checks API'
      end
    end
  end
end
