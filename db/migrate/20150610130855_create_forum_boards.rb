class CreateForumBoards < ActiveRecord::Migration
  def change
    create_table :forum_boards do |t|
      t.string :board_name
      t.string :board_hash

      t.timestamps null: false
    end
  end
end
