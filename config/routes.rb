ActionController::Routing::Routes.draw do |map|

  map.connect 'people/edit/', {:controller => 'people', :action => 'edit', :id => ' ' }
  map.connect 'organisations/edit/', {:controller => 'organisations', :action => 'edit', :id => ''}

  map.resources :people, :shallow=> true, 
    :collection => {:find => :get, :search => :post, :name_finder => :get, :role_finder => :get, :master_doc_meta_type_finder => :get, :master_doc_type_finder => :get, :login_id_finder => :get},
    :member => {
    :edit_names => :post,
    :cancel_edit_names => :post,
    :add_keywords => :post,
    :remove_keywords => :post,
    :name_card => :get,
  } do |person|
    person.resources :addresses, :member => {:set_primary_address => :post}
    person.resources :phones
    person.resources :faxes
    person.resources :websites
    person.resources :emails
    person.resources :master_docs
    person.resources :images, :member => {:thumb => :get}
    person.resources :notes
    person.resources :employments
    person.resources :person_roles
    person.resources :relationships, :collection => {:remove_relation => :delete}
  end

  map.resources :people do |person|
    person.resources :roles, :collection => {:get_roles => :get, :person_role_des => :get}
  end

  map.resources :organisations, :shallow=>true,
    :collection => {:find => :get, :search => :post, :name_finder => :get},
    :member => {:add_keywords => :post, :remove_keywords => :post} do |organisation|
    organisation.resources :addresses, :member => {:set_primary_address => :post}
    organisation.resources :phones
    organisation.resources :faxes
    organisation.resources :websites
    organisation.resources :emails
    organisation.resources :master_docs
    organisation.resources :images, :member => {:thumb => :get}
    organisation.resources :notes
  end

  map.resources :administrations, :collection => {:system_setting => :get, :system_management => :get, :list_management => :get}

  map.resources :amazon_settings, :collection => {:data_list_finder => :get}


 

  map.resources :role_conditions, :collection => {:add_conditions => :post,:remove_conditions => :post}


  map.resources :roles, :collection => {:show_roles => :get,:master_doc_meta_type_finder1 => :get, :meta_name_finder => :get, :meta_type_name_finder => :get,:doc_type_finder => :get,:role_type_finder => :get}


  map.resources :tag_settings, :collection => {:show_all_for_selected_classifier => :get}
  map.resources :tag_meta_types
  map.resources :tag_types, :collection => {:show_tag_types => :get, :show_fields => :get}
  map.resources :tags, :collection => {:show_tags => :get}

#  map.resources :query_headers, :shallow=> true do |query_header|
#    query_header.resources :query_details
#    query_header.resources :query_criterias
#  end

  map.resources :query_headers, :shallow=> true, :collection => {:show_sql_statement => :get, :run => :get, :clear => :get},
    :member => {:copy => :get, :saveas => :post} do |query_header|
    query_header.resources :query_selections
    query_header.resources :query_sorters
    query_header.resources :query_criterias
  end

  map.resources :login_accounts, :collection => {:user_name_unique => :get}
  map.resources :user_groups, :collection => {:add_security => :post, :remove_security => :post, :show_groups => :get}

  map.resources :list_headers
  map.resources :list_details
  
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
  map.welcome 'welcome', :controller => "people", :action => "show"    # After a user is logged in this is where they are sent to
  map.login 'login', :controller => "signin", :action => "login"       # This should be the page a user logs in at
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'


end
