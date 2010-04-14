namespace :db do
  desc "Create Custom Field"
  task :create_custom_field => :environment do
     @extra_types = ExtraMetaType.active
    puts "Creating Custom Field For Person"
    
    Person.all.each do |p|
      i=1
      @extra_types.each do |group|
        unless Extra.find_extra(group.id, p)
          @extra =  Extra.new
          @extra.entity_id = p.id
          @extra.group_id = group.id
          @extra.entity_type = "Person"
          group.extra_types.each do |label|
            @extra.__send__(("label#{i}_id=").to_sym,label.id)
            @extra.__send__(("label#{i}_value=").to_sym,nil)
            i=i+1
          end
          @extra.save
          i=1
        end
      end
    end

    puts "Creating Custom Field For Organsation"
        Organisation.all.each do |p|
      i=1
      @extra_types.each do |group|
        unless Extra.find_extra(group.id, p)
          @extra =  Extra.new
          @extra.entity_id = p.id
          @extra.group_id = group.id
          @extra.entity_type = "Organisation"
          group.extra_types.each do |label|
            @extra.__send__(("label#{i}_id=").to_sym,label.id)
            @extra.__send__(("label#{i}_value=").to_sym,nil)
            i=i+1
          end
          @extra.save
          i=1
        end
      end
    end

    puts "DONE"

  end
end
