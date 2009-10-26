ActionController::Routing::Routes.draw do |map|

  map.connect 'people/edit/', {:controller => 'people', :action => 'edit', :id => ' ' }
  map.connect 'organisations/edit/', {:controller => 'organisations', :action => 'edit', :id => ''}

  map.resources :people, :shallow=> true, 
    :collection => {:find => :get, :search_lists => :get, :show_postcode => :get,:lookup_fill => :get,:lookup => :get,  :check_duplication =>:get ,:show_list_select => :get, :show_left => :get, :show_list => :get, :search => :post, :name_finder => :get, :role_finder => :get, :master_doc_meta_type_finder => :get, :master_doc_type_finder => :get, :login_id_finder => :get},
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
    person.resources :master_docs
    person.resources :images, :member => {:thumb => :get}
    person.resources :notes
    person.resources :person_groups, :collection => {:show_group_members => :get}
    person.resources :employments
    person.resources :person_roles
    person.resources :relationships, :collection => {:remove_relation => :delete}
  end

  map.resources :people do |person|
    person.resources :roles, :collection => {:get_roles => :get, :person_role_des => :get}
  end

  map.resources :keyword_links, :collection => {:remove_key => :post, :add_key => :post}

  map.resources :organisations, :shallow=>true,
    :collection => {:find => :get, :search => :post,:show_left => :get, :name_finder => :get, :show_industrial_code => :get, :show_sub_category => :get, :show_list => :get, :check_duplication => :get, :lookup => :get, :lookup_fill => :get},
    :member => {:add_keywords => :post, :remove_keywords => :post, :name_card => :get} do |organisation|
    organisation.resources :addresses, :member => {:set_primary_address => :post}, :collection => {:search_postcodes => :get}
    organisation.resources :phones
    organisation.resources :faxes
    organisation.resources :websites
    organisation.resources :emails
    organisation.resources :master_docs
    organisation.resources :images, :member => {:thumb => :get}
    organisation.resources :notes
    organisation.resources :organisation_groups, :collection => {:show_group_members => :get}
  end

  map.resources :administrations, :collection => {:system_setting => :get, :system_management => :get, :duplication_formula => :get, :system_data => :get, :custom_groups => :get, :query_tables => :get, :master_docs => :get, :role_conditions => :get, :roles_management => :get, :contact_types => :get, :access_permissions => :get, :group_permissions => :get, :group_lists => :get, :security_groups => :get, :user_accounts => :get, :user_groups => :get, :user_lists => :get, :duplication_check => :get }

  map.resources :amazon_settings, :collection => {:data_list_finder => :get, :system_settings_finder => :get, :system_data_entry_finder => :get, :update_setting => :get, :new_setting => :get, :delete_system_data_entry => :get}
 

  map.resources :role_conditions, :collection => {:add_conditions => :post,:remove_conditions => :post, :role_condition_show_roles => :get, :condition_meta_type_finder => :get, :doc_type_finder => :get}


  map.resources :roles, :collection => {:show_roles => :get,:meta_name_finder => :get, :meta_type_name_finder => :get,:role_type_finder => :get}


  map.resources :tag_settings, :collection => {:show_all_for_selected_classifier => :get}
  map.resources :tag_meta_types, :collection => {:show_group_types => :get, :create_access_permissions_meta_meta_type => :get, :access_permission_finder => :get}
  map.resources :group, :collection => {:show_group_types => :get}
  map.resources :tag_types, :collection => {:show_tag_types => :get, :show_fields => :get, :show_types => :get, :create_group_meta_type => :get, :custom_groups_finder => :get, :create_security_group_meta_type => :get, :security_groups_finder => :get, :create_query_table_meta_meta_type => :get, :query_tables_finder => :get, :delete_custom_group_type => :get}
  map.resources :tags, :collection => {:show_tags => :get, :show_group_description => :get, :create_custom_sub_group => :get, :custom_sub_groups_finder => :get, :create_security_sub_group => :get, :security_sub_groups_finder => :get, :create_query_table_atttribute => :get, :query_table_attributes_finder => :get, :delete_custom_group => :get, :edit_custom_sub_group => :get}

  map.resources :query_headers, :shallow=> true, :collection => {:show_sql_statement => :get, :run => :get, :clear => :get, :check_runtime => :get, :copy_runtime => :get},
    :member => {:copy => :get, :query_header_to_xml => :get} do |query_header|
    query_header.resources :query_selections
    query_header.resources :query_sorters
    query_header.resources :query_criterias
  end

  map.resources :login_accounts, :collection => {:user_name_unique => :get}
  map.resources :user_groups, :collection => {:add_security => :post, :remove_security => :post, :show_groups => :get, :user_name_to_person => :get}

  map.resources :list_headers, :collection => {:add_merge => :post, :add_exclude => :post, :manage_list => :get, :compile_list => :get}, :member => {:copy => :get, :delete_details => :put}
  map.resources :list_details
  map.resources :include_lists
  map.resources :exclude_lists
  map.resources :compile_lists, :collection => {:clear => :post, :compile => :post}

  map.resources :group_lists, :collection => {:show_list_des => :get}

  map.resources :group_permissions, :collection => {:show_add_container => :get, :show_module => :get, :show_controllers => :get, :show_methods => :get}

  map.resources :reports, :collection => {:generate_report => :post, :generate_organisation_report_pdf => :get,:generate_person_report_pdf=>:get,:preview_report => :post, :person_contacts_report_grid => :get,:organisation_contacts_report_grid => :get}

  map.resources :personal_duplication_formulas, :collection => {:set_default => :get, :generate => :get}
  map.resources :organisational_duplication_formulas, :collection => {:set_default => :get, :generate => :get}
  map.resources :duplication_formula_details

  map.resources :addresses , :member => {:search_postcodes => :get,:move_up_address_priority => :get,:move_down_address_priority => :get,:move_down_organisation_address_priority => :get, :move_up_organisation_address_priority => :get}
  map.resources :grids, :member => {:people_search_grid => :get, :query_result_grid => :get, :list_edit_grid => :get, 
                                    :list_compile_grid => :get,:show_person_lookup_grid =>:get,:show_postcode_grid => :get,:organisation_search_grid => :get, :duplication_organisations_grid => :get,

                                    :show_other_group_organisations_grid => :get, :show_organisation_contacts_report_grid=>:get,:show_person_contacts_report_grid => :get,:show_other_member_grid => :get, :organisation_employee_grid => :get}
                                       
  map.resources :phones, :member => {:move_down_phone_priority =>:get,:move_up_phone_priority =>:get,:move_organisation_down_phone_priority=>:get,:move_organisation_up_phone_priority => :get}
  map.resources :emails, :member => {:move_down_email_priority =>:get, :move_up_email_priority => :get,:move_organisation_up_email_priority=> :get, :move_organisation_down_email_priority=> :get}
  map.resources :websites, :member => {:move_down_website_priority =>:get, :move_up_website_priority => :get,:move_organisation_down_website_priority=>:get, :move_organisation_up_website_priority => :get}
  map.resources :master_docs, :member => {:move_down_master_doc_priority =>:get, :move_up_master_doc_priority => :get,:move_organisation_up_master_doc_priority=> :get, :move_organisation_down_master_doc_priority => :get}
  map.resources :employments, :member => {:move_down_employment_priority => :get,:move_up_employment_priority => :get}
  map.resources :data_managers, :collection => {:import_index => :get, :export_index => :get, :export => :get}

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
  map.welcome 'welcome', :controller => "module", :action => "core"    # After a user is logged in this is where they are sent to
  map.login 'login', :controller => "signin", :action => "login"       # This should be the page a user logs in at
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'


end
