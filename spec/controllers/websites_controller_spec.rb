require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WebsitesController do
  before(:each) do
    @website = Factory.build(:website)  
    @attributes = Factory.attributes_for(:website)
    @person = @website.contactable
    session[:user] = Factory(:login_account).id
  end


  def post_create_info
    xhr :post, "create", :website => @attributes, :person_id => @person.id
  end


  #    xhr :put, "update", :id => "1"
  def put_update(options = {})
    options[:id] ||= @website.id
    options[:website] ||= @attributes

    put :update,options
  end

  def get_show(options = {})
    options[:id] ||= @website.id
    get :show, options
  end

  def get_edit(options = {})
    options[:id] ||= @website.id
    get :edit, options
  end

  def delete_destroy(options = {})
    options[:id] ||= @website.id
    delete :destroy, options
  end

  #Delete these examples and add some real ones
  it "should use EmailsController" do
    controller.should be_an_instance_of(WebsitesController)
  end


  describe "GET 'create'" do
    before(:each) do
      Website.stub!(:new).and_return(@website)
      Website.stub!(:contactable).and_return(@person)
      Website.contactable.stub!(:websites).and_return([@website])
    end

    it "should create a new website with params[:website]" do
      Website.should_receive(:new).with(hash_including(@attributes)).and_return(@website)
      post_create_info
    end

    it "should save the new website" do
      @website.should_receive(:save)
      post_create_info
    end

    it "should render template '/websites/create.js.erb'" do
      post_create_info
      response.should render_template("websites/create.js.erb")

    end
  end
    
  describe "GET 'update'" do
    
    before(:each) do
      Website.stub!(:find).and_return(@website)
      Website.stub!(:new).and_return(@website)
      Website.stub!(:contactable).and_return(@person)
      Website.contactable.stub!(:websites).and_return([@website])
    end


    it "should get the request Website general info" do
      Website.should_receive(:find).with(@website.id).and_return(@website)
      put_update :id => @website.id
    end

    it "should update the  website information" do

      @website.should_receive(:update_attributes).with(hash_including(@attributes)).and_return(true)
      put_update
    end
  end

  describe "GET 'show'" do
    before(:each) do
      Website.stub!(:find).and_return(@website)
    end

    it "should find the website we request" do
      Website.should_receive(:find).with(@website.id).and_return(@website)
      get_show(:id => @website.id)
    end

  end

  describe "GET 'edit'" do
    before(:each) do
      Website.stub!(:find).and_return(@website)
    end

    it "should find the website we request" do
      Website.should_receive(:find).with(@website.id).and_return(@website)
      get_edit(:id => @website.id)
    end

  end

  describe "GET 'destroy'" do
    before(:each) do
      Website.stub!(:find).and_return(@website)
      Website.stub!(:new).and_return(@website)
      Website.stub!(:contactable).and_return(@person)
      Website.contactable.stub!(:websites).and_return([@website])
    end

    it "should find a existed website with params[:id]" do
      Website.should_receive(:find).with(@website.id).and_return(@website)
      delete_destroy
    end

    it "should destroy the website" do
      @website.should_receive(:destroy)
      delete_destroy
    end

    it "should render websites/destroy.js" do
      delete_destroy
      response.should render_template("websites/destroy.js")
    end
  end
end
