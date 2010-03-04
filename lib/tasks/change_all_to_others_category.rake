namespace :db do
  desc "Change mail category from all to others"
  task :change_all_to_others_category => :environment do
    puts "Run Patch change_all_to_others_category ..."
    i = MailMergeCategory.find_by_name("All")
    unless i.nil?
      i.name = "Others"
      i.save
    end
    puts "DONE"
  end
end
