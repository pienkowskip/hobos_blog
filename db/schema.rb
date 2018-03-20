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

ActiveRecord::Schema.define(version: 20180319222837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["asset_updated_at"], name: "default_ordering_index_on_assets", order: {"asset_updated_at"=>:desc}, using: :btree
  add_index "assets", ["asset_updated_at"], name: "index_assets_on_asset_updated_at", using: :btree

  create_table "captions", force: :cascade do |t|
    t.string   "textid",     null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "captions", ["textid"], name: "index_captions_on_textid", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "categories", ["name"], name: "default_ordering_index_on_categories", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",                              null: false
    t.string   "state",            default: "draft", null: false
    t.datetime "published_at"
    t.text     "body",                               null: false
    t.text     "excerpt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.integer  "category_id"
    t.text     "markdown_body",                      null: false
    t.text     "markdown_excerpt"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree
  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree
  add_index "posts", ["created_at"], name: "default_ordering_index_on_posts", order: {"created_at"=>:desc}, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                default: "invited"
    t.datetime "key_timestamp"
  end

  add_index "users", ["name"], name: "default_ordering_index_on_users", using: :btree
  add_index "users", ["state"], name: "index_users_on_state", using: :btree

end
