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

ActiveRecord::Schema.define(version: 20150301015251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.boolean  "public",         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "avatars", force: true do |t|
    t.boolean  "processed",          default: false, null: false
    t.string   "direct_upload_url",                  null: false
    t.integer  "avatarable_id"
    t.string   "avatarable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "avatars", ["avatarable_id", "avatarable_type"], name: "index_avatars_on_avatarable_id_and_avatarable_type", using: :btree

  create_table "businesses", force: true do |t|
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
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_address"
    t.string   "phone_number"
    t.text     "about"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
  end

  add_index "businesses", ["authentication_token"], name: "index_businesses_on_authentication_token", using: :btree
  add_index "businesses", ["email"], name: "index_businesses_on_email", unique: true, using: :btree
  add_index "businesses", ["reset_password_token"], name: "index_businesses_on_reset_password_token", unique: true, using: :btree

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "deals", force: true do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "expires_at"
    t.text     "description"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deals", ["business_id"], name: "index_deals_on_business_id", using: :btree

  create_table "deals_users", force: true do |t|
    t.integer "deal_id"
    t.integer "user_id"
  end

  add_index "deals_users", ["deal_id", "user_id"], name: "index_deals_users_on_deal_id_and_user_id", using: :btree
  add_index "deals_users", ["user_id"], name: "index_deals_users_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "followships", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_followed_id"
    t.integer  "business_followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followships", ["business_followed_id"], name: "index_followships_on_business_followed_id", using: :btree
  add_index "followships", ["user_followed_id"], name: "index_followships_on_user_followed_id", using: :btree

  create_table "images", force: true do |t|
    t.boolean  "processed",          default: false, null: false
    t.string   "direct_upload_url",                  null: false
    t.text     "caption"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree

  create_table "loves", force: true do |t|
    t.integer  "loveable_id"
    t.string   "loveable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loves", ["loveable_id", "loveable_type"], name: "index_loves_on_loveable_id_and_loveable_type", using: :btree
  add_index "loves", ["user_id"], name: "index_loves_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.text     "body"
    t.integer  "postable_id"
    t.string   "postable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["postable_id", "postable_type"], name: "index_posts_on_postable_id_and_postable_type", using: :btree

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
    t.string   "authentication_token"
    t.string   "home_city"
    t.string   "name"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
