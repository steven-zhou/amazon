namespace :db do
  desc "Reset Login Attempts"
  task :reset_login_attempts => :environment do
    puts "Reset Login Attempts..."
    
    client_setup = ClientSetup.first
    client_setup.number_of_login_attempts = 99999
    client_setup.new_account_graceperiod = 99999
    client_setup.session_timeout = 99999
    client_setup.password_lifetime = 99999
    client_setup.save
    puts "DONE"

  end
end
