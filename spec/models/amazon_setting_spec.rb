require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AmazonSetting do

  before(:each) do
    @attributes = Factory.attributes_for(:male_gender)
    @amazon_setting = Factory.build(:male_gender)
  end



  describe "When validating the model" do
    it "should save when it is valid" do
      @amazon_setting.save.should == true
    end

    it "should not save when setting name is blank" do
      @amazon_setting = Factory.build(:male_gender, :name => "")
      @amazon_setting.save.should == false
      @amazon_setting.errors.on(:name).should_not be_nil
    end

    it "should not save when setting name is existing for the same type" do
      @amazon_setting2 = Factory.build(:male_gender)
      @amazon_setting.save.should == true
      @amazon_setting2.save.should == false
    end

    it "should save when the name is existing but for different type" do
      @amazon_setting2 = Factory.build(:male_title)
      @amazon_setting.save.should == true
      @amazon_setting2.save.should == true
    end
  end

  describe "getter" do
    it "should return a string of options" do
      @amazon_setting = Factory(:male_gender)
      @amazon_setting = Factory(:male_title)
      AmazonSetting.distinct_setting_type.should == "<option value='Gender'>Gender</option><option value='Title'>Title</option>"
    end
  end

end