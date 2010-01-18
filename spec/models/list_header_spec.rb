require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListHeader do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @list_header = Factory.build(:list_header)
  end

  
  it { should belong_to(:query_header)}

  it { should have_many(:list_details)}

  it { should have_many(:user_lists)}


  it "should validate name to be unique" do
    @list_header = Factory.build(:list_header, :name => "peopleInNSW")
    @list_header.save.should == true

    @list_header1 = Factory.build(:list_header, :name => "peopleInNSW")
    @list_header1.save.should == false
  end

  it "should not save when the name is blank" do
    @list_header = Factory.build(:list_header, :name => "")
    @list_header.save.should == false

   
  end
end
