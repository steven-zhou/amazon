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


ActiveRecord::Schema.define(:version => 20090810040211) do



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
    t.integer  "address_type_id"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority_number"
  end

  create_table "amazon_settings", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.boolean  "status"
  end

  create_table "contact_meta_types", :force => true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_meta_type_id"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "monday_hours"
    t.string   "tuesday_hours"
    t.string   "wednesday_hours"
    t.string   "thursday_hours"
    t.string   "friday_hours"
    t.string   "saturday_hours"
    t.string   "sunday_hours"
    t.integer  "priority_number"
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

  create_table "employments", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organisation_id"
    t.integer  "sequence_no"
    t.string   "staff_reference"
    t.string   "department"
    t.string   "section"
    t.string   "position_reference"
    t.string   "position_name"
    t.string   "position_title"
    t.date     "commenced_date"
    t.float    "term_length"
    t.date     "term_end_date"
    t.string   "position_type"
    t.string   "position_status"
    t.string   "position_classification"
    t.string   "duties_resposibilities"
    t.integer  "hired_by"
    t.integer  "report_to"
    t.float    "weekly_nominal_hours"
    t.float    "hourly_rate"
    t.float    "annual_base_salary"
    t.string   "plus_package"
    t.string   "pay_cost_centre"
    t.string   "payment_frequency"
    t.string   "payment_method"
    t.string   "payment_day"
    t.string   "award_agreement"
    t.string   "award_other"
    t.date     "suspension_start_date"
    t.date     "suspension_end_date"
    t.integer  "suspended_by"
    t.string   "suspension_type"
    t.string   "suspension_reason"
    t.string   "suspension_remarks"
    t.date     "termination_notice_date"
    t.date     "termination_date"
    t.integer  "terminated_by"
    t.string   "termination_method"
    t.string   "termination_reason"
    t.string   "termination_remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
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

  create_table "master_doc_meta_meta_types", :force => true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "status"
  end

  create_table "master_doc_meta_types", :force => true do |t|
    t.text     "name"
    t.integer  "master_doc_meta_meta_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "status"
  end

  create_table "master_doc_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "master_doc_meta_type_id"
    t.text     "description"
    t.boolean  "status"
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
    t.integer  "priority_number"
    t.integer  "issue_country_id"
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

  create_table "organisation_hierarchies", :force => true do |t|
    t.integer  "hierarchy_level"
    t.text     "hierarchy_name"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisation_key_personnels", :force => true do |t|
    t.integer  "organisation_id"
    t.integer  "person_id"
    t.text     "designation"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisation_subsidiaries", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "organisation_id"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisations", :force => true do |t|
    t.text     "custom_id"
    t.text     "full_name"
    t.text     "short_name"
    t.text     "trading_as"
    t.text     "registered_name"
    t.text     "registered_number"
    t.date     "registered_date"
    t.integer  "registered_country_id"
    t.text     "organisation_type"
    t.text     "tax_file_no"
    t.text     "legal_no_1"
    t.text     "legal_no_2"
    t.text     "business_classification"
    t.text     "business_nature"
    t.text     "business_category"
    t.text     "business_sub_category"
    t.text     "industrial_sector"
    t.text     "industrial_code"
    t.integer  "number_of_full_time_employees"
    t.integer  "number_of_part_time_employees"
    t.integer  "number_of_contractors"
    t.integer  "number_of_volunteers"
    t.integer  "number_of_other_workers"
    t.text     "business_mission"
    t.integer  "organisation_hierarchy_id"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "custom_id"
    t.integer  "primary_title_id"
    t.integer  "second_title_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "family_name"
    t.string   "maiden_name"
    t.string   "preferred_name"
    t.string   "initials"
    t.string   "post_title"
    t.date     "birth_date"
    t.string   "primary_salutation"
    t.string   "second_salutation"
    t.integer  "industry_sector_id"
    t.string   "interests"
    t.integer  "origin_country_id"
    t.integer  "residence_country_id"
    t.integer  "nationality_id"
    t.integer  "other_nationality_id"
    t.integer  "language_id"
    t.integer  "other_language_id"
    t.integer  "religion_id"
    t.date     "onrecord_since"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "marital_status_id"
    t.integer  "gender_id"
  end

  create_table "person_roles", :force => true do |t|
    t.integer  "person_id"
    t.integer  "role_id"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sequence_no"
    t.integer  "assigned_by"
    t.integer  "approved_by"
    t.date     "assignment_date"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "supervised_by"
    t.integer  "managed_by"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "source_person_id"
    t.integer  "related_person_id"
    t.integer  "relationship_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_conditions", :force => true do |t|
    t.integer  "role_id"
    t.integer  "priority_number"
    t.integer  "doctype_id"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "role_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "remarks"
    t.boolean  "role_status"
  end

end
