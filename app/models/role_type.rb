class RoleType < ActiveRecord::Base
  
  validates_presence_of :name
  
  has_many :roles
  
  
end
