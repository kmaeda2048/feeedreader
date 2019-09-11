class RenameTitleInFeeds < ActiveRecord::Migration[5.2]
  def change
    rename_column :feeds, :title, :name
  end
end
