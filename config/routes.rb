ActionController::Routing::Routes.draw do |map|

  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  map.connect 'people/edit/', {:controller => 'people', :action => 'edit', :id => ' ' }
  map.connect 'organisations/edit/', {:controller => 'organisations', :action => 'edit', :id => ''}
  map.resources :addresses,  :member => {:search_postcodes => :get,:move_up_address_priority => :get,:move_down_address_priority => :get,:move_down_organisation_address_priority => :get, :move_up_organisation_address_priority => :get}, :collection => {:page_initial => :get}
  map.resources :master_docs, :member => {:move_down_master_doc_priority =>:get, :move_up_master_doc_priority => :get,:move_organisation_up_master_doc_priority=> :get, :move_organisation_down_master_doc_priority => :get}, :collection => {:page_initial => :get}
  map.resources :relationships, :collection => {:page_initial => :get}
  map.resources :notes, :member => {:note_update => :post}, :collection => {:page_initial => :get,:new_note_form =>:get}
  map.resources :person_roles,:collection => {:page_initial => :get}
  map.resources :employments, :member => {:move_down_employment_priority => :get,:move_up_employment_priority => :get},:collection => {:page_initial => :get}
  map.resources :person_groups,:collection => {:page_initial => :get}
  map.resources :person_bank_accounts , :member=> {:move_down_bank_account_priority =>:get,:move_up_bank_account_priority=>:get}, :collection => {:page_initial => :get}
  map.resources :organisation_bank_accounts , :member=> {:move_down_bank_account_priority =>:get,:move_up_bank_account_priority=>:get}, :collection => {:page_initial => :get}
  map.resources :organisation_relationships, :collection => {:page_initial => :get}
  map.resources :people, :shallow=> true, 
    :collection => {:find => :get, :search_lists => :get, :show_postcode => :get,:lookup_fill => :get,:lookup => :get,  :check_duplication =>:get ,:show_list_select => :get, :show_left => :get, :show_list => :get, :search => :post, :name_finder => :get, :role_finder => :get, :master_doc_meta_type_finder => :get, :master_doc_type_finder => :get, :login_id_finder => :get, :general_name_show => :get, :general_show_list => :get,:page_initial => :get,:change_status => :get},
    :member => {
    :edit_names => :post,
    :cancel_edit_names => :post,
    :name_card => :get,
    :postcode_look_up =>:get
   
    

  } do |person|
    person.resources :addresses, :member => {:set_primary_address => :post}
    person.resources :phones
    person.resources :faxes
    person.resources :websites
    person.resources :emails
    person.resources :instant_messagings
    person.resources :master_docs
    person.resources :images, :member => {:thumb => :get}
    person.resources :notes
    person.resources :person_groups, :collection => {:show_group_members => :get}
    person.resources :employments
    person.resources :person_roles
    person.resources :person_bank_accounts
    person.resources :relationships, :collection => {:remove_relation => :delete}
  end

  map.resources :people do |person|
    person.resources :roles, :collection => {:get_roles => :get, :person_role_des => :get}
  end

  map.resources :keyword_links, :collection => {:remove_key => :post, :add_key => :post}

  map.resources :organisations, :shallow=>true,
    :collection => {:find => :get,:check_level_change=>:get,:change_status => :get, :search => :post,:show_left => :get, :name_finder => :get, :show_industrial_code => :get, :show_sub_category => :get, :show_list => :get, :check_duplication => :get, :lookup => :get, :lookup_fill => :get, :general_show_list => :get, :org_general_name_show => :get},
    :member => {:name_card => :get} do |organisation|
    organisation.resources :addresses, :member => {:set_primary_address => :post}, :collection => {:search_postcodes => :get}
    organisation.resources :phones
    organisation.resources :faxes
    organisation.resources :websites
    organisation.resources :instant_messagings
    organisation.resources :emails
    organisation.resources :master_docs
    organisation.resources :images, :member => {:thumb => :get}
    organisation.resources :notes
    organisation.resources :organisation_bank_accounts
    organisation.resources :organisation_groups, :collection => {:show_group_members => :get}
    organisation.resources :organisation_relationships
  end


  map.resources :client_setups, :collection => {:parameters => :get, :license_info => :get, :client_organisation => :get, :installation => :get, :available_modules => :get, :super_admin => :get, :member_zone => :get, :system_log_management => :get, :search_system_log => :get, :system_log_verify_user_name => :get, :archive_system_log_entries => :get, :system_log_archive_verify_user_name => :get, :feedback_list => :get, :verify_new_person_bank_account_person_id => :get, :verify_edit_person_bank_account_person_id => :get,
    :client_bank_accounts => :get, :new_client_bank_account => :get, :create_client_bank_account => :post, :edit_client_bank_account => :get, :update_client_bank_account => :post, :destroy_client_bank_account => :get,
    :person_bank_accounts => :get, :new_person_bank_account => :get, :create_person_bank_account => :post, :edit_person_bank_account => :get, :update_person_bank_account => :post, :destroy_person_bank_account => :get

  }
  map.resources :contacts, :collection => {:page_initial => :get}
 
  map.resources :communication, :collection => { :email => :get, :create_email_template => :post, :refresh_template_message_select => :get, :send_email => :post, :search_email => :post, :show_email => :get, :modify_email => :post,
    :message_templates => :get, :new_message_template => :get, :create_message_template => :post, :edit_message_template => :get, :update_message_template => :post, :page_initial => :get, :template_page_initial => :get, :destroy_message_template => :delete,:retrieve_message_template => :get, :person_mail_merge => :get
  }

  map.resources :administrations, :collection => {:system_setting => :get, :keyword_dict => :get, :system_management => :get, :duplication_formula => :get, :system_data => :get, :custom_groups => :get, :query_tables => :get, :master_docs => :get, :role_conditions => :get, :roles_management => :get, :contact_types => :get, :access_permissions => :get, :group_permissions => :get, :group_lists => :get, :security_groups => :get, :user_accounts => :get, :user_groups => :get, :user_lists => :get, :duplication_check => :get }

  map.resources :amazon_settings, :member => {:retrieve => :get} ,:collection => {:data_list_finder => :get, :new_keyword => :get,:system_settings_finder => :get, :system_data_entry_finder => :get, :update_setting => :get, :new_setting => :get, :delete_system_data_entry => :get}
 

  map.resources :role_conditions, :collection => {:add_conditions => :post,:remove_conditions => :post, :role_condition_show_roles => :get, :condition_meta_type_finder => :get, :doc_type_finder => :get, :page_initial => :get, :condition_dictionary_page_initial => :get}


  map.resources :roles, :member => {:retrieve => :get}, :collection => {:show_roles => :get,:meta_name_finder => :get, :meta_type_name_finder => :get,:role_type_finder => :get, :page_initial => :get}


  map.resources :receipting, :collection => {:campaign_data => :get, :page_initial => :get, :new_campaign => :get, :create_campaign => :post, :edit_campaign => :get, :update_campaign => :post, :show_by_campaign => :get, :new_source => :get, :edit_source => :get, :update_source => :post, :copy_campaign => :get, :create_copy_of_campaign => :post, :destroy_campaign => :get, :destroy_source => :get, :receipt_accounts => :get, :receipt_methods => :get, :receipt_types => :get, :allocation_types => :get}

  map.resources :tag_settings, :collection => {:show_all_for_selected_classifier => :get}
  map.resources :tag_meta_types,:member => {:retrieve => :get}, :collection => {:show_group_types => :get, :create_access_permissions_meta_meta_type => :get, :access_permission_finder => :get}
  map.resources :group, :collection => {:show_group_types => :get}
  map.resources :tag_types,:member => {:retrieve => :get}, :collection => {:show_tag_types => :get, :show_fields => :get, :show_types => :get, :create_group_meta_type => :get, :custom_groups_finder => :get, :create_security_group_meta_type => :get, :security_groups_finder => :get, :create_query_table_meta_meta_type => :get, :query_tables_finder => :get, :delete_custom_group_type => :get, :show_receipt_type => :get}
  map.resources :tags, :member => {:retrieve => :get},:collection => {:show_tags => :get, :show_role_condition_description=>:get,:show_group_description => :get, :create_custom_sub_group => :get, :custom_sub_groups_finder => :get, :create_security_sub_group => :get, :security_sub_groups_finder => :get, :create_query_table_atttribute => :get, :query_table_attributes_finder => :get, :delete_custom_group => :get, :edit_custom_sub_group => :get}

  map.resources :query_headers, :shallow=> true, :collection => {:show_sql_statement => :get, :run => :get, :clear => :get, :check_runtime => :get, :copy_runtime => :get, :org_new => :get, :org_index => :get},
    :member => {:copy => :get, :query_header_to_xml => :get} do |query_header|
    query_header.resources :query_selections
    query_header.resources :query_sorters
    query_header.resources :query_criterias
  end

  map.resources :login_accounts, :collection => {:user_name_unique => :get, :generate_password => :post, :change_password => :get, :update_password => :post}
  map.resources :user_groups, :collection => {:add_security => :post, :remove_security => :post, :show_groups => :get, :user_name_to_person => :get, :general_show_all_objects => :get, :mutiple_create => :post}

  map.resources :list_headers, :collection => {:add_merge => :post, :add_exclude => :post, :manage_list => :get, :compile_list => :get, :org_manage_list => :get, :org_compile_list => :get}, :member => {:copy => :get, :delete_details => :put}
  map.resources :list_details
  map.resources :include_lists
  map.resources :exclude_lists
  map.resources :compile_lists, :collection => {:clear => :post, :compile => :post,:org_compile =>:post}

  map.resources :group_lists, :collection => {:show_list_des => :get}

  map.resources :group_permissions, :collection => {:show_add_container => :get, :show_module => :get, :show_controllers => :get, :show_methods => :get}

  map.resources :receipt_accounts, :collection => {:new_receipt_account => :get, :create_receipt_account => :post, :edit_receipt_account => :get, :update_receipt_account => :post, :copy_receipt_account => :get, :create_copy_of_receipt_account => :post, :destroy_receipt_account => :get, :copy => :get, :retrieve_receipt_account => :get}

  map.resources :receipt_methods, :collection => {:new_receipt_method => :get, :create_receipt_method => :post, :edit_receipt_method => :get, :update_receipt_method => :post, :copy_receipt_method => :get, :create_copy_of_receipt_method => :post, :destroy_receipt_method => :get }
    
  map.resources :reports, :collection => {:generate_report => :post, :generate_organisation_report_pdf => :get,:generate_person_report_pdf=>:get,:preview_report => :post, :person_contacts_report_grid => :get,:organisation_contacts_report_grid => :get, :generate_system_log_pdf => :post, :page_initial => :get}

  map.resources :personal_duplication_formulas, :collection => {:set_default => :get, :generate => :get, :change_status => :get}
  map.resources :organisational_duplication_formulas, :collection => {:set_default => :get, :generate => :get}
  map.resources :duplication_formula_details

  
  map.resources :grids, :member => {:people_search_grid => :get, :query_result_grid => :get, :list_edit_grid => :get, 
    :list_compile_grid => :get,:show_person_lookup_grid =>:get,:show_postcode_grid => :get,:organisation_search_grid => :get, :duplication_organisations_grid => :get, :show_campaigns_grid => :get, :show_sources_by_campaign_grid => :get, :show_receipt_accounts_grid => :get,:show_allocation_types_grid => :get, :show_receipt_methods_grid => :get, :show_client_bank_accounts_grid => :get, :show_person_bank_accounts_grid => :get,
    :show_other_group_organisations_grid => :get, :show_organisation_contacts_report_grid=>:get,:show_person_contacts_report_grid => :get,:show_other_member_grid => :get, :organisation_employee_grid => :get}
                                       
  map.resources :phones, :member => {:move_down_phone_priority =>:get,:move_up_phone_priority =>:get,:move_organisation_down_phone_priority=>:get,:move_organisation_up_phone_priority => :get}
  map.resources :emails, :member => {:move_down_email_priority =>:get, :move_up_email_priority => :get,:move_organisation_up_email_priority=> :get, :move_organisation_down_email_priority=> :get}
  map.resources :websites, :member => {:move_down_website_priority =>:get, :move_up_website_priority => :get,:move_organisation_down_website_priority=>:get, :move_organisation_up_website_priority => :get}
  map.resources :instant_messagings, :resourcemember => {:move_down_instant_messaging_priority =>:get, :move_up_instant_messaging_priority => :get,:move_organisation_down_instant_messaging_priority=>:get, :move_organisation_up_instant_messaging_priority => :get}
  
 
  map.resources :data_managers, :collection => {:import_index => :get, :export_index => :get, :export => :get, :page_initial => :get}
  map.resources :user_lists, :collection => {:show_list_des => :get}
  map.resources :dashboards, :collection => {:check_password => :get, :update_password => :post, :save_dashboard => :get}
  map.resources :system_news, :member => {:switch => :get}, :collection => {:pre_three => :get, :next_three => :get}
  map.resources :to_do_lists, :member => {:switch => :get}
  

  map.resources :keywords , :member => {:retrieve => :get},:collection => {:keywords_finder => :get,:check_destroy => :get, :keyword_name_show => :get, :keyword_des_show => :get, :page_initial => :get}


  map.resources :module, :collection => {:core => :get, :membership => :get, :fundraising => :get, :case_management => :get, :administration => :get, :dashboard => :get, :client_setup => :get, :receipting => :get}
  map.resources :available_modules, :collection => {:switch_status => :get}

  map.resources :post_areas, :collection => {:select_ajax_show => :get}
  map.resources :countries, :collection => {:show_countries => :get, :select_renew => :get, :page_initial => :get}
  map.resources :postcodes, :collection => {:show_by_country => :get}
  map.resources :languages, :collection => {:show_languages => :get}
  map.resources :banks, :collection => {:list=>:get,:name_finder => :get,:lookup=>:get,:lookup_fill => :get,:refresh_existing_banks=>:get,:delete_bank_entry=>:get,:edit_bank_entry=>:get}
  map.resources :religions
  map.resources :allocation_types, :collection => {:new_allocation_type => :get, :create_allocation_type => :post, :edit_allocation_type => :get, :update_allocation_type => :post, :copy_allocation_type => :get, :create_copy_of_allocation_type => :post, :destroy_allocation_type => :get }
 
  map.resources :transactions, :collection => {:personal_transaction => :get, :organisational_transaction => :get, :show_personal_transaction => :get, :show_organisational_transaction => :get, :bank_run => :get, :enquiry => :get}

  map.resources :transaction_headers, :collection => {:page_initial => :get, :export_histroy_to_report => :get,:enquiry_show_receipt_type => :get}
  map.resources :transaction_allocations, :collection => {:temp_create => :post}, :member => {:temp_edit => :get, :temp_update => :put}
  map.resources :person_bank_accounts , :member=> {:move_down_bank_account_priority =>:get,:move_up_bank_account_priority=>:get}
  map.resources :organisation_bank_accounts , :member=> {:move_down_bank_account_priority =>:get,:move_up_bank_account_priority=>:get}, :collection => {:page_initial => :get}
  #nightly processes for testing only
  map.resources :nightly_processes, :collection => {:run => :get}
  map.resources :quick_launch_icons,:collection => {:check => :get}
  map.resources :user_preferences,:collection => {:change_email => :put,:show_modify_my_account => :get,:change_password => :put,:change_security_question =>:put, :show_whoami => :get}
  map.resources :message_templates, :collection => {:page_initial => :get}
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

  map.connect '/', {:controller => "signin", :action => "login" }
  map.welcome 'welcome', :controller => "module", :action => "dashboard"    # After a user is logged in this is where they are sent to
  map.login 'login', :controller => "signin", :action => "login"       # This should be the page a user logs in at
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'


end
