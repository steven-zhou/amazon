require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoleCondition do
  before(:each) do
    @role_condition = Factory.build(:role_condition)
  end

  it "should save the correct data" do
    @role_condition.save.should == true  
  end

  it "should always have the condition data" do
    @role_condition.doctype_id = nil
    @role_condition.save.should == false
    @role_condition.errors.on(:doctype_id).should_not be_nil

    @role_condition.doctype_id = ""
    @role_condition.save.should == false
    @role_condition.errors.on(:doctype_id).should_not be_nil
  end

  it "should always have the role data" do
    @role_condition.role_id = nil
    @role_condition.save.should == false
    @role_condition.errors.on(:role_id).should_not be_nil

    @role_condition.role_id = ""
    @role_condition.save.should == false
    @role_condition.errors.on(:role_id).should_not be_nil
  end
  it "should have the valid condition" do
    @role_condition.doctype_id = "-1"
    @role_condition.save.should == false
    @role_condition.errors.on(:doctype_id).should_not be_nil
  end
  it "should have the valid role" do
    @role_condition.role_id = "-1"
    @role_condition.save.should == false
    @role_condition.errors.on(:role_id).should_not be_nil
  end
  it "should have unique doctype for the same role" do
    #    @doctype = Factory(:master_doc_type)
    #    @role = Factory(:role)
    #    @role_condition_1 = Factory.build(:role_condition)
    #    @role_condition_1.doctype_id = "10"
    #    @role_condition_1.role_id = "10"
    #    @role_condition_1.save.should == true
    #    @role_condition_2 = Factory.build(:role_condition)
    #    @role_condition_2.doctype_id = "10"
    #    @role_condition_2.role_id = "10"
    #    @role_condition_2.save.should == false
    #    @role_condition_2.errors.on(:doctype_id).should_not be_nil

    #    @doctype = Factory(:master_doc_type)
    #    @role_condition_1 = Factory.build(:role_condition, :doctype_id => @doctype.id)
    #    @role_condition_1.save.should == true
    #    @role_condition_2 = Factory.build(:role_condition, :doctype_id => @doctype.id)
    #    @role_condition_2.save.should == false
    #    @role_condition_2.errors.on(:doctype_id).should_not be_nil
  end
  it "should belongs to Roles" do
    RoleCondition.reflect_on_association(:role).nil?.should == false
  end
  it "should belong to conditions" do
    RoleCondition.reflect_on_association(:master_doc_type).nil?.should == false
  end

end

 