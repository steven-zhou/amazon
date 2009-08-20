require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LoginAccount do

  it { should belong_to(:person)}                     # Login accounts belong to a person

  
  context "when creating a new login account" do
    
    before(:each) do
      @login_account = Factory.build(:login_account)
    end

    it "should save a valid entry" do
      @login_account.save.should == true
    end

    it "should be invalid when having an invalid person_id" do
      @login_account.person_id = "-1"
      @login_account.save.should == false
      @login_account.errors.on(:person_id).should_not be_nil
    end

    it "should be invalid with no person_id" do
      @login_account.person_id = nil
      @login_account.save.should == false
      @login_account.errors.on(:person_id).should_not be_nil
      @login_account.person_id = ""
      @login_account.save.should == false
      @login_account.errors.on(:person_id).should_not be_nil
    end

    it "should be invalid if assigning a login account to a person that already has an account" do
      @person = Factory(:person)
      @login_account_1 = Factory.build(:login_account, :person_id => @person.id)
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :person_id => @person.id)
      @login_account_2.save.should == false
      @login_account_2.errors.on(:person_id).should_not be_nil
    end

    it "should be invalid without a username" do
      @login_account.user_name = nil
      @login_account.save.should == false
      @login_account.errors.on(:user_name).should_not be_nil
      @login_account.user_name = ""
      @login_account.save.should == false
      @login_account.errors.on(:user_name).should_not be_nil
    end

    it "should be invalid without a unique username" do
      @login_account_1 = Factory.build(:login_account, :user_name => "User Name")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :user_name => "User Name")
      @login_account_2.save.should == false
      @login_account_2.errors.on(:user_name).should_not be_nil
    end

    it "should accept a password, encrypt it and create a salt" do
      @login_account.password = "password"
      @login_account.save.should == true
      @login_account.password_hash.empty?.should_not == true
      @login_account.password_salt.empty?.should_not == true
      @login_account.password_hash.empty?.should_not == "password"
      @login_account.password_salt.empty?.should_not == "password"
    end

    it "should return the login account when supplied a valid username and password" do
      @login_account.password = "password"
      @login_account.save.should == true
      LoginAccount.authenticate(@login_account.user_name, "password").should == @login_account
    end

    it "should raise an error when we try to log in with an invalid username and password" do
      @login_account.password = "password"
      @login_account.save.should == true
      lambda {LoginAccount.authenticate(@login_account.user_name, "not_the_password")}.should raise_error(RuntimeError, "Username or password invalid")
    end

  end

end
