require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonRolesController do
  before(:each) do

    @person_role = Factory.build(:person_role)
    @role = Factory.build(:role)
    @person = @person_role.role_player
    @role_attributes = Factory.attributes_for(:role)

    session[:user] = Factory(:login_account).id
    
  end


  def get_show(options = {})
    options[:id] ||= @person_role.id
    get :show, options
  end

  def delete_destroy(options = {})
    options[:id] ||= @person_role.id
    delete :destroy, options
  end


  it "should show the person_role we request when we use show" do
    # PersonRole.stub(:find).and_return(@person_role)
    PersonRole.should_receive(:find).with(@person_role.id).and_return(@person_role)
    get_show(:id => @person_role.id)

  end

  it "should find and destory the person_role specified" do
    # PersonRole.stub(:find).and_return(@person_role)
    PersonRole.should_receive(:find).with(@person_role.id).and_return(@person_role)
    @person_role.should_receive(:destroy)
    delete_destroy(:id => @person_role.id)
  end


end
