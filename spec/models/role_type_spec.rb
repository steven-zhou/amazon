require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoleType do
  before(:each) do
    @valid_attributes = Factory.attributes_for(:role_type)
  end

  it { should validate_presence_of(:name) }
  it { should have_many(:roles)}

  it "should create a new instance given valid attributes" do
    RoleType.create!(@valid_attributes)
  end
end
