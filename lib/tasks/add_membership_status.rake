namespace :db do
  desc "Add membership status"
  task :add_membership_status => :environment do
    puts "Run Patch all membership_status ..."
    MembershipStatus.all.each do |i|
      i.destroy
    end

    MembershipStatus.create(:name => "Prospective", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "In-review", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Rejected", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Actived", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Suspended", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Terminated", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Archived", :status => true,:to_be_removed =>false)
    MembershipStatus.create(:name => "Removed", :status => true,:to_be_removed =>false)
    puts "DONE"

  end
end
