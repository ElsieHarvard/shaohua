class CreatePeriodicals < ActiveRecord::Migration
  def change
    create_table :periodicals do |t|
      t.string :prdtitle
      t.string :prdinfo
      t.text :prdpages
      t.string :prdhash

      t.timestamps null: false
    end
  end
end
