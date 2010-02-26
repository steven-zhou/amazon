namespace :db do
  desc "Run patch after restore database"
  task :patch => [:environment, "db:migrate", "add_all_countries", "fixtoberemoved", "fixopl", "fixfeedbacksubmittedby", "fixentity_statusremove", "addnewamazonsetting", "creator_updater_patch"] do
    puts "Patch Done!"
  end
end
