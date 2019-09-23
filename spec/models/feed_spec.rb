require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe 'バリデーション' do
    context '入力された値が有効な場合' do
      let!(:valid_feed) { FactoryBot.create(:feed) }

      after do
        valid_feed.destroy
      end
      
      it 'バリデーションにかからない' do
        expect(valid_feed).to be_valid
      end      
    end
  
    context '入力された値が有効でない場合' do
      let!(:invalid_feed) { FactoryBot.build(:feed) }
  
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
        let!(:valid_feed) { FactoryBot.create(:feed) }
        let!(:invalid_feed) { FactoryBot.build(:feed) }

        after do
          valid_feed.destroy
        end
  
        it '登録に失敗する' do
          invalid_feed.valid?
          expect(invalid_feed.errors.full_messages).to include 'URLはすでに存在します'
        end
      end
    end
  end

  describe '#set_attributes' do
    let!(:feed) { FactoryBot.create(:feed, name: '') }

    after do
      feed.destroy
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
    let!(:feed) { FactoryBot.create(:feed) }

    after do
      feed.destroy
    end

    it '登録したフィードの記事が追加される' do
      expect(Article.last.feed_id).to eq feed.id
    end
  end
  
  describe '#fetch' do
    let!(:feed) { FactoryBot.create(:feed) }

    after do
      feed.destroy
    end

    it 'フィードをフェッチして、フィードが更新されていれば、記事を追加・更新する' do # 現状はFeedモデルをつくった直後にFeed#fetchしているので、フィードはおそらく更新されていない
      feed.last_modified -= 1
      feed.article.last.destroy
      before_fetch_size = feed.article.all.size
      feed.fetch
      expect(feed.article.all.size).to be > before_fetch_size
      # last_modifiedの更新のテスト
    end
  end
end
