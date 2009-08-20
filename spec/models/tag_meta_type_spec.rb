require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagMetaType do

  before(:each) do
    @tag_meta_type = Factory(:doc_tag_meta_type)
  end

  it { should have_many(:tag_types)}
  
  it "should return options" do
    TagMetaType.distinct_types_of_tag_meta_types.should == "<option value='MasterDocMetaMetaType'>MasterDocMetaMetaType</option>"
  end

  it "should change all children's status to be inactive if its status is change to be inactive" do
    @tag_type = Factory(:doc_tag_type, :status => true)
    @tag_meta_type.status = false
    @tag_type.tag_meta_type = @tag_meta_type
    @tag_meta_type.tag_types << @tag_type
    @tag_meta_type.save

    @tag_meta_type.tag_types[0].status.should == false
  end

end
