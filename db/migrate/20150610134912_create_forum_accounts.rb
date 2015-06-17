class CreateForumAccounts < ActiveRecord::Migration
  def change
    create_table :forum_accounts do |t|
      t.string :user_name
      t.string :user_hash
      t.string :user_verification
      t.string :user_account
      t.string :user_nick_name
      t.text :user_information

      t.timestamps null: false
    end
  end
end
