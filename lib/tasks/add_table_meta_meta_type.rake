namespace :db do
  desc "Add Table Meta Meta Type"
  task :add_table_meta_meta_type => :environment do
    puts "Run Patch all TableMetaMetaType ..."
       #Extras Table
    unless TableMetaMetaType.find_by_name("extras")
      extras = TableMetaMetaType.create :name => "extras",  :description => "extras table", :status => true, :category => "enitity", :to_be_removed =>false
      TableMetaType.create :name => "group_value", :tag_meta_type_id => extras.id, :description => "Group_value (e.g. Any String)",  :status => true, :category => "String", :to_be_removed =>false
    end
    puts "DONE"
  end
end
