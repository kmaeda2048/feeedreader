require 'rails_helper'

RSpec.describe Feed, type: :model do
  context '入力された値が有効な場合' do
    let!(:valid_feed) { FactoryBot.create(:feed) }
    
    it 'バリデーションにかからない' do
      expect(valid_feed).to be_valid
    end
    
    context 'nameが未入力の場合' do
      let!(:name_blank_feed) { FactoryBot.create(:feed, :apple, name: '') }

      it '自動で登録される' do
        expect(name_blank_feed.name).to eq 'Apple Newsroom'
      end
    end

    it 'urlが自動で登録される' do
      expect(valid_feed.feed_url).to include valid_feed.url
    end

    it 'favicon_urlが自動で登録される' do
      expect(valid_feed.favicon_url).to eq "https://www.google.com/s2/favicons?domain_url=#{valid_feed.url}"
    end
  end

  context '入力された値が有効でない場合' do
    let!(:not_valid_feed) { FactoryBot.build(:feed) }

    context 'feed_urlが未入力の場合' do
      it '登録に失敗する' do
        not_valid_feed.feed_url = ''
        not_valid_feed.valid?
        expect(not_valid_feed.errors.full_messages).to include 'URLを入力してください'
      end
    end
    
    context 'feed_urlがURLでない場合' do
      it '登録に失敗する' do
        not_valid_feed.feed_url = 'not url'
        not_valid_feed.valid?
        expect(not_valid_feed.errors.full_messages).to include 'URLにアクセスできません'
      end
    end
  
    context 'フィードをパースできない場合' do
      it '登録に失敗する' do
        not_valid_feed.feed_url = 'http://example.com'
        not_valid_feed.valid?
        expect(not_valid_feed.errors.full_messages).to include 'URLをパースできません。入力されたURLがフィードではない可能性があります。'
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
