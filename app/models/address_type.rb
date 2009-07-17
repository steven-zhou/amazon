class AddressType < ActiveRecord::Base
  
#--
################ 
#  Associations
################
#++  

  has_many :addresses

#--
################ 
#  Validations
################
#++  

  validates_presence_of :name

  attr_accessible :name

end
