require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoleType do
  before(:each) do

    @role_type = Factory.build(:role_type)
  end

  it { should validate_presence_of(:name) }
  it { should have_many(:roles)}
  it "should save with valid record"do
    @role_type.save.should == true     
  end
  it "should not save without name" do

    @role_type.name = ""
    @role_type.save.should == false
    @role_type.errors.on(:name).should_not be_nil
  end
  it "should have the unique name" do
    @role_type.save.should == true
    @role_type_2 = Factory.build(:role_type, :name => @role_type.name)
    @role_type_2.save.should == false
    @role_type_2.errors.on(:name).should_not be_nil
    @role_type_3 = Factory.build(:role_type, :name => "new_name")
    @role_type_3.save.should == true


  end


  it "should assigned lowest priority to new record"
  it "should reorder when we delete record"
  it "should return all active role_type"



end
