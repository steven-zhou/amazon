class LoginAccountPasswordResetDispatcher < ActionMailer::Base

  def email_notification(login_account, new_password)
    # Goes to the end user when they request to have their password reset
    recipients         "#{login_account.security_email}"
    from               "noreply@memberzone.com.au"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'feedback@memberzone.com.au'}
    subject            "Password Reset Request"
    sent_on            Time.now
    body                :password => new_password
    content_type        "text/plain"

  end

  def registration_confirmation(login_account, password)
    # Goes to the end user once a new account is created
    recipients       "#{login_account.security_email}"

    from              "noreply@memberzone.com.au"
    subject          "Thank you for registering"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'feedback@memberzone.com.au'}
    sent_on           Time.now
    body              :login_account => login_account, :password => password
    content_type        "text/html"

  end




end
