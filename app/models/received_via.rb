class ReceivedVia < AmazonSetting

   has_many :transaction_headers

  def self.active_received_via
    @received_via = ReceivedVia.find(:all, :conditions => ["status = true and to_be_removed = false"], :order => 'name')
  end

end
