namespace :fetch_feed do
  desc "Feedの1つ目を参照"
  task :test => :environment do
    puts Feed.first().to_json
  end

  desc "フィードをフェッチ"
  task :fetch => :environment do
    feeds = Feed.all
    feeds.each do |feed|
      xml = HTTParty.get(feed.url).body
      entry = Feedjira.parse(xml).entries
      
      entry.each do |e|
        article = Article.new(title: e.title, url: e.url, published: e.published, content: e.content, feed_id: feed.id)

        if article.save
        else
        end
      end
    end
  end

end
