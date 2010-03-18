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

 default_scope :order => "keywords.name ASC"
    #--
  ################
  #  Validations
  ################
  #++

  validates_presence_of :keyword_type_id
  validates_presence_of :name 
  validates_uniqueness_of :name,:scope=>[:keyword_type_id], :case_sensitive => false
  #--
  ################
  #  Delegation
  ################
  #++

  # Return the first title
  delegate :name, :to => :keyword_type, :prefix => true,:allow_nil => true

  after_save :update_keyword_type_when_retrieve


  def self.active_record
    Keyword.find(:all, :conditions => ["status =true AND to_be_removed = false"])
  end

  def self.all_keyword_type_by_type(type)
    Keyword.find_all_by_keyword_type_id(type)
  end

  private
  def update_keyword_type_when_retrieve
    if self.to_be_removed == false && self.keyword_type.to_be_removed == true
      self.keyword_type.to_be_removed = false
      self.keyword_type.save
    end
  end
end
