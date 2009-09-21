require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LoginAccount do

  it { should belong_to(:person)}                     # Login accounts belong to a person
  it { should have_many(:user_groups, :foreign_key => "user_id")}
  it { should have_many(:group_types, :through => :user_groups, :uniq => true)}
  it { should have_many(:user_lists, :foreign_key => "user_id")}
  
  context "when creating a new login account" do
    
    before(:each) do
      @login_account = Factory.build(:login_account)
    end

    it "should save a valid entry" do
      @login_account.password = "newpassword"
      @login_account.password_confirmation = "newpassword"
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
      @login_account_1 = Factory.build(:login_account, :person_id => @person.id, :password => "postpassword", :password_confirmation => "postpassword")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :person_id => @person.id, :password => "postpassword", :password_confirmation => "postpassword")
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
      @login_account_1 = Factory.build(:login_account, :user_name => "UserName", :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :user_name => "UserName",  :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_2.save.should == false
      @login_account_2.errors.on(:user_name).should_not be_nil
    end

    it "should accept a password, encrypt it and create a salt" do
      @login_account.password = "password"
      @login_account.password_confirmation = "password"
      @login_account.save.should == true
      @login_account.password_hash.empty?.should_not == true
      @login_account.password_salt.empty?.should_not == true
      @login_account.password_hash.empty?.should_not == "password"
      @login_account.password_salt.empty?.should_not == "password"
    end

    it "should return the login account when supplied a valid username and password" do
      @login_account.password = "password"
      @login_account.password_confirmation = "password"
      @login_account.save.should == true
      LoginAccount.authenticate(@login_account.user_name, "password").should == @login_account
    end

    it "should raise an error when we try to log in with an invalid username and password" do
      @login_account.password = "password"
      @login_account.password_confirmation = "password"
      @login_account.save.should == true
      lambda {LoginAccount.authenticate(@login_account.user_name, "not_the_password")}.should raise_error(RuntimeError, "Username or password invalid")
    end

    it"should invalid when the username out of scope 6..30" do
      @login_account.password = "password"
      @login_account.user_name = "ab"
      @login_account.save.should == false
      @login_account.errors.on(:user_name).should_not be_nil
    end

    it"should valid when the username use the same word but capitalization and lowcase" do
      @login_account_1 = Factory.build(:login_account, :user_name => "Username", :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :user_name => "username", :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_2.save.should == true 
    end

    it "should invalid when the username out of the format" do
      @login_account_1 = Factory.build(:login_account, :user_name => "Username", :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :user_name => "Username_1", :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_2.save.should == false
      @login_account_3 = Factory.build(:login_account, :user_name => "Username29!@$%^&*()", :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_3.save.should == true
    end

    it "should invalid when the username is same as password" do
      @login_account_1 = Factory.build(:login_account, :user_name => "Username", :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :user_name => "Usernamepp", :password => "Usernamepp", :password_confirmation => "Usernamepp")
      #puts"debug--#{@login_account_2.to_yaml}"
      @login_account_2.save.should == false
    end

    it "should invalid when the password out of scope 6..30" do
      @login_account.password = "pass"
      @login_account.save.should == false
      @login_account.errors.on(:password).should_not be_nil
    end

    it "should invalid when the password is blank" do
      @login_account.password = ""
      @login_account.save.should == false
      @login_account.errors.on(:password).should_not be_nil

    end

    it "should invalid when the password and password_confirmation is different" do
      @login_account_1 = Factory.build(:login_account, :password => "passpass", :password_confirmation => "passpass")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :password => "passpass", :password_confirmation => "passpass2")
      @login_account_2.save.should == false
    end

    it "should invalid when the password is out of the format scope" do
      @login_account_1 = Factory.build(:login_account, :password => "passpassword", :password_confirmation => "passpassword")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :password => "passpassword_1", :password_confirmation => "passpassword_1")
      @login_account_2.save.should == false
      @login_account_3 = Factory.build(:login_account, :password => "Username29!@$%^&*()", :password_confirmation => "Username29!@$%^&*()")
      @login_account_3.save.should == true


    end

    it "should invalid when the security answer is same" do
      @login_account_1 = Factory.build(:login_account, :password => "passpassword", :password_confirmation => "passpassword", :question1_answer => "abc", :question2_answer => "bcd", :question3_answer => "cde")
      @login_account_1.save.should == true
      @login_account_2 = Factory.build(:login_account, :password => "passpassword", :password_confirmation => "passpassword", :question1_answer => "abc", :question2_answer => "abc", :question3_answer => "cde")
      @login_account_2.save.should == false
      @login_account_3 = Factory.build(:login_account, :password => "passpassword", :password_confirmation => "passpassword", :question1_answer => "abc", :question2_answer => "bcd", :question3_answer => "abc")
      @login_account_3.save.should == false
      @login_account_4 = Factory.build(:login_account, :password => "passpassword", :password_confirmation => "passpassword", :question1_answer => "abc", :question2_answer => "bcd", :question3_answer => "bcd")
      @login_account_4.save.should == false
    end



  end

end
