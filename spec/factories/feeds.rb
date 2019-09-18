FactoryBot.define do
  factory :feed do
    feed_url { 'https://github.com/kmaeda2048/feeedreader/commits/master.atom' }
    name { 'Recent Commits to feeedreader:master' }
    url { 'https://github.com/kmaeda2048/feeedreader/commits/master' }
    favicon_url { 'https://www.google.com/s2/favicons?domain_url=https://github.com/kmaeda2048/feeedreader/commits/master' }

    trait :github do
      feed_url { 'https://github.blog/feed/' }
      name { 'The GitHub Blog' }
      url { 'https://github.blog' }
      favicon_url { 'https://www.google.com/s2/favicons?domain_url=https://github.blog' }
    end
    
    trait :vscode do
      feed_url { 'https://code.visualstudio.com/feed.xml' }
      name { 'Visual Studio Code - Code Editing. Redefined.' }
      url { 'https://code.visualstudio.com/' }
      favicon_url { 'https://www.google.com/s2/favicons?domain_url=https://code.visualstudio.com/' }
    end
    
    trait :rails do
      feed_url { 'https://weblog.rubyonrails.org/feed/atom.xml' }
      name { 'Riding Rails' }
      url { 'https://weblog.rubyonrails.org/' }
      favicon_url { 'https://www.google.com/s2/favicons?domain_url=https://weblog.rubyonrails.org/' }
    end
  end
end
