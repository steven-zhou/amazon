require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagType do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @tag_type = Factory(:doc_tag_type)
  end

  it { should belong_to(:tag_meta_type)}
  it { should have_many(:tags)}

  it "should return options" do
    TagType.distinct_types_of_tag_types.should == "<option value='MasterDocMetaType'>MasterDocMetaType</option>"
  end

end

