require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Image do
  before(:each) do
    @primary_list = Factory(:primary_list)
    @image = Factory.build(:image)
    #@attributes = Factory.build(:image)
  end

  it "should mock up a image" do
    @image.should be_an_instance_of(Image)
  end
end
