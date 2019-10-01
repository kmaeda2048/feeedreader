class Article < ApplicationRecord
  belongs_to :feed

  scope :unread, -> { where(unread: true) }
  scope :starred, -> { where(starred: true) }
  scope :order_pub, -> { order(published: :asc) }
  scope :order_star, -> { order(starred_at: :asc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.destroy_read_articles
    Article.where(unread: false, starred: false).map(&:destroy)
  end

  def self.destroy_overflowing_articles(max)
    (Article.all.size - max).times do
      Article.where(starred: false).order(published: 'asc').first.destroy
    end
  end

  def read
    self.update(unread: false)
  end

  def toggle_star
    if self.starred
      self.update(starred: false, starred_at: nil)
    else
      self.update(starred: true, starred_at: Time.now)
    end
  end
end
