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

ActiveRecord::Schema[8.0].define(version: 2025_05_14_190224) do
  create_table "Card", force: :cascade do |t|
    t.integer "nro_cuenta"
    t.integer "cvv"
    t.string "fecha_creacion"
    t.string "fecha_vto"
    t.string "nombre_titular"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", id: false, force: :cascade do |t|
    t.integer "cvu", null: false
    t.string "alias"
    t.decimal "saldo_total", precision: 10, scale: 2
    t.date "fecha_creacion"
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "nom_service"
    t.decimal "monto_mensual", precision: 10, scale: 2
    t.date "fecha_pago"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", id: false, force: :cascade do |t|
    t.integer "num_operation", null: false
    t.date "date"
    t.integer "transaction_type", default: 0, null: false
    t.decimal "value", precision: 10, scale: 2
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end
end
