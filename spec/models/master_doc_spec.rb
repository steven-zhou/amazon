require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MasterDoc do
  
  # it { should belong_to(:entity) }
  it "should belong to an entity" do
    MasterDoc.reflect_on_association(:entity).nil?.should == false
  end
  it { should belong_to(:master_doc_type) }
  it { should validate_presence_of(:master_doc_type_id) }
  it { should belong_to(:issue_country)}
end
