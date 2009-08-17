require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagMetaType do
  before(:each) do
    @tag_meta_type = Factory(:doc_tag_meta_type)
  end

  it { should have_many(:tag_types)}
  
  it "should return options" do
    TagMetaType.distinct_types_of_tag_meta_types.should == "<option value='MasterDocMetaMetaType'>MasterDocMetaMetaType</option>"
  end

end
