require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmploymentsController do
  before(:each) do
    @attributes = Factory.attributes_for(:employment)
    @employment = Factory.build(:employment)
    @person = @employment.employee
    Person.stub!(:find).and_return(@person)
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
end
