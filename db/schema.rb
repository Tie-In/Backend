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

ActiveRecord::Schema.define(version: 20170123104329) do

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
  end

  add_index "projects", ["environmental_factor_id"], name: "index_projects_on_environmental_factor_id", using: :btree
  add_index "projects", ["organization_id"], name: "index_projects_on_organization_id", using: :btree
  add_index "projects", ["technical_factor_id"], name: "index_projects_on_technical_factor_id", using: :btree

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
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "user_organizations", ["organization_id"], name: "index_user_organizations_on_organization_id", using: :btree
  add_index "user_organizations", ["user_id"], name: "index_user_organizations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username"
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
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "effort_estimations", "projects"
  add_foreign_key "environmental_factors", "effort_estimations"
  add_foreign_key "features", "projects"
  add_foreign_key "project_contributes", "projects"
  add_foreign_key "project_contributes", "users"
  add_foreign_key "projects", "environmental_factors"
  add_foreign_key "projects", "organizations"
  add_foreign_key "projects", "technical_factors"
  add_foreign_key "technical_factors", "effort_estimations"
  add_foreign_key "user_organizations", "organizations"
  add_foreign_key "user_organizations", "users"
end
