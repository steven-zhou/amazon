class TransactionHeader < ActiveRecord::Base

   belongs_to :entity, :polymorphic => true
   belongs_to :receipt_meta_meta_type, :class_name => "ReceiptMetaMetaType", :foreign_key => "receipt_meta_type_id"
   belongs_to :receipt_meta_type, :class_name => "ReceiptMetaType", :foreign_key => "receipt_type_id"
   belongs_to :bank_account
   belongs_to :received_via
   #belongs_to :bank_run
   
   has_many :transaction_allocations

  validates_presence_of :transaction_date, :bank_account_id, :receipt_meta_type_id, :receipt_type_id, :received_via_id


end
