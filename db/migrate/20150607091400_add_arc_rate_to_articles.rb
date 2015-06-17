class AddArcRateToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :arc_rate, :integer
  end
end
