require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AmazonSettingsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @attributes = Factory.attributes_for(:male_gender)
    @amazon_setting = Factory(:male_gender)
    @amazon_setting2 = Factory(:female_gender)
    Gender.stub!(:new).and_return(@amazon_setting)
    session[:user] = Factory(:login_account).id
  end

  def get_new(options={})
    options[:type] ||= "Gender"
    xhr :get, "new", options
  end

  def post_create(options={})
    options[:type] ||= "Gender"
    options[:gender] ||= @attributes
    xhr :post, "create", options
  end

  def get_edit(options={})
    options[:id] ||= @amazon_setting.id
    xhr :get, "edit", options
  end

  def put_update(options={})
    options[:id] ||= @amazon_setting.id
    options[:type] ||= "Gender"
    options[:gender] ||= @attributes
    xhr :put, "update", options
  end

  def get_data_list_finder(options={})
    options[:type] ||= "Gender"
    xhr :get, "data_list_finder", options
  end
  
  describe "new" do
    it "should create a new amazonsetting" do
      Gender.should_receive(:new).and_return(@amazon_setting)
      get_new
    end

    it "should render template '/amazon_settings/new.js.erb'" do
      get_new
      response.should render_template("amazon_settings/new.js.erb")
    end
  end

  describe "create" do
    it "should get the new amazonsetting with correct content" do
      Gender.should_receive(:new).with(hash_including(@attributes)).and_return(@amazon_setting)
      post_create
    end

    it "should be saved" do
      @amazon_setting.should_receive(:save)
      post_create
    end

    it "should put flash message if save successfully" do
      post_create
      flash[:message].should have_at_least(1).things
    end


    it "should render template '/amazon_settings/create.js.erb" do
      post_create
      response.should render_template("amazon_settings/create.js.erb")
    end
  end

  describe "edit" do
    it "should find the corrent amazonsetting for edit" do
      AmazonSetting.should_receive(:find).and_return(@amazon_setting)
      get_edit
    end

    it "should render template '/amazon_settings/edit.js.erb" do
      get_edit
      response.should render_template("amazon_settings/edit.js.erb")
    end
  end

  describe "update" do

    before(:each) do
      AmazonSetting.stub!(:find).and_return(@amazon_setting)
    end


    it "should find the corrent amazonsetting for update" do
      AmazonSetting.should_receive(:find).with(@amazon_setting.id).and_return(@amazon_setting)
      put_update
    end

    it "should update attributes" do
      @amazon_setting.should_receive(:update_attributes)
      put_update
    end

    it "should be saved" do
      @amazon_setting.should_receive(:save).at_least(:once)
      put_update
    end

    it "should flash message when save successfully" do
      put_update
      flash[:message].should have_at_least(1).things
    end

    it "should render template '/amazon_settings/update.js.erb" do
      put_update
      response.should render_template("amazon_settings/update.js.erb")
    end
  end

  describe "data_list_finder" do
    before(:each) do
      AmazonSetting.stub!(:find).and_return([@amazon_setting, @amazon_setting2])
    end

    it "should return all the amazonsettings within the same type" do
      AmazonSetting.should_receive(:find).and_return([@amazon_setting, @amazon_setting2])
      get_data_list_finder
    end

    it "should render template amazon_settings/data_list_finder.js.erb" do
      get_data_list_finder
      response.should render_template("amazon_settings/data_list_finder.js.erb")
    end
  end


end
