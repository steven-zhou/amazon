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

ActiveRecord::Schema.define(:version => 20090723001304) do

  create_table "address_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.string   "building_name"
    t.string   "suite_unit"
    t.string   "street_number"
    t.string   "street_name"
    t.string   "town"
    t.string   "state"
    t.string   "district"
    t.string   "region"
    t.integer  "country_id"
    t.string   "postal_code"
    t.string   "time_zone"
    t.string   "map_reference"
    t.string   "bar_code"
    t.boolean  "priority"
    t.integer  "address_type_id"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_types", :force => true do |t|
    t.string   "name"
    t.string   "metatype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "pre_value"
    t.string   "value"
    t.string   "post_value"
    t.string   "preferred_time"
    t.string   "preferred_day"
    t.string   "remarks"
    t.string   "type"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.integer  "contact_type_id"
    t.boolean  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "monday_hours"
    t.string   "tuesday_hours"
    t.string   "wednesday_hours"
    t.string   "thursday_hours"
    t.string   "friday_hours"
    t.string   "saturday_hours"
    t.string   "sunday_hours"
  end

  create_table "countries", :force => true do |t|
    t.string   "long_name"
    t.string   "short_name"
    t.string   "citizenship"
    t.string   "capital"
    t.string   "iso_code"
    t.string   "currency"
    t.string   "currency_subunit"
    t.integer  "main_language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.binary   "image_file_data"
    t.string   "image_filename"
    t.integer  "image_width"
    t.integer  "image_height"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keyword_links", :force => true do |t|
    t.integer  "keyword_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keyword_types", :force => true do |t|
    t.string   "name"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.string   "remarks"
    t.integer  "keyword_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "master_doc_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "master_docs", :force => true do |t|
    t.string   "doc_number"
    t.string   "doc_reference"
    t.string   "security_number"
    t.string   "category"
    t.string   "long_name"
    t.string   "short_name"
    t.string   "name_on_doc"
    t.string   "other_on_doc"
    t.string   "issue_person"
    t.string   "issue_organisation"
    t.string   "issue_place"
    t.string   "issue_state"
    t.string   "issue_country"
    t.string   "action_taken"
    t.string   "remarks"
    t.date     "issue_date"
    t.date     "expiry_date"
    t.boolean  "reminder"
    t.integer  "master_doc_type_id"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "note_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.string   "label"
    t.string   "short_description"
    t.date     "alarm_date"
    t.time     "alarm_time"
    t.boolean  "active"
    t.string   "body_text"
    t.integer  "noteable_id"
    t.string   "noteable_type"
    t.integer  "note_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "custom_id"
    t.integer  "title_id"
    t.integer  "second_title_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "family_name"
    t.string   "maiden_name"
    t.string   "preferred_name"
    t.string   "initials"
    t.string   "post_title"
    t.string   "gender"
    t.string   "marital_status"
    t.date     "birth_date"
    t.string   "primary_salutation"
    t.string   "second_salutation"
    t.integer  "industry_sector"
    t.string   "interests"
    t.integer  "origin_country_id"
    t.integer  "residence_country_id"
    t.integer  "nationality_id"
    t.integer  "other_nationality_id"
    t.integer  "language_id"
    t.integer  "other_language_id"
    t.integer  "religion_id"
    t.string   "view_name"
    t.date     "onrecord_since"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_roles", :force => true do |t|
    t.integer  "person_id"
    t.integer  "role_id"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationship_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "source_person_id"
    t.integer  "related_person_id"
    t.integer  "relationship_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "religions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "role_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "title_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles", :force => true do |t|
    t.string   "name"
    t.integer  "title_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
