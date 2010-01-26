require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagMetaTypesController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @attributes = Factory.attributes_for(:doc_tag_meta_type)
    @doc_tag_meta_type = Factory.build(:doc_tag_meta_type)
    @doc_tag_type = Factory.build(:doc_tag_type)
    MasterDocMetaMetaType.stub!(:new).and_return(@doc_tag_meta_type)
    MasterDocMetaMetaType.stub!(:find).and_return(@doc_tag_meta_type)
    TagMetaType.stub!(:find).and_return(@doc_tag_meta_type)
    session[:user] = Factory(:login_account).id
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

  def get_show_group_type(options={})
    options[:group_meta_meta_type_id] ||= @group_meta_meta_type.id
    xhr :get, "show_group_types", options
  end
#
#  def get_show_group(options={})
#    options[:group_meta_type_id] ||= @group_meta_type.id
#    xhr :get, "show_types", options
#  end

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
      TagMetaType.should_receive(:find).and_return(@doc_tag_meta_type)
      get_edit
    end

    it "should show all tag types belongs to selected tag meta type" do
      @doc_tag_meta_type.tag_types << @doc_tag_type
      get_edit
      @doc_tag_meta_type.tag_types.should == [@doc_tag_type]
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

    it "should render template /tag_meta_types/update.js" do
      put_update
      response.should render_template("tag_meta_types/update.js.erb")
    end
  end

  describe "GET show_group_types" do
    before(:each) do
      @group_meta_meta_type = Factory(:group_tag_meta_type)
      @group_meta_type = Factory(:group_tag_type)

      @group_meta_meta_type.group_meta_types << @group_meta_type
      @group_meta_meta_type.save
      @group_meta_types = @group_meta_meta_type.group_meta_types
    
      GroupMetaMetaType.stub!(:find).and_return(@group_meta_meta_type)

      GroupMetaType.stub!(:find).and_return(@group_meta_types)
       GroupType.stub!(:find).and_return(@group_types)
    end

#    it "should find the selected group meta meta type" do
#      GroupMetaMetaType.should_receive(:find).with(@group_meta_meta_type.id).and_return(@group_meta_meta_type)
#     #  @group_meta_meta_type.should_receive(:find).and_return(@group_meta_types)
#      get_show_group_type
#    end


#  it "should find the group meta type" do
#
#     @group_meta_meta_type.group_meta_types.should_receive(:find).and_return(@group_meta_types)
#    # GroupMetaType.should_receive(:find)
#      get_show_group_type
#    end

  
#    it "should find the group type" do
#      GroupMetaType.should_receive(:find).with(@group_meta_type.id).and_return(@group_meta_type)
#      get_show_group
#    end


#    it "should find the group type" do
#      @group_meta_types.group_types.should_receive(:find).and_return(@group_meta_types)
#      get_show_group_type
#
#    end


  end
#       GroupMetaType.should_receive(:find).and_return(@group_meta_types)
#      +@group_meta_meta_type = GroupMetaMetaType.find(params[:group_meta_meta_type_id])
#      +@group_meta_types = @group_meta_meta_type.group_meta_types.find(:all, :order => "name")
end
