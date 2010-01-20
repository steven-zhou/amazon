require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IncludeListsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @include_list = Factory(:include_list)
    session[:user] = @include_list.login_account.id
  end

  def post_person_create(options={})
    options[:list_header_id] ||= @include_list.list_header.id
    options[:login_account_id] ||= @include_list.login_account.id
    options[:type] ||= "person"
    xhr :post, "create", options
  end

  def post_organisation_create(options={})
    options[:list_header_id] ||= @include_list.list_header.id
    options[:login_account_id] ||= @include_list.login_account.id
    options[:type] ||= "org"
    xhr :post, "create", options
  end

  def delete_destroy(options={})
    options[:id] ||= @include_list.id
    xhr :delete, "destroy", options
  end

  describe "Post PersonIncludeList Create" do
    before(:each) do
      PersonIncludeList.stub!(:new).and_return(@include_list)
    end
    it "should create new include list" do
      PersonIncludeList.should_receive(:new)
      post_person_create
    end

    it "should save the new include list" do
      @include_list.should_receive(:save)
      post_person_create
    end
  end

  describe "Post OrganisationIncludeList Create" do
    before(:each) do
      OrganisationIncludeList.stub!(:new).and_return(@include_list)
    end
    it "should create new include list" do
      OrganisationIncludeList.should_receive(:new)
      post_organisation_create
    end

    it "should save the new include list" do
      @include_list.should_receive(:save)
      post_organisation_create
    end
  end

  describe "Delete Destroy" do
    before(:each) do
      PersonIncludeList.stub!(:find).and_return(@include_list)
      OrganisationIncludeList.stub!(:find).and_return(@include_list)
    end
    it "should find the correct include list to delete" do
      PersonIncludeList.should_receive(:find).with(@include_list.id).and_return(@include_list)
      delete_destroy
    end
    it "should delete the current include list" do
      @include_list.should_receive(:destroy)
      delete_destroy
    end
  end
end
