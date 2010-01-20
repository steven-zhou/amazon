require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrganisationsController do
  
  before(:each) do
    @primary_list = Factory(:primary_list)
    @organisation = Factory.build(:google)
    @attributes = @organisation.attributes
    @person = Factory(:person)
    ClientOrganisation.stub!(:new).and_return(@organisation)
    Organisation.stub!(:find).and_return(@organisation)
    session[:user] = Factory(:login_account).id
  end

  def get_show(options = {})
    options[:id] ||= @organisation.id
    get :show, options
  end

  def post_create(options = {})
    options[:type] ||= "ClientOrganisation"
    options[:organisation] ||= @attributes
    options[:organisation][:level] ||= "1"
    post :create, options
  end

  def get_edit(options = {})
    get :edit, options
  end


  def put_update(options = {})
    options[:id] ||= @organisation.id
    options[:organisation] ||= @attributes
    options[:client_organisation] ||= @attributes
    put :update, options
  end

  def get_name_finder(options = {})
    get :name_finder, options
  end

  def get_search(options={})
    options[:commit] ||= "Search"
    options[:id] ||= @person.id
    get :search, options
  end

  def get_check_duplication(options={})
    options[:check_field] ||= ["Google", "Google", "Google"]
    xhr :get, "check_duplication", options
  end

  describe "GET 'new'" do
    before(:each) do
      get 'new'
    end
    it "should assign a new Organisation to a variable" do
      assigns[:organisation].should be_new_record
    end

    it "should assign a new Organisation with an associate address to a variable" do
      assigns[:organisation].addresses.length.should == 1
    end

    it "should have a phone associated with an Organisation" do
      assigns[:organisation].phones.length.should == 1
    end

    it "should have an email associated with an Organisation" do
      assigns[:organisation].emails.length.should == 1
    end

    it "should have a fax associated with an Organisation" do
      assigns[:organisation].faxes.length.should == 1
    end

    it "should have a website associated with an Organisation" do
      assigns[:organisation].websites.length.should == 1
    end

    it "should render new" do
      response.should render_template('new')
    end
  end


  describe "GET 'show'" do

    it "should render show" do
      get_show :id => 1
      response.should render_template('show')
    end
  end

  describe "POST 'create'" do
    context "when params are valid" do
      before(:each) do
        @organisation.stub!(:save).and_return(true)
        @client_setup = ClientSetup.new
        ClientSetup.stub!(:first).and_return(@client_setup)
        @client_setup.stub!(:level__label).and_return("level1")
        @client_setup.stub!(:level_1_label).and_return("level1")
      end

      it "should build the organisation" do
        ClientOrganisation.should_receive(:new).and_return(@organisation)
        post_create
      end

      it "should save the organisation" do
        @organisation.should_receive(:save).and_return(true)
        post_create
      end

      it "should assign the new record" do
        post_create
        assigns[:organisation].should == @organisation
      end

      it "should redirect to new" do
        post_create :commit => "Submit"
        response.should redirect_to(new_organisation_path)
      end

    end

  end

  describe "GET 'edit'" do

    it "should find the correctly set @organisation if params[:organisation_id] is specified" do
      get_edit(:organisation_id => @organisation.id)
      assigns[:organisation].should equal(@organisation)
    end

    it "should generate a new record for @organisation if there is no params[:organisation_id] specified" do
      get_edit
      assigns[:organisation].should be_new_record
    end
  end

   describe "PUT :update" do
    it "should get the request organisation general info" do
      Organisation.should_receive(:find).with(@organisation.id.to_s).and_return(@organisation)
      put_update :organisation_id => @organisation.id
    end

    it "should update the person's attributes" do
      @organisation.should_receive(:update_attributes).with(hash_including(@attributes)).and_return(true)
      put_update
    end

  end

  describe "GET :name_finder" do

    before(:each) do
      Organisation.stub!(:find).and_return(@organisation)
    end

    it "should find the correctly set @person if params[:person_id] is specified" do
      get_name_finder(:person_id => @organisation.id)
      assigns[:organisation].should equal(@organisation)
    end

    it "should render name_finder" do
      get_name_finder
      response.should render_template('name_finder')
    end

  end

  describe "Get 'search'" do

    context "if params[:commit] == 'Search'" do

      context "if no organisation was found" do
        before(:each) do
          Organisation.stub!(:find_all_by_id).and_return([])
          get_search
        end

      end


      context "only one organisation was found" do
        before(:each) do
          Organisation.stub!(:find_all_by_id).and_return([@organisation])
          get_search
        end

        # it {should redirect_to(organisation_path(@organisation))}
      end
    end
  end

  describe "Get check_duplication" do

    it "should get the organisational duplciation formula applied setting" do

    end

    
  end
end
