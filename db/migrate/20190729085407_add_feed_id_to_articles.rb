class AddFeedIdToArticles < ActiveRecord::Migration[5.2]
  def up
    add_reference :articles, :feed, foreign_key: true
  end

  def down
    remove_reference :articles, :feed, foreign_key: true
  end
end
