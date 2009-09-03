require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryHeader do

  before(:each) do
    @query_header = Factory.build(:query_header)
  end

  it { should have_many(:query_details)}

  it "should validate name to be unique" do
    @query_header = Factory.build(:query_header, :name => "peopleInNSW")
    @query_header.save.should == true

    @query_header1 = Factory.build(:query_header, :name => "peopleInNSW")
    @query_header1.save.should == false
  end

end
