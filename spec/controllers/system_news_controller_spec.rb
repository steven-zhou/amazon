require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SystemNewsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    session[:user] = Factory(:login_account).id
    @system_news = Factory(:system_news)
    SystemNews.stub!(:new).and_return(@system_news)
    SystemNews.stub!(:find).and_return(@system_news)
  end
  
  def post_create(options={})
    options[:system_news] ||= @system_news.attributes
    xhr :post, "create", options
  end

  def delete_destroy(options={})
    options[:id] ||= @system_news.id
    xhr :delete, "destroy", options
  end

  describe "Post Create" do
    it "should create new system news for save" do
      SystemNews.should_receive(:new).with(hash_including(@system_news.attributes)).and_return(@system_news)
      post_create
    end

    it "should save the new system news" do
      @system_news.should_receive(:save)
      post_create
    end
  end

  describe "Delete Destroy" do
    it "should find the correct system news for delete" do
      SystemNews.should_receive(:find).with(@system_news.id).and_return(@system_news)
      delete_destroy
    end

    it "should destroy the system news" do
      @system_news.should_receive(:destroy)
      delete_destroy
    end
  end
end
