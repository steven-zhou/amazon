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

end
