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

ActiveRecord::Schema[7.0].define(version: 2024_05_13_224319) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.integer "events_per_day", default: 1
    t.boolean "archived", default: false
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
    t.decimal "base_price", precision: 8, scale: 2
    t.integer "weekend_fee"
    t.decimal "per_person_fee", precision: 8, scale: 2
    t.integer "per_person_weekend_fee"
    t.decimal "per_hour_fee", precision: 8, scale: 2
    t.integer "per_hour_weekend_fee"
    t.boolean "archived", default: false
    t.index ["buffet_id"], name: "index_event_types_on_buffet_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "order_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_messages_on_order_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "event_type_id", null: false
    t.integer "user_id", null: false
    t.date "event_date"
    t.integer "guests_estimation"
    t.text "event_details"
    t.text "event_address"
    t.integer "status", default: 0
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_method_id"
    t.boolean "grant_discount", default: false
    t.boolean "charge_fee", default: false
    t.decimal "extra_fee", precision: 8, scale: 2
    t.decimal "discount", precision: 8, scale: 2
    t.text "budget_details"
    t.decimal "budget", precision: 8, scale: 2
    t.date "due_date"
    t.index ["event_type_id"], name: "index_orders_on_event_type_id"
    t.index ["payment_method_id"], name: "index_orders_on_payment_method_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "social_security_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "buffet_payments", "buffets"
  add_foreign_key "buffet_payments", "payment_methods"
  add_foreign_key "buffets", "users"
  add_foreign_key "event_types", "buffets"
  add_foreign_key "messages", "orders"
  add_foreign_key "messages", "users"
  add_foreign_key "orders", "event_types"
  add_foreign_key "orders", "payment_methods"
  add_foreign_key "orders", "users"
end
