class Religion < ActiveRecord::Base

#--
################ 
#  Assocations
################
#++ 

 has_many :people
 
#--
################ 
#  Validations
################
#++
  
  validates_presence_of :name
  
end
