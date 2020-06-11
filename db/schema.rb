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

ActiveRecord::Schema.define(version: 2020_06_09_232715) do

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.string "yelp_business_id"
    t.string "address"
    t.float "avg_rating"
    t.integer "review_count"
    t.string "price"
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "date"
    t.integer "guest_number"
    t.integer "user_id"
    t.integer "business_id"
    t.string "time_zone"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password"
  end

end
