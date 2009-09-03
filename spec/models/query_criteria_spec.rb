require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryCriteria do

  before(:each) do
    @query_criteria = Factory.build(:query_criteria)
  end

  it { should belong_to(:query_header)}
end
