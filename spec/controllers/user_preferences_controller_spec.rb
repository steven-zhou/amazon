require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserPreferencesController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @email = Factory.build(:email)
    @attributes = Factory.attributes_for(:email)
    @person = @email.contactable
    @login_account = Factory(:login_account)


  end


  def post_create_info(options = {})

    options[:old_email] ||= @attributes
    options[:new_email] ||= "new@powernet.com"
    xhr :post, "change_email", options
  end


  describe "GET 'change_email'" do
    before(:each) do

     LoginAccount.stub!(:find).and_return(@login_account)
     @login_account.stub!(:security_email).and_return(@email)
    end

    it "should find a current user" do
      LoginAccount.should_receive(:find).and_return(@login_account)
    
     post_create_info
    end

#     it "old email should equel to the new email" do
#
#    end

    it "should save the current user email" do
         @login_account.should_receive(:save)
      post_create_info
    end


  end

end
