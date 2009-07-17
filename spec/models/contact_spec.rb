require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contact do
  before(:each) do
    @valid_attributes = Factory.attributes_for(:contact)
    @contact = Factory.build(:contact)
  end

  it {should belong_to(:contact_type)}
  
  it "should belong to contactable" do
    Contact.reflect_on_association(:contactable).nil?.should == false
  end
  
end
