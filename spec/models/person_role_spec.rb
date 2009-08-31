require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonRole do

  before(:each) do
    @person_role = Factory.build(:person_role)
  end

  it "should save the record when data is valid" do
    @person_role.save.should == true
  end

  it "should not saved when the role_id is blank" do
    @person_role.role_id = ""
    @person_role.save.should == false
    @person_role.errors.on(:role_id).should_not be_nil

  end

  it "should not save when the role_id is invalid" do
    @person_role.role_id = "-1"
    @person_role.save.should == false
    @person_role.errors.on(:role_id).should_not be_nil
  end


  it "should not saved when the person_id is blank"

  it "should not saved when the person_id is invalid"

  it "should puts the new record on the bottom by sequence No"


end
