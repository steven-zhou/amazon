require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactsController do

  before(:each) do
    @primary_list = Factory(:primary_list)
    session[:user] = Factory(:login_account).id
  end

  #Delete this example and add some real ones
  it "should use ContactsController" do
    controller.should be_an_instance_of(ContactsController)
  end

end
