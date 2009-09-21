require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AddressType do
  before(:each) do
    @primary_list = Factory(:primary_list)
  end
  
  it { should have_many(:addresses)}
  it { should validate_presence_of(:name)}
  
  it "should create a new instance given valid attributes" do
    AddressType.create!(Factory.attributes_for(:home_address_type))
  end
  
end
