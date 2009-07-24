class Country < ActiveRecord::Base
  
#--
################ 
#  Associations
################
#++
  
  belongs_to :main_language, :class_name => "Language"
  has_many :organisations, :foreign_key => :registered_country_id


#--
################ 
#  Validation
################
#++

  validates_presence_of :short_name, :citizenship

  
  attr_accessible :short_name, :long_name, :citizenship, :capital, :iso_code, :currency, :currency_subunit, :main_language_id
  
end
