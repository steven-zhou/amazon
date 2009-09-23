require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag do

  before(:each) do
    @tag = Factory(:doc_tag)
  end

  it { should belong_to(:tag_type)}

 it { should have_many(:group_type, :class_name=> 'PersonGroup', :foreign_key=>'tag_id')}
  
  it "should return options" do
    Tag.distinct_types_of_tags.should == "<option value='MasterDocType'>MasterDocType</option>"
  end

end

