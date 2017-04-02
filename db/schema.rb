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

ActiveRecord::Schema.define(version: 20170402040307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "effort_estimations", force: :cascade do |t|
    t.integer  "project_id"
    t.decimal  "t_factor"
    t.decimal  "e_factor"
    t.decimal  "uucp"
    t.decimal  "use_case_point"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "developers"
    t.decimal  "lower_weeks"
    t.decimal  "upper_weeks"
  end

  add_index "effort_estimations", ["project_id"], name: "index_effort_estimations_on_project_id", using: :btree

  create_table "environmental_factors", force: :cascade do |t|
    t.integer  "effort_estimation_id"
    t.integer  "rating_factor1"
    t.integer  "rating_factor2"
    t.integer  "rating_factor3"
    t.integer  "rating_factor4"
    t.integer  "rating_factor5"
    t.integer  "rating_factor6"
    t.integer  "rating_factor7"
    t.integer  "rating_factor8"
    t.decimal  "e_factor"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "environmental_factors", ["effort_estimation_id"], name: "index_environmental_factors_on_effort_estimation_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "description", default: ""
    t.integer  "complexity"
    t.integer  "project_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "features", ["project_id"], name: "index_features_on_project_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "description", default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "project_contributes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "permission_level"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "project_contributes", ["project_id"], name: "index_project_contributes_on_project_id", using: :btree
  add_index "project_contributes", ["user_id"], name: "index_project_contributes_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",                                      null: false
    t.string   "description",             default: ""
    t.integer  "sprint_duration"
    t.integer  "organization_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "status",                  default: "start"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "technical_factor_id"
    t.integer  "environmental_factor_id"
    t.integer  "current_sprint_id"
  end

  add_index "projects", ["environmental_factor_id"], name: "index_projects_on_environmental_factor_id", using: :btree
  add_index "projects", ["organization_id"], name: "index_projects_on_organization_id", using: :btree
  add_index "projects", ["technical_factor_id"], name: "index_projects_on_technical_factor_id", using: :btree

  create_table "retrospectives", force: :cascade do |t|
    t.integer "number"
    t.integer "sprint_id"
    t.integer "project_id"
  end

  add_index "retrospectives", ["project_id"], name: "index_retrospectives_on_project_id", using: :btree
  add_index "retrospectives", ["sprint_id"], name: "index_retrospectives_on_sprint_id", using: :btree

  create_table "sprints", force: :cascade do |t|
    t.integer  "number"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "project_id"
    t.integer  "sprint_points"
    t.integer  "maximum_points"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "sprints", ["project_id"], name: "index_sprints_on_project_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string  "name"
    t.integer "project_id"
    t.integer "column_index"
  end

  add_index "statuses", ["project_id"], name: "index_statuses_on_project_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "project_id"
    t.string  "color"
  end

  add_index "tags", ["project_id"], name: "index_tags_on_project_id", using: :btree

  create_table "task_tags", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "task_tags", ["tag_id"], name: "index_task_tags_on_tag_id", using: :btree
  add_index "task_tags", ["task_id"], name: "index_task_tags_on_task_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "story_point"
    t.integer  "sprint_id"
    t.integer  "feature_id"
    t.decimal  "estimate_time"
    t.decimal  "actual_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "assignee_id"
    t.integer  "project_id"
    t.integer  "status_id"
    t.integer  "row_index"
  end

  add_index "tasks", ["feature_id"], name: "index_tasks_on_feature_id", using: :btree
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["sprint_id"], name: "index_tasks_on_sprint_id", using: :btree
  add_index "tasks", ["status_id"], name: "index_tasks_on_status_id", using: :btree

  create_table "technical_factors", force: :cascade do |t|
    t.integer  "effort_estimation_id"
    t.integer  "rating_factor1"
    t.integer  "rating_factor2"
    t.integer  "rating_factor3"
    t.integer  "rating_factor4"
    t.integer  "rating_factor5"
    t.integer  "rating_factor6"
    t.integer  "rating_factor7"
    t.integer  "rating_factor8"
    t.integer  "rating_factor9"
    t.integer  "rating_factor10"
    t.integer  "rating_factor11"
    t.integer  "rating_factor12"
    t.integer  "rating_factor13"
    t.decimal  "t_factor"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "technical_factors", ["effort_estimation_id"], name: "index_technical_factors_on_effort_estimation_id", using: :btree

  create_table "user_organizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "permission_level"
  end

  add_index "user_organizations", ["organization_id"], name: "index_user_organizations_on_organization_id", using: :btree
  add_index "user_organizations", ["user_id"], name: "index_user_organizations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                               null: false
    t.string   "username",                            null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token",             default: ""
    t.string   "firstname",                           null: false
    t.string   "lastname",                            null: false
    t.date     "birth_date"
    t.string   "phone_number",                        null: false
    t.string   "image"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "viewpoint_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "retrospective_id"
    t.string   "color"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "viewpoint_categories", ["retrospective_id"], name: "index_viewpoint_categories_on_retrospective_id", using: :btree

  create_table "viewpoints", force: :cascade do |t|
    t.string   "comment"
    t.integer  "retrospective_id"
    t.integer  "user_id"
    t.integer  "type"
    t.boolean  "selected"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "viewpoint_categories_id"
  end

  add_index "viewpoints", ["retrospective_id"], name: "index_viewpoints_on_retrospective_id", using: :btree
  add_index "viewpoints", ["user_id"], name: "index_viewpoints_on_user_id", using: :btree
  add_index "viewpoints", ["viewpoint_categories_id"], name: "index_viewpoints_on_viewpoint_categories_id", using: :btree

  add_foreign_key "effort_estimations", "projects"
  add_foreign_key "environmental_factors", "effort_estimations"
  add_foreign_key "features", "projects"
  add_foreign_key "project_contributes", "projects"
  add_foreign_key "project_contributes", "users"
  add_foreign_key "projects", "environmental_factors"
  add_foreign_key "projects", "organizations"
  add_foreign_key "projects", "technical_factors"
  add_foreign_key "retrospectives", "projects"
  add_foreign_key "retrospectives", "sprints"
  add_foreign_key "sprints", "projects"
  add_foreign_key "statuses", "projects"
  add_foreign_key "tags", "projects"
  add_foreign_key "task_tags", "tags"
  add_foreign_key "task_tags", "tasks"
  add_foreign_key "tasks", "features"
  add_foreign_key "tasks", "sprints"
  add_foreign_key "technical_factors", "effort_estimations"
  add_foreign_key "user_organizations", "organizations"
  add_foreign_key "user_organizations", "users"
  add_foreign_key "viewpoint_categories", "retrospectives"
  add_foreign_key "viewpoints", "retrospectives"
  add_foreign_key "viewpoints", "users"
end
