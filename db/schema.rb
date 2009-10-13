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

ActiveRecord::Schema.define(:version => 20091012061523) do

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

  create_table "compile_lists", :force => true do |t|
    t.integer  "login_account_id"
    t.integer  "list_header_id"
    t.string   "type"
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
    t.integer  "contact_meta_type_id"
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

  create_table "duplication_formula_details", :force => true do |t|
    t.integer  "duplication_formula_id"
    t.string   "table_name"
    t.string   "field_name"
    t.integer  "number_of_charecter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_foreign_key"
  end

  create_table "duplication_formulas", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "duplication_space"
    t.string   "type"
    t.string   "group"
  end

  create_table "employments", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organisation_id"
    t.integer  "sequence_no"
    t.string   "staff_reference"
    t.string   "position_reference"
    t.string   "position_name"
    t.date     "commenced_date"
    t.float    "term_length"
    t.date     "term_end_date"
    t.string   "duties_resposibilities"
    t.integer  "hired_by"
    t.integer  "report_to"
    t.float    "weekly_nominal_hours"
    t.float    "hourly_rate"
    t.float    "annual_base_salary"
    t.string   "plus_package"
    t.string   "award_other"
    t.date     "suspension_start_date"
    t.date     "suspension_end_date"
    t.integer  "suspended_by"
    t.string   "suspension_reason"
    t.string   "suspension_remarks"
    t.date     "termination_notice_date"
    t.date     "termination_date"
    t.integer  "terminated_by"
    t.string   "termination_reason"
    t.string   "termination_remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
    t.integer  "department_id"
    t.integer  "section_id"
    t.integer  "cost_centre_id"
    t.integer  "position_title_id"
    t.integer  "position_classification_id"
    t.integer  "position_type_id"
    t.integer  "award_agreement_id"
    t.integer  "position_status_id"
    t.integer  "payment_frequency_id"
    t.integer  "payment_method_id"
    t.integer  "payment_day_id"
    t.integer  "suspension_type_id"
    t.integer  "termination_method_id"
  end

  create_table "group_lists", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "list_header_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_permissions", :force => true do |t|
    t.integer "system_permission_type_id"
    t.integer "user_group_id"
  end

  create_table "groups", :force => true do |t|
    t.integer  "tags_id"
    t.string   "name"
    t.string   "description"
    t.boolean  "status"
    t.integer  "group_owner"
    t.date     "start_date"
    t.date     "end_date"
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

  create_table "list_details", :force => true do |t|
    t.integer  "list_header_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_headers", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.integer  "list_size"
    t.date     "last_date_generated"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.string   "source_type"
    t.boolean  "allow_duplication"
    t.string   "top_type"
    t.integer  "top_value"
  end

  create_table "login_accounts", :force => true do |t|
    t.integer  "person_id"
    t.text     "user_name"
    t.text     "password_hash"
    t.text     "password_salt"
    t.text     "security_email"
    t.text     "password_hint"
    t.text     "question1_answer"
    t.text     "question2_answer"
    t.text     "question3_answer"
    t.text     "password_last_hash"
    t.text     "password_last_salt"
    t.date     "password_last_date"
    t.datetime "last_login"
    t.datetime "last_logoff"
    t.text     "last_ip_address"
    t.integer  "session_timeout"
    t.text     "authentication_token"
    t.integer  "authentication_grace_period"
    t.boolean  "login_status"
    t.boolean  "system_user"
    t.integer  "security_question1_id"
    t.integer  "security_question2_id"
    t.integer  "security_question3_id"
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
    t.text     "tax_file_no"
    t.text     "legal_no_1"
    t.text     "legal_no_2"
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
    t.integer  "organisation_type_id"
    t.integer  "business_type_id"
    t.integer  "industry_sector_id"
    t.integer  "business_category_id"
    t.date     "onrecord_since"
    t.string   "business_sub_category"
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
    t.string   "duplication_value"
  end

  create_table "person_groups", :force => true do |t|
    t.integer  "people_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "postcodes", :force => true do |t|
    t.integer "country_id"
    t.text    "type"
    t.text    "governance"
    t.text    "province"
    t.text    "state"
    t.text    "county"
    t.text    "region"
    t.text    "district"
    t.text    "zone"
    t.text    "city"
    t.text    "town"
    t.text    "suburb"
    t.text    "electoral_area"
    t.text    "postcode"
    t.text    "mail_code"
    t.text    "bulk_code"
    t.integer "geographical_area_id"
  end

  create_table "query_criterias", :force => true do |t|
    t.integer "query_header_id"
    t.integer "sequence"
    t.string  "table_name"
    t.string  "field_name"
    t.string  "data_type"
    t.string  "operator"
    t.string  "option"
    t.string  "value"
    t.boolean "status"
  end

  create_table "query_details", :force => true do |t|
    t.integer "query_header_id"
    t.integer "sequence"
    t.string  "table_name"
    t.string  "field_name"
    t.boolean "status"
    t.string  "type"
    t.boolean "ascending"
    t.string  "data_type"
  end

  create_table "query_headers", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "last_date_executed"
    t.integer  "result_size"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "top_value"
    t.string   "top_type"
    t.boolean  "allow_duplication"
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

  create_table "tag_meta_types", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "position"
    t.boolean  "status"
    t.text     "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "tag_types", :force => true do |t|
    t.text     "name"
    t.integer  "tag_meta_type_id"
    t.text     "description"
    t.integer  "position"
    t.boolean  "status"
    t.text     "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "tags", :force => true do |t|
    t.text     "name"
    t.integer  "tag_type_id"
    t.text     "description"
    t.integer  "position"
    t.boolean  "status"
    t.text     "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "user_groups", :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "user_lists", :force => true do |t|
    t.integer "user_id"
    t.integer "list_header_id"
  end

end
