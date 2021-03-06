class UsersController < ApplicationController
  filter_access_to :all

  def index
    @users = User.paginate :page => params[:page], :per_page => 20, :order => 'id DESC'
  end

  def new
    @hide_user_sidebar = true

    @user = User.new
  end
  
  def create
    @hide_user_sidebar = true
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
    unless current_user.has_role? :admin
      @user = current_user
    else
      @user = User.find params[:id]
    end
    
    @section = params['section'] || 'about'

    respond_to do |f|
      f.js{ render :partial => ['edit', @section].compact.join('_') }
      f.html
    end
  end
  
  def update
    unless current_user.has_role? :admin
      @user = current_user
    else
      @user = User.find params[:id]
    end

    if params[:user] && params[:user]['roles']
      params[:user]['roles'] = params[:user]['roles'].split(' ').map{ |role_name| Role.find_by_sysname role_name }
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url(@user)
    else
      render :action => :edit
    end
  end

  def recover_password
    @hide_user_sidebar = true
    @user = User.new
  end

  def reset_password
    @hide_user_sidebar = true
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

  def set_roles
    roles = params['roles'].strip.split( ' ' )
    user = User.find( params['user_id'].to_i )

    user.roles.clear
    user.roles << Role.find_all_by_sysname( roles )

    render :text => ''
  end
end
