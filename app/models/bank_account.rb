class BankAccount < ActiveRecord::Base

  has_many :transaction_headers
  belongs_to :bank


  validates_uniqueness_of :account_number, :scope => [:bank_id]
  
end
