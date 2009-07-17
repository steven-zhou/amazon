require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MasterDocType do
  it { should have_many(:master_docs)}
end
