require 'rails_helper'

RSpec.describe 'フィード管理機能', type: :system do
  describe 'フィードの一覧表示' do
    let!(:feed) { FactoryBot.create(:feed) }

    after do
      feed.destroy
    end

    context 'feedsにアクセスしたとき' do
      before do
        visit feeds_path
      end

      it 'フィード名が表示される' do
        expect(page).to have_content feed.name
      end
    end
  end

  describe 'フィードの未読記事一覧表示' do
    let!(:feed) { FactoryBot.create(:feed) }
    let!(:unread_article) { FactoryBot.create(:article, feed: feed) }
    let!(:read_article) { FactoryBot.create(:article, :read, feed: feed) }

    after do
      feed.destroy
    end
    
    context 'feeds/N/unreadにアクセスしたとき' do
      before do
        visit unread_feed_path(feed)
      end

      let(:card) { find(".mycard[data-article-id='#{unread_article.id}'") }
      
      it 'atomフィードの未読記事のタイトルが含まれる' do
        within (card) do
          expect(page).to have_selector '.card-link', text: unread_article.title
        end
      end

      it 'atomフィードの未読記事のリンクが含まれる' do
        within (card) do
          expect(page).to have_selector ".card-link[href='#{unread_article.url}']"
        end
      end

      # it 'atomフィードの未読記事のフィード名が含まれる' do
      #   within (card) do
      #     関連
      #     expect(page).to have_selector '.feed-name', text: unread_article.
      #   end
      # end

      # it 'atomフィードの未読記事の相対時間表示の公開日が含まれる' do
      #   within (card) do
          # 相対時間に変更
          # expect(page).to have_selector '.pub-col', text: unread_article.published
      #   end
      # end

      it 'atomフィードの既読記事が含まれない' do
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
