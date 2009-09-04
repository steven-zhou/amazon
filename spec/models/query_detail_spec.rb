require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryDetail do

  before(:each) do
    @query_detail = Factory.build(:query_detail)
  end

  it { should belong_to(:query_header)}
end
