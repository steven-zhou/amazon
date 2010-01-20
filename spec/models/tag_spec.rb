require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @tag = Factory(:doc_tag)
  end

  it { should belong_to(:tag_type)}

 it { should have_many(:group_type, :class_name=> 'PersonGroup', :foreign_key=>'tag_id')}
  

end

