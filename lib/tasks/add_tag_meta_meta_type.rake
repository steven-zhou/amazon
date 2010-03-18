namespace :db do
  desc "Add Tag Meta Meta Type"
  task :add_tag_meta_meta_type => :environment do
    puts "Run Patch all TagMetaMetaType ..."
    ExtraType.all.each do |i|
      i.destroy
    end

    ExtraMetaType.all.each do |i|
      i.destroy
    end
    
    ExtraMetaMetaType.all.each do |i|
      i.destroy
    end

    ExtraMetaMetaType.create(:name => "Custom Field", :status => true, :to_be_removed =>false)
    
    ExtraMetaType.create(:name => "Group One",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
    ExtraMetaType.create(:name => "Group Two",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
    ExtraMetaType.create(:name => "Group Three",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
    ExtraMetaType.create(:name => "Group Four",:tag_meta_type_id=>ExtraMetaMetaType.find_by_name("Custom Field").id, :status => true,:to_be_removed =>false)
    
    ExtraType.create(:name => "Label One",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Two",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Three",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Four",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Five",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Six",:tag_type_id=>ExtraMetaType.find_by_name("Group One").id, :status => true,:to_be_removed =>false)

    ExtraType.create(:name => "Label One",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Two",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Three",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Four",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Five",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Six",:tag_type_id=>ExtraMetaType.find_by_name("Group Two").id, :status => true,:to_be_removed =>false)

    ExtraType.create(:name => "Label One",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Two",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Three",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Four",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Five",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Six",:tag_type_id=>ExtraMetaType.find_by_name("Group Three").id, :status => true,:to_be_removed =>false)

    ExtraType.create(:name => "Label One",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Two",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Three",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Four",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Five",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
    ExtraType.create(:name => "Label Six",:tag_type_id=>ExtraMetaType.find_by_name("Group Four").id, :status => true,:to_be_removed =>false)
    puts "DONE"
  end
end
