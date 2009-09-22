require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserGroup do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @user_group = Factory.build(:user_group)
  end

  it { should belong_to(:login_account) }
  it { should belong_to(:group_type)}
  it {should validate_presence_of(:user_id)}
  it {should validate_presence_of(:group_id)}

  it "should not save if the user_id is blank" do
    @user_group.user_id = ""
    @user_group.save.should == false
    @user_group.errors.on(:user_id).should_not be_nil

  end

  it "should not save if the group_id is blank" do
    @user_group.group_id = ""
    @user_group.save.should == false
    @user_group.errors.on(:group_id).should_not be_nil

  end

  it "should not save if the group_id is the same when user_id is the same" do
    @group_type = Factory(:group_type)
    @user_group_1 = UserGroup.new
    @user_group_2 = UserGroup.new
    @user_group_1.user_id = "1"
    @user_group_1.group_id = @group_type.id
    @user_group_1.save.should == true

    @user_group_2.user_id = "1"
    @user_group_2.group_id = @group_type.id
    @user_group_2.save.should == false
  end

  it "should save if the name is the same but the role_type is not same" do
    @group_type = Factory(:group_type)
    @user_group_1 = UserGroup.new
    @user_group_2 = UserGroup.new
    @user_group_1.user_id = "1"
    @user_group_1.group_id = @group_type.id
    @user_group_1.save.should == true

    @user_group_2.user_id = "2"
    @user_group_2.group_id = @group_type.id
    @user_group_2.save.should == true

  end

  




end