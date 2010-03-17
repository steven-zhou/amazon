namespace :db do
  desc "Add Tag Meta Meta Type"
  task :add_tag_meta_meta_type => :environment do
    puts "Run Patch all TagMetaMetaType ..."
    
    ExtraMetaMetaType.all.each do |i|
      i.destroy
    end

    ExtraMetaMetaType.create :name => "Custom Field", :status => true,:to_be_removed =>false

    puts "DONE"

  end
end
