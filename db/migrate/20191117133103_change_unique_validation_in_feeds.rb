class ChangeUniqueValidationInFeeds < ActiveRecord::Migration[5.2]
  def change
    remove_index :feeds, :feed_url
    add_index :feeds, [:user_id, :feed_url], unique: true
  end
end
