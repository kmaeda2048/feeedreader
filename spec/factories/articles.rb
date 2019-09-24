FactoryBot.define do
  factory :article do
    title { 'Example article' }
    url { 'http://example.com/articles/1' }
    published { '2000-01-01 00:00:00' }
    unread { true }
    starred { false }
    thumbnail_url { 'https://placehold.jp/75x75.png' }
    feed

    trait :old_unread do
      title { 'Old article' }
      url { 'http://example.com/articles/old' }
      published { '2000-01-01 00:00:00' }
      unread { true }
      starred { false }
      thumbnail_url { 'https://placehold.jp/75x75.png' }
      feed
    end

    trait :new_unread do
      title { 'New article' }
      url { 'http://example.com/articles/new' }
      published { '2001-01-01 00:00:00' }
      unread { true }
      starred { false }
      thumbnail_url { 'https://placehold.jp/75x75.png' }
      feed
    end

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

    trait :old_starred do
      title { 'Starred article' }
      url { 'http://example.com/articles/starred' }
      published { '2000-01-01 00:00:00' }
      unread { true }
      starred { true }
      thumbnail_url { 'https://placehold.jp/75x75.png' }
      starred_at { '2000-01-01 00:00:00' }
      feed
    end

    trait :new_starred do
      title { 'Starred article' }
      url { 'http://example.com/articles/starred' }
      published { '2000-01-01 00:00:00' }
      unread { true }
      starred { true }
      thumbnail_url { 'https://placehold.jp/75x75.png' }
      starred_at { '2001-01-01 00:00:00' }
      feed
    end
  end
end
