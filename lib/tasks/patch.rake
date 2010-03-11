namespace :db do
  desc "Run patch after restore database"
  task :patch => [:environment, "db:migrate", "initial_current_user", "add_membership_status", "add_payment_methods", "add_payroll_methods", "add_template_categories", "add_workplaces","add_person_mail_template"] do
    puts "Patch Done!"
  end
end