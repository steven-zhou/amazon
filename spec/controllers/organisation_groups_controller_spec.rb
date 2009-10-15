require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrganisationGroupsController do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @organisation = Factory(:google)
    @group = Factory(:group_type)
    @organisation_group = OrganisationGroup.new(:organisation_id => @organisation.id, :tag_id => @group.id)
    OrganisationGroup.stub!(:new).and_return(@organisation_group)
    session[:user] = Factory(:login_account).id
    OrganisationGroup.stub!(:find).and_return(@organisation_group)
  end

  def post_create(options={})
    options[:organisation_id] ||= @organisation.id
    options[:organisation_group_id] ||= @group.id
    xhr :post, "create", options
  end

  def show_edit(options={})
    options[:id] ||= @organisation_group.id
    xhr :post, "show", options
  end

  def put_update(options={})
    options[:id] ||= @organisation_group.id
    options[:organisation_group] ||= @organisation_group.attributes
    xhr :put, "update", options
  end

  def delete_destroy(options={})
    options[:id] ||= @organisation_group.id
    xhr :delete, "destroy", options
  end

  describe "GET show" do
    it "should find the corrent organsation group for show" do
      OrganisationGroup.should_receive(:find).with(@organisation_group.id).and_return(@organisation_group)
      xhr :get, "show", :id => @organisation_group.id
    end
  end

  describe "POST create" do
    before(:each) do
      Organisation.stub!(:find).and_return(@organisation)
      Tag.stub!(:find).and_return(@group)
    end

    it "should find the organisation" do
      Organisation.should_receive(:find).with(@organisation.id).and_return(@organisation)
      post_create
    end

    it "should find the group" do
      Tag.should_receive(:find).with(@group.id).and_return(@group)
      post_create
    end

    it "should create a new organisation_group" do
      OrganisationGroup.should_receive(:new).and_return(@organisation_group)
      post_create
    end

    it "should sace the new organisation_group" do
      @organisation_group.should_receive(:save)
      post_create
    end
  end

  describe "SHOW edit" do
    it "should find the organisation group" do
      OrganisationGroup.should_receive(:find).with(@organisation_group.id).and_return(@organsation_group)
      show_edit
    end
  end
  
  describe "PUT update" do
    
    it "should find the organisation group" do      
      OrganisationGroup.should_receive(:find).with(@organisation_group.id).and_return(@organisation_group)
      put_update
    end
    
    it "should update attributes" do
      @organisation_group.should_receive(:update_attributes).with(hash_including(@organisation_group.attributes)).and_return(true)
      put_update
    end
  end

  describe "DELETE destroy" do
    
    it "should find the organisation group" do
      OrganisationGroup.should_receive(:find)
      delete_destroy
    end

    it "should destroy the organisation group" do
      @organisation_group.should_receive(:destroy)
      delete_destroy
    end
  end

  describe "Get show_group_members" do

#    it "should find the organisation group" do
#      OrganisationGroup.should_receive(:find).with(@organisation_group.id).and_return(@organisation_group)
#      xhr :get, "show_group_members", :id => @organisation_group.id
#    end
  end

end