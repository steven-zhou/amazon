require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryCriteriasController do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @query_criteria = Factory(:query_criteria)
    @attributes = @query_criteria
    @query_header = @query_criteria.query_header    
    QueryHeader.stub!(:find).and_return(@query_header)
    QueryCriteria.stub!(:new).and_return(@query_criteria)
    session[:user] = Factory(:login_account).id
  end

  def post_create(options = {})
    options[:query_header_id] ||= @query_header.id
    options[:query_criteria] ||= @attributes
    xhr :post, "create", options
  end
  
  describe "post create" do

    it "should find the correct query header" do
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
      post_create
    end
    
    it "should create a new query criteria to save" do
      QueryCriteria.should_receive(:new).with(@attributes).and_return(@query_criteria)
      post_create
    end
  end
  
end
