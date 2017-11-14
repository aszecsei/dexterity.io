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

ActiveRecord::Schema.define(version: 20171114233241) do

  create_table "assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "issue_id"
    t.index ["issue_id"], name: "index_assignments_on_issue_id"
    t.index ["user_id", "issue_id"], name: "index_assignments_on_user_id_and_issue_id", unique: true
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "blockages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "issue_id"
    t.integer "blocked_issue_id"
    t.index ["blocked_issue_id"], name: "index_blockages_on_blocked_issue_id"
    t.index ["issue_id", "blocked_issue_id"], name: "index_blockages_on_issue_id_and_blocked_issue_id", unique: true
    t.index ["issue_id"], name: "index_blockages_on_issue_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_categories_on_project_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "status_id", null: false
    t.integer "category_id", null: false
    t.integer "project_id", null: false
    t.integer "created_by_id", null: false
    t.string "estimated_time"
    t.integer "story_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "next_id"
    t.boolean "first"
    t.index ["category_id"], name: "index_issues_on_category_id"
    t.index ["created_by_id"], name: "index_issues_on_created_by_id"
    t.index ["first"], name: "index_issues_on_first"
    t.index ["next_id"], name: "index_issues_on_next_id"
    t.index ["project_id"], name: "index_issues_on_project_id"
    t.index ["status_id"], name: "index_issues_on_status_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.integer "project_id", null: false
    t.boolean "add_issues", default: false
    t.boolean "close_issues", default: false
    t.boolean "assign_issues", default: false
    t.boolean "edit_project", default: false
    t.boolean "delete_project", default: false
    t.boolean "add_project_members", default: false
    t.boolean "remove_project_members", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_roles_on_project_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "category", default: "To Do", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_statuses_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "displayName"
    t.string "password_digest"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workingons", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_workingons_on_project_id"
    t.index ["role_id"], name: "index_workingons_on_role_id"
    t.index ["user_id"], name: "index_workingons_on_user_id"
  end

end
