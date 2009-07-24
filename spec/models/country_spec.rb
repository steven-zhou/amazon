require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  before(:each) do
  end
  
  it { should belong_to(:main_language)}
  it { should validate_presence_of(:short_name)}
  it { should validate_presence_of(:citizenship)}
  it { should have_many(:organisations)}
  
  it { should allow_mass_assignment_of(:short_name, :long_name, :citizenship, :capital, :iso_code, :currency, :currency_subunit, :main_language_id)}
  
end
