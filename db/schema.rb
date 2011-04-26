# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100804162345) do

  create_table "articles", :force => true do |t|
    t.string   "sysname",                                 :null => false
    t.string   "title",                                   :null => false
    t.string   "custom_author",        :default => ""
    t.string   "custom_author_link",   :default => ""
    t.string   "photographer",         :default => ""
    t.string   "photographer_link",    :default => ""
    t.string   "source",               :default => ""
    t.string   "source_link",          :default => ""
    t.text     "content",                                 :null => false
    t.text     "description"
    t.text     "internal_comment"
    t.text     "meta_keywords"
    t.text     "meta_description"
    t.integer  "user_id",                                 :null => false
    t.integer  "style_id"
    t.integer  "category_id"
    t.integer  "views_count",          :default => 0
    t.integer  "importance",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",            :default => false
    t.boolean  "draft",                :default => true
    t.datetime "publish_date"
    t.string   "imagebh_file_name"
    t.string   "imagebh_content_type"
    t.integer  "imagebh_file_size"
    t.datetime "imagebh_updated_at"
    t.string   "imagebv_file_name"
    t.string   "imagebv_content_type"
    t.integer  "imagebv_file_size"
    t.datetime "imagebv_updated_at"
    t.string   "imagemh_file_name"
    t.string   "imagemh_content_type"
    t.integer  "imagemh_file_size"
    t.datetime "imagemh_updated_at"
    t.string   "imagemv_file_name"
    t.string   "imagemv_content_type"
    t.integer  "imagemv_file_size"
    t.datetime "imagemv_updated_at"
    t.string   "imagemm_file_name"
    t.string   "imagemm_content_type"
    t.integer  "imagemm_file_size"
    t.datetime "imagemm_updated_at"
  end

  create_table "assigments", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "sysname",                                 :null => false
    t.string   "name",                                    :null => false
    t.boolean  "public",               :default => false, :null => false
    t.text     "description",                             :null => false
    t.integer  "user_id"
    t.string   "custom_author",        :default => ""
    t.string   "custom_author_link",   :default => ""
    t.string   "photographer",         :default => ""
    t.string   "photographer_link",    :default => ""
    t.string   "imagemh_file_name"
    t.string   "imagemh_content_type"
    t.integer  "imagemh_file_size"
    t.datetime "imagemh_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    :default => 0, :null => false
  end

  create_table "events", :force => true do |t|
    t.datetime "date",                        :null => false
    t.string   "title",      :default => "",  :null => false
    t.text     "text",                        :null => false
    t.string   "artist",                      :null => false
    t.string   "city",       :default => "",  :null => false
    t.float    "price",      :default => 0.0, :null => false
    t.string   "club",       :default => "",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
  end

  create_table "roles", :force => true do |t|
    t.string   "sysname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "styles", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "template",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "nick"
    t.integer  "age"
    t.string   "fname"
    t.string   "lname"
    t.string   "sname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "about",                              :null => false
    t.datetime "birthday"
    t.string   "gender"
    t.string   "city"
  end

end
