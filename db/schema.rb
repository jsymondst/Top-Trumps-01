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

ActiveRecord::Schema.define(version: 2020_05_06_092402) do

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "val1"
    t.string "val2"
    t.string "val3"
    t.string "val4"
    t.string "val5"
    t.string "val6"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.string "deck_path"
    t.integer "column_count"
    t.integer "playable_columns"
  end

  create_table "game_records", force: :cascade do |t|
    t.integer "player_id"
    t.integer "deck_id"
    t.integer "win"
    t.integer "loss"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
  end

end
