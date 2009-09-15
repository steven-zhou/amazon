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
    options[:id] = @query_header.id
    xhr :get, "show_sql_statement", options
  end

  def get_run(options={})
    options[:id] = @query_header.id
    xhr :get, "run", options
  end

  def get_clear(options={})
    options[:id] = @query_header.id
    xhr :get, "clear", options
  end

  def get_edit(options={})
    options[:id] = @query_header.id
    xhr :get, "edit", options
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

    it "should update the result size" do
      @person = Factory.build(:person)
      @query_header.stub!(:run).and_return([@person])
      get_run
      @query_header.result_size.should == 1      
    end
  end

  describe "Get Clear" do
    it "should find the current query header to clear" do
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
      get_clear
    end

    it "should clear it's query criterias" do
      @query_criteria = QueryCriteria.new(:table_name => "People", :field_name => "first_name", :operator => "starts with", :value => "a")
      @query_header.query_criterias << @query_criteria
      @query_criteria.save
      get_clear
      @query_header.query_criterias.size.should == 0
    end

    it "should clear it's query selections" do
      @query_selection = QuerySelection.new(:table_name => "People", :field_name => "first_name")
      @query_header.query_selections << @query_selection
      @query_selection.save
      get_clear
      @query_header.query_selections.size.should == 0
    end

    it "should clear it's query sorters" do
      @query_sorter = QuerySorter.new(:table_name => "People", :field_name => "first_name", :ascending => true)
      @query_header.query_sorters << @query_sorter
      @query_sorter.save
      get_clear
      @query_header.query_sorters.size.should == 0
    end    
  end

  describe "Get Edit" do
    it "should find the currect query header for edit" do
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
      get_edit
    end

    it "should create new query criteria for edit" do
      QueryCriteria.should_receive(:new)
      get_edit
    end

    it "should create new query selection for edit" do
      QuerySelection.should_receive(:new)
      get_edit
    end

    it "should create new query sorter for edit" do
       QuerySorter.should_receive(:new)
       get_edit
    end
  end
end
