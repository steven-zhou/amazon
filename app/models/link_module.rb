class LinkModule < AmazonSetting



 def self.active_link_module_type
    @link_module_type = LinkModule.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end
end