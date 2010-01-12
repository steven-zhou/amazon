class PotentialMember < ActiveRecord::Base

  validates_presence_of :first_name, :family_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})$/
  
end
