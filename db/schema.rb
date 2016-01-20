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

ActiveRecord::Schema.define(version: 20160120020354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "student_id"
    t.string   "commitment_status"
    t.string   "method_of_transit"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "departure_type"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "start_date_and_time"
    t.float    "duration"
    t.string   "description"
    t.integer  "organization_id"
    t.string   "event_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "minimum_age"
  end

  create_table "nudges", force: :cascade do |t|
    t.integer  "nudger_id"
    t.integer  "nudgee_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "domain_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "email_domain"
  end

  create_table "parents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_providers", force: :cascade do |t|
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "username"
    t.integer  "school_id"
    t.string   "home_address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "nudges_enabled"
    t.boolean  "can_nudge"
  end

  add_index "students", ["username"], name: "index_students_on_username", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "email_token"
    t.string   "phone_token"
    t.boolean  "email_verified"
    t.boolean  "phone_verified"
    t.boolean  "inactive"
    t.string   "password_reset_token"
    t.boolean  "nudges_enabled"
    t.string   "time_zone"
    t.integer  "role_id"
    t.string   "role_type"
  end

end
