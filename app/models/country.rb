class Country < ActiveRecord::Base
  
#--
################ 
#  Associations
################
#++
  
  belongs_to :main_language, :class_name => "Language"
  
#--
################ 
#  Validation
################
#++

  validates_presence_of :short_name, :citizenship
  
  attr_accessible :short_name, :long_name, :citizenship, :capital, :iso_code, :currency, :currency_subunit, :main_language_id
  
end
