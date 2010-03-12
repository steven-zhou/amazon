class EmailDispatcher < ActionMailer::Base

  def message(recipient, sender, subject, message)
    # When sending out email to people from a list
    recipients       "#{recipient}"
    from             "#{sender}"
    headers          = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'feedback@memberzone.com.au'}
    subject          "#{subject}"
    sent_on           Time.now
    body             :message => message
    content_type     "text/html"

  end

  def email_with_template(recipient, subject, email_template, object)
    # Goes to the end user when they request to have their password reset
    recipients         "#{recipient}"
    from               "noreply@memberzone.com.au"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'feedback@memberzone.com.au'}
    subject            "#{subject}"
    sent_on            Time.now
    body                :email_template => email_template, :object => object
    content_type        "text/html"
  end

   def change_password_email_with_template(recipient, subject, email_template, object, password)
    # Goes to the end user when they request to have their password reset
    recipients         "#{recipient}"
    from               "noreply@memberzone.com.au"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'feedback@memberzone.com.au'}
    subject            "#{subject}"
    sent_on            Time.now
    body                :email_template => email_template, :object => object,:password => password
    content_type        "text/html"
  end

   def send_person_email_template(email,content)
    recipients       "#{email}"
    from              "noreply@memberzone.com.au"
    subject          "Thank you for joining the membership"
    headers           = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'feedback@memberzone.com.au'}
    sent_on           Time.now
    body              :content => content
    content_type        "text/html"

  end
end
