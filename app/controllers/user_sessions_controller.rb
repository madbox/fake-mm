class UserSessionsController < ApplicationController
  filter_access_to :all

  # GET /user_sessions/new
  # GET /user_sessions/new.xml
  def new
    @hide_user_sidebar = true
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_session }
    end
  end

  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    @hide_user_sidebar = true
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        flash[:notice] = I18n.t('notice.logged_in')
        format.html { redirect_to profile_path }
        format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @hide_user_sidebar = true
    @user_session = UserSession.find
    @user_session.destroy

    flash[:notice] = "Successfully logged out."
    
    respond_to do |format|
      format.html { redirect_to root_url }
      format.xml  { head :ok }
    end
  end
end
