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

ActiveRecord::Schema.define(version: 20160912033658) do

  create_table "routes", force: :cascade do |t|
    t.string   "number",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "source",     limit: 255
    t.string   "dest",       limit: 255
  end

  create_table "stations", force: :cascade do |t|
    t.string   "station_id",   limit: 255
    t.string   "station_name", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "full_address", limit: 255
    t.float    "lat",          limit: 24
    t.float    "lon",          limit: 24
  end

  create_table "travel_infos", force: :cascade do |t|
    t.string   "direction",    limit: 255
    t.string   "destination",  limit: 255
    t.float    "lat",          limit: 24
    t.float    "lng",          limit: 24
    t.integer  "offset",       limit: 4
    t.integer  "offset_sec",   limit: 4
    t.integer  "vehicle_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "service",      limit: 255
    t.string   "track",        limit: 255
    t.string   "track_change", limit: 255
    t.string   "next_stop",    limit: 255
    t.integer  "late_by",      limit: 4
  end

  add_index "travel_infos", ["vehicle_id"], name: "index_travel_infos_on_vehicle_id", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "vehicle_number", limit: 255
    t.integer  "label",          limit: 4
    t.integer  "vehicle_id",     limit: 4
    t.integer  "block_id",       limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "route_id",       limit: 4
  end

  add_index "vehicles", ["route_id"], name: "index_vehicles_on_route_id", using: :btree

  add_foreign_key "travel_infos", "vehicles"
end
