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

ActiveRecord::Schema.define(:version => 20120618190659) do

  create_table "guests", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "authentication_token"
  end

  add_index "guests", ["id"], :name => "index_guests_on_id"

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "room_id"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.string   "message_type"
    t.text     "metadata"
  end

  add_index "messages", ["id"], :name => "index_messages_on_id"
  add_index "messages", ["room_id", "user_id"], :name => "index_messages_on_room_id_and_user_id"
  add_index "messages", ["room_id"], :name => "index_messages_on_room_id"
  add_index "messages", ["user_id", "room_id"], :name => "index_messages_on_user_id_and_room_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "status",     :default => "Pending"
    t.integer  "guest_id"
  end

  add_index "rooms", ["guest_id"], :name => "index_rooms_on_guest_id"
  add_index "rooms", ["id"], :name => "index_rooms_on_id"
  add_index "rooms", ["status"], :name => "index_rooms_on_status"

end
