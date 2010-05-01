class FeedbackController < ApplicationController
  def new
  end

  def create
    Notifications.deliver_feedback_message( params[:name], params[:email], params[:text] )
    flash[:notice] = I18n.t('notice.feedback.created')
    redirect_to root_path
  end

end
