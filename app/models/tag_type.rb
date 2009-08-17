class TagType < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type]

  def distinct_types_of_tag_types
    @tag_types = AmazonSetting.find(:all, :select => "DISTINCT type")
    results = ""
    @tag_types.each { |setting| results += "<option value='" + "#{setting.type}" + "'>" + "#{setting.type}" + "</option>" }
    return results
  end
  
end
