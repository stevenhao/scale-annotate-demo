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

ActiveRecord::Schema.define(version: 20160919194006) do

  create_table "annotation_requests", id: nil, force: :cascade do |t|
    t.text     "labels"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "task_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["id"], name: "sqlite_autoindex_annotation_requests_1", unique: true
    t.index ["task_id"], name: "index_annotation_requests_on_task_id"
  end

  create_table "annotation_responses", force: :cascade do |t|
    t.integer  "annotation_request_id"
    t.text     "api_response"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["annotation_request_id"], name: "index_annotation_responses_on_annotation_request_id"
  end

end
