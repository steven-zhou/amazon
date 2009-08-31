require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonRole do
  #  before(:each) do
  #    @valid_attributes = {
  #      :person_id => 1,
  #      :role_id => 1,
  #      :remarks => "Some remark"
  #    }
  #    @attributes = Factory.attributes_for(:employment)
  #    @attributes = Factory.attributes_for(:person_role)
  #    @person_role = Factory.build(:person_role)
  #  end
  #
  #  it { should belong_to(:role_player, :class_name => 'Person', :foreign_key => 'person_id')}
  #  it { should belong_to(:role_assigner, :class_name => 'Person', :foreign_key => 'assigned_by')}
  #  it { should belong_to(:role_approver, :class_name => 'Person', :foreign_key => 'approved_by')}
  #  it { should belong_to(:role_superviser, :class_name => 'Person', :foreign_key => 'supervised_by')}
  #  it { should belong_to(:role_manager, :class_name => 'Person', :foreign_key => 'managed_by')}
  #  it { should belong_to(:role) }
  #
  #
  #  it "should create a new instance given valid attributes" do
  #    PersonRole.create!(@valid_attributes)
  #  end
  before(:each) do
    @person_role = PersonRole.new
    @person = Factory.build(:jane)
    @role = Factory.build(:role)
    @person_role.role_player = @person
    @person_role.role = @role
  end

  it "should save the record when data is valid" do

    @person_role.save.should == true
  end

  it "should not saved when the role_id is blank" do
    @person_role = PersonRole.new
    @person_role.role_id = ""
    @person_role.save.should == false
    @person_role.errors.on(:role_id).should_not be_nil

  end

  it "should not saved when the role_id is wrong" do

   @person_role = PersonRole.new
  @person_role.role_id = "-1"
  @person_role.save.should == false
  @person_role.errors.on(:role_id).should_not be_nil

  end


  it "should not saved when the person_id is blank"

  it "should not saved when the person_id is wrong"

  it "should puts the new record on the bottom by sequence No"


end
