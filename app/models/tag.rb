class Tag < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type]

  def distinct_types_of_tags
    @tags = Tag.find(:all, :select => "DISTINCT type")
    results = ""
    @tags.each { |setting| results += "<option value='" + "#{setting.type}" + "'>" + "#{setting.type}" + "</option>" }
    return results
  end
  
end
