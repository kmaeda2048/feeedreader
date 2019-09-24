require 'rails_helper'

RSpec.describe 'フィード管理機能', type: :system do
  describe 'フィードの一覧表示' do
    let!(:old_feed) { FactoryBot.create(:feed) }
    let!(:new_feed) { FactoryBot.create(:feed, :github) }

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
    let!(:feed) { FactoryBot.create(:feed) }
    let!(:old_unread_article) { FactoryBot.create(:article, :old_unread, feed: feed) }
    let!(:new_unread_article) { FactoryBot.create(:article, :new_unread, feed: feed) }
    let!(:read_article) { FactoryBot.create(:article, :read, feed: feed) }

    after do
      feed.destroy
    end
    
    context 'feeds/N/unreadにアクセスしたとき' do
      before do
        visit unread_feed_path(feed)
      end

      it '公開日が最も古い未読記事が、一番上に表示される' do
        expect(first('.card-link').text).to eq old_unread_article.title
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
    end
  end

  describe 'フィードの新規登録' do
  end

  describe 'フィードの編集' do
  end

  describe 'フィードの削除' do
  end
end
