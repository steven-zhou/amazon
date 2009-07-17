require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TitleType do  
  it {should validate_presence_of(:name)}
  it {should allow_mass_assignment_of(:name)}
  
  
end
