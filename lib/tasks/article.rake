namespace :article do
  desc '既読記事や古い記事の削除'
  task :destroy => :environment do
    Rails.application.config.article_destroy_logger.debug('rake----------------------------------------------------------------------------------------')
    Rails.application.config.article_destroy_logger.debug("開始時: #{Article.all.size}件")

    Article.destroy_read_articles
    Rails.application.config.article_destroy_logger.debug("既読記事の削除後: #{Article.all.size}件")

    max = 500
    if Article.all.size > max
      Article.destroy_overflowing_articles(max)
      Rails.application.config.article_destroy_logger.debug("古い記事の削除後: #{Article.all.size}件")
    end
    Rails.application.config.article_destroy_logger.debug('--------------------------------------------------------------------------------------------')
  end
end
