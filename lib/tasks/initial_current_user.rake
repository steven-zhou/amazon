namespace :db do
  desc "Initial current user"
  task :initial_current_user => :environment do
    puts "Prepare current user ..."
    #LoginAccount.current_user is shared by all the patches
    LoginAccount.current_user = MemberZone.first
    puts "DONE"
  end
end