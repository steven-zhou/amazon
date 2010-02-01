namespace :db do
  desc "change to be removed to be false after adding that field to tables"
  task :fixtoberemoved => :environment do
    ReceiptAccount.transaction do
      puts "change receipt account"
      ReceiptAccount.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
      puts "change campaign"
      Campaign.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
      puts "change source"
      Source.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
      puts "change bank account"
      BankAccount.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
      puts "change email"
      MessageTemplate.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
    end
  end
end