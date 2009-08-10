require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Email do
  before(:each) do
    @email = Factory.build(:email)
    @attributes = Factory.build(:email)
  end

  # No longer used / needed
  # it {should belong_to(:contactable)}
  
  it "should return the address" do
    @email.address.should == @attributes[:value]
  end
  
  it "should save a new record as a primary email if there is no phone belongs to contactable" do
    @email.contactable.emails.clear
    @email.save!
    @email.priority_number.should == 1
  end
end
