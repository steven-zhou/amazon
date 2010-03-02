class LinkModule < AmazonSetting

has_many :fee_items ,:class_name=>"FeeItem",:foreign_key=>"link_module_id"

 def self.active_link_module_type
    @link_module_type = LinkModule.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end
end