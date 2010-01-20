require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagMetaType do

  before(:each) do
    @primary_list = Factory(:primary_list)
    @tag_meta_type = Factory(:doc_tag_meta_type)
  end

  it { should have_many(:tag_types)}
  

end
