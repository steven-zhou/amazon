require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RolesController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @role = Factory(:role)
    @attributes = Factory.attributes_for(:role)
    session[:user] = Factory(:login_account).id
    #    Role.stub!(:find).and_return(@role)
    #    @person = Factory.build(:person)
    #    Person.stub!(:find).and_return(@person)
    #    session[:user] = Factory(:login_account).id
  end

  #    xhr :put, "update", :id => "1"
  def put_update(options = {})
    options[:id] ||= @role.id
    options[:role] ||= @attributes
    put :update,options
  end


  def delete_destroy(options = {})
    options[:id] ||= @role.id
    delete :destroy, options
  end


  #Delete these examples and add some real ones
  it "should use RolesController" do
    controller.should be_an_instance_of(RolesController)
  end

  describe 'put update' do

    before(:each) do
      Role.stub!(:find).with(@role.id).and_return(@role)
      #@roles = Role.find(:all, :conditions => ["role_type_id=?",params[:role_type_id]]) unless (params[:role_type_id].nil? || params[:role_type_id].empty?)

    end

    it "should find the correct role which waiting for update" do
      Role.should_receive(:find).with(@role.id).and_return(@role)
      put_update
    end

    it "should update the role with attribute which has been specified"
    it "should render the show.js page"



  end

end
