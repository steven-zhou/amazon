namespace :db do
  desc "Run patch after restore database"
  task :patch => [:environment, "db:migrate", "fixtoberemoved", "fixopl", "fixfeedbacksubmittedby", "fixentity_statusremove", "addnewamazonsetting"] do
    puts "Patch runned"
  end
end
