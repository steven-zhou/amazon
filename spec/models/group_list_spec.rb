require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GroupList do
  before(:each) do
    @group_list = Factory.build(:group_list)
  end

  it {should belong_to(:list_header)}

  it {should belong_to(:group_type)}

  it {should validate_presence_of(:list_header_id)}
  it {should validate_presence_of(:tag_id)}

  it "should not save if the tag_id is blank" do
    @user_group.tag_id = ""
    @user_group.save.should == false
    @user_group.errors.on(:tag_id).should_not be_nil

  end
















end
