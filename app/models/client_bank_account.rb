class ClientBankAccount < ActiveRecord::Base

  belongs_to :bank
  belongs_to :account_purpose


end
