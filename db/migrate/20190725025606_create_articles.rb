class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.text :summary
      t.datetime :published
      t.text :content
      t.text :memo

      t.timestamps
    end
  end
end
