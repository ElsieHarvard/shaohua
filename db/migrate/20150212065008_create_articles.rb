class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :arctitle
      t.string :arcauthor
      t.string :arctype
      t.text :arccontent

      t.timestamps null: false
    end
  end
end
