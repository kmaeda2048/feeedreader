class Feed < ApplicationRecord
  has_many :article, dependent: :delete_all
  
  validates :feed_url, uniqueness: true
  validate :validate_feed_url

  before_create :set_attributes, on: :create
  after_create :create_articles, on: :create

  def self.ransackable_attributes(auth_object = nil)
    %w[feed_url name url]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private

  def validate_feed_url
    if self.feed_url.blank?
      errors.add(:feed_url, :blank)
    else
      begin
        response = HTTParty.get(self.feed_url)
      rescue
        errors.add(:feed_url, :cannot_access)
      else
        begin
          parse_result = Feedjira.parse(response.body)
        rescue
          errors.add(:feed_url, :cannot_parse)
        end
      end
    end
  end

  def set_attributes
    response = HTTParty.get(self.feed_url)
    parse_result = Feedjira.parse(response.body)
    set_name(parse_result) if self.name == ''
    set_url(parse_result)
    set_favicon_url
  end

  def set_name(parse_result)
    self.name = parse_result.title
  end

  def set_url(parse_result)
    self.url = parse_result.url
  end

  def set_favicon_url
    self.favicon_url = "https://www.google.com/s2/favicons?domain_url=#{self.url}"
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

      article = Article.new(title: e.title, url: e.url, published: e.published, feed_id: self.id, thumbnail_url: image)

      if article.save
      else
      end
    end
  end

end
