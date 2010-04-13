namespace :db do
  desc "Add Workplaces"
  task :add_workplaces => :environment do
    puts "Run Patch add_workplaces ..."
    Employment.find(:all, :conditions => ["workplace_id isNull"]).each do |i|
      i.workplace_id = i.organisation_id
      i.save
    end
    puts "DONE"
  end
end
