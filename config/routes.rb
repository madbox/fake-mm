ActionController::Routing::Routes.draw do |map|
  #map.review '/review'    , :controller => 'categories', :action => 'show', :sysname => 'review'
  #map.features '/features', :controller => 'categories', :action => 'show', :sysname => 'features'
  #map.news '/news'        , :controller => 'categories', :action => 'show', :sysname => 'news'
  map.connect '/categories/index_all', :controller => 'categories', :action => 'index_all'
  map.resources :categories

  map.resources :roles
  map.resources :assigments
  map.resources :styles

  map.resource :user_sessions
  map.resource :profile, :controller => 'users'
  map.resources :users do |user|
    user.resources :articles
    user.resources :assigments
    user.resources :comments, :through => :articles
    user.resources :roles, :through => :assigments
  end

  map.resources :comments
  map.article_editor '/articles/editor', :controller => 'articles', :action => 'editor'
  map.drafts '/articles/drafts', :controller => 'articles', :action => 'drafts'
  map.resources :articles, :has_many => :comments

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
  map.root :controller => "front"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.

  map.login  '/login',  :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.register '/signup', :controller => 'users', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
