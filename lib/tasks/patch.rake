namespace :db do
  desc "Run patch after restore database"
  task :patch => [:environment, "db:migrate", "initial_current_user", "modify_client_setups_level", "add_family_id"] do
    puts "Patch Done!"
  end
end