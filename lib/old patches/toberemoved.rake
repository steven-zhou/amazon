namespace :db do
  desc "change to be removed to be false after adding that field to tables"
  task :fixtoberemoved => :environment do

    @tablesArray = Array[
      "bank_accounts",
      "campaigns","countries",
      "message_templates",
      "post_areas", "postcodes",
      "receipt_accounts",
      "sources"
    ]

    puts "Run Patch fixtoberemoved ..."
    @tablesArray.each do |table|
      puts "Patch fixtoberemoved to #{table.camelize} ..."
      table.singularize.camelize.constantize.all.each do |i|
        i.status = true if i.status.nil?
        i.to_be_removed = false if i.to_be_removed.nil?
        i.save
      end
    end
    
    puts "DONE"
  end
end
