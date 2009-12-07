class AmazonSetting < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type], :case_sensitive => false

  def self.distinct_setting_type
    @setting = AmazonSetting.find(:all, :select => "DISTINCT type", :order => "type")
    results = ""
    @setting.each { |setting| results += "<option value='" + "#{setting.class}" + "'>" + "#{setting.class}".titleize + "</option>" if (setting.class.to_s != "Language" && setting.class.to_s != "Religion")}
    return results
  end
  
end
