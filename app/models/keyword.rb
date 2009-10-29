class Keyword < ActiveRecord::Base

  #--
  ################
  #  Assocations
  ################
  #++
  has_many :keyword_links
  has_many :people, :source => :taggable, 
    :through => :keyword_links,
    :class_name => "Person",
    :source_type => "Person",
    :uniq => true
  has_many :organisation, :source => :taggable,
    :through => :keyword_links,
    :class_name => "Organisation",
    :source_type => "Organisation",
    :uniq => true
  
  belongs_to :keyword_type, :class_name => "KeywordType", :foreign_key => "keyword_type_id"


    #--
  ################
  #  Validations
  ################
  #++

  validates_presence_of :keyword_type_id
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  #--
  ################
  #  Delegation
  ################
  #++

  # Return the first title
  delegate :name, :to => :keyword_type, :prefix => true,:allow_nil => true
end
