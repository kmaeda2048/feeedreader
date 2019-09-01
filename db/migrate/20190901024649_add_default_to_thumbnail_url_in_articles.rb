class AddDefaultToThumbnailUrlInArticles < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :thumbnail_url, :string, null: false, default: ''
  end

  def down
    change_column :articles, :thumbnail_url, :string, null: false
  end
end
