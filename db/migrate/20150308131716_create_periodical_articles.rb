class CreatePeriodicalArticles < ActiveRecord::Migration
  def change
    create_table :periodical_articles do |t|
      t.string :arcpicture
      t.string :arctitle
      t.string :arcpreauthor
      t.string :arcauthor
      t.integer :arcnumber
      t.text :arcbeforecontent
      t.string :arcattrbeforecontent
      t.text :arccontent
      t.string :arcattraftercontent
      t.text :arcaftercontent
      t.string :archash

      t.timestamps null: false
    end
  end
end
