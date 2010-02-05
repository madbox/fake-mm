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
end
