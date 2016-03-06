class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :idhsh
      t.string :arc_title
      t.string :ext_author_idhsh
      t.text :arc_content
      t.text :marshal_info_hash
      t.text :formatted_information

      t.timestamps null: false
    end
  end
end
