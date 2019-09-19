FactoryBot.define do
  factory :article do
    title { 'Example article' }
    url { 'http://example.com/articles/1' }
    published { '2000-01-01 00:00:00' }
    unread { true }
    starred { false }
    thumbnail_url { 'https://placehold.jp/75x75.png' }
    feed

    trait :read do
      title { 'Read article' }
      url { 'http://example.com/articles/read' }
      published { '2000-01-01 00:00:00' }
      unread { false }
      starred { false }
      thumbnail_url { 'https://placehold.jp/75x75.png' }
      feed
    end

    trait :starred do
      title { 'Starred article' }
      url { 'http://example.com/articles/starred' }
      published { '2000-01-01 00:00:00' }
      unread { true }
      starred { true }
      thumbnail_url { 'https://placehold.jp/75x75.png' }
      feed
    end
  end
end
