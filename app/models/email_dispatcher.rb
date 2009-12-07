class EmailDispatcher < ActionMailer::Base

  def message(recipient, subject, message)

    puts " *** Sending an email to #{recipient}"

    # When sending out email to people from a list
    recipients       "#{recipient}"
    from             "feedback@memberzone.com.au"
    headers          = {'Precedence' => 'bulk', 'List-Unsubscribe' => 'feedback@memberzone.com.au'}
    subject          "#{subject}"
    sent_on           Time.now
    body             :message => message
    content_type     "text/plain"

  end

end
