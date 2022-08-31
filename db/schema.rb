# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_31_155836) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "photo"
    t.text "description"
    t.text "synopsis"
    t.integer "rating"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available", default: true, null: false
    t.string "publisher"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "receiver_id", null: false
    t.bigint "sender_id", null: false
    t.bigint "trade_id", null: false
    t.index ["receiver_id"], name: "index_reviews_on_receiver_id"
    t.index ["sender_id"], name: "index_reviews_on_sender_id"
    t.index ["trade_id"], name: "index_reviews_on_trade_id"
  end

  create_table "trades", force: :cascade do |t|
    t.boolean "accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "seller_id"
    t.bigint "buyer_id"
    t.bigint "seller_book_id"
    t.bigint "buyer_book_id"
    t.bigint "chatroom_id", null: false
    t.index ["buyer_book_id"], name: "index_trades_on_buyer_book_id"
    t.index ["buyer_id"], name: "index_trades_on_buyer_id"
    t.index ["chatroom_id"], name: "index_trades_on_chatroom_id"
    t.index ["seller_book_id"], name: "index_trades_on_seller_book_id"
    t.index ["seller_id"], name: "index_trades_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.float "reputation"
    t.string "address"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "books", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "reviews", "trades"
  add_foreign_key "reviews", "users", column: "receiver_id"
  add_foreign_key "reviews", "users", column: "sender_id"
  add_foreign_key "trades", "books", column: "buyer_book_id"
  add_foreign_key "trades", "books", column: "seller_book_id"
  add_foreign_key "trades", "chatrooms"
  add_foreign_key "trades", "users", column: "buyer_id"
  add_foreign_key "trades", "users", column: "seller_id"
end
