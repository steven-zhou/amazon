ActionController::Routing::Routes.draw do |map|

  map.root :controller => "people"

  map.connect 'people/edit/', {:controller => 'people', :action => 'edit', :id => ' ' }

  map.resources :people, :shallow=> true, 
    :collection => {:find => :get, :search => :post, :name_finder => :get, :role_finder => :get, :master_doc_meta_type_finder => :get, :master_doc_type_finder => :get},
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
    person.resources :roles, :collection => {:get_roles => :get}
  end

  map.resources :organisations, :shallow=>true, :collection => {:name_finder => :get}

  map.resources :administrations

  map.resources :amazon_settings, :collection => {:data_list_finder => :get}

  map.resources :tag_settings, :collection => {:show_all_for_selected_classifier => :get}
  map.resources :tag_meta_types, :shallow => true do |tag_meta_type|
    tag_meta_type.resources :tag_types, :shallow => true do |tag_type|
      tag_type.resources :tags
    end
  end
    
  
  
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
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
