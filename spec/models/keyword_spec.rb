require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Keyword do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @keyword = Factory.build(:keyword)
  end
  it { should have_many(:keyword_links)}
  it { should have_many(:people,:uniq => true)}
  it { should belong_to(:keyword_type)}
  it { should validate_presence_of(:keyword_type_id)}

  it "should return keyword type name" do
    @keyword.keyword_type_name.should == @keyword.keyword_type.name
  end
end
