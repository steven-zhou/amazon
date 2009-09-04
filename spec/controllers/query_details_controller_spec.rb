require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryDetailsController do

  before(:each) do
    @query_detail = Factory.build(:query_detail)
    QueryDetail.stub!(:new).and_return(@query_detail)
    session[:user] = Factory(:login_account).id
  end

  describe "get new" do
    it "should create a new query_detail to save" do
      QueryDetail.should_receive(:new).and_return(@query_detail)
      get :new
    end
  end
end
