class Feed < ApplicationRecord
  has_many :article, dependent: :delete_all
  
  validates :feed_url, presence: true, uniqueness: true
  validates :title, length: { maximum: 20 }
  validate :validate_feed_url

  before_create :set_title_url_and_thumbnail_url, on: :create
  after_create :create_articles, on: :create

  private

  def validate_feed_url
    errors.add(:feed_url, :not_a_feed) if HTTParty.get(self.feed_url).body.empty?
  end

  def set_title_url_and_thumbnail_url
    xml = HTTParty.get(self.feed_url).body
    parse_result = Feedjira.parse(xml)
    self.title = parse_result.title if self.title == ''
    self.url = parse_result.url
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
