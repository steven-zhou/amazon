require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CompileListsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @include_list = Factory(:include_list)
    session[:user] = @include_list.login_account.id
  end

  def post_clear(options={})
    options[:login_account_id] ||= session[:user]
    xhr :post, "clear", options
  end

  def post_compile(options={})
    options[:login_account_id] ||= session[:user]
    xhr :post, "compile", options
  end

  describe "Post Clear" do
    before(:each) do
      CompileList.stub!(:find_all_by_login_account_id).and_return([@include_list])
    end

    it "should find all the compile lists belongs to the login account" do
      CompileList.should_receive(:find_all_by_login_account_id).and_return([@include_list])
      post_clear
    end
    
    it "should delete all the compile lists belongs to the login account" do
      @include_list.should_receive(:destroy)
      post_clear
    end
  end

  describe "Post Compile" do
#    context "if include list is empty should spell an error" do
#      it "should spell an error when include list is empty" do
#        IncludeList.stub!(:find_all_by_login_account_id).and_return([])
#        @people = Array.new
#        Array.stub!(:new).and_return(@people)
#        Array.should_receive(:new).and_return(@people)
#        post_compile
#      end
#    end
#
#    context "if include list is not empty should compile" do
#      before(:each) do
#
#      end
#   end
  end
end
