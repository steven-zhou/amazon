require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MasterDocsController do
  before(:each) do
    @master_doc = Factory.build(:master_doc)
    @attributes = Factory.attributes_for(:master_doc)
    @person = @master_doc.entity

    Person.stub!(:find).and_return(@person)

    MasterDoc.stub!(:find).and_return(@master_doc)
    MasterDoc.stub!(:new).and_return(@master_doc)
    MasterDoc.stub!(:entity).and_return(@person)
    MasterDoc.entity.stub!(:master_docs).and_return([@master_doc])
    MasterDoc.entity.master_docs.stub!(:new).and_return(@master_doc)
  end

  def post_create(options = {})
    options[:master_doc] ||= @attributes
    post :create, options, :person_id => @person.id

  end

  def get_edit(options = {})
    options[:id] ||= @master_doc.id
    options[:master_doc] ||= @attributes
    get :edit, options
  end

  def get_show(options = {})
    options[:id] ||= @master_doc.id
    get :show, options
  end

  def put_update(options = {})
    options[:id] ||= @master_doc.id
    options[:master_doc] = {}
    options[:master_doc][@master_doc.id.to_s] = @attributes
    put :update, options
  end

  def delete_destroy(options = {})
    options[:id] ||= @master_doc.id
    delete :destroy, options
  end

  describe "GET :edit" do
    it "should find a existing master_doc with params[:id]" do
      MasterDoc.should_receive(:find).and_return(@master_doc)
      get_edit
    end

    it "should render master_docs/edit.js" do
      get_edit
      response.should render_template("master_docs/edit.js")
    end
  end

  describe "GET :show" do
    it "should find a existing master_doc with params[:id]" do
      MasterDoc.should_receive(:find).and_return(@master_doc)
      get_show
    end

    it "should render master_docs/show.js" do
      get_show
      response.should render_template("master_docs/show.js")
    end
  end

  describe "POST :create" do
    before(:each) do
      @master_doc.stub!(:save).and_return(true)
    end
#    it "should create a new master_doc with params[:master_doc]" do
#      MasterDoc.should_receive(:new).with(hash_including(@attributes)).and_return(@master_doc)
#      post_create
#    end
    it "should save the new master_doc" do
      @master_doc.should_receive(:save)
      post_create
    end
    it "should render master_docs/create.js" do
      post_create
      response.should render_template("master_docs/create.js")
    end
  end

  describe "PUT :update" do
    before(:each) do

    end

    it "should find a existing master_doc with params[:id]" do
      MasterDoc.should_receive(:find).with(@master_doc.id.to_s).and_return(@master_doc)
      put_update
    end

    it "should update the master_doc with params[:master_doc]['master_doc_id]" do
      @master_doc.should_receive(:update_attributes).with(hash_including(@attributes))
      put_update
    end

    it "should render template master_doc/show.js" do
      put_update
      response.should render_template("master_docs/show.js")
    end
  end


  describe "DELETE :destroy" do
    before(:each) do

    end
    it "should find a existing master_doc with params[:id]" do
      MasterDoc.should_receive(:find).with(@master_doc.id.to_s).and_return(@master_doc)
      delete_destroy
    end

    it "should destroy the master_doc" do
      @master_doc.should_receive(:destroy)
      delete_destroy
    end

    it "should render master_docs/destroy.js" do
      delete_destroy
      response.should render_template("master_docs/destroy.js")
    end
  end
end
