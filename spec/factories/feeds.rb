FactoryBot.define do
  factory :feed do
    feed_url { 'https://github.com/kmaeda2048/feeedreader/commits/master.atom' }
    name { 'Recent Commits to feeedreader:master	' }
    url { 'https://github.com/kmaeda2048/feeedreader/commits/master' }
    favicon_url { 'https://www.google.com/s2/favicons?domain_url=https://github.com/kmaeda2048/feeedreader/commits/master' }
  end
end
