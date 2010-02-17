#all the tables are added two new columns
#creator_id: for store who create this record
#updater_id: for store who update this record
#order of the add_coloumn commands are following the order of tables under pgadmin3, this is just for easy to check
class AddUserstamps < ActiveRecord::Migration
  @tablesArray = Array[
    "addresses", "allocation_types", "amazon_settings", "available_modules",
    "bank_accounts", "bank_grids", "bank_run_details", "bank_run_report_details","bank_run_reports", "bank_runs", "banks","bulk_emails",
    "campaigns", "client_setups", "compile_lists", "contacts", "countries",
    "dashboard_preferences","duplication_formula_details", "duplication_formulas",
    "employments",
    "feedback_items",
    "grids", "group_lists", "group_permissions", "groups",
    "helps",
    "images",
    "keyword_links","keywords",
    "languages", "list_details", "list_headers", "login_accounts",
    "master_docs", "message_templates",
    "notes",
    "organisation_groups", "organisation_hierarchies","organisation_key_personnels", "organisation_relationships", "organisation_subsidiaries", "organisations",
    "people", "person_bank_accounts", "person_groups", "person_roles","post_areas", "postcodes", "potential_members",
    "query_criterias", "query_details", "query_headers", "quick_launch_icons",
    "receipt_accounts", "receipt_methods","relationships", "role_conditions", "roles",
    "schema_migrations", "simple_captcha_data", "sources", "system_logs", "system_news",
    "tag_meta_types", "tag_types","tags", "to_do_lists", "transaction_allocations", "transaction_headers", "transaction_type_details",
    "user_groups", "user_lists"
  ]

  def self.up
    @tablesArray.each do |table|
      add_column table.to_sym, :creator_id, :integer
      add_column table.to_sym, :updater_id, :integer
    end
  end

  def self.down
    @tablesArray.each do |table|
      remove_column table.to_sym, :creator_id, :updater_id
    end
  end
end
