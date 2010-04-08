namespace :db do
  desc "Add Family ID To Level 0 Organisations"
  task :add_family_id => :environment do
    puts "Run Patch Add Family ID To Level 0 Organisations..."
    
    @organisations = Organisation.find(:all, :conditions => ["level = 0"])
    @organisations.each do |i|
      i.update_attribute("family_id", i.id)
    end
    puts "DONE"

  end
end
