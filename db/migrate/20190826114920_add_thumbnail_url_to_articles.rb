class AddThumbnailUrlToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :thumbnail_url, :string, null: false
  end
end
