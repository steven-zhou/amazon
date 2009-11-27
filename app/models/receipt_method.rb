class ReceiptMethod < ActiveRecord::Base

  belongs_to :receipt_method_type

  validates_uniqueness_of :name
  validates_presence_of :name, :receipt_method_type_id

end
