class Article < ApplicationRecord
  belongs_to :feed

  def self.ransackable_attributes(auth_object = nil)
    %w[title url]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
