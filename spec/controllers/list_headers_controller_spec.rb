require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListHeadersController do

  before(:each) do
    @list_detail = Factory(:list_detail)
    @list_header = @list_detail.list_header
    @list_details = @list_header.list_details
    @query_header = @list_header.query_header
    @attributes = Factory.attributes_for(:list_header)
    ListHeader.stub!(:find).and_return(@list_header)
  end
  
  def post_create(options={})
    options[:type] ||= "StaticList"
    options[:list_header] ||= @attributes
    options[:query_header_id] ||= @query_header.id
    options[:person_id] = {"2" => "3", "4" => "5"}
    xhr :post, "create", options
  end

  def post_create_copy(options={})
    options[:source_id] ||= @list_header.id
    options[:list_header] ||= @attributes
    xhr :post, "create", options
  end

  def delete_destroy(options={})
    options[:id] ||= @list_header.id
    xhr :delete, "destroy", options
  end

  def get_edit(options={})
    options[:id] ||= @list_header.id
    xhr :get, "edit", options
  end

  def get_copy(options={})
    options[:id] ||= @list_header.id
    xhr :get, "copy", options
  end

  describe "Post Create" do

    it "should find the correct query header this list belongs to" do
        QueryHeader.stub!(:find).and_return(@query_header)
        QueryHeader.should_receive(:find).with(@query_header.id).and_return(@query_header)
        post_create
      end

    context "when type is Static List" do
      before(:each) do
        @static_list = @list_header
        StaticList.stub!(:new).and_return(@static_list)
      end      

      it "should create new Static List for save when type is StaticList" do
        StaticList.should_receive(:new).with(hash_including(@attributes)).and_return(@static_list)
        post_create
      end

      it "should save the new Static List" do
        @static_list.should_receive(:save)
        post_create
      end

    end

    context "when type is Dynamic List" do
      before(:each) do
        @dynamic_list = @list_header
        DynamicList.stub!(:new).and_return(@dynamic_list)
      end
      it "should create new Dynamic List for save when type is DynamicList" do
        DynamicList.should_receive(:new).with(hash_including(@attributes)).and_return(@dynamic_list)
        post_create :type => "DynamicList"
      end
      it "should save the new Dynamic List" do
        @dynamic_list.should_receive(:save)
        post_create :type => "DynamicList"
      end
    end
  end

  describe "Post Create Copy" do
    before(:each) do
      @list_header_old = @list_header
      ListHeader.stub!(:find).and_return(@list_header_old)
      ListHeader.stub!(:new).and_return(@list_header)
    end
    it "should find the old list for copy" do
        ListHeader.should_receive(:find).with(@list_header_old.id).and_return(@list_header_old)
      post_create_copy
    end

    it "should create a new list" do
      ListHeader.should_receive(:new)
      post_create_copy
    end
  end

  describe "Delete Destroy" do

    it "should find the current list header for delete" do
      ListHeader.should_receive(:find).with(@list_header.id).and_return(@list_header)
      delete_destroy
    end

    it "should delete the current list header" do
      @list_header.should_receive(:destroy)
      delete_destroy
    end
  end

  describe "Get Edit" do
    it "should find the current list for edit" do
      ListHeader.should_receive(:find).with(@list_header.id).and_return(@list_header)
      get_edit
    end

    it "should get the query_header belongs to current list" do
      @query_header.should == @list_header.query_header
    end

    it "should get all the list details belongs to current list" do
      @list_details.should == @list_header.list_details
      get_edit
    end
  end

  describe "Get Copy" do
    it "should find the current list for copy" do
      ListHeader.should_receive(:find).with(@list_header.id).and_return(@list_header)
      get_copy
    end
  end
end
