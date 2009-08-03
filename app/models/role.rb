class Role < ActiveRecord::Base

  belongs_to :role_type, :class_name => "RoleType", :foreign_key => "role_type_id"

  has_many :person_roles
  has_many :people, :through => :person_roles, :uniq => true
  
  validates_presence_of :name, :role_type_id
  validates_associated :role_type
  
  
end
