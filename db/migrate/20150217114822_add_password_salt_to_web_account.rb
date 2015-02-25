class AddPasswordSaltToWebAccount < ActiveRecord::Migration
  def change
    add_column :web_accounts, :password_salt, :string
  end
end
