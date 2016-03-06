# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160120105616) do

  create_table "articles", force: :cascade do |t|
    t.string   "idhsh"
    t.string   "arc_title"
    t.string   "ext_author_idhsh"
    t.text     "arc_content"
    t.text     "marshal_info_hash"
    t.text     "formatted_information"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "forum_accounts", force: :cascade do |t|
    t.string   "idhsh"
    t.string   "ext_shell_idhsh"
    t.string   "usr_name"
    t.text     "marshal_info_hash"
    t.text     "formatted_information"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "shell_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "idhsh",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "shell_users", ["email"], name: "index_shell_users_on_email", unique: true
  add_index "shell_users", ["reset_password_token"], name: "index_shell_users_on_reset_password_token", unique: true

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

end
