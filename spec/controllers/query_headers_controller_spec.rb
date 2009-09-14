require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryHeadersController do

  before(:each) do
    @query_header = Factory(:query_header)
    @attributes = @query_header
    QueryHeader.stub!(:new).and_return(@query_header)
    QueryHeader.stub!(:find).and_return(@query_header)
  end
  
  def get_new
    xhr :get, "new"
  end

  def post_update(options={})
    options[:id] ||= @query_header.id
    options[:query_header] ||= @attributes
    xhr :post, "update", options
  end

  def get_show_sql_statement(options={})
    options[:query_header_id] = @query_header.id
    xhr :get, "show_sql_statement"
  end

  def get_run(options={})
    options[:query_header_id] = @query_header.id
    xhr :get, "run"
  end

  describe "Get New" do
    it "should create a new query header for the new query" do
      QueryHeader.should_receive(:new)
      get_new
    end

    it "should save a new query header for the new query" do
      @query_header.should_receive(:save)
      get_new
    end

    it "should create a new query criteria for the new query" do
      QueryCriteria.should_receive(:new)
      get_new
    end

    it "should create a new query selection for the new query" do
      QuerySelection.should_receive(:new)
      get_new
    end

    it "should screateave a new query sorter for the new query" do
      QuerySorter.should_receive(:new)
      get_new
    end
  end


  describe "Post Update" do
    it "should find the correct query_header to update" do
      QueryHeader.should_receive(:find).and_return(@query_header)
      post_update
    end
  end

  describe "Get show_sql_statement" do
    it "should find the current query header" do
      QueryHeader.should_receive(:find).and_return(@query_header)
      get_show_sql_statement
    end
  end

  describe "Get Run" do
    it "should find the current query header to run" do
      QueryHeader.should_receive(:find).and_return(@query_header)
      get_run
    end
  end

end
