require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Grid do
  before(:each) do
    @primary_list = Factory(:primary_list)
  end

  it { should belong_to(:login_account)}
end
