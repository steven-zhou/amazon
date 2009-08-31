require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Role do
  before(:each) do
   @role = Factory.build(:role)
  end

  it { should belong_to(:role_type)}
  it { should have_many(:person_roles)}
  it { should have_many(:role_conditions)}
  it { should have_many(:role_players, :through => :person_roles, :source => :role_player)}
  

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:role_type_id) }
  it { should validate_associated(:role_type)}
  
  it "should save the the record if it is valid" do
    
    @role.save.should == true
    
  end


  it "should not save if the name not exist"

  it "should not save if the name is the same when role_type is the same"

  it "should save if the name is the same but the role_type is not same"



end
