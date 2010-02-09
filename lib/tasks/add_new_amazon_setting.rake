namespace :db do
  desc "add new amazon setting type to the database"
  task :addnewamazonsetting => :environment do

    puts "all Mail Merge Category"
    MailMergeCategory.create(:name => "All", :status => true,:to_be_removed =>false)

  end
end
