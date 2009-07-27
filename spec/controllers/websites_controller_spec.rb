require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WebsitesController do
  before(:each) do
    @website = Factory.build(:website, :id => 1)
  
    @attributes = Factory.attributes_for(:website)
    Website.stub!(:find).and_return(@website)
    @person = Factory.build(:person)
    Person.stub!(:find).and_return(@person)
  end


  def post_create_info
    xhr :post, "create",:website => @attributes
  end


  #    xhr :put, "update", :id => "1"
  def put_update(options = {})
    options[:id] ||= @website.id
    options[:website] ||= @attributes

    put :update,options
  end


   def delete_destroy(options = {})
    options[:id] ||= @website.id
    delete :destroy, options
  end

  #Delete these examples and add some real ones
  it "should use EmailsController" do
    controller.should be_an_instance_of(WebsitesController)
  end


  describe "GET 'create'" do
    before(:each) do
      Website.stub!(:new).and_return(@website)
    end

    it "should create a new website with params[:website]" do
      Website.should_receive(:new).with(hash_including(@attributes)).and_return(@website)
      post_create_info
    end

    it "should save the new website" do
      @website.should_receive(:save)
      post_create_info
    end

    it "should render template '/websites/create.js.erb'" do
      post_create_info

      response.should render_template("websites/create.js.erb")

    end
  end
    
  describe "GET 'update'" do
#    before(:each) do
#      Website.stub!(:find).and_return(@website)
#    end


    it "should get the request Website general info" do
      Website.should_receive(:find).with(@website.id.to_s).and_return(@website)
      put_update :id => @website.id
    end

     it "should update the  website information" do

      @website.should_receive(:update_attributes).with(hash_including(@attributes)).and_return(true)
      put_update
     end
#      it "should got the Website with id" do
#        Website.should_receive(:find).with(@website.id.to_s).and_return(@website)
#        put_update
#      end

#      it "should update the website with params[:id]" do
#         @website.should_receive(:update_attributes).with(hash_including(@attributs))
#         put_update
#       end

#       it "should render template websites/show.js" do
#         put_update
#         response.should render_template("websites/show.js.erb")
#       end

  end

  describe "GET 'destroy'" do
    before(:each) do
      Website.stub!(:find).and_return(@website)
    end
    it "should find a existed website with params[:id]" do
      Website.should_receive(:find).with(@website.id.to_s).and_return(@website)
      delete_destroy
    end

    it "should destroy the website" do
      @website.should_receive(:destroy)
      delete_destroy
    end

    it "should render websites/destroy.js" do
      delete_destroy
      response.should render_template("websites/destroy.js")
    end
  end
end