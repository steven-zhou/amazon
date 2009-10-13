require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GridsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    session[:user] = Factory(:login_account).id
  end
  
end
