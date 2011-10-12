authorization do
  role :newsmaker do
    includes :customer
    has_permission_on [ :articles ], :to => [ :manage ], :join_by => :and do
      if_attribute :articles => is { user }
      if_attribute :is_news? => is { true }
    end
  end

  role :author do
    includes :customer
    has_permission_on [:articles, :comments, :events], :to => [ :manage, :editor, :drafts ]
  end

  role :customer do
    includes :guest
    has_permission_on [:comments], :to => [:new, :create]
    has_permission_on [:users, :comments], :to => [:edit, :update] do
      if_attribute :user => is { user }
    end
    has_permission_on :user_sessions, :to => [:destroy]
  end
  
  role :guest do
    has_permission_on [:articles], :to => [:next_news, :prev_news]
    has_permission_on [:articles, :comments, :categories, :users], :to => [:index, :show]
    has_permission_on [:user_sessions], :to => [:new, :create]
    has_permission_on [:users], :to => [:show, :update, :new, :create, :recover_password, :reset_password]
    has_permission_on [:events], :to => [:read]
  end
  
  role :admin do
    includes :author
    has_permission_on [:comments, :categories, :users, :user_sessions, :events, :assigments], :to => [ :manage, :index_all]
    has_permission_on [:roles], :to => [:read]
    has_permission_on [:users], :to => [:set_roles]
  end
end

privileges do
  privilege :manage do
    includes :create, :read, :update, :destroy, :new, :edit, :publish, :unpublish, :to_drafts, :undraft
  end

  privilege :read do
    includes :index, :show
  end
end
