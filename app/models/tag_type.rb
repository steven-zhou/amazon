class TagType < ActiveRecord::Base

  belongs_to :tag_meta_type
  has_many :tags

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type]

  accepts_nested_attributes_for :tags, :reject_if => proc { |attributes| attributes['name'].blank? || attributes['tag_type_id'].blank? }

  def self.distinct_types_of_tag_types
    @tag_types = TagType.find(:all, :select => "DISTINCT type")
    results = ""
    @tag_types.each { |setting| results += "<option value='" + "#{setting.type}" + "'>" + "#{setting.type}" + "</option>" }
    return results
  end
  
end
