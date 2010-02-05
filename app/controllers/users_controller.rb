class UsersController < ApplicationController
  filter_access_to :all

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.roles << Role.find_by_sysname('customer')
    if @user.save
      flash[:notice] = I18n.t('notice.user_registered')
      Notifications.deliver_signup( @user, params[:user][:password] )
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def show
    unless params[:id].blank?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
 
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to profile_url
    else
      render :action => :edit
    end
  end

  def recover_password
    @user = User.new
  end

  def reset_password
    @user = User.find_by_email(params[:user][:email])

    if @user
      @user.password_confirmation = @user.password = User.generate_password
      if @user.save_without_session_maintenance 
        Notifications.deliver_recover_password( @user, @user.password )
        
        flash[:notice] = I18n.t('notice.password_recovered')
        redirect_to login_url
      else
        flash[:error] = I18n.t('errors.user_save_failed')
        redirect_to root_url
      end
    else
      flash[:error] = I18n.t('errors.user_not_found')
      redirect_to recover_password_path
    end
  end
end
