require 'rails_helper'

RSpec.describe '記事表示機能', type: :system do
  describe '未読記事一覧表示' do
    let!(:atom_feed) { FactoryBot.create(:feed) }
    let!(:unread_article) { FactoryBot.create(:article, title: 'Unread article', url: 'http://example.com/unread', unread: true, feed: atom_feed) }
    let!(:read_article) { FactoryBot.create(:article, title: 'Read article', url: 'http://example.com/read', unread: false, feed: atom_feed) }
    
    context 'articles/unreadにアクセスしたとき' do
      before do
        visit unread_articles_path
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

  describe 'スター付き記事一覧表示' do
    let!(:atom_feed) { FactoryBot.create(:feed) }
    let!(:starred_article) { FactoryBot.create(:article, title: 'Starred article', url: 'http://example.com/starred', starred: true, feed: atom_feed) }
    let!(:unstarred_article) { FactoryBot.create(:article, title: 'Unstarred article', url: 'http://example.com/unstarred', starred: false, feed: atom_feed) }
    
    context 'articles/starredにアクセスしたとき' do
      before do
        visit starred_articles_path
      end

      let(:card) { find(".mycard[data-article-id='#{starred_article.id}'") }

      it 'atomフィードのスター付き記事のタイトルが含まれる' do
        within (card) do
          expect(page).to have_selector '.card-link', text: starred_article.title
        end
      end

      it 'atomフィードのスター付き記事のリンクが含まれる' do
        within (card) do
          expect(page).to have_selector ".card-link[href='#{starred_article.url}']"
        end
      end

      # it 'atomフィードのスター付き記事のフィード名が含まれる' do
      #   within (card) do
      #     関連
      #     expect(page).to have_selector '.feed-name', text: starred_article.
      #   end
      # end

      # it 'atomフィードのスター付き記事の相対時間表示の公開日が含まれる' do
      #   within (card) do
          # 相対時間に変更
          # expect(page).to have_selector '.pub-col', text: starred_article.published
      #   end
      # end

      it 'atomフィードのスター付きでない記事が含まれない' do
        expect(page).not_to have_content unstarred_article.title
      end
    end
  end
end
