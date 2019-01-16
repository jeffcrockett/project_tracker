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

ActiveRecord::Schema.define(version: 2019_01_14_205915) do

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "distributors", force: :cascade do |t|
    t.string "name"
    t.integer "discount"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_distributors_on_name", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "cogs", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "confidence"
    t.integer "distributor_id"
    t.string "rep"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "application"
    t.integer "company_id"
    t.index ["company_id", "name"], name: "index_projects_on_company_id_and_name", unique: true
    t.index ["distributor_id"], name: "index_projects_on_distributor_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "project_id"
    t.date "expiration"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact"
    t.index ["project_id"], name: "index_registrations_on_project_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "project_id"
    t.integer "product_id"
    t.integer "quantity"
    t.decimal "cable_length", precision: 5, scale: 1
    t.decimal "price", precision: 10, scale: 2
    t.date "date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_shipments_on_product_id"
    t.index ["project_id"], name: "index_shipments_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.boolean "admin"
    t.boolean "exec"
    t.date "start_date"
    t.date "end_date"
    t.integer "min_confidence"
    t.integer "max_confidence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end