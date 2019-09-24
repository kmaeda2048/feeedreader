require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '.destroy_read_articles' do
    let!(:feed) { FactoryBot.create(:feed) }
    let!(:unread_article) { FactoryBot.create(:article, feed: feed) }
    let!(:read_article) { FactoryBot.create(:article, :read, feed: feed) }
    let!(:starred_article) { FactoryBot.create(:article, :starred, feed: feed) }

    after do
      feed.destroy
    end

    it '既読かつスター付きでない記事のみ削除される' do
      Article.destroy_read_articles
      expect(Article.where(id: unread_article.id)).to exist
      expect(Article.where(id: read_article.id)).not_to exist
      expect(Article.where(id: starred_article.id)).to exist
    end
  end

  describe '.destroy_overflowing_articles' do
    let!(:feed) { FactoryBot.create(:feed) }
    let(:create_size) { 10 }
    let(:max) { 5 }

    before do
      create_size.times { FactoryBot.create(:article, feed: feed) }
    end

    after do
      feed.destroy
    end

    it '記事数がmaxになるように削除される' do
      Article.destroy_overflowing_articles(max)
      expect(Article.all.size).to eq max
    end
  end
end
