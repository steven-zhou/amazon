require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Employment do

  before(:each) do
    @attributes = Factory.attributes_for(:employment)
    @employment = Factory.build(:employment)
  end


  it { should belong_to(:organisation) }
  it { should belong_to(:employee, :class_name => 'Person', :foreign_key => 'person_id')}
  it { should belong_to(:recruiter, :class_name => 'Person', :foreign_key => 'hired_by')}
  it { should belong_to(:supervisor, :class_name => 'Person', :foreign_key => 'report_to')}
  it { should belong_to(:terminator, :class_name => 'Person', :foreign_key => 'terminated_by')}
  it { should belong_to(:suspender, :class_name => 'Person', :foreign_key => 'suspended_by')}



end