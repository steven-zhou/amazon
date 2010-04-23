class ChequeDetail < DepositDetail

  belongs_to :bank
  
  validates_presence_of :bank_id, :name_on_cheque, :cheque_number, :date_on_cheque
end
