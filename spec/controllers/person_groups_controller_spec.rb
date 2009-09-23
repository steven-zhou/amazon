require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonGroupsController do
 before(:each) do
      @person = Factory(:person)
      @group = Factory(:group_type)
      @person_group = Factory(:person_group)
      PersonGroup.stub!(:new).and_return(@person_group)
      #PersonGroup.stub!(:save).and_return(@person_group)
           # GroupMetaMetaType.stub!(:find).and_return(@group_meta_meta_type)
    end


  def save_person_group(options={})
    options[:person_id]||=@person.id
    options[:group_id]||=@group.id

   xhr :put, "save_person_group", options
  end

  describe "Save Person ID and Group ID" do

    


    it "should save to the Person Group Table" do

      @person_group.should_receive(:save)
      save_person_group
    end

#        it "should find the selected group meta meta type" do
#      GroupMetaMetaType.should_receive(:find).with(@group_meta_meta_type.id).and_return(@group_meta_meta_type)
#     #  @group_meta_meta_type.should_receive(:find).and_return(@group_meta_types)
#      get_show_group_type
#    end

  end
end