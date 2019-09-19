require 'rails_helper'

RSpec.describe Feed, type: :model do
  context '入力された値が有効な場合' do
    let!(:feed) { FactoryBot.create(:feed, url: '', favicon_url: '') }

    it '登録に成功する' do
      expect(feed).to be_valid
    end

    it 'urlが自動で登録される' do
      expect(feed.feed_url).to include feed.url
    end

    it 'favicon_urlが自動で登録される' do
      expect(feed.favicon_url).to eq "https://www.google.com/s2/favicons?domain_url=#{feed.url}"
    end

    context 'nameが未入力の場合' do
      let!(:name_blank_feed) { FactoryBot.create(:feed, :github, name: '', url: '', favicon_url: '') }

      it '自動で登録される' do
        expect(name_blank_feed.name).to eq 'The GitHub Blog'
      end
    end
  end

  context '入力された値が有効でない場合' do
    let!(:feed) { FactoryBot.create(:feed, url: '', favicon_url: '') }

    context 'feed_urlが未入力の場合' do
      it '登録に失敗する' do
        feed.feed_url = ''
        feed.valid?
        expect(feed.errors.full_messages).to include 'URLを入力してください'
      end
    end
    
    context 'feed_urlがURLでない場合' do
      it '登録に失敗する' do
        feed.feed_url = 'not url'
        feed.valid?
        expect(feed.errors.full_messages).to include 'URLにアクセスできません'
      end
    end
  
    context 'フィードをパースできない場合' do
      it '登録に失敗する' do
        feed.feed_url = 'http://example.com'
        feed.valid?
        expect(feed.errors.full_messages).to include 'URLをパースできません。入力されたURLがフィードではない可能性があります。'
      end
    end
    
    # context '既に存在するフィードの場合' do
    #   let!(:existing_feed) { FactoryBot.build(:feed, url: '', favicon_url: '') }

    #   it '登録に失敗する' do
    #     existing_feed.valid?
    #     expect(existing_feed.errors.full_messages).to include 'はすでに存在します'
    #   end
    # end
  end
end
