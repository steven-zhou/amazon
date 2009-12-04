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

ActiveRecord::Schema.define(:version => 20091203235117) do

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

  create_table "allocation_types", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "link_module_id"
    t.boolean  "post_to_history"
    t.boolean  "post_to_campaign"
    t.boolean  "send_receipt"
    t.boolean  "status"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "link_module_name"
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

  create_table "available_modules", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bank_accounts", :force => true do |t|
    t.integer "bank_id"
    t.text    "account_number"
    t.integer "account_purpose_id"
    t.boolean "status"
    t.text    "remarks"
    t.integer "entity_id"
    t.text    "type"
    t.integer "account_type_id"
    t.integer "priority_number"
  end

  create_table "bank_grids", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banks", :force => true do |t|
    t.text     "full_name"
    t.text     "short_name"
    t.text     "branch_name"
    t.text     "branch_number"
    t.text     "address_line_1"
    t.text     "address_line_2"
    t.text     "address_line_3"
    t.text     "state"
    t.text     "postcode"
    t.integer  "country_id"
    t.text     "website"
    t.text     "general_email"
    t.text     "contact_person"
    t.text     "contact_person_job_title"
    t.text     "contact_person_email"
    t.text     "contact_phone"
    t.text     "contact_fax"
    t.text     "contact_mobile"
    t.boolean  "status"
    t.text     "status_reason"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bdrb_job_queues", :force => true do |t|
    t.text     "args"
    t.string   "worker_name"
    t.string   "worker_method"
    t.string   "job_key"
    t.integer  "taken"
    t.integer  "finished"
    t.integer  "timeout"
    t.integer  "priority"
    t.datetime "submitted_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "archived_at"
    t.string   "tag"
    t.string   "submitter_info"
    t.string   "runner_info"
    t.string   "worker_key"
    t.datetime "scheduled_at"
  end

  create_table "campaigns", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "target_amount"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "status"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_setups", :force => true do |t|
    t.integer  "organisation_id"
    t.string   "client_id"
    t.string   "client_rego"
    t.date     "installation_date"
    t.date     "halt_date"
    t.boolean  "system_status"
    t.string   "modules_installed"
    t.string   "system_type"
    t.string   "system_purchase"
    t.integer  "maximum_core_records"
    t.string   "hosting_status"
    t.integer  "number_of_users"
    t.integer  "number_of_login_attempts"
    t.integer  "new_account_graceperiod"
    t.integer  "session_timeout"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "password_lifetime"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "primary_phone_number"
    t.string   "secondary_phone_number"
    t.string   "primary_email_address"
    t.string   "secondary_email_address"
    t.string   "login_name"
    t.string   "account_id"
    t.string   "pin"
    t.datetime "last_login"
    t.datetime "last_logoff"
    t.text     "last_ip_address"
    t.text     "member_zone_power_password_hash"
    t.text     "member_zone_power_password_salt"
    t.text     "super_admin_power_password_hash"
    t.text     "super_admin_power_password_salt"
    t.string   "superadmin_message"
    t.string   "feedback_to"
    t.string   "reply_from"
    t.integer  "home_country_id"
    t.text     "level_0_label"
    t.text     "level_0_remarks"
    t.text     "level_1_label"
    t.text     "level_1_remarks"
    t.text     "level_2_label"
    t.text     "level_2_remarks"
    t.text     "level_3_label"
    t.text     "level_3_remarks"
    t.text     "level_4_label"
    t.text     "level_4_remarks"
    t.text     "level_5_label"
    t.text     "level_5_remarks"
    t.text     "level_6_label"
    t.text     "level_6_remarks"
    t.text     "level_7_label"
    t.text     "level_7_remarks"
    t.text     "level_8_label"
    t.text     "level_8_remarks"
    t.text     "level_9_label"
    t.text     "level_9_remarks"
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
    t.string   "dialup_code"
    t.string   "govenment_language"
  end

  create_table "dashboard_preferences", :force => true do |t|
    t.integer "login_account_id"
    t.integer "column_id"
    t.integer "box_id"
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
    t.boolean  "status"
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

  create_table "feedback_items", :force => true do |t|
    t.integer  "login_account_id"
    t.text     "subject"
    t.text     "content"
    t.text     "ip_address"
    t.text     "status"
    t.datetime "feedback_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "response"
    t.datetime "response_date"
    t.integer  "responded_to_by_id"
  end

  create_table "grids", :force => true do |t|
    t.integer "login_account_id"
    t.integer "grid_object_id"
    t.string  "type"
    t.text    "field_1"
    t.text    "field_2"
    t.text    "field_3"
    t.text    "field_4"
    t.text    "field_5"
    t.text    "field_6"
    t.text    "field_7"
    t.text    "field_8"
    t.text    "field_9"
    t.text    "field_10"
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
    t.integer  "keyword_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
    t.string   "description"
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
    t.integer  "login_account_id"
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
    t.text     "access_attempt_ip"
    t.integer  "access_attempts_count"
    t.boolean  "password_by_admin"
    t.integer  "password_lifetime"
    t.string   "type"
    t.datetime "password_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "online_status"
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

  create_table "organisation_groups", :force => true do |t|
    t.integer  "organisation_id"
    t.integer  "tag_id"
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
    t.string   "duplication_value"
    t.string   "type"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "level"
    t.string   "level_label"
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

  create_table "person_bank_accounts", :force => true do |t|
    t.integer "person_id"
    t.integer "bank_id"
    t.text    "account_number"
    t.integer "account_type_id"
    t.boolean "status"
    t.text    "remarks"
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

  create_table "post_areas", :force => true do |t|
    t.integer  "country_id"
    t.string   "division_name"
    t.string   "remarks"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country_name"
  end

  create_table "postcodes", :force => true do |t|
    t.integer "country_id"
    t.text    "governance"
    t.text    "province"
    t.text    "state"
    t.text    "region"
    t.text    "district"
    t.text    "zone"
    t.text    "city"
    t.text    "town"
    t.text    "suburb"
    t.text    "postcode"
    t.text    "mail_code"
    t.text    "bulk_code"
    t.integer "geographical_area_id"
    t.integer "electoral_area_id"
    t.text    "geo_area"
    t.text    "elec_area"
    t.text    "country_name"
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

  create_table "receipt_accounts", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.boolean  "post_to_history"
    t.boolean  "post_to_campaign"
    t.boolean  "send_receipt"
    t.boolean  "status"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "link_module_id"
    t.text     "link_module_name"
  end

  create_table "receipt_methods", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "receipt_method_type_id"
    t.boolean  "status"
    t.text     "remarks"
    t.text     "card_merchant_number"
    t.text     "card_name"
    t.text     "card_location"
    t.text     "card_cost"
    t.text     "card_floor_limit"
    t.integer  "card_lines_per_page"
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

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.integer  "campaign_id"
    t.text     "name"
    t.text     "description"
    t.integer  "volume"
    t.text     "cost"
    t.integer  "dead_return"
    t.integer  "letter_id"
    t.integer  "account_code_id"
    t.boolean  "status"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_logs", :force => true do |t|
    t.integer  "login_account_id"
    t.text     "message"
    t.text     "controller"
    t.text     "action"
    t.text     "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "status"
  end

  create_table "system_news", :force => true do |t|
    t.text     "description"
    t.datetime "event_date"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.boolean  "status"
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

  create_table "to_do_lists", :force => true do |t|
    t.text     "description"
    t.string   "status"
    t.datetime "due_date"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "login_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_allocations", :force => true do |t|
    t.integer  "transaction_header_id"
    t.integer  "receipt_account_id"
    t.integer  "campaign_id"
    t.integer  "source_id"
    t.decimal  "amount",                :precision => 11, :scale => 3
    t.integer  "letter_id"
    t.boolean  "letter_sent"
    t.date     "date_sent"
    t.integer  "extention_id"
    t.string   "extention_type"
    t.integer  "cluster_id"
    t.string   "cluster_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_headers", :force => true do |t|
    t.integer  "entity_id"
    t.string   "entity_type"
    t.date     "todays_date"
    t.date     "transaction_date"
    t.integer  "receipt_meta_type_id"
    t.string   "receipt_meta_type_name"
    t.integer  "receipt_type_id"
    t.string   "receipt_type_name"
    t.integer  "bank_account_id"
    t.string   "bank_account_name"
    t.integer  "bank_run_id"
    t.integer  "receipt_number"
    t.integer  "letter_id"
    t.boolean  "letter_sent"
    t.date     "date_sent"
    t.decimal  "total_amount",           :precision => 11, :scale => 3
    t.text     "notes"
    t.integer  "received_via_id"
    t.string   "received_via_name"
    t.boolean  "banked"
    t.datetime "created_at"
    t.datetime "updated_at"
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
