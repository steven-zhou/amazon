require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NotesController do
  before(:each) do
    @note = Factory.build(:note)
    @attributes = Factory.attributes_for(:note)
    @person = @note.noteable
    session[:user] = Factory(:login_account).id
  end


  def post_create_info
    xhr :post, "create", :note => @attributes, :person_id => @person.id
  end


  #    xhr :put, "update", :id => "1"
  def put_update(options = {})
    options[:id] ||= @note.id
    options[:note] = {}
    options[:note][@note.id.to_s] = @attributes
    put :update,options
  end


  def show(options = {})
    options[:id] ||= @note.id
    delete :show, options
  end

  def edit(options = {})
    options[:id] ||= @note.id
    delete :edit, options
  end

  def delete_destroy(options = {})
    options[:id] ||= @note.id
    delete :destroy, options
  end

  it "should use NoteController" do
    controller.should be_an_instance_of(NotesController)
  end


  describe "GET 'create'" do
    before(:each) do
      Note.stub!(:new).and_return(@note)
    end

    it "should create a new note with params[:note]" do
      Note.should_receive(:new).with(hash_including(@attributes)).and_return(@note)
      post_create_info
    end

    it "should save the new note" do
      @note.should_receive(:save)
      post_create_info
    end

    it "should render template '/notes/create.js.erb'" do
      post_create_info

      response.should render_template("notes/create.js.erb")

    end
  end
    
  describe "GET 'update'" do
    before(:each) do
      Note.stub!(:find).and_return(@note)
      Note.stub!(:noteable).and_return(@person)
    end


    it "should get find the correct note to update" do
      Note.should_receive(:find).with(@note.id).and_return(@note)
      put_update :id => @note.id
    end

     it "should update the attributes for the note" do
      @note.should_receive(:update_attributes).with(hash_including(@attributes)).and_return(true)
      put_update
     end

  end

   describe "GET 'show'" do

    before(:each) do
      Note.stub!(:find).and_return(@note)
      Note.stub!(:noteable).and_return(@person)
     end

     it "should find the correct note when passed the param[:id]" do
      Note.should_receive(:find).and_return(@note)
      show
     end

    it "should render notes/show.js" do
      show
      response.should render_template("notes/show.js")
    end

   end

   describe "GET 'edit'" do

    before(:each) do
      Note.stub!(:find).and_return(@note)
      Note.stub!(:noteable).and_return(@person)
     end

     it "should find the correct note when passed the param[:id]" do
      Note.should_receive(:find).and_return(@note)
      edit
     end

    it "should render notes/edit.js" do
      edit
      response.should render_template("notes/edit.js")
    end

   end


  describe "GET 'destroy'" do
    before(:each) do
      Note.stub!(:find).and_return(@note)
      Note.stub!(:noteable).and_return(@person)
     end
    it "should find an existing note with params[:id]" do
      Note.should_receive(:find).with(@note.id).and_return(@note)
      delete_destroy
    end

    it "should destroy the note" do
      @note.should_receive(:destroy)
      delete_destroy
    end

    it "should render notes/destroy.js" do
      delete_destroy
      response.should render_template("notes/destroy.js")
    end
  end
end
