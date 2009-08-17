require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AdministrationsController do
  
  describe "index" do
    it "should create a new AmazonSetting" do
      AmazonSetting.should_receive(:new)
      xhr :get, "index"
    end

    it "should create a new TagMetaType" do
      TagMetaType.should_receive(:new)
      xhr :get, "index"
    end

    it "should create a new TagType" do
      TagType.should_receive(:new)
      xhr :get, "index"
    end

    it "should create a new Tag" do
      Tag.should_receive(:new)
      xhr :get, "index"
    end
    

    it "should render template '/administrations/index.html'" do
      xhr :get, "index"
      response.should render_template("administrations/index.html")
    end
  end
end
