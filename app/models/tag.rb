class Tag < ActiveRecord::Base

  belongs_to :tag_type
  has_many :group_type, :class_name => 'PersonGroup', :foreign_key => 'tag_id'

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type, :tag_type_id], :case_sensitive => false

  default_scope :order => "name ASC"
  named_scope :active, :conditions => {:status => true, :to_be_removed => false}
  named_scope :inactive, :conditions => {:status => false}
  named_scope :removed, :conditions => {:to_be_removed => true}
  
  after_save :update_parent_when_retrieve

  def self.distinct_types_of_tags
    @tags = Tag.find(:all, :select => "DISTINCT type")
    results = ""
    @tags.each { |setting| results += "<option value='" + "#{setting.type}" + "'>" + "#{setting.type}" + "</option>" }
    return results
  end
  
  private
  def update_parent_when_retrieve
    if self.to_be_removed == false && self.tag_type.to_be_removed == true
      self.tag_type.to_be_removed = false
      self.tag_type.save
    end
  end
end
