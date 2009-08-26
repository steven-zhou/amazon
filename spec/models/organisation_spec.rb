require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Organisation do

  before(:each) do
    @attributes = Factory.attributes_for(:google)
    @organisation = Factory.build(:google)
  end

  it { should have_many(:organisation_key_personnels) }
  it { should have_many(:key_people, :through => :organisation_key_personnels, :source => :person) }
  it { should have_many(:employments)}
  it { should have_many(:employees, :through => :employments, :source => :employee)}
  it { should have_many(:addresses)}
  it { should have_one(:image)}
  it { should have_many(:contacts)}
  it { should have_many(:phones)}
  it { should have_many(:emails)}
  it { should have_many(:faxes)}
  it { should have_many(:websites)}
  it { should have_many(:master_docs)}
  it { should have_many(:keyword_links)}
  it { should have_many(:keywords)}
  it { should have_many(:notes)}

  it { should belong_to(:country) }
  it { should belong_to(:organisation_hierarchy) }
  it { should belong_to(:organisation_type)}
  it { should belong_to(:business_type)}
  it { should belong_to(:business_category)}
  it { should belong_to(:industry_sector)}


end