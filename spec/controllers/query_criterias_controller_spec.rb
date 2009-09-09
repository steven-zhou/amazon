require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryCriteriasController do

  before(:each) do
    @query_criteria = QueryCriteria.new(:table_name => "Addresses", :field_name => "state", :operator => "equals", :value => "NSW")
    @attributes = @query_criteria
    @query_header = Factory(:query_header)
    QueryHeader.stub!(:new).and_return(@query_header)
    QueryCriteria.stub!(:new).and_return(@query_criteria)
    session[:user] = Factory(:login_account).id
  end

  def post_create(options = {})
    options[:query_header_id] ||= @query_header.id
    options[:query_criteria] ||= @attributes
    xhr :post, "create", options
  end

  def post_update(options = {})
    options[:query_criteria] ||= @attributes
    xhr :post, "update", options
  end
  
  describe "post create" do
    it "should get the correct query header it belongs to" do
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
      post_create
    end

    it "should create a new query criteria to save" do
      QueryCriteria.should_receive(:new).with(@attributes).and_return(@query_criteria)
      post_create
    end
  end
end
