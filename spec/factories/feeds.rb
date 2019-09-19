FactoryBot.define do
  factory :feed do
    feed_url { 'https://github.com/kmaeda2048/feeedreader/commits/master.atom' }
    name { 'Recent Commits to feeedreader:master' }

    trait :github do
      feed_url { 'https://github.blog/feed/' }
      name { 'The GitHub Blog' }
    end
    
    trait :vscode do
      feed_url { 'https://code.visualstudio.com/feed.xml' }
      name { 'Visual Studio Code - Code Editing. Redefined.' }
    end
    
    trait :rails do
      feed_url { 'https://weblog.rubyonrails.org/feed/atom.xml' }
      name { 'Riding Rails' }
    end
  end
end
