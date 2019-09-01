class AddLimitToTitleInFeeds < ActiveRecord::Migration[5.2]
  def up
    change_column :feeds, :title, :string, null: false, limit: 20
  end

  def down
    change_column :feeds, :title, :string, null: false
  end
end
