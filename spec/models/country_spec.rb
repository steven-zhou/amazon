require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  before(:each) do
    @primary_list = Factory(:primary_list)
  end
  
  it { should belong_to(:main_language)}
  it { should validate_presence_of(:short_name)}
  it { should validate_presence_of(:citizenship)}
  it { should have_many(:organisations)}
  
end
