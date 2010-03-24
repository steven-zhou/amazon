class Allocation < ActiveRecord::Base

  belongs_to :receipt
  belongs_to :receipt_account
  belongs_to :campaign
  belongs_to :source

  validates_presence_of :receipt_id, :receipt_account_id, :amount
  validates_uniqueness_of :receipt_account_id, :scope => "receipt_id"
  

end
