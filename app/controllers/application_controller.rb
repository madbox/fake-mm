# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :prepare_news

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password

  helper_method :current_user, :current_user_session

  def permission_denied
    flash[:error] = I18n.t('errors.authorization_failed')
    respond_to do |format|
      format.html { redirect_to(:back) rescue redirect_to('/') }
      # format.xml  { head :unauthorized }
      # format.js   { head :unauthorized }
    end
  end

  protected

  def prepare_news
    news_count = 8
    @news = Article.published.news.find(:all, :limit => news_count)
    if @news.size < news_count
      (news_count - @news.size).times do
        @news << Article.new( :title => 'no article' )
      end
    end
  end

  private

  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

end
