class AddLastModifiedToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :last_modified, :datetime
  end
end
