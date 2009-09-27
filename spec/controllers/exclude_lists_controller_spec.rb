require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExcludeListsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @exclude_list = Factory(:exclude_list)
    session[:user] = @exclude_list.login_account.id
  end

  def post_create(options={})
    options[:list_header_id] ||= @exclude_list.list_header.id
    options[:login_account_id] ||= @exclude_list.login_account.id
    xhr :post, "create", options
  end

  def delete_destroy(options={})
    options[:id] ||= @exclude_list.id
    xhr :delete, "destroy", options
  end

  describe "Post Create" do
    before(:each) do
      ExcludeList.stub!(:new).and_return(@exclude_list)
    end
    it "should create new include list" do
      ExcludeList.should_receive(:new)
      post_create
    end

    it "should save the new include list" do
      @exclude_list.should_receive(:save)
      post_create
    end
  end

  describe "Delete Destroy" do
    before(:each) do
      ExcludeList.stub!(:find).and_return(@exclude_list)
    end
    it "should find the correct include list to delete" do
      ExcludeList.should_receive(:find).with(@exclude_list.id).and_return(@exclude_list)
      delete_destroy
    end
    it "should delete the current include list" do
      @exclude_list.should_receive(:destroy)
      delete_destroy
    end
  end
end
