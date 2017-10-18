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

ActiveRecord::Schema.define(version: 20171018013000) do

  create_table "file_contents", force: :cascade do |t|
    t.integer "file_info_id", null: false
    t.binary "content", limit: 512000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["file_info_id"], name: "index_file_contents_on_file_info_id"
  end

  create_table "file_infos", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest", null: false
    t.integer "content_size", null: false
    t.boolean "private", null: false
    t.datetime "expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at", "private", "expiration"], name: "index_file_infos_on_created_at_and_private_and_expiration"
  end

end
