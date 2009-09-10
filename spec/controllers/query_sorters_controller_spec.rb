require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuerySortersController do

  before(:each) do
    @query_sorter = Factory.build(:query_sorter)
    QuerySorter.stub!(:new).and_return(@query_sorter)
    session[:user] = Factory(:login_account).id
  end

end
