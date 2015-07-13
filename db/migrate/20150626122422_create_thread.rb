class CreateThread < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.string :thread_title
      t.string :thread_hash
      t.string :thread_info
      t.string :thread_board
    end
  end
end
