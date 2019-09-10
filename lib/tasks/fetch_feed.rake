namespace :fetch_feed do
  desc 'フィードをフェッチ'
  task :fetch => :environment do
    feeds = Feed.all
    feeds.each do |feed|
      response = HTTParty.get(feed.feed_url)
      articles = Feedjira.parse(response.body).entries

      articles.each do |article|
        # first_or_initializeは同じ記事がなければ作成、あれば呼び出しという処理をする
        local_article = feed.article.where(title: article.title).first_or_initialize

        image = article.image ? article.image : ''
        if image == ''
          response = HTTParty.get(article.url)
          image = Nokogiri::HTML.parse(response.body, nil, 'utf-8').css('//meta[property="og:image"]/@content').to_s
        end
        
        local_article.update_attributes(url: article.url, published: article.published, feed_id: feed.id, favicon_url: image)
      end      
    end
  end
end
