require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CompileList do
  
  it { should belong_to(:login_account)}
  it { should belong_to(:list_header)}
end
