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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120615193914) do

  create_table "interests", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "interests_projects", :id => false, :force => true do |t|
    t.integer "interest_id"
    t.integer "project_id"
  end

  create_table "project_to_interest_associations", :force => true do |t|
    t.integer  "project_id"
    t.integer  "interest_id"
    t.integer  "skill_required"
    t.string   "comment"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "tagline"
    t.string   "description"
    t.integer  "skill_id"
    t.string   "repository"
    t.string   "visibility"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "owner"
  end

  create_table "ratings", :force => true do |t|
    t.string   "user_id"
    t.string   "project_id"
    t.integer  "code_quality"
    t.integer  "effort"
    t.integer  "communication_skills"
    t.string   "code_quality_just"
    t.string   "effort_just"
    t.string   "communication_skills_just"
    t.string   "general"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "ratings", ["project_id", "created_at"], :name => "index_ratings_on_project_id_and_created_at"
  add_index "ratings", ["user_id", "created_at"], :name => "index_ratings_on_user_id_and_created_at"
  add_index "ratings", ["user_id", "project_id"], :name => "index_ratings_on_user_id_and_project_id"

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "surname"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "pseudonym"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["pseudonym"], :name => "index_users_on_pseudonym", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
