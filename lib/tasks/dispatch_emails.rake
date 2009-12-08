namespace :db do

  DEBUG = false

  # Cron entry:
  # */10 * * * * /usr/bin/ruby /usr/bin/rake -f /home/rails/amazon/current/Rakefile rake:db:send_pending_emails RAILS_ENV=production >/dev/null 2>&1
  desc "Send the next email that has a pending status."
  task :send_pending_emails  => :environment do

    
    email = BulkEmail.find(:first, :conditions => "dispatch_date IS NULL")

    while !email.nil?

      debug("Preparing to dispatch email.")

      email.dispatch_date = Time.now
      email.save
      
      pending_email = EmailDispatcher.create_message(email.to, email.from, email.subject, email.body)
      EmailDispatcher.deliver(pending_email)

      debug("#{email.to_yaml}")

      debug("Finished dispatching email.")

      email = BulkEmail.find(:first, :conditions => "dispatch_date IS NULL")

    end
    
  end

  private

  def debug(string)
    puts string if DEBUG
  end

end
