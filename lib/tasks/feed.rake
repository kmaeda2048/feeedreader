namespace :feed do
  desc '全フィードをフェッチ'
  task :fetch => :environment do
    Feed.fetch_all_feed
  end
end