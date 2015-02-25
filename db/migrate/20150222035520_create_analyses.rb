class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.integer :arcid
      t.string  :arctag
      t.integer :arcview

      t.timestamps null: false
    end
  end
end
