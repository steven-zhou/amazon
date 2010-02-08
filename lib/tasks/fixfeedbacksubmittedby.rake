namespace :db do
  desc "Add submitted_by to feedback table"
  task :fixfeedbacksubmittedby => :environment do
    FeedbackItem.all.each do |i|
      if i.submitted_by.nil?
        i.submitted_by = (i.login_account.class.to_s == "SystemUser")?  "#{i.login_account.user_name}(#{i.login_account.person.name})" : i.login_account.user_name
        i.save
      end
    end
  end
end
