class ReceiptAccount < ActiveRecord::Base

  belongs_to :receipt_account_type
  
  validates_uniqueness_of :name
  validates_presence_of :name, :receipt_account_type_id


end
