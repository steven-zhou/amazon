require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagType do

  before(:each) do
    @attributes = Factory.attributes_for(:master_doc_meta_type)
    @amazon_setting = Factory.build(:master_doc_meta_type)
  end

  describe "When validating the model" do
    it "should save when it is valid" do
      @amazon_setting.save.should == true
    end

    it "should not save when setting name is blank" do
      @amazon_setting = Factory.build(:master_doc_meta_type, :name => "")
      @amazon_setting.save.should == false
      @amazon_setting.errors.on(:name).should_not be_nil
    end

    it "should not save when setting name is existing for the same type" do
      @amazon_setting.name = "Name"
      @amazon_setting2 = Factory.build(:master_doc_meta_type, :name => "Name")
      @amazon_setting.save.should == true
      @amazon_setting2.save.should == false
    end

  end

  describe "getter" do
    it "should return a string of options" do
      @amazon_setting = Factory(:master_doc_meta_type)
      TagType.distinct_types_of_tag_types.should == "<option value='MasterDocMetaType'>MasterDocMetaType</option>"
    end
  end

end