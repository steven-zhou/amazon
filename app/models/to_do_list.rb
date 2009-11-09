class ToDoList < ActiveRecord::Base

  validates_uniqueness_of :description, :case_sensitive => false
  belongs_to :created_by, :class_name => "LoginAccount", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "LoginAccount", :foreign_key => "updated_by_id"
end
