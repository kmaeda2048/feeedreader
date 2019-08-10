class AddUrlIndexToFeeds < ActiveRecord::Migration[5.2]
  def up
    add_index :feeds, :url, unique: true
  end

  def down
    remove_index :feeds, :url
  end
end
