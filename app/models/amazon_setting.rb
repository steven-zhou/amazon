class AmazonSetting < ActiveRecord::Base
  
  def distinct_setting_type
    @setting = AmazonSetting.find(:all, :select => "DISTINCT type")
    results = ""
    @setting.each { |setting| results += "<option value='" + "#{setting.type}" + "'>" + "#{setting.type}" + "</option>" }
    return results
  end
  
end
