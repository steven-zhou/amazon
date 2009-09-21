require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @tag = Factory(:doc_tag)
  end

  it { should belong_to(:tag_type)}

  it "should return options" do
    Tag.distinct_types_of_tags.should == "<option value='MasterDocType'>MasterDocType</option>"
  end

end

