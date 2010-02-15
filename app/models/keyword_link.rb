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


  def self.find_keyword(id,keyword_id,source_type)
    KeywordLink.find(:first,:conditions=>["taggable_id = ? and keyword_id = ?  and taggable_type = ?",id,keyword_id,source_type])
  end

  def self.find_all_keyword(id,keyword_id,source_type)
    KeywordLink.find(:all,:conditions=>["taggable_id = ? and keyword_id = ?  and taggable_type = ?",id,keyword_id,source_type])
  end
end
