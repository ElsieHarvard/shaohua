class CreateWebAccounts < ActiveRecord::Migration
  def change
    create_table :web_accounts do |t|
      t.string :usrname
      t.string :usrpasswordhash
      t.string :usrtype
      t.string :usrhash
      t.text :usrpubkey

      t.timestamps null: false
    end
  end
end
