class LoginAccountPasswordResetDispatcher < ActionMailer::Base

  def email_notification(login_account, new_password)

    @recipients       = "#{login_account.security_email}"
    @from             = "Amazon System <noreply@powernet.com.au>"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'powernet@powernet.com.au'}
    @subject          = "Password Reset Request"
    @sent_on          = Time.now
    @body["password"] = new_password
    content_type        "text/html"

  end

  def registration_confirmation(login_account, password)
    recipients       "#{login_account.security_email}"
    from              "lei@powernet.com.au"
    subject          "Thank you for registering"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'powernet@powernet.com.au'}
    sent_on           Time.now
    body              :login_account => login_account, :password => password
    content_type        "text/html"
            


  end


end
