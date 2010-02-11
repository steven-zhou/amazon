class BankRunDetail < ActiveRecord::Base

  belongs_to :bank_run
  belongs_to :transaction_header
end
