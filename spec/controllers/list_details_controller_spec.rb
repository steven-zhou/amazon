require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListDetailsController do
  before(:each) do
    @list_detail = Factory(:list_detail)
    @list_header = @list_detail.list_header
    @person = Factory(:jane)
  end

  def delete_destroy(options={})
    options[:id] ||= @list_detail.id
    xhr :delete, "destroy", options
  end

  def post_create(options={})
    options[:list_header_id] ||= @list_header.id
    options[:person_id] ||= @person.id
    xhr :post, "create", options
  end

  describe "Delete Destroy" do
    before(:each) do
      ListDetail.stub!(:find).and_return(@list_detail)
    end
    it "should find the selected list detail to delete" do
      ListDetail.should_receive(:find).with(@list_detail.id).and_return(@list_detail)
      delete_destroy
    end

    it "should delete the selected list detail" do
      @list_detail.should_receive(:destroy)
      delete_destroy
    end
  end

  describe "Post Create" do
    before(:each) do
      ListDetail.stub!(:new).and_return(@list_detail)
    end
    it "should create a new list detail" do
      ListDetail.should_receive(:new)
      post_create
    end
  end
end
