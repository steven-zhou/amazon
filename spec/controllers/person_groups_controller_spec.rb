require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PersonGroupsController do
 before(:each) do
      @primary_list = Factory(:primary_list)
      @person = Factory(:person)
      @group = Factory(:group_type)
      @person_group = Factory(:person_group)
      PersonGroup.stub!(:new).and_return(@person_group)
    end


end