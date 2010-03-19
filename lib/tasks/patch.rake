namespace :db do
  desc "Run patch after restore database"
  task :patch => [:environment, "db:migrate", "initial_current_user", "add_table_meta_meta_type", "add_tag_meta_meta_type", "add_membership_status", "add_person_mail_template"] do
    puts "Patch Done!"
  end
end