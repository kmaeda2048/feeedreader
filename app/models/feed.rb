class Feed < ApplicationRecord
  after_save :create_articles, on: :create

  validates :url, presence: true
  validates :title, presence: true

  private

  def create_articles
    xml = HTTParty.get(self.url).body
    entry = Feedjira.parse(xml).entries

    entry.each do |e|
      article = Article.new(title: e.title, url: e.url, published: e.published, content: e.content, feed_id: self.id)

      if article.save
      else
      end
    end
  end

end
