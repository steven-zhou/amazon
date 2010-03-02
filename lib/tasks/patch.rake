namespace :db do
  desc "Run patch after restore database"
  task :patch => [:environment, "db:migrate", "initial_current_user", "add_payment_methods"] do
    puts "Patch Done!"
  end
end