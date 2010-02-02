class BankRunReportDetail < ActiveRecord::Base
  belongs_to :bank_run_report
  belongs_to :bank
  belongs_to :campaign

end
