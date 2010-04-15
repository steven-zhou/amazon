namespace :db do
  desc "Delete the Amazonsetting security question value"
  task :clean_security_question => :environment do
    puts "Delete the Amazonsetting security question value"
    
    SecurityQuestion.find(:all).each do |i|
      i.destroy
    end

    begin
      SystemUser.find(:all).each do |f|
        f.update_password = false
        f.security_question1 = "what is your user name"
        f.question1_answer = f.user_name

        f.security_question2 = "what is your security Email"
        f.question2_answer = f.security_email

        f.save
      end
    rescue
      
    puts "warning, there is mistake when change user security question"
    end
    puts "DONE"

  end
end
