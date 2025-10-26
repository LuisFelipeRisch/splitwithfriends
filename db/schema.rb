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

ActiveRecord::Schema[8.0].define(version: 2025_10_25_220758) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.bigint "payer_id", null: false
    t.bigint "group_id", null: false
    t.integer "category", null: false
    t.decimal "paid_value", precision: 10, scale: 2, null: false
    t.date "date", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_balances", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.decimal "total_paid_value", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "balance", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "lock_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "user_id", "month", "year"], name: "idx_on_group_id_user_id_month_year_aa9ba3e16a", unique: true
  end

  create_table "group_invitations", force: :cascade do |t|
    t.string "email_address", null: false
    t.integer "status", default: 0, null: false
    t.bigint "group_id", null: false
    t.bigint "inviter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address", "group_id"], name: "index_group_invitations_on_email_address_and_group_id", unique: true
    t.index ["email_address"], name: "index_group_invitations_on_email_address"
    t.index ["group_id"], name: "index_group_invitations_on_group_id"
    t.index ["inviter_id"], name: "index_group_invitations_on_inviter_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id", "group_id"], name: "index_memberships_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "expenses", "groups"
  add_foreign_key "expenses", "users", column: "payer_id"
  add_foreign_key "group_balances", "groups"
  add_foreign_key "group_balances", "users"
  add_foreign_key "group_invitations", "groups"
  add_foreign_key "group_invitations", "users", column: "inviter_id"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "sessions", "users"
end
