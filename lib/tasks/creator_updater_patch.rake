# To change this template, choose Tools | Templates
# and open the template in the editor.

namespace :db do
  desc "add creator_id and updater_id to all the tables which already have records"
  task :creator_updater_patch => :environment do
    puts "Run creator_updater_patch..."
    @tablesArray = Array[
      "addresses", "allocation_types", "amazon_settings", "available_modules",
      "bank_accounts", "bank_grids", "bank_run_report_details","bank_run_reports", "bank_runs", "banks", "bulk_emails",
      "campaigns", "client_setups", "compile_lists", "contacts", "countries",
      "dashboard_preferences","duplication_formula_details", "duplication_formulas",
      "employments",
      "feedback_items",
      "grids", "group_lists", "group_permissions", "groups",
      "helps",
      "images",
      "keyword_links","keywords",
      "list_details", "list_headers", "login_accounts",
      "master_docs", "message_templates",
      "notes",
      "organisation_groups", "organisation_hierarchies","organisation_key_personnels", "organisation_relationships", "organisations",
      "people", "person_bank_accounts", "person_groups", "person_roles","post_areas", "postcodes", "potential_members",
      "query_criterias", "query_details", "query_headers", "quick_launch_icons",
      "receipt_accounts", "receipt_methods","relationships", "role_conditions", "roles",
      "sources", "system_logs", "system_news",
      "tag_meta_types", "tag_types","tags", "to_do_lists", "transaction_allocations", "transaction_headers", "transaction_type_details",
      "user_groups", "user_lists"
    ]

    @tablesArray.each do |table|
      puts "Patch #{table.camelize} ..."
      table.singularize.camelize.constantize.all.each do |i|
        i.creator_id = 1 if i.creator_id.nil?
        i.updater_id = 1 if i.updater_id.nil?
        i.save!
      end
    end
  end
end