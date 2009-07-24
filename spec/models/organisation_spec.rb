require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Organisation do

  before(:each) do
    @attributes = Factory.attributes_for(:google)
    @organisation = Factory.build(:google)
  end

  it { should have_many(:organisation_key_personnels) }
  it { should have_many(:key_people, :through => :organisation_key_personnels, :source => :person) }
  it { should belong_to(:country) }
  it { should belong_to(:organisation_hierarchy) }


end