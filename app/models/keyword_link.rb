class KeywordLink < ActiveRecord::Base
  
#--
################ 
#  Assocations
################
#++

  belongs_to :keyword
  belongs_to :taggable, :polymorphic => true


  def self.check_exsiting(id)
    KeywordLink.find_by_keyword_id(id)
  end
  
end
