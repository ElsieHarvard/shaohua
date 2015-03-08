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

ActiveRecord::Schema.define(version: 20150308143318) do

  create_table "analyses", force: :cascade do |t|
    t.integer  "arcid"
    t.string   "arctag"
    t.integer  "arcview"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "arctype"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "arctitle"
    t.string   "arcauthor"
    t.string   "arctype"
    t.text     "arccontent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "archash"
  end

  create_table "periodical_articles", force: :cascade do |t|
    t.string   "arcpicture"
    t.string   "arctitle"
    t.string   "arcpreauthor"
    t.string   "arcauthor"
    t.integer  "arcnumber"
    t.text     "arcbeforecontent"
    t.string   "arcattrbeforecontent"
    t.text     "arccontent"
    t.string   "arcattraftercontent"
    t.text     "arcaftercontent"
    t.string   "archash"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "prdhash"
  end

  create_table "periodicals", force: :cascade do |t|
    t.string   "prdtitle"
    t.string   "prdinfo"
    t.text     "prdpages"
    t.string   "prdhash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "web_accounts", force: :cascade do |t|
    t.string   "usrname"
    t.string   "usrpasswordhash"
    t.string   "usrtype"
    t.string   "usrhash"
    t.text     "usrpubkey"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_salt"
  end

end
