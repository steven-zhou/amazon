namespace :db do
  desc "Add Tag Meta Meta Type"
  task :add_tag_meta_meta_type => :environment do
    puts "Run Patch all TagMetaMetaType ..."
    
    ExtraMetaMetaType.all.each do |i|
      i.destroy
    end

    ExtraMetaMetaType.create :name => "Custom Field", :status => true,:to_be_removed =>false

    puts "DONE"

    puts "Run Patch Custom Group"
    ExtraMetaType.all.each do |i|
      i.destroy
    end


    ExtraMetaType.create(:name => "Group One",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
    ExtraMetaType.create(:name => "Group Two",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
    ExtraMetaType.create(:name => "Group Three",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
    ExtraMetaType.create(:name => "Group Four",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)

  end
end
