class AddUnreadToArticles < ActiveRecord::Migration[5.2]
  def up
    add_column :articles, :unread, :boolean
  end

  def down
    remove_column :articles, :unread
  end
end
