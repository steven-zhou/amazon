class ContactMetaType < ActiveRecord::Base

# Each ContactMetaType should have a related model that extends the Contact model.

#--
################ 
#  Associations
################
#++
  
  has_many :contact_types

#--
################ 
#  Validations
################
#++  

  validates_presence_of :name

  
end
