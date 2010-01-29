namespace :db do
  desc "change to be removed to be false after adding that field to tables"
  task :fixtoberemoved => :environment do
    ReceiptAccount.transaction do
      ReceiptAccount.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
      Campaign.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
      Source.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
      BankAccount.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
      MessageTemplate.all.each do |i|
        if i.to_be_removed.nil?
          i.to_be_removed = false
          i.save!
        end
      end
    end
  end
end
