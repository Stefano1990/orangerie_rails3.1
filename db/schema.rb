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

ActiveRecord::Schema.define(:version => 20110730171413) do

  create_table "activities", :force => true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read",       :default => false
  end

  add_index "activities", ["item_id"], :name => "index_activities_on_item_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "admins", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "albums", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cover_id"
  end

  add_index "albums", ["user_id"], :name => "index_albums_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "chatmessages", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "body"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "flagged"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "communications", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "parent_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "sender_deleted_at"
    t.datetime "sender_read_at"
    t.datetime "recipient_deleted_at"
    t.datetime "recipient_read_at"
    t.datetime "replied_at"
    t.string   "type"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "communications", ["recipient_id"], :name => "index_communications_on_recipient_id"
  add_index "communications", ["sender_id"], :name => "index_communications_on_sender_id"
  add_index "communications", ["type"], :name => "index_communications_on_type"

  create_table "connections", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.integer  "status"
    t.datetime "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "sender_deleted_at"
    t.datetime "recipient_deleted_at"
  end

  create_table "event_photos", :force => true do |t|
    t.integer  "event_id"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "short_description"
    t.text     "long_description"
    t.boolean  "has_comments"
    t.datetime "date"
    t.integer  "price_male"
    t.integer  "price_female"
    t.integer  "price_couple"
    t.integer  "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "series_id"
    t.boolean  "is_review"
  end

  create_table "flags", :force => true do |t|
    t.integer  "flaggable_id"
    t.string   "flaggable_type"
    t.integer  "user_id"
    t.boolean  "deleted",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flags", ["flaggable_id"], :name => "index_flags_on_flaggable_id"
  add_index "flags", ["user_id"], :name => "index_flags_on_user_id"

  create_table "guestbook_messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "answer_user_id"
    t.text     "answer_body"
    t.datetime "answered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infos", :force => true do |t|
    t.integer  "user_id"
    t.string   "sex"
    t.integer  "age_m"
    t.integer  "weight_m"
    t.integer  "height_m"
    t.string   "hair_color_m"
    t.string   "eye_color_m"
    t.string   "appearance_m"
    t.string   "bi_tendency_m"
    t.string   "sex_tend_m"
    t.boolean  "smoking_m"
    t.integer  "age_f"
    t.integer  "weight_f"
    t.integer  "height_f"
    t.string   "hair_color_f"
    t.string   "eye_color_f"
    t.string   "appearance_f"
    t.string   "bi_tendency_f"
    t.string   "sex_tend_f"
    t.boolean  "smoking_f"
    t.string   "region"
    t.string   "mobility"
    t.text     "about_us"
    t.text     "for_text"
    t.text     "like"
    t.text     "dislike"
    t.text     "looking_for"
    t.text     "to_do"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "infos", ["user_id"], :name => "index_infos_on_user_id"

  create_table "invites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.boolean  "wall_publish"
    t.text     "body"
    t.integer  "invitable_id"
    t.string   "invitable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "livestreams", :force => true do |t|
    t.integer "user_id"
    t.integer "activity_id"
  end

  add_index "livestreams", ["activity_id"], :name => "index_livestreams_on_activity_id"
  add_index "livestreams", ["user_id"], :name => "index_livestreams_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "conversation_id"
    t.string   "subject"
    t.text     "content"
    t.integer  "parent_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "sender_deleted_at"
    t.datetime "sender_read_at"
    t.datetime "recipient_deleted_at"
    t.datetime "recipient_read_at"
    t.datetime "replied_at"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "read_at"
    t.integer  "contact_id"
  end

  add_index "notifications", ["item_id"], :name => "index_notifications_on_item_id"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "page_photos", :force => true do |t|
    t.integer  "page_id"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "content"
    t.boolean  "is_commentable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "lang"
    t.integer  "position",       :default => 0
  end

  create_table "photos", :force => true do |t|
    t.integer  "album_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["album_id"], :name => "index_photos_on_album_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "wall_id"
    t.text     "body"
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"
  add_index "posts", ["wall_id"], :name => "index_posts_on_wall_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "sex"
    t.integer  "age_m"
    t.integer  "weight_m"
    t.integer  "height_m"
    t.string   "hair_color_m"
    t.string   "eye_color_m"
    t.string   "appearance_m"
    t.string   "bi_tendency_m"
    t.string   "sex_tend_m"
    t.boolean  "smoking_m"
    t.integer  "age_f"
    t.integer  "weight_f"
    t.integer  "height_f"
    t.string   "hair_color_f"
    t.string   "eye_color_f"
    t.string   "appearance_f"
    t.string   "bi_tendency_f"
    t.string   "sex_tend_f"
    t.boolean  "smoking_f"
    t.string   "region"
    t.string   "mobility"
    t.text     "about_us"
    t.text     "for_text"
    t.text     "like"
    t.text     "dislike"
    t.text     "looking_for"
    t.text     "to_do"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "reservations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "guests_male",   :default => 0
    t.integer  "guests_female", :default => 0
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "trusted",                             :default => false
    t.integer  "avatar_id"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wall_items", :force => true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
