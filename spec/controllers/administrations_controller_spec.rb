require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AdministrationsController do
  
  describe "index" do
    it "should render template '/administrations/index.html'" do
      xhr :get, "index"
      response.should render_template("administrations/index.html")
    end
  end
end
