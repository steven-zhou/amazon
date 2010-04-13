class  ReceiptAllocation < Receipt

  belongs_to :receipt_account
  belongs_to :campaign
  belongs_to :source
  belongs_to :entity_receipt

  validates_presence_of :receipt_account_id, :amount
  validates_uniqueness_of :receipt_account_id, :scope => ["entity_receipt_id"]
  

end
