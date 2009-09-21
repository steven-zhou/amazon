require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonRole do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @person_role = Factory.build(:person_role)
  end

  it { should validate_presence_of(:role_id) }
  it { should validate_presence_of(:person_id) }
  it { should belong_to(:role_player, :class_name => 'Person', :foreign_key => 'person_id')}
  it { should belong_to(:role_assigner, :class_name => 'Person', :foreign_key => 'assigned_by')}
  it { should belong_to(:role_approver, :class_name => 'Person', :foreign_key => 'approved_by')}
  it { should belong_to(:role_superviser, :class_name => 'Person', :foreign_key => 'supervised_by')}
  it { should belong_to(:role_manager, :class_name => 'Person', :foreign_key => 'managed_by')}
  it { should belong_to(:role) }

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


  it "should not saved when the person_id is blank" do
    @person_role.person_id = ""
    @person_role.save.should == false
    @person_role.errors.on(:person_id).should_not be_nil
  end

  it "should not saved when the person_id is invalid" do
    @person_role.person_id = "-1"
    @person_role.save.should == false
    @person_role.errors.on(:person_id).should_not be_nil

  end

  it "should puts the new record on the bottom by sequence No" do

    @person_role_a = Factory.build(:person_role)
    @person_role_a.save
    @person_role_b = Factory.build(:person_role)
    @person_role_b.save

    @person_role_a.sequence_no.should == 1
    @person_role_b.sequence_no.should == 2
  end


end
