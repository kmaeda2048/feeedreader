class RenameThumbnailUrlInFeeds < ActiveRecord::Migration[5.2]
  def change
    rename_column :feeds, :thumbnail_url, :favicon_url
  end
end
