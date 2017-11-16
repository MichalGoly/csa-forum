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

ActiveRecord::Schema.define(version: 20171116171448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broadcasts", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_broadcasts_on_user_id"
  end

  create_table "broadcasts_feeds", id: false, force: :cascade do |t|
    t.bigint "broadcast_id"
    t.bigint "feed_id"
    t.index ["broadcast_id"], name: "index_broadcasts_feeds_on_broadcast_id"
    t.index ["feed_id"], name: "index_broadcasts_feeds_on_feed_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.bigint "user_id"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "date", null: false
    t.bigint "user_id"
    t.bigint "topic_id"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_posts_on_parent_id"
    t.index ["topic_id"], name: "index_posts_on_topic_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_reads", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "topic_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_posts_reads_on_post_id"
    t.index ["topic_id"], name: "index_posts_reads_on_topic_id"
    t.index ["user_id"], name: "index_posts_reads_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "date", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.string "login"
    t.string "salt"
    t.string "crypted_password"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "surname", null: false
    t.string "firstname", null: false
    t.string "phone"
    t.integer "grad_year", null: false
    t.boolean "jobs", default: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["surname"], name: "index_users_on_surname"
  end

  add_foreign_key "broadcasts", "users"
  add_foreign_key "broadcasts_feeds", "broadcasts"
  add_foreign_key "broadcasts_feeds", "feeds"
  add_foreign_key "images", "users"
  add_foreign_key "posts", "posts", column: "parent_id"
  add_foreign_key "posts", "topics"
  add_foreign_key "posts", "users"
  add_foreign_key "posts_reads", "posts"
  add_foreign_key "posts_reads", "topics"
  add_foreign_key "posts_reads", "users"
  add_foreign_key "topics", "users"
  add_foreign_key "user_details", "users"
end
