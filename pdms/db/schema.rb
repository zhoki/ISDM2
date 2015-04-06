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

ActiveRecord::Schema.define(version: 20150331132625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "document_templates", force: true do |t|
    t.string   "name"
    t.string   "template_file_name"
    t.string   "template_content_type"
    t.integer  "template_file_size"
    t.datetime "template_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uploadedBy"
    t.integer  "user_id"
  end

  create_table "documents", force: true do |t|
    t.integer  "project_id"
    t.integer  "document_template_id"
    t.string   "docFile_file_name"
    t.string   "docFile_content_type"
    t.integer  "docFile_file_size"
    t.datetime "docFile_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "documents", ["document_template_id"], name: "index_documents_on_document_template_id", using: :btree
  add_index "documents", ["project_id"], name: "index_documents_on_project_id", using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "pmbok_processes", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pmbok_workflows", force: true do |t|
    t.integer  "pmbok_process_id"
    t.integer  "document_template_id"
    t.string   "doctype",              limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pmbok_workflows", ["document_template_id"], name: "index_pmbok_workflows_on_document_template_id", using: :btree
  add_index "pmbok_workflows", ["pmbok_process_id", "document_template_id"], name: "unique_workflow", unique: true, using: :btree
  add_index "pmbok_workflows", ["pmbok_process_id"], name: "index_pmbok_workflows_on_pmbok_process_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pm"
    t.date     "startDate"
    t.date     "dueDate"
  end

  create_table "projects_users", id: false, force: true do |t|
    t.integer "project_id", null: false
    t.integer "user_id",    null: false
  end

  add_index "projects_users", ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id", unique: true, using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "task_statuses", ["name"], name: "index_task_statuses_on_name", unique: true, using: :btree

  create_table "tasks", force: true do |t|
    t.date     "assignedOn"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "approver_id"
    t.integer  "assignee_id"
    t.integer  "document_template_id"
    t.string   "remarks"
    t.integer  "task_status_id",       default: 1
  end

  add_index "tasks", ["approver_id"], name: "index_tasks_on_approver_id", using: :btree
  add_index "tasks", ["assignee_id"], name: "index_tasks_on_assignee_id", using: :btree
  add_index "tasks", ["document_template_id"], name: "index_tasks_on_document_template_id", using: :btree
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["task_status_id"], name: "index_tasks_on_task_status_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstName"
    t.string   "lastName"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
