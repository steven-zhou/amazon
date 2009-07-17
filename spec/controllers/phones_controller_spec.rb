require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhonesController do

  before(:each) do
    @phone = Factory.build(:phone, :id => 1)

    @attributes = Factory.attributes_for(:phone)
    Phone.stub!(:find).and_return(@phone)
    @person = Factory.build(:person)
    Person.stub!(:find).and_return(@person)
  end

  def post_create_info
    xhr :post, "create",:phone => @attributes
  end


  #    xhr :put, "update", :id => "1"
  def put_update(options = {})
    options[:id] ||= @phone.id
    options[:phone] ||= @attributes

#    options[:email][@email.id.to_s] = @attributes
    put :update,options
  end


   def delete_destroy(options = {})
    options[:id] ||= @phone.id
    delete :destroy, options
  end


  #Delete these examples and add some real ones
  it "should use PhonesController" do
    controller.should be_an_instance_of(PhonesController)
  end


  describe "GET 'create'" do
    before(:each) do
      Phone.stub!(:new).and_return(@phone)
    end

    it "should create a new phone with params[:phone]" do
      Phone.should_receive(:new).with(hash_including(@attributes)).and_return(@phone)
      post_create_info
    end

    it "should save the new phone" do
      @phone.should_receive(:save)
      post_create_info
    end

    it "should render template '/phones/create.js.erb'" do
      post_create_info

      response.should render_template("phones/create.js.erb")

    end
  end

  describe "GET 'update'" do
      it "should get the request phone general info" do
      Phone.should_receive(:find).with(@phone.id.to_s).and_return(@phone)
      put_update :id => @phone.id
    end

     it "should update the  phone information" do

      @phone.should_receive(:update_attributes).with(hash_including(@attributes)).and_return(true)
      put_update
     end
  end

  describe "GET 'destroy'" do
    before(:each) do
      Phone.stub!(:find).and_return(@phone)
    end
    it "should find a existed phone with params[:id]" do
      Phone.should_receive(:find).with(@phone.id.to_s).and_return(@phone)
      delete_destroy
    end

    it "should destroy the master_doc" do
      @phone.should_receive(:destroy)
      delete_destroy
    end

    it "should render phones/destroy.js" do
      delete_destroy
      response.should render_template("phones/destroy.js")
    end
  end
end
