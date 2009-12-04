class TransactionHeader < ActiveRecord::Base

   belongs_to :person
   belongs_to :receipt_meta_meta_type, :class_name => "ReceiptMetaMetaType", :foreign_key => "receipt_meta_type_id"
   belongs_to :receipt_meta_type, :class_name => "ReceiptMetaType", :foreign_key => "receipt_type_id"
   belongs_to :bank_account
   belongs_to :received_via
   #belongs_to :bank_run
   



   has_many :transaction_allocations

end
