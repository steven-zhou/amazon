require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmploymentsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @employment = Factory(:employment)
    @attributes = Factory.attributes_for(:employment)
    @person = @employment.employee
    Person.stub!(:find).and_return(@person)
    session[:user] = Factory(:login_account).id
  end


  def put_update(options = {})
    options[:id] ||= @employment.id
    options[:employment] ||= Hash.new
    options[:employment][@employment.id.to_s] = @attributes
    put :update, options
  end

  def get_show(options = {})
    options[:id] ||= @employment.id
    get :show, options
  end

  def get_edit(options = {})
    options[:id] ||= @employment.id
    get :edit, options
  end

  def delete_destroy(options = {})
    options[:id] ||= @employment.id
    get :destroy, options
  end


  describe "POST 'create'" do
    before(:each) do
      Employment.stub!(:new).and_return(@employment)
    end

    it "should create a new employment with params[:employment]" do
      Employment.should_receive(:new).with(hash_including(@attributes)).and_return(@employment)
      xhr :post, "create",:employment => @attributes
    end

    it "should save the new employment" do
      @employment.should_receive(:save)
      xhr :post, "create",:employment => @attributes
    end

    it "should render template '/employments/create.js.erb'" do
      xhr :post, "create",:employment => @attributes
      response.should render_template("employments/create.js.erb")
    end
  end

  describe "POST 'update'" do
    before(:each) do
      Employment.stub!(:find).and_return(@employment)
      Employment.stub!(:employee).and_return(@person)
      Employment.employee.stub!(:employments).and_return([@employment])
    end

    it "should find the correct record to update" do
      Employment.should_receive(:find).with(@employment.id).and_return(@employment)
      put_update
    end

    it "should update the record" do
      @employment.should_receive(:update_attributes).and_return(@employment)
      put_update
    end

  end

  describe "GET 'show'" do
    before(:each) do
      Employment.stub!(:find).and_return(@employment)
    end

    it "should find the requested record" do
      Employment.should_receive(:find).with(@employment.id).and_return(@employment)
      get_show
      assigns[:employment].should == @employment
    end

  end


  describe "GET 'edit'" do
    before(:each) do
      Employment.stub!(:find).and_return(@employment)
    end

    it "should find the requested record for editing" do
      Employment.should_receive(:find).with(@employment.id).and_return(@employment)
      get_edit
      assigns[:employment].should == @employment
    end


  end

  describe "DELETE 'destroy'" do
    before(:each) do
      Employment.stub!(:find).and_return(@employment)
      Employment.stub!(:employee).and_return(@person)
      Employment.employee.stub!(:employments).and_return([@employment])
    end

    it "should destroy the requested record" do
      @employment.should_receive(:destroy).and_return(@employment)
      delete_destroy
    end


  end



end
