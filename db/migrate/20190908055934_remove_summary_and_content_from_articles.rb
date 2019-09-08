class RemoveSummaryAndContentFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :summary, :text
    remove_column :articles, :content, :text
  end
end
