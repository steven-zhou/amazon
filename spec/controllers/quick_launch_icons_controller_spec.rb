require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuickLaunchIconsController do
  before(:each) do
    @login_account = Factory.build(:login_account)
    QuickLaunchIcons.stub!(:new).and_return(@quick_launch_icons)
  end


  def post_create(options = {})
    options[:controller] ||= "people"
    options[:action] ||= "show"
    options[:image_url] ||= "123.png"
    options[:title] ||= "People Profile"
   #options[:login_account_id] ||= @login_account.id
    xhr :post, "create", options
  end

  describe "POST 'create'" do
    it "should create a new quick launch icons" do
      QuickLaunchIcons.should_receive(:new).and_return(@quick_launch_icons)
      post_create
    end  
  end


  
end
