namespace :db do
  desc "Add template categories"
  task :add_template_categories => :environment do
    puts "Run Patch add_template_categories ..."
    TemplateCategory.create(:name => "Others", :status => true,:to_be_removed =>false)
    TemplateCategory.create(:name => "Membership", :status => true,:to_be_removed =>false)
    puts "DONE"
  end
end
