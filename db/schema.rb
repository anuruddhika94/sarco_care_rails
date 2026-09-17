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

ActiveRecord::Schema[8.1].define(version: 2026_09_17_104532) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "articles", force: :cascade do |t|
    t.text "body_en", default: [], null: false, array: true
    t.text "body_th", default: [], null: false, array: true
    t.integer "category", null: false
    t.datetime "created_at", null: false
    t.string "icon", null: false
    t.integer "position", default: 0, null: false
    t.integer "read_minutes", default: 3, null: false
    t.string "summary_en", null: false
    t.string "summary_th", null: false
    t.string "title_en", null: false
    t.string "title_th", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assessments", force: :cascade do |t|
    t.jsonb "answers", default: [], null: false
    t.datetime "completed_at", null: false
    t.datetime "created_at", null: false
    t.bigint "patient_id", null: false
    t.integer "score", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id", "completed_at"], name: "index_assessments_on_patient_id_and_completed_at"
    t.index ["patient_id"], name: "index_assessments_on_patient_id"
  end

  create_table "care_links", force: :cascade do |t|
    t.bigint "caretaker_id", null: false
    t.datetime "created_at", null: false
    t.bigint "patient_id", null: false
    t.string "relationship"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["caretaker_id"], name: "index_care_links_on_caretaker_id"
    t.index ["patient_id", "caretaker_id"], name: "index_care_links_on_patient_id_and_caretaker_id", unique: true
    t.index ["patient_id"], name: "index_care_links_on_patient_id"
  end

  create_table "daily_goal_completions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.boolean "exercise_done", default: false, null: false
    t.bigint "patient_id", null: false
    t.boolean "protein_done", default: false, null: false
    t.datetime "updated_at", null: false
    t.boolean "water_done", default: false, null: false
    t.index ["patient_id", "date"], name: "index_daily_goal_completions_on_patient_id_and_date", unique: true
    t.index ["patient_id"], name: "index_daily_goal_completions_on_patient_id"
  end

  create_table "exercise_logs", force: :cascade do |t|
    t.date "completed_on", null: false
    t.datetime "created_at", null: false
    t.bigint "exercise_id", null: false
    t.integer "minutes", null: false
    t.bigint "patient_id", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_logs_on_exercise_id"
    t.index ["patient_id", "completed_on"], name: "index_exercise_logs_on_patient_id_and_completed_on"
    t.index ["patient_id"], name: "index_exercise_logs_on_patient_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "default_minutes", null: false
    t.string "icon", null: false
    t.jsonb "instructions", default: [], null: false
    t.string "key", null: false
    t.string "name_en", null: false
    t.string "name_th", null: false
    t.datetime "updated_at", null: false
    t.string "video_id", null: false
    t.index ["key"], name: "index_exercises_on_key", unique: true
  end

  create_table "health_readings", force: :cascade do |t|
    t.decimal "calf_cm", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.decimal "height_cm", precision: 5, scale: 2
    t.bigint "patient_id", null: false
    t.date "recorded_on", null: false
    t.datetime "updated_at", null: false
    t.decimal "weight_kg", precision: 5, scale: 2
    t.index ["patient_id", "recorded_on"], name: "index_health_readings_on_patient_id_and_recorded_on", unique: true
    t.index ["patient_id"], name: "index_health_readings_on_patient_id"
  end

  create_table "meal_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "eaten_on", null: false
    t.bigint "meal_plan_meal_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_plan_meal_id"], name: "index_meal_logs_on_meal_plan_meal_id"
    t.index ["patient_id", "eaten_on"], name: "index_meal_logs_on_patient_id_and_eaten_on"
    t.index ["patient_id"], name: "index_meal_logs_on_patient_id"
  end

  create_table "meal_plan_days", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "day_number", null: false
    t.string "day_total_en", null: false
    t.string "day_total_th", null: false
    t.string "label_en", null: false
    t.string "label_th", null: false
    t.datetime "updated_at", null: false
    t.index ["day_number"], name: "index_meal_plan_days_on_day_number", unique: true
  end

  create_table "meal_plan_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "meal_plan_meal_id", null: false
    t.string "name_en", null: false
    t.string "name_th", null: false
    t.integer "position", default: 0, null: false
    t.string "protein_en", null: false
    t.string "protein_th", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_plan_meal_id"], name: "index_meal_plan_items_on_meal_plan_meal_id"
  end

  create_table "meal_plan_meals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "icon", null: false
    t.string "image"
    t.bigint "meal_plan_day_id", null: false
    t.integer "position", default: 0, null: false
    t.integer "slot", null: false
    t.string "title_en", null: false
    t.string "title_th", null: false
    t.string "total_protein_en", null: false
    t.string "total_protein_th", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_plan_day_id"], name: "index_meal_plan_meals_on_meal_plan_day_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true, null: false
    t.integer "kind", null: false
    t.bigint "patient_id", null: false
    t.time "time_of_day"
    t.datetime "updated_at", null: false
    t.index ["patient_id", "kind"], name: "index_reminders_on_patient_id_and_kind", unique: true
    t.index ["patient_id"], name: "index_reminders_on_patient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.string "email"
    t.string "full_name", null: false
    t.integer "gender"
    t.string "password_digest", null: false
    t.string "phone_number", null: false
    t.integer "role", default: 0, null: false
    t.jsonb "settings", default: {}, null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  add_foreign_key "assessments", "users", column: "patient_id"
  add_foreign_key "care_links", "users", column: "caretaker_id"
  add_foreign_key "care_links", "users", column: "patient_id"
  add_foreign_key "daily_goal_completions", "users", column: "patient_id"
  add_foreign_key "exercise_logs", "exercises"
  add_foreign_key "exercise_logs", "users", column: "patient_id"
  add_foreign_key "health_readings", "users", column: "patient_id"
  add_foreign_key "meal_logs", "meal_plan_meals"
  add_foreign_key "meal_logs", "users", column: "patient_id"
  add_foreign_key "meal_plan_items", "meal_plan_meals"
  add_foreign_key "meal_plan_meals", "meal_plan_days"
  add_foreign_key "reminders", "users", column: "patient_id"
end
