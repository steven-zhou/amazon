class CreditCardDetail < TransactionTypeDetail
  
  validates_presence_of :name_on_card, :card_number, :expire_month, :expire_year, :cvv_number
end
