namespace :db do
  desc "Run patch after restore database"

  task :patch => [:environment, "db:migrate", "initial_current_user", "add_payroll_methods", "add_payment_methods", "add_workplaces"] do
    puts "Patch Done!"
  end
end