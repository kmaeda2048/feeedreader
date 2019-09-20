class RenameFromUrlToOriginUrlInFeeds < ActiveRecord::Migration[5.2]
  def change
    rename_column :feeds, :url, :origin_url
  end
end
