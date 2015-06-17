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

ActiveRecord::Schema.define(version: 20150610134912) do

  create_table "articles", force: :cascade do |t|
    t.string  "arc_title"
    t.string  "arc_type"
    t.string  "arc_preauthor"
    t.string  "arc_author"
    t.text    "arc_beforecontent"
    t.string  "arc_attrbeforecontent"
    t.text    "arc_content"
    t.string  "arc_attraftercontent"
    t.text    "arc_aftercontent"
    t.string  "arc_picture"
    t.string  "arc_prdhash"
    t.string  "arc_prdnumber"
    t.integer "arc_view"
    t.integer "arc_top"
    t.text    "arc_tag"
    t.string  "arc_hash"
    t.string  "arc_author_hash"
    t.integer "arc_rate"
  end

  create_table "forum_accounts", force: :cascade do |t|
    t.string   "user_name"
    t.string   "user_hash"
    t.string   "user_verification"
    t.string   "user_account"
    t.string   "user_nick_name"
    t.text     "user_information"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "forum_boards", force: :cascade do |t|
    t.string   "board_name"
    t.string   "board_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periodicals", force: :cascade do |t|
    t.string "prd_no"
    t.string "prd_title"
    t.string "prd_info"
    t.string "prd_msg"
    t.string "prd_hash"
  end

  create_table "web_accounts", force: :cascade do |t|
    t.string   "usrname"
    t.string   "usrpasswordhash"
    t.string   "usrtype"
    t.string   "usrhash"
    t.text     "usrpubkey"
    t.text     "password_salt"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
