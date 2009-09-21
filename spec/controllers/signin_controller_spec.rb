require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SigninController do
  before(:each) do

    @primary_list = Factory(:primary_list)
    @login_account = Factory.build(:login_account)

    @password = "password"
    @login_account.password = @password
    @login_account.password_confirmation = @password
    @login_account.save
    @group_type = Factory(:group_type)
    @user_group = UserGroup.new(:user_id => @login_account.id, :group_id => @group_type.id)
    @user_group.save
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
      @controller.instance_eval{flash.stub!(:sweep)}
      post_login(:password => "not the password")
      flash.now[:warning].should_not be_nil
    end

    it "should record the ip address of the user" do
      last_ip_address = @login_account.last_ip_address
      post_login
      @login_account = LoginAccount.find(@login_account.id)
      @login_account.last_ip_address.should_not == last_ip_address
    end

    it "should record the login date and time" do
      last_login = @login_account.last_login.should
      post_login
      @login_account = LoginAccount.find(@login_account.id)
      @login_account.last_login.should_not == last_login
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

    it "should record the the logoff time" do
      last_logoff = @login_account.last_logoff
      put_signout
      @login_account = LoginAccount.find(@login_account.id)
      @login_account.last_logoff.should_not == last_logoff
    end

    it "should redirect to the login_url" do
      put_signout
      response.should redirect_to(login_url)
    end

  end


end
