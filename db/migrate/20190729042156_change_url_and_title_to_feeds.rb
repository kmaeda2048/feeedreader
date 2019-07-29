class ChangeUrlAndTitleToFeeds < ActiveRecord::Migration[5.2]
  def up
    change_column :feeds, :url, :string, null: false
    change_column :feeds, :title, :string, null: false
  end

  def down
    change_column :feeds, :url, :string
    change_column :feeds, :title, :string
  end
end
