class Receipt < ActiveRecord::Base

  belongs_to :deposit
  belongs_to :receipt_account
  belongs_to :campaign
  belongs_to :source

  validates_presence_of :deposit_id, :receipt_account_id, :amount
  validates_uniqueness_of :receipt_account_id, :scope => "deposit, entity_id, entity_type"
  

end
