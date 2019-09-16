FactoryBot.define do
  factory :article do
    title { '記事のタイトル' }
    url { 'https://github.com/kmaeda2048/feeedreader/commit/45cf4764560dbc1d4a97d3a530d209f2c040731b' }
    published { '2019-09-14 11:51:32' }
    unread { true }
    starred { false }
    thumbnail_url { 'https://avatars1.githubusercontent.com/u/48312376?s=30&v=4' }
    feed
  end
end
