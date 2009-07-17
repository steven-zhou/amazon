class TitleType < ActiveRecord::Base

#--
################ 
#  Validations
################
#++
  validates_presence_of :name
  
  attr_accessible :name
  
end
