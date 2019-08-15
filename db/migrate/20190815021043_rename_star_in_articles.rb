class RenameStarInArticles < ActiveRecord::Migration[5.2]
  def change
    rename_column :articles, :star, :starred
  end
end
