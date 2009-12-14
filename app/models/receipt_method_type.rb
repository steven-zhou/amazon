class ReceiptMethodType < AmazonSetting

 def self.active_receipt_method_type
    @receipt_method_type = ReceiptMethodType.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end


end
