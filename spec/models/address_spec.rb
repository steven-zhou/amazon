require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Address do
  before(:each) do
    @primary_list = Factory(:primary_list)
  end

  it "should belong to addressable" do
    Address.reflect_on_association(:addressable).nil?.should == false
  end
  it { should belong_to(:address_type)}
  it { should belong_to(:country)}
  
  it { should validate_presence_of(:address_type_id)}
  it {should allow_mass_assignment_of(:name)}
  
  
  context "when returning line details" do
    
    before(:each) do
      @address = Factory(:personal_home_address)
      @attr = Factory.attributes_for(:personal_home_address)
      @country_attr = Factory.attributes_for(:australia)
    end
    
    it "should return a line with building name, suite unit, street number and street name" do
      @address.first_line.should == "#{@attr[:building_name]} #{@attr[:suite_unit]} #{@attr[:street_number]} #{@attr[:street_name]}"
    end
    
    it "should return the second line with town, district, region" do
      @address.second_line.should == "Argent Archon Arctic"
    end
    
    it "should return the third line with state, postal_code, country" do
      @address.third_line.should == "#{@attr[:state]} #{@attr[:postal_code]} #{@country_attr[:short_name]}"
    end
    
    it "should return a formatted string with town and address if attributes are missing" do
      @address.building_name = nil
      @address.suite_unit = nil
      @address.first_line.should == "#{@address.street_number} #{@address.street_name}"
    end
    
    it "should return a formatted string with town and address if attributes are missing" do
      @address.region = nil
      @address.second_line.should == "#{@address.town} #{@address.district}"
    end
    
    it "should return a formatted string with state and country name if attributes are missing" do
      @address.postal_code = nil
      @address.third_line.should == "#{@address.state} #{@address.country_short_name}"
    end
    
  end #end context
  
  context "when updating priority" do
    
    before(:each) do 
      @address = Factory.create(:personal_home_address)
    end
  
    it "should save a new record as a priority address if it is the only address" do
      @address.addressable.addresses.clear
      @address.save!
      @address.priority_number.should eql(1)
    end
    
  end
  
  it "should be invalid when all the fields except address_type, addressable, priority are empty" do
    @invalid_object = Address.new(:addressable_id => 1, :addressable_type => "person",:address_type_id => 1)
    @invalid_object.should_not be_valid
  end
  
end
