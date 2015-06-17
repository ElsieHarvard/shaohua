class AddArcHashToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :arc_author_hash,:string
  end
end
