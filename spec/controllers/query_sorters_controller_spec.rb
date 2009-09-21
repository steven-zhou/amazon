require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuerySortersController do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @query_sorter = Factory(:query_sorter)
    @attributes = @query_sorter
    @query_header = @query_sorter.query_header
    session[:user] = Factory(:login_account).id
    QueryHeader.stub!(:find).and_return(@query_header)
    QuerySorter.stub!(:new).and_return(@query_sorter)
  end

  def post_create(options = {})
    options[:query_header_id] ||= @query_header.id
    options[:query_sorter] ||= @attributes
    xhr :post, "create", options
  end

  describe "post create" do

    it "should find the correct query header" do
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
      post_create
    end

    it "should create a new query criteria to save" do
      QuerySorter.should_receive(:new).with(@attributes).and_return(@query_sorter)
      post_create
    end
  end

end
