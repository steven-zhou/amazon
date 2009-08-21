require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagsController do
   before(:each) do
    @attributes = Factory.attributes_for(:doc_tag)
    @doc_tag = Factory.build(:doc_tag)
    @doc_tag_type = Factory.build(:doc_tag_type)
    MasterDocType.stub!(:new).and_return(@doc_tag)
    MasterDocType.stub!(:find).and_return(@doc_tag)
    MasterDocMetaType.stub!(:find).and_return(@doc_tag_type)
  end

  def get_new(options={})
    options[:tag] ||= "MasterDoc"
    xhr :get, "new", options
  end

  def post_create(options={})
    options[:type] ||= "MasterDocType"
    options[:tag_type] ||= "MasterDocMetaType"
    options[:tag_type_id] ||= @doc_tag_type.id
    options[:master_doc_type] ||= @attributes
    xhr :post, "create", options
  end

  def get_edit(options={})
    options[:tag] ||= "MasterDoc"
    options[:id] ||= @doc_tag.id
    xhr :get, "edit", options
  end

  def put_update(options={})
    options[:type] ||= "MasterDocType"
    options[:id] ||= @doc_tag.id
    options[:master_doc_type] ||= @attributes
    xhr :put, "update", options
  end

  describe "get new" do
    before(:each) do
      @doc_tag_type.tags << @doc_tag
      @doc_tag.tag_type == @doc_tag_type
      @doc_tag.save
      @doc_tag_type.save
    end

    it "should create a new tag" do
      MasterDocType.should_receive(:new)
      get_new
    end

    it "should get the tag_type which the new tag_type belongs to" do
      MasterDocMetaType.should_receive(:find).and_return(@doc_tag_type)
      get_new
    end

    it "should show all tags belongs to the tag_type" do
      get_new
      @doc_tag_type.tags.should include(@doc_tag)
    end

    it "should render template /tags/new.js" do
      get_new
      response.should render_template("tags/new.js.erb")
    end
  end

  describe "post create" do
    it "should create a new tag with current attributes" do
      MasterDocType.should_receive(:new).with(hash_including(@attributes)).and_return(@doc_tag)
      post_create
    end

    it "should find the corrent tag_type which the new tag belongs to" do
      MasterDocMetaType.should_receive(:find).and_return(@doc_tag_type)
      post_create
    end

    it "should build relationship between the new tag and the tag_type" do
      post_create
      @doc_tag_type.tags.should include(@doc_tag)
    end

    it "should save the new tag" do
      @doc_tag.should_receive(:save)
      post_create
    end

    it "should flash[:message] when save successfully" do
      post_create
      flash[:message].should have_at_least(1).things
    end

    it "should flash[:warning] when save unsuccessfully" do
      @doc_tag.stub!(:save).and_return(false)
      post_create
      flash[:warning].should have_at_least(1).things
    end
  end

  describe "get edit" do
    before(:each) do
      @doc_tag_type.tags << @doc_tag
      @doc_tag.tag_type == @doc_tag_type
      @doc_tag.save
      @doc_tag_type.save
    end

    it "should find the correct tag for edit" do
      MasterDocType.should_receive(:find).and_return(@doc_tag)
      get_edit
    end

    it "should show the tag_type it belongs to" do
      get_new
      @doc_tag.tag_type.should == @doc_tag_type
    end

    it "should show all tags belongs to the tag_type" do
      get_new
      @doc_tag_type.tags.should include(@doc_tag)
    end

    it "should render template /tags/edit.js" do
      get_edit
      response.should render_template("tags/edit.js.erb")
    end
  end

  describe "put update" do
    it "should find the correct tag for update" do
      MasterDocType.should_receive(:find).and_return(@doc_tag)
      put_update
    end

    it "should update attributes" do
      @doc_tag.should_receive(:update_attributes).with(hash_including(@attributes))
      put_update
    end

    it "should flash[:message] when update successfully" do
      put_update
      flash[:message].should have_at_least(1).things
    end

    it "should flash[:warning] when update unsuccessfully" do
      @doc_tag.stub!(:update_attributes).and_return(false)
      put_update
      flash[:warning].should have_at_least(1).things
    end

    it "should render template /tags/update.js" do
      put_update
      response.should render_template("tags/update.js.erb")
    end
  end
 
end
