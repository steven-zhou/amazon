class BankRunReport < ActiveRecord::Base

  has_many :bank_run_report_detail
  belongs_to :bank_run 
  belongs_to :client_organisation
  has_one :client_bank_account, :class_name =>"ClientBankAccount",:foreign_key =>"bank_id"
end
