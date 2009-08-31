require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe RoleType do
  before(:each)do
    @role_type = Factory.build(:role_type)
  end

  it "should save when it is valid" do
    @role_type.save.should == true
  end
  it "should not save when the attribute name is blank" do
    @role_type.name = ""
    @role_type.save.should == false
    @role_type.errors.on(:name).should_not be_nil
  end
  it { should validate_presence_of(:name) }
  it { should have_many(:roles)}
  it "should not save when the name already exist in the system" do
    @role_type_1 = Factory.build(:role_type)
    @role_type_1.save.should == true
    @role_type_2 = Factory.build(:role_type)
    @role_type_2.name = @role_type_1.name
    @role_type_2.save.should == false
    @role_type_2.errors.on(:name).should_not be_nil
    @role_type_3 = Factory.build(:role_type)
    @role_type_3.name = "new"
    @role_type_3.save.should == true
  end
  it "should assigned lowest priority to the new record" do

    @role_type_a = Factory.build(:role_type)
    @role_type_a.save
    @role_type_b = Factory.build(:role_type)
    @role_type_b.save

    @role_type_a.position.should == 1
    @role_type_b.position.should == 2
  end

  it "should remove priority when record destroied" do
    @role_type_c = Factory.build(:role_type)
    @role_type_c.save
    @role_type_d = Factory.build(:role_type)
    @role_type_d.save

    @role_type_c.position.should == 1
    @role_type_d.position.should == 2

  end

   



end
