require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RolesController do
  before(:each) do
    @role = Factory.build(:role)

    @attributes = Factory.attributes_for(:role)
    Role.stub!(:find).and_return(@role)
    @person = Factory.build(:person)
    Person.stub!(:find).and_return(@person)
  end

  #    xhr :put, "update", :id => "1"
  def put_update(options = {})
    options[:id] ||= @role.id
    options[:role] ||= @attributes

    #    options[:email][@email.id.to_s] = @attributes
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

end
