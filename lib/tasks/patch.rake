namespace :db do
  desc "Run patch after restore database"
  task :patch => [:environment, "db:migrate", "initial_current_user",  "change_all_to_others_category"] do
    puts "Patch Done!"
  end
end