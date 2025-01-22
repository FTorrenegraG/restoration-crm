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

ActiveRecord::Schema[8.0].define(version: 2025_01_22_033916) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.string "message"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_alerts_on_event_id"
    t.index ["user_id"], name: "index_alerts_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.string "role"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_assignments_on_event_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.string "location"
    t.text "description"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ministries", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "super_ministry", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ministry_roles", force: :cascade do |t|
    t.bigint "ministry_id", null: false
    t.string "name"
    t.text "description"
    t.string "uni_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ministry_id"], name: "index_ministry_roles_on_ministry_id"
    t.index ["uni_key"], name: "index_ministry_roles_on_uni_key", unique: true
  end

  create_table "ministry_sub_roles", force: :cascade do |t|
    t.bigint "ministry_role_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ministry_role_id"], name: "index_ministry_sub_roles_on_ministry_role_id"
  end

  create_table "song_events", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "song_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_song_events_on_event_id"
    t.index ["song_id"], name: "index_song_events_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.string "performer"
    t.string "key"
    t.string "song_type"
    t.string "reference_link"
    t.string "lyrics"
    t.string "sheet_music"
    t.string "vocals"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_ministry_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ministry_id", null: false
    t.bigint "ministry_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ministry_sub_role_id", null: false
    t.index ["ministry_id"], name: "index_user_ministry_roles_on_ministry_id"
    t.index ["ministry_role_id"], name: "index_user_ministry_roles_on_ministry_role_id"
    t.index ["ministry_sub_role_id"], name: "index_user_ministry_roles_on_ministry_sub_role_id"
    t.index ["user_id"], name: "index_user_ministry_roles_on_user_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.string "casa_r"
    t.jsonb "other_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["casa_r"], name: "index_user_profiles_on_casa_r"
    t.index ["first_name"], name: "index_user_profiles_on_first_name"
    t.index ["last_name"], name: "index_user_profiles_on_last_name"
    t.index ["other_details"], name: "index_user_profiles_on_other_details", using: :gin
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "alerts", "events"
  add_foreign_key "alerts", "users"
  add_foreign_key "assignments", "events"
  add_foreign_key "assignments", "users"
  add_foreign_key "availabilities", "users"
  add_foreign_key "ministry_roles", "ministries"
  add_foreign_key "ministry_sub_roles", "ministry_roles"
  add_foreign_key "song_events", "events"
  add_foreign_key "song_events", "songs"
  add_foreign_key "user_ministry_roles", "ministries"
  add_foreign_key "user_ministry_roles", "ministry_roles"
  add_foreign_key "user_ministry_roles", "ministry_sub_roles"
  add_foreign_key "user_ministry_roles", "users"
  add_foreign_key "user_profiles", "users"
end
