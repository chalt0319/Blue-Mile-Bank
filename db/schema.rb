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

ActiveRecord::Schema.define(version: 2018_11_28_174418) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "banks", force: :cascade do |t|
    t.integer "account_id"
    t.integer "checking", default: 0
    t.integer "savings", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "checking_history"
    t.text "savings_history"
  end

  create_table "histories", force: :cascade do |t|
    t.boolean "checking"
    t.boolean "savings"
    t.string "date"
    t.integer "amount"
    t.string "message"
    t.boolean "add"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
