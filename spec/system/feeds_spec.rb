require 'rails_helper'

RSpec.describe 'フィード管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user_a.email
    fill_in 'パスワード', with: user_a.password
    click_button 'ログイン'
  end

  after do
    user_a.destroy
  end

  describe 'フィードの一覧表示' do
    let!(:old_feed) { FactoryBot.create(:feed, user: user_a) }
    let!(:new_feed) { FactoryBot.create(:feed, :github, user: user_a) }

    after do
      old_feed.destroy
      new_feed.destroy
    end

    context 'feedsにアクセスしたとき' do
      before do
        visit feeds_path
      end

      it '最後に登録したフィードが一番上に表示される' do
        expect(first('.feed-name').text).to eq new_feed.name
      end
    end
  end

  describe 'フィードの未読記事一覧表示' do
    let!(:feed) { FactoryBot.create(:feed, user: user_a) }
    let!(:read_article) { FactoryBot.create(:article, :read, feed: feed) }

    after do
      feed.destroy
    end
    
    context 'feeds/N/unreadにアクセスしたとき' do
      before do
        visit unread_feed_path(feed)
      end
      
      # it '未読記事のフィード名が含まれる' do
      #   within (card) do
      #     関連
      #     expect(page).to have_selector '.feed-name', text: unread_article.
      #   end
      # end

      # it '未読記事の相対時間表示の公開日が含まれる' do
      #   within (card) do
          # 相対時間に変更
          # expect(page).to have_selector '.pub-col', text: unread_article.published
      #   end
      # end

      it '既読記事が含まれない' do
        expect(page).not_to have_content read_article.title
      end
      
      it '現在ページが表示される' do
        expect(find('#now-page').text).to eq feed.name
      end

      it '表示記事数が表示される' do
        expect(find('#articles-count').text).to eq "(#{feed.articles.where(unread: true).size})"
      end
    end
  end

  describe 'フィードの新規登録' do
    let(:url) { 'https://github.com/kmaeda2048/feeedreader/commits/master.atom' }

    before do
      visit new_feed_path
      fill_in 'feed_feed_url', with: url
      click_button '登録する'
    end

    after do
      Feed.last.destroy
    end

    it '登録される' do
      expect(Feed.last.feed_url).to eq url
    end

    it 'unread_feed_pathにリダイレクトされる' do
      expect(find('.notice').text).to eq "登録完了: #{Feed.last.name}"
    end
  end

  describe 'フィードの編集' do
    let!(:feed) { FactoryBot.create(:feed, user: user_a) }
    let(:new_name) { '新しいフィード名' }

    before do
      visit edit_feed_path(feed)
      fill_in 'feed_name', with: new_name
      click_button '更新する'
    end

    after do
      feed.destroy
    end

    it '編集される' do
      expect(Feed.last.name).to eq new_name
    end

    it 'unread_feed_pathにリダイレクトされる' do
      expect(find('.notice').text).to eq "更新完了: #{new_name}"
    end
  end

  describe 'フィードの削除' do
    let!(:feed) { FactoryBot.create(:feed, user: user_a) }

    before do
      visit feeds_path
      Capybara.page.driver.browser.manage.window.resize_to(1920, 1080)
      find('#delete').click
      page.driver.browser.switch_to.alert.accept
    end

    it '削除される' do
      expect(Article.where(id: feed.id)).not_to exist
    end
  end
end
