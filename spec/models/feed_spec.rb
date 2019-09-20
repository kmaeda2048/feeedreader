require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe 'バリデーション' do
    context '入力された値が有効な場合' do
      let!(:valid_feed) { FactoryBot.create(:feed) }
      
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
        let!(:rails_feed) { FactoryBot.create(:feed, :rails) }
        let!(:existing_feed) { FactoryBot.build(:feed, :rails) }
  
        it '登録に失敗する' do
          existing_feed.valid?
          expect(existing_feed.errors.full_messages).to include 'URLはすでに存在します'
        end
      end
    end
  end

  describe '#set_attributes' do
    let!(:name_blank_feed) { FactoryBot.create(:feed, :apple, name: '') }

    describe '#set_name' do
      it 'nameが自動で登録される' do
        expect(name_blank_feed.name).to eq 'Apple Newsroom'
      end
    end

    describe '#set_origin_url' do
      it 'origin_urlが自動で登録される' do
        expect(name_blank_feed.feed_url).to include name_blank_feed.origin_url
      end
    end

    describe '#set_favicon_url' do
      it 'favicon_urlが自動で登録される' do
        expect(name_blank_feed.favicon_url).to eq "https://www.google.com/s2/favicons?domain_url=#{name_blank_feed.origin_url}"
      end
    end
  end

  describe '#create_articles' do
    let!(:vscode_feed) { FactoryBot.create(:feed, :vscode) }

    it '登録したフィードの記事が追加される' do
      expect(Article.last.feed_id).to eq vscode_feed.id
    end
  end

  describe '#fetch_feed' do
    it 'フィードをフェッチして、新規記事があれば追加する' do
      test_feed = Feed.find_by(feed_url: 'http://b.hatena.ne.jp/hotentry/it.rss')
      before_fetch_size = test_feed.article.all.size
      test_feed.fetch_feed
      expect(test_feed.article.all.size).to be > before_fetch_size
    end
  end
end
