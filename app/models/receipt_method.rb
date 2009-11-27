class ReceiptMethod < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :name, :receipt_method_type_id, :status

end
