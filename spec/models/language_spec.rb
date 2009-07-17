require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Language do
  it {should validate_presence_of(:name)}
end
