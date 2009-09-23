require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrganisationKeyPersonnel do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @attributes = Factory.attributes_for(:google_ceo)
    @organisation_key_personnel = Factory.build(:google_ceo)
  end

  it { should belong_to(:organisation) }
  it { should belong_to(:person) }



end