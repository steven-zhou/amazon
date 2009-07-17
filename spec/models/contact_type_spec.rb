require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactType do
  before(:each) do
    @contact_type = Factory.build(:contact_type)
  end
  
  it {should have_many(:contacts)}
    
  it {should validate_presence_of(:name, :metatype)}  
  it {should allow_mass_assignment_of(:name, :metatype)}
  
  
  it "should not be valid with an incorrect metatype" do
    @contact_type.metatype = "FOO"
    @contact_type.valid?.should be_false
  end
  
  it "should be valid with a correct metatype" do
    @contact_type.valid?.should be_true
  end
  
end
