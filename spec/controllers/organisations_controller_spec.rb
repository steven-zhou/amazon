require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrganisationsController do
  
  before(:each) do
    @organisation = Factory.build(:google)
    @attributes = Factory.attributes_for(:google)
    Organisation.stub!(:find).and_return(@organisation)
    session[:user] = Factory(:login_account).id
  end

  def get_show(options = {})
    options[:id] ||= @organisation.id
    get :show, options
  end

  def post_create(options = {})
    options[:organisation] ||= @attributes
    post :create, {:organisation => @attributes}
  end

  def get_edit(options = {})
    get :edit, options
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
        Organisation.stub!(:new).and_return(@organisation)
        @organisation.stub!(:save).and_return(true)
        session[:user] = Factory(:login_account).id
      end

      it "should build the organisation" do
        Organisation.should_receive(:new).with(hash_including(@attributes)).and_return(@organisation)
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

    context "when params are invalid" do

      before(:each) do
        @invalid = Factory.build(:invalid_organisation)
        @invalid.emails.build()
        @invalid.addresses.build()
        @invalid.phones.build()
        @invalid.faxes.build()
        @invalid.websites.build()
        Organisation.stub!(:new).and_return(@invalid)
        @organisation.stub!(:save).and_return(false)
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

  describe "GET 'edit'" do

    before(:each) do
      Organisation.stub!(:find).and_return(@organisation)
    end

    it "should find the correctly set @organisation if params[:organisation_id] is specified" do
      get_edit(:organisation_id => @organisation.id)
      assigns[:organisation].should equal(@organisation)
    end

    it "should generate a new record for @organisation if there is no params[:organisation_id] specified" do
      get_edit
      assigns[:organisation].should be_new_record
    end


  end



end
