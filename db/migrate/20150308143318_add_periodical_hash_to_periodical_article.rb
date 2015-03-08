class AddPeriodicalHashToPeriodicalArticle < ActiveRecord::Migration
  def change
    add_column :periodical_articles, :prdhash, :string
  end
end
