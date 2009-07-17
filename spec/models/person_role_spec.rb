require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonRole do
  before(:each) do
    @valid_attributes = {
      :person_id => 1,
      :role_id => 1,
      :remarks => "Some remark"
    }
  end
  
  it { should belong_to(:person) }
  it { should belong_to(:role) }

  it "should create a new instance given valid attributes" do
    PersonRole.create!(@valid_attributes)
  end
end
