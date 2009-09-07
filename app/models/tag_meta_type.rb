class TagMetaType < ActiveRecord::Base

  OPTIONS = ['MasterDoc', 'Group', 'Fee', 'Table', 'Contact']

  has_many :tag_types
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type], :case_sensitive => false



  def self.distinct_types_of_tag_meta_types
    @tag_meta_types = TagMetaType.find(:all, :select => "DISTINCT type")
    results = ""
    @tag_meta_types.each { |setting| results += "<option value='" + "#{setting.type}" + "'>" + "#{setting.type}" + "</option>" }
    return results
  end
  
end
