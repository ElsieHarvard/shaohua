class AddHashToArticle < ActiveRecord::Migration
  def change
  	 add_column :articles, :archash, :string
  end
end
