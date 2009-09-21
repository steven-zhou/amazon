require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrganisationHierarchy do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @attributes = Factory.attributes_for(:global_head)
    @organisation_hierarchy = Factory.build(:global_head)
  end

  it { should have_many(:organisations) }


end