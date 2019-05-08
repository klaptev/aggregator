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

ActiveRecord::Schema.define(version: 20190504214635) do

  create_table "feeds", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "link",       limit: 255
    t.string   "title",      limit: 255
    t.integer  "group_id",   limit: 4
  end

  create_table "news", force: :cascade do |t|
    t.text     "title",      limit: 65535
    t.integer  "feed_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "sumcheck",   limit: 255
  end

  add_index "news", ["sumcheck"], name: "index_news_on_sumcheck", unique: true, using: :btree

end
