class Feed < ApplicationRecord
  has_many :article
  
  before_create :set_url_and_thumbnail_url, on: :create
  after_create :create_articles, on: :create

  validates :feed_url, presence: true, uniqueness: true
  validates :title, presence: true

  private

  def set_url_and_thumbnail_url
    xml = HTTParty.get(self.feed_url).body
    self.url = Feedjira.parse(xml).url
    self.thumbnail_url = "https://www.google.com/s2/favicons?domain_url=" + self.url
  end

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
