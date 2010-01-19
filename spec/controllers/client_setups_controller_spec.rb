require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClientSetupsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    session[:user] = Factory(:login_account).id
    @client_setup = Factory(:client_setup)
    ClientSetup.stub!(:find).and_return(@client_setup)
  end

  def put_update(options={})
    options[:client_setup] ||= @client_setup.attributes
    put :update, options
  end

  describe "Put Update" do
    it "should find the client setup for update" do
      ClientSetup.should_receive(:first).and_return(@client_setup)
#      dfdfsd
      put_update
    end

    it "should update the client setup" do
      @client_setup.should_receive(:update_attributes)
      put_update
    end
  end
end
