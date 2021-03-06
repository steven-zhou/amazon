class FeedbackController < ApplicationController
  

  def list
    @feedback = FeedbackItem.find(:all, :order => "created_at DESC")

    #clear temple table and save result into temple table
    FeedbackSearchGrid.find_all_by_login_account_id(session[:user]).each do |i|
      i.destroy
    end

    @feedback.each do |feedback|
      @psg = FeedbackSearchGrid.new
      @psg.login_account_id = session[:user]
      @psg.grid_object_id = feedback.id
      @psg.field_1 = feedback.feedback_date.strftime('%a %d %b %Y')
      @psg.field_2 = feedback.submitted_by
      @psg.field_3 = feedback.subject
      @psg.field_4 = feedback.ip_address
      @psg.field_5 = feedback.status
      @psg.save
    end
    
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

  def show
    @feedback_item = FeedbackItem.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def submit_reply

    @feedback_item = FeedbackItem.find(params[:id])
    @feedback_item.response = params[:feedback_reply_content]
    @feedback_item.response_date = Date.today()
    @feedback_item.responded_to_by_id = @current_user.id
    @feedback_item.status = "Replied To"
    @feedback_item.save

    subject = params[:feedback_reply_subject]

    email = FeedbackDispatcher.create_reply_to_feedback(@feedback_item, subject)
    FeedbackDispatcher.deliver(email)
    
    respond_to do |format|
      format.js
    end

  end

end
