require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe 'バリデーション' do
    context '入力された値が有効な場合' do
      let(:user_a) { FactoryBot.create(:user) }
      let!(:valid_feed) { FactoryBot.create(:feed, user: user_a) }

      after do
        user_a.destroy
      end
      
      it 'バリデーションにかからない' do
        expect(valid_feed).to be_valid
      end
    end
  
    context '入力された値が有効でない場合' do
      let(:user_a) { FactoryBot.create(:user) }
      let!(:invalid_feed) { FactoryBot.build(:feed, user: user_a) }

      after do
        user_a.destroy
      end
  
      context 'feed_urlが未入力の場合' do
        it '登録に失敗する' do
          invalid_feed.feed_url = ''
          invalid_feed.valid?
          expect(invalid_feed.errors.full_messages).to include 'URLを入力してください'
        end
      end
      
      context 'feed_urlがURLでない場合' do
        it '登録に失敗する' do
          invalid_feed.feed_url = 'not url'
          invalid_feed.valid?
          expect(invalid_feed.errors.full_messages).to include 'URLにアクセスできません'
        end
      end
    
      context 'フィードをパースできない場合' do
        it '登録に失敗する' do
          invalid_feed.feed_url = 'http://example.com'
          invalid_feed.valid?
          expect(invalid_feed.errors.full_messages).to include 'URLをパースできません。入力されたURLがフィードではない可能性があります。'
        end
      end
      
      context '既に存在するフィードの場合' do
        let!(:valid_feed) { FactoryBot.create(:feed, user: user_a) }
        let!(:invalid_feed) { FactoryBot.build(:feed, user: user_a) }
  
        it '登録に失敗する' do
          invalid_feed.valid?
          expect(invalid_feed.errors.full_messages).to include 'URLはすでに存在します'
        end
      end
    end
  end

  describe '#set_attributes' do
    let(:user_a) { FactoryBot.create(:user) }
    let!(:feed) { FactoryBot.create(:feed, name: '', user: user_a) }

    after do
      user_a.destroy
    end

    describe '#set_name' do
      it 'nameが自動で登録される' do
        expect(feed.name).to eq 'Recent Commits to feeedreader:master'
      end
    end

    describe '#set_origin_url' do
      it 'origin_urlが自動で登録される' do
        expect(feed.feed_url).to include feed.origin_url
      end
    end

    describe '#set_favicon_url' do
      it 'favicon_urlが自動で登録される' do
        expect(feed.favicon_url).to eq "https://www.google.com/s2/favicons?domain_url=#{feed.origin_url}"
      end
    end
  end

  describe '#create_articles' do
    let(:user_a) { FactoryBot.create(:user) }
    let!(:feed) { FactoryBot.create(:feed, user: user_a) }

    after do
      user_a.destroy
    end

    it '登録したフィードの記事が追加される' do
      expect(Article.last.feed_id).to eq feed.id
    end
  end
  
  describe '#fetch' do
    let(:user_a) { FactoryBot.create(:user) }
    let!(:feed) { FactoryBot.create(:feed, user: user_a) }
    let(:article) { feed.articles.last }

    before do
      article.destroy
      feed.last_modified -= 1
    end

    after do
      user_a.destroy
    end

    it '削除した記事が再度追加される' do
      feed.fetch
      expect(Article.where(title: article.title)).to exist
    end
  end
end
