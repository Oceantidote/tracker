# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_18_115241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activity_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "task_id"
    t.bigint "list_id"
    t.string "action"
    t.bigint "period_id"
    t.bigint "invoice_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_activity_logs_on_invoice_id"
    t.index ["list_id"], name: "index_activity_logs_on_list_id"
    t.index ["period_id"], name: "index_activity_logs_on_period_id"
    t.index ["task_id"], name: "index_activity_logs_on_task_id"
    t.index ["user_id"], name: "index_activity_logs_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_documents_on_project_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved", default: false
    t.boolean "paid", default: false
    t.float "total"
    t.datetime "paid_at"
    t.datetime "due_by", default: "2020-09-10 15:23:10"
    t.datetime "issued_at"
    t.index ["project_id"], name: "index_invoices_on_project_id"
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "payment_type"
    t.string "description"
    t.index ["project_id"], name: "index_lists_on_project_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "noteable_type"
    t.bigint "noteable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["noteable_type", "noteable_id"], name: "index_notes_on_noteable_type_and_noteable_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "periods", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "end_note"
    t.integer "price"
    t.integer "length", default: 0
    t.boolean "faulty", default: false
    t.boolean "completed", default: false
    t.index ["task_id"], name: "index_periods_on_task_id"
    t.index ["user_id"], name: "index_periods_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "archived", default: false
    t.bigint "dev_user_id"
    t.index ["dev_user_id"], name: "index_projects_on_dev_user_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.integer "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "list_id", null: false
    t.string "status", default: "pending"
    t.string "rejected_reason"
    t.index ["list_id"], name: "index_quotes_on_list_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "approved"
    t.integer "price"
    t.datetime "completed_by"
    t.boolean "completed", default: false
    t.integer "length"
    t.datetime "completed_at"
    t.boolean "faulty", default: false
    t.bigint "invoice_id"
    t.bigint "quote_id"
    t.index ["invoice_id"], name: "index_tasks_on_invoice_id"
    t.index ["list_id"], name: "index_tasks_on_list_id"
    t.index ["quote_id"], name: "index_tasks_on_quote_id"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "relation"
    t.string "email"
    t.integer "priority"
    t.index ["project_id"], name: "index_team_memberships_on_project_id"
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "user_tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_user_tasks_on_task_id"
    t.index ["user_id"], name: "index_user_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "position"
    t.integer "hourly_rate", default: 40
    t.string "color"
    t.boolean "accepts_terms", default: false
    t.boolean "accepts_promise", default: false
    t.string "source"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activity_logs", "invoices"
  add_foreign_key "activity_logs", "lists"
  add_foreign_key "activity_logs", "periods"
  add_foreign_key "activity_logs", "tasks"
  add_foreign_key "activity_logs", "users"
  add_foreign_key "documents", "projects"
  add_foreign_key "invoices", "projects"
  add_foreign_key "lists", "projects"
  add_foreign_key "notes", "users"
  add_foreign_key "periods", "tasks"
  add_foreign_key "periods", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "projects", "users", column: "dev_user_id"
  add_foreign_key "quotes", "lists"
  add_foreign_key "tasks", "invoices"
  add_foreign_key "tasks", "lists"
  add_foreign_key "team_memberships", "projects"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "user_tasks", "tasks"
  add_foreign_key "user_tasks", "users"
end
