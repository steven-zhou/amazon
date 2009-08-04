require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactType do
  before(:each) do
    @contact_type = Factory.build(:ct_phone_home)
  end
  
  it {should have_many(:contacts)}

  it {should belong_to(:contact_meta_type)}
  it {should validate_presence_of(:name)}  
  it {should allow_mass_assignment_of(:name)}
  
    
end
