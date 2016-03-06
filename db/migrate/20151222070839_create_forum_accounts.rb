class CreateForumAccounts < ActiveRecord::Migration
  def change
    create_table :forum_accounts do |t|
      t.string :idhsh
      t.string :ext_shell_idhsh
      t.string :usr_name
      t.text :marshal_info_hash
      t.text :formatted_information

      t.timestamps null: false
    end
  end
end
