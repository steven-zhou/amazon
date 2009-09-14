require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserGroup do

  it { should belong_to(:login_account) }
   it { should belong_to(:group)}
end