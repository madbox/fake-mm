class UsersController < ApplicationController
  filter_access_to :all

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
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
      redirect_to profite_url
    else
      render :action => :edit
    end
  end
end
