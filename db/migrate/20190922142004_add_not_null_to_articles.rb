class AddNotNullToArticles < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :title, :string, null: false
    change_column :articles, :url, :string, null: false
    change_column :articles, :published, :datetime, null: false
  end

  def down
    change_column :articles, :title, :string
    change_column :articles, :url, :string
    change_column :articles, :published, :datetime
  end
end
