require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuerySelectionsController do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @query_selection = Factory(:query_selection)    
    @attributes = @query_selection
    @query_header = @query_selection.query_header
    session[:user] = Factory(:login_account).id
    QueryHeader.stub!(:find).and_return(@query_header)
    QuerySelection.stub!(:new).and_return(@query_selection)
  end

  def post_create(options = {})
    options[:query_header_id] ||= @query_header.id
    options[:query_selection] ||= @attributes
    xhr :post, "create", options
  end

  describe "post create" do

    it "should find the correct query header" do
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
      post_create
    end

    it "should create a new query criteria to save" do
      QuerySelection.should_receive(:new).with(@attributes).and_return(@query_selection)
      post_create
    end
  end

  
end
