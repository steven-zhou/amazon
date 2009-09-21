require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FaxesController do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @fax = Factory.build(:fax)
    @attributes = Factory.attributes_for(:fax)
    @person = @fax.contactable

    Fax.stub!(:find).and_return(@fax)
    Fax.stub!(:new).and_return(@fax)
    Fax.stub!(:contactable).and_return(@person)
    Fax.contactable.stub!(:faxes).and_return([@fax])
    session[:user] = Factory(:login_account).id
  end

  def post_create_info
    xhr :post, "create",:fax => @attributes, :person_id => @person.id
  end


  #    xhr :put, "update", :id => "1"
  def put_update(options = {})
    options[:id] ||= @fax.id
    options[:fax] ||= @attributes

    put :update,options
  end


  def delete_destroy(options = {})
    options[:id] ||= @fax.id
    delete :destroy, options
  end


  #Delete these examples and add some real ones
  it "should use FaxesController" do
    controller.should be_an_instance_of(FaxesController)
  end


  describe "GET 'create'" do
    before(:each) do
      Fax.stub!(:new).and_return(@fax)
    end

    it "should create a new fax with params[:fax]" do
      Fax.should_receive(:new).with(hash_including(@attributes)).and_return(@fax)
      post_create_info
    end

    it "should save the new fax" do
      @fax.should_receive(:save)
      post_create_info
    end

    it "should render template '/faxes/create.js.erb'" do
      post_create_info

      response.should render_template("faxes/create.js.erb")

    end
  end

  describe "GET 'update'" do
    it "should get the request fax general info" do
      Fax.should_receive(:find).with(@fax.id.to_s).and_return(@fax)
      put_update :id => @fax.id
    end

    it "should update the  fax information" do

      @fax.should_receive(:update_attributes).with(hash_including(@attributes)).and_return(true)
      put_update
    end
  end

  describe "GET 'destroy'" do
    before(:each) do
      Fax.stub!(:find).and_return(@fax)
    end
    it "should find a existed fax with params[:id]" do
      Fax.should_receive(:find).with(@fax.id.to_s).and_return(@fax)
      delete_destroy
    end

    it "should destroy the master_doc" do
      @fax.should_receive(:destroy)
      delete_destroy
    end

    it "should render faxes/destroy.js" do
      delete_destroy
      response.should render_template("faxes/destroy.js")
    end
  end
end
