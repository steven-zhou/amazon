require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagMetaTypesController do
  before(:each) do
    @attributes = Factory.attributes_for(:doc_tag_meta_type)
    @doc_tag_meta_type = Factory.build(:doc_tag_meta_type)
    @doc_tag_type = Factory.build(:doc_tag_type)
    MasterDocMetaMetaType.stub!(:new).and_return(@doc_tag_meta_type)
    MasterDocMetaMetaType.stub!(:find).and_return(@doc_tag_meta_type)
  end

  def get_new(options={})
    options[:tag] ||= "MasterDoc"
    xhr :get, "new", options
  end

  def get_edit(options={})
    options[:tag] ||= "MasterDoc"
    options[:id] ||= @doc_tag_meta_type.id
    xhr :get, "edit", options
  end
  
  def post_create(options={})
    options[:type] ||= "MasterDocMetaMetaType"
    options[:master_doc_meta_meta_type] ||= @attributes
    xhr :post, "create", options
  end

  def put_update(options={})
    options[:type] ||= "MasterDocMetaMetaType"
    options[:id] ||= @doc_tag_meta_type.id
    options[:master_doc_meta_meta_type] ||= @attributes
    xhr :put, "update", options
  end

  describe "get new" do
    it "should create a new MasterDocMetaMetaType" do
      MasterDocMetaMetaType.should_receive(:new).and_return(@doc_tag_meta_type)
      get_new
    end

    it "should render template /tag_meta_types/new.js" do
      get_new
      response.should render_template("tag_meta_types/new.js.erb")
    end
  end

  describe "get edit" do
    it "should find an existing MasterDocMetaMetaType with correct id" do
      MasterDocMetaMetaType.should_receive(:find).and_return(@doc_tag_meta_type)
      get_edit
    end

    it "should create a new MasterDocMetaType associate with the existing MasterDocMetaMetaType" do
      MasterDocMetaType.should_receive(:new).and_return(@doc_tag_type)
      get_edit
    end

    it "should render template /tag_meta_types/edit.js" do
      get_edit
      response.should render_template("tag_meta_types/edit.js.erb")
    end
  end

  describe "post create" do

    it "should create a new tag meta type for save" do
      MasterDocMetaMetaType.should_receive(:new).with(hash_including(@attributes)).and_return(@doc_tag_meta_type)
      post_create
    end

    it "should save the new tag meta type" do
      @doc_tag_meta_type.should_receive(:save)
      post_create
    end

    it "should flash[:message] after saved successfully" do
      post_create
      flash[:message].should have_at_least(1).things
    end

    it "should flash[:warning after saved unsuccessfully" do
      @doc_tag_meta_type.stub!(:save).and_return(false)
      post_create
      flash[:warning].should have_at_least(1).things
    end

    it "should render template /tag_meta_types/create.js" do
      post_create
      response.should render_template("tag_meta_types/create.js.erb")
    end
  end

  describe "put update" do

    it "should find the currect tag meta type for update" do
      MasterDocMetaMetaType.should_receive(:find).with(@doc_tag_meta_type.id).and_return(@doc_tag_meta_type)
      put_update
    end

    it "should update" do
      @doc_tag_meta_type.should_receive(:update_attributes).with(hash_including(@attributes))
      put_update
    end

    it "should flash[:message] after saved successfully" do
      put_update
      flash[:message].should have_at_least(1).things
    end

    it "should flash[:warning after saved unsuccessfully" do
      @doc_tag_meta_type.stub!(:update_attributes).and_return(false)
      put_update
      flash[:warning].should have_at_least(1).things
    end

    it "should render template /tag_meta_types/update.js" do
      put_update
      response.should render_template("tag_meta_types/update.js.erb")
    end
  end


 
end
