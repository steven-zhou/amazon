require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Title do
  it {should validate_presence_of(:name)}
  
  it {should allow_mass_assignment_of(:name)}
  
  it {should have_many(:primary_title_owners, :class_name=>"Person", :foreign_key => "primary_title_id")}
  it {should have_many(:second_title_owners, :class_name=>"Person", :foreign_key => "second_title_id")}

  
  
end
