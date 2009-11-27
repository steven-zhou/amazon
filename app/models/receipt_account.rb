class ReceiptAccount < ActiveRecord::Base
  
  validates_uniqueness_of :name
  validates_presence_of :name, :receipt_account_type_id, :status


end
