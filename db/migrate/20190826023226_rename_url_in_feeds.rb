class RenameUrlInFeeds < ActiveRecord::Migration[5.2]
  def change
    rename_column :feeds, :url, :feed_url
  end
end
