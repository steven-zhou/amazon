require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @login_account = Factory(:login_account)
  end

  def put_check_authentication(options={})
    put :check_authentication, options
  end



  describe "when checking the user's authentication" do

    before(:each) do

    end


    it "when the user is not logged in it should redirect to the login_url" do
      put_check_authentication
      response.should redirect_to(login_url)
    end

    it "when the user is logged in should set @current_user to be the LoginAccount of the currently logged in user" do
      session[:user] = @login_account.id
      put_check_authentication
      assigns[:current_user].should == @login_account
    end


  end

  
end
