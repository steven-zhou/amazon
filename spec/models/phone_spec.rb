require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Phone do
  before(:each) do
    @attributes = Factory.attributes_for(:phone)
    @phone = Factory.build(:phone)
  end

  #  it {should belong_to(:person)}
  
  describe "prefix" do 
    it "should return the pre_value data" do
      @phone.prefix.should == @attributes[:pre_value]
    end
  end

  describe "number" do
    it "should return the value data" do
      @phone.number.should == @attributes[:value]
    end
  end
  
  describe "suffix" do
    it "should return the post_value data" do
      @phone.suffix.should == @attributes[:post_value]
    end
  end
  
  describe "complete number" do
    it "should return the complete number = prefix + number + suffix" do
      @phone.complete_number.should == "#{@phone.prefix} #{@phone.number} #{@phone.suffix}"
    end
    
    it "should return the non nil or empty parts of the number" do
      @phone.pre_value = nil
      @phone.complete_number.should == "#{@phone.number} #{@phone.suffix}"
    end
  end

  it "should save a new record as a primary phone if there is no phone belongs to contactable" do
    @phone.contactable.phones.clear
    @phone.save!
    @phone.priority_number.should == 1
  end
end
