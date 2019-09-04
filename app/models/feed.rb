class Feed < ApplicationRecord
  has_many :article
  
  validates :feed_url, presence: true, uniqueness: true
  validates :title, presence: true, length: { maximum: 20 }
  validate :validate_feed_url

  before_create :set_url_and_thumbnail_url, on: :create
  after_create :create_articles, on: :create

  private

  def validate_feed_url
    errors.add(:feed_url, :not_a_feed) if HTTParty.get(self.feed_url).body.empty?
  end

  def set_url_and_thumbnail_url
    xml = HTTParty.get(self.feed_url).body
    self.url = Feedjira.parse(xml).url
    self.thumbnail_url = 'https://www.google.com/s2/favicons?domain_url=' + self.url
  end

  def create_articles
    xml = HTTParty.get(self.feed_url).body
    entry = Feedjira.parse(xml).entries

    entry.each do |e|
      images = Nokogiri::HTML.parse(e.content, nil, 'utf-8').css('img')
      first_image_url = images.empty? ? '' : images.first.attribute('src').value
      
      article = Article.new(title: e.title, url: e.url, published: e.published, content: e.content, feed_id: self.id, thumbnail_url: first_image_url)

      if article.save
      else
      end
    end
  end

end
