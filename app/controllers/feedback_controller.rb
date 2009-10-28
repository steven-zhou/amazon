class FeedbackController < ApplicationController
  

  def list
    @feedback = FeedbackItem.find(:all, :order => "feedback_date ASC")
    
  end

  def submit_feedback
    @feedback = FeedbackItem.new(
      :login_account_id => @current_user.id,
      :subject => params[:feedback_item_subject],
      :content => params[:feedback_item_content],
      :ip_address => request.remote_ip,
      :status => "Submitted",
      :feedback_date => Time.now()
    )
    @feedback.save

      email = FeedbackDispatcher.create_notify_admin(@feedback)
      FeedbackDispatcher.deliver(email)

    respond_to do |format|
      format.js
    end

  end

  def issue_confirmation
    @feedback = FeedbackItem.find(params[:id])
    email = FeedbackDispatcher.create_confirmation_email(@feedback)
    FeedbackDispatcher.deliver(email)
    render :nothing => true
  end

end
