require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuickLaunchIconsController do
  before(:each) do
    @login_account = Factory.build(:login_account)
    @quick_launch_icons = Factory(:quick_launch_icon)
    QuickLaunchIcon.stub!(:new).and_return(@quick_launch_icons)
#    QuickLaunchIcon.stub!(:find).and_return(@quick_launch_icons)
    session[:user] = Factory(:login_account).id
  end


  def post_create(options = {})
    options[:controller] ||= "people"
    options[:action] ||= "show"
    options[:image_url] ||= "123.png"
    options[:title] ||= "People Profile"
   #options[:login_account_id] ||= @login_account.id
    xhr :post, "create", options
  end


    def delete_destroy(options = {})
    options[:id] ||= @quick_launch_icons.id
     xhr :delete, "destroy", options

  end

  describe "POST 'create'" do
    it "should create a new quick launch icons" do
      QuickLaunchIcon.should_receive(:new).and_return(@quick_launch_icons)
      post_create
    end  
  end

    describe "POST 'destory'" do

      before(:each) do
        QuickLaunchIcon.stub!(:find).and_return(@quick_launch_icons)
      end


    it "should find and destory a quick launch icons" do
  
      QuickLaunchIcon.should_receive(:find).with(@quick_launch_icons.id).and_return(@quick_launch_icons)
      @quick_launch_icons.should_receive(:destroy)
     delete_destroy
    end
  end


  
end
