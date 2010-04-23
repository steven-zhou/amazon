namespace :db do
  desc "Add  Primary Phone Num and Email to Person and Organisation Table"
  task :add_primary_phone_and_email => :environment do
    puts "Add  Primary Phone Num and Email to Person Table..."
    
    @person = Person.all
    @person.each do |i|
      if i.primary_phone_num.nil?
        i.primary_phone_num = i.try(:phones).find_by_priority_number(1).try(:value)

      end

       if i.primary_email_address.nil?
        i.primary_email_address = i.try(:emails).find_by_priority_number(1).try(:value)
      end
      i.save
    end
    puts "Add  Primary Phone Num and Email to Organisation Table..."
    @organisation = Organisation.all
        @organisation.each do |i|
      if i.primary_phone_num.nil?
        i.primary_phone_num = i.try(:phones).find_by_priority_number(1).try(:value)

      end

       if i.primary_email_address.nil?
        i.primary_email_address = i.try(:emails).find_by_priority_number(1).try(:value)
      end
      i.save
    end

    puts "DONE"

  end
end
