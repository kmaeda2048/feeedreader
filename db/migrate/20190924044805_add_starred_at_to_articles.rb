class AddStarredAtToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :starred_at, :datetime
  end
end
