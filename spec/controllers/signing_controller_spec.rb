require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SigninController do
  before(:each) do
    @login_account = Factory.build(:login_account)
    @password = "password"
    @login_account.password = @password
    @login_account.save
  end

  def post_login(options = {})
    options[:user_name] ||= @login_account.user_name
    options[:password] ||= @password
    post :login, options
  end

  def put_signout(options = {})
    put :signout, options
  end


  describe "when logging in" do
    before(:each) do

    end

    it "should set session[:user] to be the correct LoginAccount.id with a correct username and password" do
      LoginAccount.should_receive(:authenticate).with(@login_account.user_name, @password).and_return(@login_account)
      post_login
      session[:user].should == @login_account.id
    end

    it "should redirect to the intended controller and action if set when logging in with correct credentials" do
      session[:intended_controller] = "signin"
      session[:intended_action] = "signout"
      post_login
      response.should redirect_to(:controller => "signin", :action => "signout")
    end

    it "should redirect to the welcome_url if the username and password are correct (and we did not set a intended controller and action)" do
      post_login
      response.should redirect_to(welcome_url)
    end

    it "should rescue an exception when the username and password are incorrect and set a flash message" do
      post_login(:password => "not the password")
      flash[:warning].should_not be_nil
    end

  end

  describe "when logging out" do
    before(:each) do
      post_login
    end

    it "should clear session[:user]" do
      session[:user].should == @login_account.id
      put_signout
      session[:user].should == nil
    end

    it "should redirect to the login_url" do
      put_signout
      response.should redirect_to(login_url)
    end

  end


end
