class RemoveMemoFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :memo, :text
  end
end
