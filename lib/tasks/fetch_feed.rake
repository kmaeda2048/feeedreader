namespace :fetch_feed do
  desc 'フィードをフェッチ'
  task :fetch => :environment do
    feeds = Feed.all
    feeds.each do |feed|
      xml = HTTParty.get(feed.feed_url).body
      articles = Feedjira.parse(xml).entries

      articles.each do |article|
        # first_or_initializeは同じ記事がなければ作成、あれば呼び出しという処理をする
        local_article = feed.article.where(title: article.title).first_or_initialize

        if article.image
          image = article.image
        elsif article.content
          images = Nokogiri::HTML.parse(article.content, nil, 'utf-8').css('img')
          image = images.empty? ? '' : images.first.attribute('src').value
        else
          image = ''
        end  
        
        local_article.update_attributes(url: article.url, published: article.published, content: article.content, feed_id: feed.id, thumbnail_url: image)
      end      
    end
  end
end
