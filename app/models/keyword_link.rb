class KeywordLink < ActiveRecord::Base
  
#--
################ 
#  Assocations
################
#++

  belongs_to :keyword
  belongs_to :taggable, :polymorphic => true
  
end
