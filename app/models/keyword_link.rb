class KeywordLink < ActiveRecord::Base
  
#--
################ 
#  Assocations
################
#++

  belongs_to :keyword
  belongs_to :taggable, :polymorphic => true


#  before_destroy :check_keyword_removed
#
#
#  private
#
#  def check_keyword_removed
#
##    keyword = Keyword.find(self.keyword_id)
##    if keyword.to_be_removed == true
##      return false
##    else
##      return true
##    end
#puts "before destroy"
#return false
#
#
#  end
  
end
