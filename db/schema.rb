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

ActiveRecord::Schema.define(version: 20170508143806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadata", primary_key: "key", id: :string, force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_ins", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "latitude",   null: false
    t.float    "longitude",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "address"
    t.index ["user_id"], name: "index_check_ins_on_user_id", using: :btree
  end

  create_table "check_outs", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "latitude",   null: false
    t.float    "longitude",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "address"
    t.index ["user_id"], name: "index_check_outs_on_user_id", using: :btree
  end

  create_table "day_months", force: :cascade do |t|
    t.string   "day1"
    t.string   "day2"
    t.string   "day3"
    t.string   "day4"
    t.string   "day5"
    t.string   "day6"
    t.string   "day7"
    t.string   "day8"
    t.string   "day9"
    t.string   "day10"
    t.string   "day11"
    t.string   "day12"
    t.string   "day13"
    t.string   "day14"
    t.string   "day15"
    t.string   "day16"
    t.string   "day17"
    t.string   "day18"
    t.string   "day19"
    t.string   "day20"
    t.string   "day21"
    t.string   "day22"
    t.string   "day23"
    t.string   "day24"
    t.string   "day25"
    t.string   "day26"
    t.string   "day27"
    t.string   "day28"
    t.string   "day29"
    t.string   "day30"
    t.string   "day31"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.float    "latitude",                 null: false
    t.float    "longitude",                null: false
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "percentage", default: 100, null: false
    t.index ["user_id"], name: "index_locations_on_user_id", using: :btree
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id", using: :btree
    t.index ["user_id"], name: "index_user_groups_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                                        null: false
    t.string   "email",                                       null: false
    t.string   "password_digest",                             null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "admin",              default: false,          null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.boolean  "online_status",      default: false,          null: false
    t.datetime "update_location_at", default: -> { "now()" }, null: false
    t.integer  "percentage",         default: 100,            null: false
  end

  add_foreign_key "check_ins", "users"
  add_foreign_key "check_outs", "users"
  add_foreign_key "locations", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"

  create_view :check_in_day_views, materialized: true,  sql_definition: <<-SQL
      SELECT s.user_id,
      s.check_in_month,
      s.check_in_day,
      s.check_in_time
     FROM ( SELECT a.user_id,
              date_part('day'::text, a.created_at) AS check_in_day,
              date_part('month'::text, a.created_at) AS check_in_month,
              (date_part('hour'::text, a.created_at) + (round(((date_part('minute'::text, a.created_at) / (60)::double precision))::numeric, 2))::double precision) AS check_in_time
             FROM (check_ins a
               LEFT JOIN check_outs b ON (((a.user_id = b.user_id) AND (date_trunc('day'::text, a.created_at) = date_trunc('day'::text, b.created_at)))))) s;
  SQL

  create_view :check_out_day_views, materialized: true,  sql_definition: <<-SQL
      SELECT s.user_id,
      s.check_out_month,
      s.check_out_day,
      s.check_out_time
     FROM ( SELECT b.user_id,
              date_part('month'::text, b.created_at) AS check_out_month,
              date_part('day'::text, b.created_at) AS check_out_day,
              (date_part('hour'::text, b.created_at) + (round(((date_part('minute'::text, b.created_at) / (60)::double precision))::numeric, 2))::double precision) AS check_out_time
             FROM (check_ins a
               LEFT JOIN check_outs b ON (((a.user_id = b.user_id) AND (date_trunc('day'::text, a.created_at) = date_trunc('day'::text, b.created_at)))))) s;
  SQL

  create_view :check_in_early_views, materialized: true,  sql_definition: <<-SQL
      SELECT s.user_id,
      s.check_in_month,
      s.check_in_date,
      s.early
     FROM ( SELECT s1.user_id,
              date_part('month'::text, s1.created_at) AS check_in_month,
              date_part('day'::text, s1.check_in_date) AS check_in_date,
                  CASE
                      WHEN (s1.check_in_time < (7.5)::double precision) THEN round(((s1.check_out_time - (7.5)::double precision))::numeric, 2)
                      ELSE NULL::numeric
                  END AS early
             FROM ( SELECT a.user_id,
                      a.created_at,
                      a.created_at AS check_in_date,
                      (date_part('hour'::text, a.created_at) + (round(((date_part('minute'::text, a.created_at) / (60)::double precision))::numeric, 2))::double precision) AS check_in_time,
                      (date_part('hour'::text, b.created_at) + (round(((date_part('minute'::text, b.created_at) / (60)::double precision))::numeric, 2))::double precision) AS check_out_time
                     FROM (check_ins a
                       LEFT JOIN check_outs b ON (((a.user_id = b.user_id) AND (date_trunc('day'::text, a.created_at) = date_trunc('day'::text, b.created_at)))))) s1) s;
  SQL

  create_view :check_out_late_views, materialized: true,  sql_definition: <<-SQL
      SELECT s.user_id,
      s.check_out_month,
      s.check_out_date,
      s.late
     FROM ( SELECT s1.user_id,
              date_part('month'::text, s1.created_at) AS check_out_month,
              date_part('day'::text, s1.check_out_date) AS check_out_date,
                  CASE
                      WHEN (s1.check_out_time > (16.5)::double precision) THEN round(((s1.check_out_time - (16.5)::double precision))::numeric, 2)
                      ELSE NULL::numeric
                  END AS late
             FROM ( SELECT a.user_id,
                      a.created_at,
                      a.created_at AS check_out_date,
                      (date_part('hour'::text, a.created_at) + (round(((date_part('minute'::text, a.created_at) / (60)::double precision))::numeric, 2))::double precision) AS check_out_time
                     FROM (check_outs a
                       LEFT JOIN check_outs b ON (((a.user_id = b.user_id) AND (date_trunc('day'::text, a.created_at) = date_trunc('day'::text, b.created_at)))))) s1) s;
  SQL

end
