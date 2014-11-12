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

ActiveRecord::Schema.define(version: 1) do

  create_table "shrew_page_views", force: true do |t|
    t.integer "user_id"
    t.string  "controller"
    t.string  "action"
    t.string  "path"
    t.integer "status"
    t.integer "start_time"
    t.integer "duration"
    t.float   "view_runtime"
    t.float   "db_runtime"
    t.integer "sent_time"
    t.integer "js_return_time"
    t.binary  "js_tracking_id", limit: 16
  end

  add_index "shrew_page_views", ["js_tracking_id"], name: "index_shrew_page_views_on_js_tracking_id"
  add_index "shrew_page_views", ["user_id"], name: "index_shrew_page_views_on_user_id"

end
