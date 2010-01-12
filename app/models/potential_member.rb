class PotentialMember < ActiveRecord::Base

  validates_presence_of :first_name, :family_name, :email
  validates_uniqueness_of :email

  
end
