require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagType do

  before(:each) do
    @tag_type = Factory(:doc_tag_type)
  end

  it { should belong_to(:tag_meta_type)}
  it { should have_many(:tags)}

  it "should return options" do
    TagType.distinct_types_of_tag_types.should == "<option value='MasterDocMetaType'>MasterDocMetaType</option>"
  end

  it "should change all children's status to be inactive if its status is change to be inactive" do
    @tag = Factory(:doc_tag, :status => true)
    @tag_type.status = false
    @tag.tag_type = @tag_type
    @tag_type.tags << @tag
    @tag_type.save

    @tag_type.tags[0].status.should == false
  end

end

