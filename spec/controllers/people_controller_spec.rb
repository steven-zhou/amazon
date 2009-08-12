require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PeopleController do
  before(:each) do
    @person = Factory.build(:john)
    @attributes = Factory.attributes_for(:john)
    Person.stub!(:find).and_return(@person)
  end
  
  def post_create(options = {})
    options[:person] ||= @attributes
    post :create, {:person => @attributes}
  end

  def post_add_keywords(options ={})
    options[:add_keywords] ||= [1,2]
    post :add_keywords, options
  end
    
  def put_update(options = {})
    options[:id] ||= @person.id
    options[:person] ||= @attributes
    put :update, options
  end

  def get_name_finder(options = {})
    get :name_finder, options
  end

  def get_role_finder(options = {})
    get :role_finder, options
  end

  def get_master_doc_meta_type_finder(options = {})
    get :master_doc_meta_type, options
  end

  def get_master_doc_type_finder(options = {})
    get :master_doc_type_finder, options
  end

  def get_edit(options = {})
    get :edit, options
  end

  def get_show(options = {})
    options[:id] ||= @person.id
    get :show, options
  end
  
  def get_search(options={})
    options[:commit] ||= "Search"
    options[:id] ||= @person.id
    get :search, options
  end

  describe "GET 'new'" do
    before(:each) do
      get 'new'
    end
    it "should assign a new Person to a variable" do
      assigns[:person].should be_new_record
    end

    it "should assign a new Person with an associate address to a variable" do
      assigns[:person].addresses.length.should == 1
    end

    it "should have a phone associated with a Person" do
      assigns[:person].addresses.length.should == 1
    end
    
    it "should have an email associated with a Person" do
      assigns[:person].addresses.length.should == 1
    end

    it "should render new" do
      response.should render_template('new')
    end
  end

  describe "POST 'create'" do
    context "when params are valid" do
      before(:each) do
        Person.stub!(:new).and_return(@person)
        @person.stub!(:save).and_return(true)
      end
      
      it "should build the person" do
        Person.should_receive(:new).with(hash_including(@attributes)).and_return(@person)
        post_create
      end

      it "should save the person" do
        @person.should_receive(:save).and_return(true)
        post_create
      end

      it "should assign the new record" do
        post_create
        assigns[:person].should == @person
      end

      it "should redirect to new" do
        post_create :commit => "Submit"
        response.should redirect_to(new_person_path)
      end

    end

    context "when params are invalid" do

      before(:each) do
        @invalid = Factory.build(:invalid_person)
        @invalid.emails.build()
        @invalid.addresses.build()
        @invalid.phones.build()
        @invalid.faxes.build()
        @invalid.websites.build()
        Person.stub!(:new).and_return(@invalid)
        @person.stub!(:save).and_return(false)
      end

      it "should render new if unsucessful" do
        post_create
        response.should render_template('new')
      end

      it "should flash an error message if unsuccessful" do
        post_create
        flash[:warning].should have_at_least(1).things
      end

    end
  end

  describe "PUT :update" do
    it "should get the request person general info" do
      Person.should_receive(:find).with(@person.id.to_s).and_return(@person)
      put_update :person_id => @person.id
    end

    it "should update the person's attributes" do
      @person.should_receive(:update_attributes).with(hash_including(@attributes)).and_return(true)
      put_update
    end

  end


  describe "PUT :name_finder" do

    before(:each) do
      Person.stub!(:find).and_return(@person)
    end

    it "should find the correctly set @person if params[:person_id] is specified" do
      get_name_finder(:person_id => @person.id)
      assigns[:person].should equal(@person)
    end

    it "should render name_finder" do
      get_name_finder
      response.should render_template('name_finder')
    end

  end

  describe "PUT :role_finder" do

    before(:each) do
      Person.stub!(:find).and_return(@person)
    end

    it "should find the correctly set @person if params[:person_id] is specified" do
      get_role_finder(:person_id => @person.id)
      assigns[:person].should equal(@person)
    end

    it "should render role_finder" do
      get_role_finder
      response.should render_template('role_finder')
    end

  end


  describe "GET 'show'" do

    it "should render show" do
      get_show :id => 1
      response.should render_template('show')
    end
  end

  describe "GET 'edit'" do

    before(:each) do
      Person.stub!(:find).and_return(@person)
      Person.stub!(:new).and_return(@person)
    end

    it "should find the correctly set @person if params[:person_id] is specified" do
      get_edit(:person_id => @person.id)
      assigns[:person].should equal(@person)
    end

    it "should generate a new record for @person if there is no params[:person_id] specified" do
      get_edit
      assigns[:person].should be_new_record
    end


  end

  describe "Get 'search'" do
    context "if params[:commit] != 'Search'" do
      before(:each) do
        get_search :commit => 'test'
      end
      it { should render_template("search")}
    end

    context "if params[:commit] == 'Search'" do

      context "if no person was found" do
        before(:each) do
          Person.stub!(:find_all_by_id).and_return([])
          get_search
        end

      end

      context "if more than one person was found" do
        before(:each) do
          Person.stub!(:find_all_by_id).and_return([@person,@person])
          get_search
        end
        
        it {should render_template("people/search.html.haml")}
      end

      context "only one person was found" do
        before(:each) do
          Person.stub!(:find_all_by_id).and_return([@person])
          get_search
        end

        # it {should redirect_to(person_path(@person))}
      end
    end
  end

  describe "handle POST 'add_keywords'" do
    before(:each) do
      @keyword = Factory.build(:keyword)
      @keyword_2 = Factory.build(:keyword)
      Keyword.stub!(:find).and_return(@keyword,@keyword_2)
      @ids = [1,2]
    end

    it "should find keywords for each elements in add_keyword params" do
      @ids.each do |id|
        Keyword.should_receive(:find).with(id)
      end
      post_add_keywords :add_keywords => @ids
    end
    
    it "should add all founded keywords to person" do
      post :add_keywords, :add_keywords => @ids
      @person.keywords.size.should equal(@ids.size)
    end

    it "should render add_keywords.js" do
      post_add_keywords :add_keywords => @ids
      response.should render_template("people/add_keywords.js")
    end
  end

  describe "handle POST 'remove_keywords'" do
    before(:each) do
      @keyword = Factory.build(:keyword)
      Keyword.stub!(:find).and_return(@keyword)
      @ids = [1]
    end

    it "should find keywords for each elements in remove_keyword params" do
      @ids.each do |id|
        Keyword.should_receive(:find).with(id)
      end
      post :remove_keywords, :remove_keywords => @ids
    end

    it "should remove all founded keywords from person" do
      @person.keywords.should_receive(:delete).exactly(@ids.size)
      post :remove_keywords, :remove_keywords => @ids
    end

    it "should render remove_keywords.js" do
      post :remove_keywords, :remove_keywords => @ids
      response.should render_template("people/remove_keywords.js")
    end
  end
end
