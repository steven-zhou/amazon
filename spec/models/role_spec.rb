require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Role do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :role_type_id => 1
    }
  end

  it { should belong_to(:role_type)}
  it { should have_many(:person_roles)}
  it { should have_many(:role_players, :through => :person_roles, :source => :role_player)}
  

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:role_type_id) }
  it { should validate_associated(:role_type)}
  
  it "should create a new instance given valid attributes" do
    Role.create!(@valid_attributes)
  end
end
