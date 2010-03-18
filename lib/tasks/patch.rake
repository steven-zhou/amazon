namespace :db do
  desc "Run patch after restore database"
  task :patch => [:environment, "db:migrate", "initial_current_user", "add_tag_meta_meta_type"] do
    puts "Patch Done!"
  end
end