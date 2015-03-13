class AddPrdNumbermsgToPeriodical < ActiveRecord::Migration
  def change
    add_column :periodicals, :prdno, :integer
  end
end
