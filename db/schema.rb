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

ActiveRecord::Schema.define(version: 20160412103228) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "sports_installation_id"
    t.integer  "time_band_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.integer  "local_team"
    t.integer  "away_team"
    t.string   "participants"
    t.integer  "max_size"
  end

  create_table "installations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installations_sports", id: false, force: :cascade do |t|
    t.integer "installation_id"
    t.integer "sport_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "sender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "date"
  end

  create_table "sports", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_players"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sports_installations", force: :cascade do |t|
    t.integer  "installation_id"
    t.integer  "sport_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "sports_installations_time_bands", force: :cascade do |t|
    t.boolean  "free"
    t.integer  "time_band_id"
    t.integer  "sports_installation_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sports_installations_time_bands", ["time_band_id"], name: "intermediate_tb"

  create_table "teams", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "sport"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sport_id"
  end

  create_table "time_bands", force: :cascade do |t|
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "start_hour"
    t.string   "end_hour"
  end

  create_table "users", force: :cascade do |t|
    t.string   "dni"
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_teams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users_teams", ["team_id"], name: "index_users_teams_on_team_id"
  add_index "users_teams", ["user_id"], name: "index_users_teams_on_user_id"

end
