class FeedbackDispatcher < ActionMailer::Base

  def notify_admin(feedback)

    @recipients       = "magdy@powernet.com.au"
    @from             = "Amazon System Feedback <noreply@powernet.com.au>"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'powernet@powernet.com.au'}
    @subject          = "System Feedback"
    @sent_on          = Time.now
    @body["feedback"] = feedback
    content_type        "text/html"

  end


  def confirmation_email(feedback)

    @recipients       = "#{feedback.login_account.security_email}"
    @from             = "Amazon System Feedback <noreply@powernet.com.au>"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'powernet@powernet.com.au'}
    @subject          = "System Feedback Ticket #{feedback.id}"
    @sent_on          = Time.now
    @body["feedback"] = feedback
    content_type        "text/html"

  end

end
