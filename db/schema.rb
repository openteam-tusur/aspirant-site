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

ActiveRecord::Schema.define(version: 20160718052419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adverts", force: :cascade do |t|
    t.string   "science_degree"
    t.integer  "council_speciality_id"
    t.integer  "dissertation_council_id"
    t.date     "placement_date"
    t.string   "place"
    t.date     "publication_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "title"
  end

  add_index "adverts", ["council_speciality_id"], name: "index_adverts_on_council_speciality_id", using: :btree
  add_index "adverts", ["dissertation_council_id"], name: "index_adverts_on_dissertation_council_id", using: :btree

  create_table "council_specialities", force: :cascade do |t|
    t.string   "code"
    t.string   "title"
    t.string   "science_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "council_specialities_dissertation_councils", force: :cascade do |t|
    t.integer "dissertation_council_id"
    t.integer "council_speciality_id"
    t.integer "row_order"
  end

  create_table "dissertation_councils", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "dissertation_councils", ["slug"], name: "index_dissertation_councils_on_slug", unique: true, using: :btree

  create_table "file_copies", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.date     "placement_date"
    t.string   "kind"
    t.integer  "context_id"
    t.string   "context_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.string   "science_degree"
    t.string   "science_title"
    t.integer  "council_speciality_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "science_degree_abbr"
    t.string   "science_title_abbr"
    t.text     "work_place"
    t.text     "work_post"
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "role"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "context_id"
    t.string   "context_type"
    t.integer  "person_id"
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "row_order"
    t.string   "person_type"
  end

  add_foreign_key "adverts", "council_specialities"
  add_foreign_key "adverts", "dissertation_councils"
end
