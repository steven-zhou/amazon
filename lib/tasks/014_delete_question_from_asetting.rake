namespace :db do
  desc "Delete the Amazonsetting security question value"
  task :clean_security_question => :environment do
    puts "Delete the Amazonsetting security question value"
    
    SecurityQuestion.find(:all).each do |i|
      i.destroy
    end
    puts "DONE"

  end
end
