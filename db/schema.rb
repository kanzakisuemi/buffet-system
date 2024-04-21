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

ActiveRecord::Schema[7.0].define(version: 2024_04_19_220430) do
  create_table "buffet_payments", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_buffet_payments_on_buffet_id"
    t.index ["payment_method_id"], name: "index_buffet_payments_on_payment_method_id"
  end

  create_table "buffets", force: :cascade do |t|
    t.string "social_name"
    t.string "corporate_name"
    t.string "company_registration_number"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.text "description"
  end

  create_table "event_types", force: :cascade do |t|
    t.integer "category"
    t.string "name"
    t.text "description"
    t.integer "minimal_people_capacity"
    t.integer "maximal_people_capacity"
    t.integer "default_duration_minutes"
    t.text "food_menu"
    t.boolean "alcoholic_drinks"
    t.boolean "decoration"
    t.boolean "parking_service"
    t.boolean "location_flexibility"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_event_types_on_buffet_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "buffet_payments", "buffets"
  add_foreign_key "buffet_payments", "payment_methods"
  add_foreign_key "buffets", "users"
  add_foreign_key "event_types", "buffets"
end
