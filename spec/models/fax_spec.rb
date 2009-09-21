require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fax do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @attributes = Factory.attributes_for(:fax)
    @fax = Factory.build(:fax)
  end

  #  it {should belong_to(:person)}
  
  describe "prefix" do 
    it "should return the pre_value data" do
      @fax.prefix.should == @attributes[:pre_value]
    end
  end

  describe "number" do
    it "should return the value data" do
      @fax.number.should == @attributes[:value]
    end
  end
  
  describe "suffix" do
    it "should return the post_value data" do
      @fax.suffix.should == @attributes[:post_value]
    end
  end
  
  describe "complete number" do
    it "should return the complete number = prefix + number + suffix" do
      @fax.complete_number.should == "#{@fax.prefix} #{@fax.number} #{@fax.suffix}"
    end
    
    it "should return the non nil or empty parts of the number" do
      @fax.pre_value = nil
      @fax.complete_number.should == "#{@fax.number} #{@fax.suffix}"
    end
  end

  it "should save a new record as a primary fax if there is no fax belongs to contactable" do
    @fax.contactable.faxes.clear
    @fax.save!
    @fax.priority_number.should == 1  end
end
