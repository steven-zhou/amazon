namespace :db do
  desc "Add membership status"
  task :add_membership_status => :environment do
    puts "Run Patch all membership_status ..."
    MembershipStatus.all.each do |i|
      i.destroy
    end
    MembershipStatus.create(:name => "Initiated", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Reviewed", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Approved", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Declined", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Suspended", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Terminated", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Financial", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Unfinancial", :status => true,:to_be_removed =>false)
    puts "DONE"
  end
end
