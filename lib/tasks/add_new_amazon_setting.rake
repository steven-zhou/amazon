namespace :db do
  desc "add new amazon setting type to the database"
  task :addnewamazonsetting => :environment do
    puts "Run Patch addnewamazonsetting ..."
    if MailMergeCategory.first.nil?
      puts "Create all Mail Merge Category"
      MailMergeCategory.create(:name => "All", :status => true, :to_be_removed =>false)
    else
      puts "all Mail Merge Category already exists"
    end
    puts "DONE"
  end
end
