class BankRun < ActiveRecord::Base
  has_many :transaction_headers
  has_many :bank_run_reports 
end
