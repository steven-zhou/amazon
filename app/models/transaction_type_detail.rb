class TransactionTypeDetail < ActiveRecord::Base
  
  belongs_to :transaction_header

  validates_presence_of :transaction_header_id
end
