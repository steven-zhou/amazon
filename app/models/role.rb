class Role < ActiveRecord::Base

  belongs_to :role_type
  #has_many :people, :through => :person_role, :uniq => true
  has_many :person_roles
  has_many :people, :through => :person_roles, :uniq => true
  
  validates_presence_of :name, :role_type_id
  validates_associated :role_type
  
  delegate :name, :to => :role_type, :prefix => true,:allow_nil => true


end
