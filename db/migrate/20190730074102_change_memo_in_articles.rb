class ChangeMemoInArticles < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :memo, :text, default: 'メモはありません'
  end

  def down
    change_column :articles, :memo, :text
  end
end
