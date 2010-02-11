require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryHeadersController do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @query_header = Factory(:query_header)
    @org_query_header = Factory(:org_query_header)
    @attributes = @query_header
    PersonQueryHeader.stub!(:new).and_return(@query_header)
    QueryHeader.stub!(:new).and_return(@query_header)
    QueryHeader.stub!(:find).and_return(@query_header)
    PersonQueryHeader.stub!(:saved_queries).and_return([])
    OrganisationQueryHeader.stub!(:saved_queries).and_return([])
    session[:user] = Factory(:login_account).id
  end
  
  def get_new
    xhr :get, "new"
  end

  def put_update(options={})
    options[:id] ||= @query_header.id
    options[:query_header] ||= @attributes
    xhr :put, "update", options
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

  def delete_destroy(options={})
    options[:id] = @query_header.id
    xhr :delete, "destroy", options
  end

  def get_copy(options={})
    options[:id] = @query_header.id
    xhr :get, "copy", options
  end

  def post_create(options={})
    options[:source_id] = @query_header.id
    options[:query_header] = @query_header.attributes
    xhr :post, "create", options
  end

  describe "Get New" do
    it "should create a new query header for the new query" do
      PersonQueryHeader.should_receive(:new)
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
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
#      OrganisationQueryHeader.should_receive(:find).with(@org_query_header.id).and_return(@query_header)
      put_update
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

#    it "should update the result size" do
#      @person = Factory.build(:person)
#      @query_header.stub!(:run).and_return([@person])
#      get_run
#      @query_header.result_size.should == 1
#    end

    it "should create a new list header for create" do
      ListHeader.should_receive(:new)
      get_run
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

  describe "Delete Destroy" do
    it "should find the current query header for delete" do
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
      delete_destroy
    end

    it "should delelte the current query header" do
      @query_header.should_receive(:destroy)
      delete_destroy
    end
  end

  describe "Get Copy" do
    it "should find the current query header for copy" do
      QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
      get_copy
    end
  end

  describe "Post Create" do
     before(:each) do
      @query_header_old = @query_header
      @query_criteria1 = QueryCriteria.new(:table_name => "people", :field_name => "first_name", :operator => "starts with", :value => "a")
      @query_criteria2 = QueryCriteria.new(:table_name => "people", :field_name => "family_name", :operator => "starts with", :value => "b")
      @query_header_old.query_criterias << @query_criteria1
      @query_header_old.query_criterias << @query_criteria2
      @query_selection1 = QuerySelection.new(:table_name => "people", :field_name => "family_name")
      @query_header_old.query_selections << @query_selection1
      @query_sorter1 = QuerySorter.new(:table_name => "people", :field_name => "family_name", :ascending => true)
      @query_header_old.query_sorters << @query_sorter1
      @query_header_old.save

      @query_header = QueryHeader.new
    end
    it "should find the current query header for copy" do
      QueryHeader.should_receive(:find).with(@query_header_old.id).and_return(@query_header_old)
      post_create
    end

    it "should create a new query header for save the copy" do
      PersonQueryHeader.stub!(:new).and_return(@query_header)
      PersonQueryHeader.should_receive(:new).and_return(@query_header)
      post_create
    end

    it "should change the new query header to be a temp query header" do
      post_create
      @query_header.group.should == "save"
    end

    it "should copy all the query criterias from old to new query header" do
      post_create
      @query_header.query_criterias.should == [@query_criteria1, @query_criteria2]
    end
#
#    it "should copy all the query selections from old to new query header" do
#      post_create
#      @query_header.query_selections.should == [@query_selection1]
#    end
#
#    it "should copy all the query sorters from old to new query header" do
#      post_create
#      @query_header.query_sorters.should == [@query_sorter1]
#    end
  end
end
