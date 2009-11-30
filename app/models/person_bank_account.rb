class PersonBankAccount < ActiveRecord::Base

  belongs_to :person
  belongs_to :bank
  belongs_to :account_type


end
