class Country < ActiveRecord::Base
  
#--
################ 
#  Associations
################
#++
  
  belongs_to :main_language, :class_name => "Language"
  has_many :organisations, :foreign_key => :registered_country_id
  has_many :geographical_areas
  has_many :electoral_areas
  has_many :post_areas
  has_many :postcodes



#--
################ 
#  Validation
################
#++

  validates_presence_of :short_name, :citizenship
  validates_uniqueness_of :short_name, :citizenship
  default_scope :order => "countries.short_name ASC"
  
end
