authorization do
  role :customer do
    has_permission_on [:comments], :to => [:new, :create]
    has_permission_on [:users, :comments], :to => [:edit, :update] do
      if_attribute :user => is { user }
    end
    has_permission_on :user_sessions, :to => [:destroy]
  end
  
  role :guest do
    has_permission_on [:articles, :comments, :categories, :users], :to => [:index, :show]
    has_permission_on [:user_sessions], :to => [:new, :create]
    has_permission_on [:users], :to => [:index, :show, :update]
  end
  
  role :admin do
    has_permission_on [:articles, :comments, :categories, :users, :user_sessions], :to => [:index, :new, :show, :create, :edit, :update, :destroy, :index_all]
  end
end
