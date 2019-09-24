class Article < ApplicationRecord
  belongs_to :feed

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
      Article.all.order(published: 'asc').first.destroy
    end
  end
end
