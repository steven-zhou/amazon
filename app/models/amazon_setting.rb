class AmazonSetting < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type], :case_sensitive => false

  named_scope :active, :conditions => {:status => true, :to_be_removed => false}
  named_scope :inactive, :conditions => {:status => false}
  named_scope :removed, :conditions => {:to_be_removed => true}

  def self.distinct_setting_type
    @setting = AmazonSetting.find(:all, :conditions=>["type != 'RelationshipType' "] ,:select => "DISTINCT type", :order => "type")
    
    results = ""
    @setting.each { |setting| results += "<option value='" + "#{setting.class}" + "'>" + "#{setting.class}".titleize + "</option>" if (setting.class.to_s != "Language" && setting.class.to_s != "Religion")}
    return results
  end

  def self.search_by_type(type)
    AmazonSetting.find(:all, :conditions => ["type = ?", type], :order => 'name')
  end
  
end
