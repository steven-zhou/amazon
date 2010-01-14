class TransactionHeader < ActiveRecord::Base

  belongs_to :entity, :polymorphic => true
  belongs_to :receipt_meta_meta_type, :class_name => "ReceiptMetaMetaType", :foreign_key => "receipt_meta_type_id"
  belongs_to :receipt_meta_type, :class_name => "ReceiptMetaType", :foreign_key => "receipt_type_id"
  belongs_to :bank_account
  belongs_to :received_via
  #belongs_to :bank_run
   
  has_many :transaction_allocations, :dependent => :destroy
  has_one :transaction_type_detail, :dependent => :destroy
  has_one :cheque_detail, :dependent => :destroy
  has_one :credit_card_detail, :dependent => :destroy

  default_scope :order => "transaction_headers.id"

  validates_presence_of :transaction_date, :bank_account_id, :receipt_meta_type_id, :receipt_type_id, :received_via_id

  #reg ex for date format with dd/mm/yyyy
  validates_format_of :transaction_date, :with => /^(((0[1-9]|[12]\d|3[01])\-(0[13578]|1[02])\-((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\-(0[13456789]|1[012])\-((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\-02\-((19|[2-9]\d)\d{2}))|(29\-02\-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/
  
  #reg ex for date format with mm/dd/yyyy
  #validates_format_of :transaction_date, :with => /^(((0?[1-9]|1[012])\-(0?[1-9]|1\d|2[0-8])|(0?[13456789]|1[012])\-(29|30)|(0?[13578]|1[02])\-31)\-(19|[2-9]\d)\d{2}|0?2\-29\-((19|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00)))$/
end
