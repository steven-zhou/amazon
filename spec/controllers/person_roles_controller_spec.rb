require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonRolesController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @person_role = Factory(:person_role)
    @person_role_attributes = Factory.attributes_for(:person_role)
    @person = @person_role.role_player
    @role = @person_role.role
    PersonRole.stub(:find).and_return(@person_role)
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

  def post_create(options = {})
    options[:person_id] ||= @person.id
    options[:person_role] ||= @person_role_attributes
    post :create, options
  end

  def put_update(options = {})
    options[:id] ||= @person_role.id
    options[:person_role] = {}
    options[:person_role][@person_role.id.to_s] = @person_role_attributes
    put :update, options
  end

  def get_edit(options ={})
    options[:id] ||= @person_role.id
    get :edit, options
  end

  describe "POST 'create'" do
    before(:each) do
      PersonRole.stub!(:new).and_return(@person_role)
    end

#    it "should find the right person for the role we are assigning" do
#      Person.stub!(:find).with(@person.id).and_return(@person)
#      Person.should_receive(:find).with(@person.id).and_return(@person)
#      post_create
#    end

    it "should create a new person_role with the parameters specified" do
      PersonRole.should_receive(:new).with(hash_including(@person_role_attributes)).and_return(@person_role)
    
      post_create
    end

    it "should assign the role to this person" do
      @person_role.should_receive(:save)
      post_create
      PersonRole.find_by_id(@person_role.id).should == @person_role
    end

    it "should render the page create.js page" do
      post_create
      response.should render_template("create.js.erb")
    end
  end




  describe "GET 'show'" do
    before(:each) do
      PersonRole.stub!(:find).and_return(@person_role)

    end

    it "should show the person_role we request when we use show" do
      PersonRole.should_receive(:find).with(@person_role.id).and_return(@person_role)
      get_show(:id => @person_role.id)
    end

    it "show should render the show.js page" do
      get_show
      response.should render_template("show.js.erb")
    end

  end
  






  describe "Post 'destroy'" do
    before(:each) do
      PersonRole.stub!(:find).and_return(@person_role)
    end

    it "should find and destory the person_role specified" do
      PersonRole.should_receive(:find).with(@person_role.id).and_return(@person_role)
      @person_role.should_receive(:destroy)
      delete_destroy(:id => @person_role.id)
    end


    it "show should render the destroy.js page" do
      delete_destroy
      response.should render_template("destroy.js.erb")
    end
    
  end


  describe "Put 'update'" do
    before(:each) do
      PersonRole.stub!(:find).and_return(@person_role)
    end

    it "should find the right Person_role for update" do
      PersonRole.should_receive(:find).with(@person_role.id).and_return(@person_role)
      put_update
    end

    it "should update the person_role data" do
      @person_role.should_receive(:update_attributes).and_return(@person_role)
      put_update
    end

    it "should render the show.js page" do
      put_update
      response.should render_template("show.js.erb")
    end
  end


  describe "Get 'edit'" do

    before(:each) do
      PersonRole.stub!(:find).and_return(@person_role)
    end

    it "should find the exist person_role for further editing" do
      PersonRole.should_receive(:find).with(@person_role.id).and_return(@person_role)
      get_edit
    end

    it "should render edit.js" do
      get_edit
      response.should render_template("edit.js")
    end

  end

  
end
