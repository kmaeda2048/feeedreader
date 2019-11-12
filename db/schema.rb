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

ActiveRecord::Schema.define(version: 2019_11_12_034241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.datetime "published", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "feed_id"
    t.boolean "unread", default: true
    t.boolean "starred", default: false
    t.string "thumbnail_url", default: "", null: false
    t.datetime "starred_at"
    t.index ["feed_id"], name: "index_articles_on_feed_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "feed_url", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "origin_url", null: false
    t.string "favicon_url", null: false
    t.datetime "last_modified"
    t.index ["feed_url"], name: "index_feeds_on_feed_url", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "feeds"
end
