require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AdministrationsController do

  before(:each) do
    @primary_list = Factory(:primary_list)
    session[:user] = Factory(:login_account).id
  end
  
  describe "Get System Setting" do
    it "should render template '/administrations/system_setting.html'" do
      xhr :get, "system_setting"
      response.should render_template("administrations/system_setting.html")
    end
  end

  describe "System Management" do

    it "create a new role" do
      Role.should_receive(:new)
      xhr :get, "system_management"
    end

    it "create a new role condition" do
      RoleCondition.should_receive(:new)
      xhr :get, "system_management"
    end

    it "create a new role type" do
      RoleType.should_receive(:new)
      xhr :get, "system_management"
    end

    it "create a new login account" do
      LoginAccount.should_receive(:new)
      xhr :get, "system_management"
    end

    it "should render template '/administrations/system_management.html'" do
      xhr :get, "system_management"
      response.should render_template("administrations/system_management.html")
    end
  end

  describe "List Management" do
    it "should render template '/administrations/list_management.html'" do
      xhr :get, "list_management"
      response.should render_template("administrations/list_management.html")
    end
  end

  describe "Get Duplication Formula" do
    it "should find the duplication formula" do
      DuplicationFormula.should_receive(:first)
      xhr :get, "duplication_formula"
    end
  end
end
