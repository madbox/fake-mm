authorization do
  role :author do
    includes :customer
    has_permission_on [:articles, :comments], :to => [ :manage, :editor, :drafts ]
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
    has_permission_on [:articles, :comments, :categories, :users], :to => [:index, :show]
    has_permission_on [:user_sessions], :to => [:new, :create]
    has_permission_on [:users], :to => [:index, :show, :update, :new, :create, :recover_password, :reset_password]
  end
  
  role :admin do
    includes :author
    has_permission_on [:comments, :categories, :users, :user_sessions], :to => [ :manage, :index_all]
  end
end

privileges do
  privilege :manage do
    includes :create, :read, :update, :destroy, :new, :edit, :publish, :unpublish, :make_draft, :undraft
  end

  privilege :read do
    includes :index, :show
  end
end
