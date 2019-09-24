require 'rails_helper'

RSpec.describe '記事表示機能', type: :system do
  let!(:feed) { FactoryBot.create(:feed) }

  after do
    feed.destroy
  end

  describe '未読記事一覧表示' do
    let!(:old_unread_article) { FactoryBot.create(:article, :old_unread, feed: feed) }
    let!(:new_unread_article) { FactoryBot.create(:article, :new_unread, feed: feed) }
    let!(:read_article) { FactoryBot.create(:article, :read, feed: feed) }
    
    context 'articles/unreadにアクセスしたとき' do
      before do
        visit unread_articles_path
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

  describe 'スター付き記事一覧表示' do
    let!(:old_starred_article) { FactoryBot.create(:article, :old_starred, feed: feed) }
    let!(:new_starred_article) { FactoryBot.create(:article, :new_starred, feed: feed) }
    let!(:unstarred_article) { FactoryBot.create(:article, feed: feed) }
    
    context 'articles/starredにアクセスしたとき' do
      before do
        visit starred_articles_path
      end

      it 'スターをつけた日時が最も古いスター付き記事が、一番上に表示される' do
        expect(first('.card-link').text).to eq old_starred_article.title
      end

      # it 'スター付き記事のフィード名が含まれる' do
      #   within (card) do
      #     関連
      #     expect(page).to have_selector '.feed-name', text: starred_article.
      #   end
      # end

      # it 'スター付き記事の相対時間表示の公開日が含まれる' do
      #   within (card) do
          # 相対時間に変更
          # expect(page).to have_selector '.pub-col', text: starred_article.published
      #   end
      # end

      it 'スター付きでない記事が含まれない' do
        expect(page).not_to have_content unstarred_article.title
      end
    end
  end
end
