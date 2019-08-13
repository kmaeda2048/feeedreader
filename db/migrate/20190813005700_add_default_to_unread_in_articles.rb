class AddDefaultToUnreadInArticles < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :unread, :boolean, default: true
  end

  def down
    change_column :articles, :unread, :boolean
  end
end
