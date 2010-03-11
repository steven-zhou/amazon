namespace :db do
  desc "Add membership status"
  task :add_membership_status => :environment do
    puts "Run Patch all membership_status ..."
    MembershipStatus.all.each do |i|
      i.destroy
    end
    MembershipStatus.create(:name => "In-process", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Life", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "End", :status => true,:to_be_removed =>false)
    #    MembershipStatus.create(:name => "Declined", :status => true,:to_be_removed =>false)
    #    MembershipStatus.create(:name => "Suspended", :status => true,:to_be_removed =>false)
    #    MembershipStatus.create(:name => "Terminated", :status => true,:to_be_removed =>false)
    #    MembershipStatus.create(:name => "Financial", :status => true,:to_be_removed =>false)
    #    MembershipStatus.create(:name => "Unfinancial", :status => true,:to_be_removed =>false)
    puts "DONE"

    puts "Run Patch all membership sub status"
    MembershipSubStatus.all.each do |i|
      i.destroy
    end
    MembershipSubStatus.create(:name => "Initiated", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Reviewed", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "2nd Review Required", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "3nd Review Required", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Approved", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Declined", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Incompleted", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Actived", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Suspended", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Terminated", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Archived", :status => true,:to_be_removed =>false)
    MembershipSubStatus.create(:name => "Removed", :status => true,:to_be_removed =>false)
      puts "DONE"

  end
end
