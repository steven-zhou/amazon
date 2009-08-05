require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EmailsController do
  before(:each) do
    @email = Factory.build(:email)  
    @attributes = Factory.attributes_for(:email)
    Email.stub!(:find).and_return(@email)
    @person = Factory.build(:jane)
    Person.stub!(:find).and_return(@person)

    @email.stub(:size)
    @email.stub(:each)

  end


  def post_create_info
    xhr :post, "create",:email => @attributes
  end


  #    xhr :put, "update", :id => "1"
  def put_update(options = {})
    options[:id] ||= @email.id
    options[:email] ||= @attributes

#    options[:email][@email.id.to_s] = @attributes
    put :update,options
  end


   def delete_destroy(options = {})
    options[:id] ||= @email.id
    delete :destroy, options
  end

  #Delete these examples and add some real ones
  it "should use EmailsController" do
    controller.should be_an_instance_of(EmailsController)
  end


  describe "GET 'create'" do
    before(:each) do
      Email.stub!(:new).and_return(@email)
    end

    it "should create a new email with params[:email]" do
      Email.should_receive(:new).with(hash_including(@attributes)).and_return(@email)
      post_create_info
    end

    it "should save the new email" do
      @email.should_receive(:save)
      post_create_info
    end

    it "should render template '/emails/create.js.erb'" do
      post_create_info

      response.should render_template("emails/create.js.erb")

    end
  end
    
  describe "GET 'update'" do
#    before(:each) do
#      Email.stub!(:find).and_return(@email)
#    end


    it "should get the request Email general info" do
      Email.should_receive(:find).with(@email.id.to_s).and_return(@email)
      put_update :id => @email.id
    end

     it "should update the  email information" do

      @email.should_receive(:update_attributes).with(hash_including(@attributes)).and_return(true)
      put_update
     end
#      it "should got the Email with id" do
#        Email.should_receive(:find).with(@email.id.to_s).and_return(@email)
#        put_update
#      end

#      it "should update the email with params[:id]" do
#         @email.should_receive(:update_attributes).with(hash_including(@attributs))
#         put_update
#       end

#       it "should render template Emails/show.js" do
#         put_update
#         response.should render_template("emails/show.js.erb")
#       end

  end

  describe "GET 'destroy'" do
    before(:each) do
      Email.stub!(:find).and_return(@email)
    end
    it "should find a existed email with params[:id]" do
      Email.should_receive(:find).with(@email.id.to_s).and_return(@email)
      delete_destroy
    end

    it "should destroy the email" do
      @email.should_receive(:destroy)
      delete_destroy
    end

    it "should render emails/destroy.js" do
      delete_destroy
      response.should render_template("emails/destroy.js")
    end
  end
end
