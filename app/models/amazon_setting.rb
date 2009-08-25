class AmazonSetting < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type]

  def self.distinct_setting_type
    @setting = AmazonSetting.find(:all, :select => "DISTINCT type", :order => "type")
    results = ""
    @setting.each { |setting| results += "<option value='" + "#{setting.class}" + "'>" + "#{setting.class}" + "</option>" }
    return results
  end
  
end
