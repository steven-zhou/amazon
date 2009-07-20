class ContactType < ActiveRecord::Base

#--
################ 
#  Associations
################
#++
  
  has_many :contacts

#--
################ 
#  Validations
################
#++  

  validates_presence_of :name, :metatype
  validates_inclusion_of :metatype, :in => %w(Phone Email IM Pager URL Fax Website)
  
  attr_accessible :name, :metatype
  
end
