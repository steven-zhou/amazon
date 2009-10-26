require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ToDoList do
  
  it { should belong_to(:created_by, :class_name => "LoginAccount", :foreign_key => "created_by_id")}
  it { should belong_to(:updated_by, :class_name => "LoginAccount", :foreign_key => "updated_by_id")}
end
