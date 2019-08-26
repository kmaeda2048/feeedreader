class Feed < ApplicationRecord
  has_many :article
  
  after_create :create_articles, on: :create

  validates :feed_url, presence: true, uniqueness: true
  validates :title, presence: true

  private

  def create_articles
    xml = HTTParty.get(self.feed_url).body
    entry = Feedjira.parse(xml).entries

    entry.each do |e|
      article = Article.new(title: e.title, url: e.url, published: e.published, content: e.content, feed_id: self.id)

      if article.save
      else
      end
    end
  end

end
