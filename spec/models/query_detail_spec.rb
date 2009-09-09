require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QueryDetail do

  it { should belong_to(:query_header)}
end
