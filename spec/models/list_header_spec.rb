require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListHeader do
  it {should have_many(:list_details)}
  it {should belong_to(:query_header)}
  
end
