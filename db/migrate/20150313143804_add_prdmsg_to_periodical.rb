class AddPrdmsgToPeriodical < ActiveRecord::Migration
  def change
    add_column :periodicals, :prdmsg, :text
  end
end
