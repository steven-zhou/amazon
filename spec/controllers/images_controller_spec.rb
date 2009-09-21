require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ImagesController do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @image = Factory(:image)
    Image.stub!(:find).and_return(@image)
    session[:user] = Factory(:login_account).id
  end

  describe "get show" do
    it "should find the correct image for show" do
      Image.should_receive(:find)
      get :show
    end

    it "should render show.jpg" do
      get :show
      response.should render_template("images/show.jpg")
    end
  end

  describe "get edit" do
    it "should find the correct image for edit" do
      Image.should_receive(:find)
      get :edit
    end
  end

end
