class LoginAccountUsernameRetrievalDispatcher < ActionMailer::Base

  def email_notification(login_account)
    # When a user has forgotten their username and wants to get it emailed to them
    @recipients       = "#{login_account.security_email}"
    @from             = "noreply@memberzone.com.au"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'powernet@powernet.com.au'}
    @subject          = "Username Retrieval Request"
    @sent_on          = Time.now
    @body["username"] = login_account.user_name
    content_type        "text/plain"

  end
  

end
