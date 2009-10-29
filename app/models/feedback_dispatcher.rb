class FeedbackDispatcher < ActionMailer::Base

  def notify_admin(feedback)
    # When feedback comes in send notification to the admin
    recipients       "feedback@memberzone.com.au"
    from             "feedback@memberzone.com.au"
    headers          = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'powernet@powernet.com.au'}
    subject          "System Feedback"
    sent_on           Time.now
    body             :feedback => feedback
    content_type     "text/plain"

  end


  def confirmation_email(feedback)
    # If they user requests confirmation of feedback send it to them
    recipients       "#{feedback.login_account.security_email}"
    from             "noreply@memberzone.com.au"
    headers          = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'powernet@powernet.com.au'}
    subject          "System Feedback Ticket #{feedback.id}"
    sent_on          Time.now
    body             :feedback => feedback
    content_type     "text/plain"

  end

end
