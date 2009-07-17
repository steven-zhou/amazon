class Contact < ActiveRecord::Base

#--
################
#  Associations
################
#++

  belongs_to :contact_type
  belongs_to :contactable, :polymorphic => true
  

#--
################ 
#  Validations
################
#++


  #validates_presence_of :priority
  #validates_uniqueness_of :priority, :scope => [:contactable_id, :contactable_type, :contact_type_id]
  

end
