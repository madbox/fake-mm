class FeedbackController < ApplicationController

  def create
    fh = params[:feedback]
    Notifications.deliver_feedback_message( fh[:name],
                                            fh[:email],
                                            fh[:text] )
    if  fh[:name].blank? ||
        fh[:email].blank? || !fh[:email].match() ||
        fh[:text].blank?
      flash[:error] = I18n.t( 'errors.incorrect_feedback_data' )
      redirect_to :action => 'new'
    end
    
    flash[:notice] = I18n.t('notice.feedback_created')
    redirect_to root_path
  end
end
