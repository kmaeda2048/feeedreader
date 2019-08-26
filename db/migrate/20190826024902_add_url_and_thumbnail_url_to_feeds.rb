class AddUrlAndThumbnailUrlToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :url, :string, null: false
    add_column :feeds, :thumbnail_url, :string, null: false
  end
end
