class AddNotNullToFeeds < ActiveRecord::Migration[5.2]
  def up
    change_column :feeds, :last_modified, :datetime, null: false
  end

  def down
    change_column :feeds, :last_modified, :datetime
  end
end
