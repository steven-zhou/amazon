require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ToDoListsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    session[:user] = Factory(:login_account).id
    @to_do_list = Factory(:to_do_list)
    ToDoList.stub!(:new).and_return(@to_do_list)
    ToDoList.stub!(:find).and_return(@to_do_list)
  end

   def post_create(options={})
    options[:to_do_list] ||= @to_do_list.attributes
    xhr :post, "create", options
  end

  def delete_destroy(options={})
    options[:id] ||= @to_do_list.id
    xhr :delete, "destroy", options
  end

  describe "Post Create" do
    it "should create new to_do_list for save" do
      ToDoList.should_receive(:new).with(hash_including(@to_do_list.attributes)).and_return(@to_do_list)
      post_create
    end

    it "should save the new to_do_list" do
      @to_do_list.should_receive(:save)
      post_create
    end
  end

  describe "Delete Destroy" do
    it "should find the correct to_do_list for delete" do
      ToDoList.should_receive(:find).with(@to_do_list.id).and_return(@to_do_list)
      delete_destroy
    end

    it "should destroy the to_do_list" do
      @to_do_list.should_receive(:destroy)
      delete_destroy
    end
  end
end
