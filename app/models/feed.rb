class Feed < ApplicationRecord
  has_many :article, dependent: :delete_all
  
  validates :feed_url, presence: true, uniqueness: true
  validate :validate_feed_url

  before_create :set_title_and_url_and_favicon_url, on: :create
  after_create :create_articles, on: :create

  private

  def validate_feed_url
    response = HTTParty.get(self.feed_url)
    begin
      parse_result = Feedjira.parse(response.body)
    rescue
      errors.add(:feed_url, :not_a_feed)
    end
  end

  def set_title_and_url_and_favicon_url
    response = HTTParty.get(self.feed_url)
    parse_result = Feedjira.parse(response.body)
    self.title = parse_result.title if self.title == ''
    self.url = parse_result.url
    self.favicon_url = 'https://www.google.com/s2/favicons?domain_url=' + self.url
  end

  def create_articles
    response = HTTParty.get(self.feed_url)
    entry = Feedjira.parse(response.body).entries

    entry.each do |e|
      image = e.image ? e.image : ''
      if image == ''
        response = HTTParty.get(e.url)
        image = Nokogiri::HTML.parse(response.body, nil, 'utf-8').css('//meta[property="og:image"]/@content').to_s
      end

      article = Article.new(title: e.title, url: e.url, published: e.published, feed_id: self.id, favicon_url: image)

      if article.save
      else
      end
    end
  end

end
