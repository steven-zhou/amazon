require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Title do
  it {should validate_presence_of(:name)}
  
  it {should allow_mass_assignment_of(:name)}
  
  it {should belong_to(:title_type)}
  it {should have_many(:people)}
  it {should have_many(:secondary_people)}
  
  
end
