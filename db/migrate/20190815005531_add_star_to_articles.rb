class AddStarToArticles < ActiveRecord::Migration[5.2]
  def up
    add_column :articles, :star, :boolean, default: false
  end
  
  def down
    remove_column :articles, :star
  end
end
