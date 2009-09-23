require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonGroup do

  it { should belong_to(:group_owner, :class_name => 'Person', :foreign_key => 'people_id')}
  it { should belong_to(:group_type, :class_name => 'Tag', :foreign_key => 'tag_id')}
   
# it { should belong_to(:person, :foreign_key => 'people_id')}
end
