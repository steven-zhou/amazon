class TransactionAllocation < ActiveRecord::Base

  belongs_to :transaction_header
  belongs_to :receipt_account
  belongs_to :campaign
  belongs_to :source
  #belongs_to :letter we do not have this model now, latter add this
  #latter add entity table relationship
  belongs_to :extention, :polymorphic => true
  belongs_to :cluster, :polymorphic => true

  validates_presence_of :transaction_header_id, :receipt_account_id, :amount
  validates_uniqueness_of :receipt_account_id, :scope => "transaction_header_id"
  

end
