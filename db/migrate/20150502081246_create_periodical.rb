class CreatePeriodical < ActiveRecord::Migration
  def change
    create_table :periodicals do |t|
		t.string :prd_no
		t.string :prd_title
		t.string :prd_info
		t.string :prd_msg
		t.string :prd_hash
    end
  end
end
