class ChequeDetail < TransactionTypeDetail

  validates_presence_of :bank_name, :bsb, :name_on_cheque, :cheque_number, :date_on_cheque
end
