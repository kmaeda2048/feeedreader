namespace :feed do
  desc '全フィードをフェッチ'
  task :fetch => :environment do
    Rails.application.config.feed_fetch_logger.debug('rake----------------------------------------------------------------------------------------')
    Feed.fetch_all
    Rails.application.config.feed_fetch_logger.debug('--------------------------------------------------------------------------------------------')
  end
end
