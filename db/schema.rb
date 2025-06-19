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

ActiveRecord::Schema[8.0].define(version: 2025_06_19_180000) do
  create_table "account_contacts", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "contact_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "contact_account_id"], name: "index_account_contacts_on_account_id_and_contact_account_id", unique: true
    t.index ["account_id"], name: "index_account_contacts_on_account_id"
    t.index ["contact_account_id"], name: "index_account_contacts_on_contact_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cvu", null: false
    t.string "alias"
    t.integer "total_balance"
    t.date "creation_date"
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "no_card"
    t.integer "account_holder_id"
    t.integer "cvv"
    t.string "creation_date"
    t.string "exp_date"
    t.string "holder_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_holder_id"], name: "index_cards_on_account_holder_id"
  end

  create_table "payed_services", force: :cascade do |t|
    t.integer "service_id", null: false
    t.integer "account_id", null: false
    t.date "pay_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payed_services_on_account_id"
    t.index ["service_id"], name: "index_payed_services_on_service_id"
  end

  create_table "pigs", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "name_pig", null: false
    t.integer "total_balance"
    t.date "creation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_pigs_on_account_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name_service", null: false
    t.integer "monthly_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "no_operation", null: false
    t.integer "source_account_id", null: false
    t.integer "target_account_id"
    t.integer "value"
    t.date "date"
    t.integer "transaction_type", default: 0, null: false
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_account_id"], name: "index_transactions_on_source_account_id"
    t.index ["target_account_id"], name: "index_transactions_on_target_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "dni"
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "tel"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "account_contacts", "accounts"
  add_foreign_key "account_contacts", "accounts", column: "contact_account_id"
  add_foreign_key "accounts", "users"
  add_foreign_key "cards", "accounts", column: "account_holder_id"
  add_foreign_key "payed_services", "accounts"
  add_foreign_key "payed_services", "services"
  add_foreign_key "pigs", "accounts"
  add_foreign_key "transactions", "accounts", column: "source_account_id"
  add_foreign_key "transactions", "accounts", column: "target_account_id"
end
