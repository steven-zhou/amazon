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
end
