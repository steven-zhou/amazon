require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AddressesController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @attributes = Factory.attributes_for(:personal_home_address)
    @address = Factory.build(:personal_home_address)
    @person = @address.addressable
    Person.stub!(:find).and_return(@person)
    session[:user] = Factory(:login_account).id
  end
  
  describe "POST 'create'" do
    before(:each) do
      Address.stub!(:new).and_return(@address)
    end

    it "should create a new address with params[:address]" do
      Address.should_receive(:new).with(hash_including(@attributes)).and_return(@address)
      xhr :post, "create",:address => @attributes
    end
    
    it "should save the new address" do
      @address.should_receive(:save)
      xhr :post, "create",:address => @attributes
    end

    it "should render template '/addresses/create.js.erb'" do
      xhr :post, "create",:address => @attributes
      response.should render_template("addresses/create.js.erb")
    end
  end
end
