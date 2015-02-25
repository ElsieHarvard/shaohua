class AddArctypeToAnalysis < ActiveRecord::Migration
  def change
    add_column :analyses, :arctype, :string
  end
end
