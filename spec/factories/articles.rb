FactoryBot.define do
  factory :article do
    title { 'Example article' }
    url { 'http://example.com/articles/1' }
    published { '2000-01-01 00:00:00' }
    unread { true }
    starred { false }
    thumbnail_url { 'https://placehold.jp/75x75.png' }
    feed


    # trait :github do
    #   feed_url { 'https://github.blog/feed/' }
    #   name { 'The GitHub Blog' }
    # end

  end
end
