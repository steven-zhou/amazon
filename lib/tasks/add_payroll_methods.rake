namespace :db do
  desc "Add payroll methods"
  task :add_payroll_methods => :environment do
    puts "Run Patch add_payroll_methods ..."
    PayrollMethod.create :name => "Cheque", :status => true, :to_be_removed => false
    PayrollMethod.create :name => "Cash", :status => true, :to_be_removed => false
    PayrollMethod.create :name => "Bank Transfer", :status => true, :to_be_removed => false
    puts "DONE"
  end
end
