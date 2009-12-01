class ClientBankAccount < ActiveRecord::Base

  belongs_to :bank
  belongs_to :account_purpose

  validates_uniqueness_of :account_number, :scope => [:bank_id]


end
