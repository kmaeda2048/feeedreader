class RemoveLimitFromTitleInFeeds < ActiveRecord::Migration[5.2]
  def up
    change_column :feeds, :title, :string, null: false
  end

  def down
    change_column :feeds, :title, :string, null: false, limit: 20
  end
end
