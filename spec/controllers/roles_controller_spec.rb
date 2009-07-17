require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RolesController do
 before(:each) do
    @role = Factory.build(:role, :id => 1)

    @attributes = Factory.attributes_for(:role)
    Role.stub!(:find).and_return(@role)
    @person = Factory.build(:person)
    Person.stub!(:find).and_return(@person)
  end

  def post_create_info
    xhr :post, "create",:role => @attributes
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

  describe "GET 'create'" do
     before(:each) do
      Role.stub!(:new).and_return(@role)
    end

    it "should create a new role with params[:role]" do
      Role.should_receive(:find).and_return(@role)
      post_create_info
    end

   
    it "should render template '/roles/create.js.erb'" do
      post_create_info

      response.should render_template("roles/create.js.erb")

    end
  end
#not the case at all ----------------------------
#  describe "GET 'update'" do
#    it "should be successful" do
#      pending
#      get 'update'
#      response.should be_success
#    end
#  end

  describe "GET 'destroy'" do
      before(:each) do
      Role.stub!(:find).and_return(@role)
    end
    it "should find a existed role with params[:id]" do
      @person.roles.should_receive(:delete).with(@role)
      delete_destroy
    end


    it "should render roles/destroy.js" do
      delete_destroy
      response.should render_template("roles/destroy.js")
    end

  end
end
