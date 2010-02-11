namespace :db do
  desc "add status and to_be_removed value to the person/orgnisation which do not have these value"
  task :fixentity_statusremove => :environment do
    puts "Run Patch fixentity_statusremove ..."
    puts "change people status and to_be_removed"
    Person.all.each do |i|
      i.to_be_removed = false if i.to_be_removed.nil?
      i.status = true if i.status.nil?
      i.save!
    end
  

    puts "change orgnisation status and to_be_removed"
    Organisation.all.each do |i|
      i.to_be_removed = false if i.to_be_removed.nil?
      i.status = true if i.status.nil?
      i.save!
    end
    puts "DONE"
  end
end