class Feed < ApplicationRecord
  belongs_to :user
  has_many :articles, dependent: :delete_all
  
  validates :feed_url, uniqueness: true
  validate :validate_feed_url

  before_create :set_attributes, on: :create
  after_create :create_articles, on: :create

  scope :recently, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[feed_url name origin_url created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.fetch_all
    feeds = Feed.all
    
    feeds.each do |feed|
      feed.fetch
    end
  end

  def fetch
    Rails.application.config.feed_fetch_logger.debug("id=#{self.id}「#{self.name}」の#fetch開始(記事数: #{self.articles.size})")

    response = HTTParty.get(self.feed_url)
    parse_result = Feedjira.parse(response.body)

    if parse_result.last_modified.in_time_zone > self.last_modified
      Rails.application.config.feed_fetch_logger.debug("フィード更新あり")

      self.update(last_modified: parse_result.last_modified.in_time_zone)
      articles = parse_result.entries.reverse
  
      articles.each do |article|
        # first_or_initializeは同じ記事がなければ作成、あれば呼び出しという処理をする
        local_article = self.articles.where(title: article.title).first_or_initialize
        thumbnail = decide_thumbnail(article)
        local_article.update_attributes(url: article.url, published: article.published, feed_id: self.id, thumbnail_url: thumbnail)
      end
    end

    Rails.application.config.feed_fetch_logger.debug("id=#{self.id}「#{self.name}」の#fetch終了(記事数: #{self.articles.size})")
  end

  def decide_thumbnail(article)
    thumbnail = article.image ? article.image : ''

    if thumbnail == ''
      response = HTTParty.get(article.url)
      thumbnail = Nokogiri::HTML.parse(response.body, nil, 'utf-8').css('//meta[property="og:image"]/@content').to_s
    end

    return thumbnail
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
          @parse_result = Feedjira.parse(response.body)
          self.last_modified = @parse_result.last_modified.in_time_zone
        rescue
          errors.add(:feed_url, :cannot_parse)
        end
      end
    end
  end

  def set_attributes
    set_name if self.name.blank?
    set_origin_url
    set_favicon_url
  end

  def set_name
    self.name = @parse_result.title
  end

  def set_origin_url
    self.origin_url = @parse_result.url
  end

  def set_favicon_url
    self.favicon_url = "https://www.google.com/s2/favicons?domain_url=#{self.origin_url}"
  end

  def create_articles
    articles = @parse_result.entries.reverse

    articles.each do |article|
      thumbnail = decide_thumbnail(article)
      article = Article.new(title: article.title, url: article.url, published: article.published, feed_id: self.id, thumbnail_url: thumbnail)

      if article.save
      else
      end
    end
  end
end
