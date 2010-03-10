namespace :db do
  desc "add new amazon setting type to the database"
  task :addnewamazonsetting => :environment do
    puts "Run Patch addnewamazonsetting ..."
    if TemplateCategory.first.nil?
      puts "Create Template Category - all"
      TemplateCategory.create(:name => "All", :status => true, :to_be_removed =>false)
    else
      puts "all Mail Merge Category already exists"
    end

    if MembershipType.first.nil?
      puts "Create MembershipType - Full Member"
      MembershipType.create(:name => "Full Member", :status => true, :to_be_removed =>false)
    else
      puts "MembershipType - Full Member already exists"
    end

    if MembershipStatus.first.nil?
      puts "Create MembershipStatus - Financial"
      MembershipStatus.create(:name => "Financial", :status => true, :to_be_removed =>false)
    else
      puts "MembershipStatus - Financial already exists"
    end
    puts "DONE"
  end
end
