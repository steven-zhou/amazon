class Title < ActiveRecord::Base

  attr_accessible :name

#--
################ 
#  Assocations
################
#++
  belongs_to :title_type
  has_many :people
  has_many :secondary_people, :class_name => "Person", :foreign_key => "second_title_id"

#--
################ 
#  Validations
################
#++

  validates_presence_of :name
  
end
