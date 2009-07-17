require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KeywordType do
  it { should have_many(:keywords) }
end
